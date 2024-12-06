SET SERVEROUTPUT ON;

--Exercício package_aluno
CREATE OR REPLACE PACKAGE PKG_ALUNO AS
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER);

    CURSOR cursor_maiores_18 IS
        SELECT nome, data_nascimento
        FROM aluno
        WHERE TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12) > 18;

    PROCEDURE listar_maiores_18;

    PROCEDURE cursor_por_curso(p_id_curso IN NUMBER);
END PKG_ALUNO;
/

CREATE OR REPLACE PACKAGE BODY PKG_ALUNO AS
    PROCEDURE excluir_aluno(p_id_aluno IN NUMBER) IS
    BEGIN
        DELETE FROM matricula
        WHERE id_aluno = p_id_aluno;

        DELETE FROM aluno
        WHERE id_aluno = p_id_aluno;

        DBMS_OUTPUT.PUT_LINE('Aluno e matrículas associadas excluídos com sucesso.');
    END excluir_aluno;

    PROCEDURE listar_maiores_18 IS
        v_nome aluno.nome%TYPE;
        v_data_nascimento aluno.data_nascimento%TYPE;
    BEGIN
        OPEN cursor_maiores_18;
        LOOP
            FETCH cursor_maiores_18 INTO v_nome, v_data_nascimento;
            EXIT WHEN cursor_maiores_18%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Nome: ' || v_nome || ', Data de Nascimento: ' || TO_CHAR(v_data_nascimento, 'DD/MM/YYYY'));
        END LOOP;
        CLOSE cursor_maiores_18;
    END listar_maiores_18;

    PROCEDURE cursor_por_curso(p_id_curso IN NUMBER) IS
        CURSOR c_alunos_curso IS
            SELECT DISTINCT a.nome
            FROM aluno a
            JOIN matricula m ON a.id_aluno = m.id_aluno
            JOIN disciplina d ON m.id_disciplina = d.id_disciplina
            WHERE d.id_curso = p_id_curso;

        v_nome_aluno aluno.nome%TYPE;
    BEGIN
        OPEN c_alunos_curso;
        LOOP
            FETCH c_alunos_curso INTO v_nome_aluno;
            EXIT WHEN c_alunos_curso%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_nome_aluno);
        END LOOP;
        CLOSE c_alunos_curso;
    END cursor_por_curso;
END PKG_ALUNO;
/

--Testes realizados no sql developer
SELECT * FROM aluno WHERE id_aluno = 2;
SELECT * FROM matricula WHERE id_aluno = 1;

BEGIN
    PKG_ALUNO.excluir_aluno(1);
END;

BEGIN
    PKG_ALUNO.listar_maiores_18;
END;

BEGIN
    PKG_ALUNO.cursor_por_curso(1);
END;

--Exercício package_disciplina
CREATE OR REPLACE PACKAGE PKG_DISCIPLINA AS
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER);

    PROCEDURE total_alunos_disciplina;

    PROCEDURE media_idade_por_disciplina(p_id_disciplina IN NUMBER);

    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER);
END PKG_DISCIPLINA;
/

CREATE OR REPLACE PACKAGE BODY PKG_DISCIPLINA AS
    PROCEDURE cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER) IS
    BEGIN
        INSERT INTO disciplina (nome, descricao, carga_horaria)
        VALUES (p_nome, p_descricao, p_carga_horaria);

        DBMS_OUTPUT.PUT_LINE('Disciplina cadastrada com sucesso: ' || p_nome);
    END cadastrar_disciplina;

    PROCEDURE total_alunos_disciplina IS
        CURSOR c_total_alunos IS
            SELECT d.nome, COUNT(m.id_aluno) AS total_alunos
            FROM disciplina d
            JOIN matricula m ON d.id_disciplina = m.id_disciplina
            GROUP BY d.nome
            HAVING COUNT(m.id_aluno) > 10;

        v_nome_disciplina disciplina.nome%TYPE;
        v_total_alunos NUMBER;
    BEGIN
        OPEN c_total_alunos;

        LOOP
            FETCH c_total_alunos INTO v_nome_disciplina, v_total_alunos;
            EXIT WHEN c_total_alunos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Disciplina: ' || v_nome_disciplina || ', Total de Alunos: ' || v_total_alunos);
        END LOOP;

        CLOSE c_total_alunos;
    END total_alunos_disciplina;

    PROCEDURE media_idade_por_disciplina(p_id_disciplina IN NUMBER) IS
        CURSOR c_media_idade IS
            SELECT ROUND(AVG(2024 - EXTRACT(YEAR FROM a.data_nascimento)), 2) AS media_idade
            FROM aluno a
            JOIN matricula m ON a.id_aluno = m.id_aluno
            WHERE m.id_disciplina = p_id_disciplina;

        v_media_idade NUMBER;
    BEGIN
        OPEN c_media_idade;
        FETCH c_media_idade INTO v_media_idade;
        CLOSE c_media_idade;

        IF v_media_idade IS NOT NULL THEN
            DBMS_OUTPUT.PUT_LINE('Média de idade para a disciplina ' || p_id_disciplina || ': ' || v_media_idade);
        ELSE
            DBMS_OUTPUT.PUT_LINE('Nenhum aluno matriculado na disciplina ' || p_id_disciplina || '.');
        END IF;
    END media_idade_por_disciplina;

    PROCEDURE listar_alunos_disciplina(p_id_disciplina IN NUMBER) IS
        CURSOR c_alunos IS
            SELECT a.nome
            FROM aluno a
            JOIN matricula m ON a.id_aluno = m.id_aluno
            WHERE m.id_disciplina = p_id_disciplina;

        v_nome aluno.nome%TYPE;
    BEGIN
        OPEN c_alunos;
        LOOP
            FETCH c_alunos INTO v_nome;
            EXIT WHEN c_alunos%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Aluno: ' || v_nome);
        END LOOP;
        CLOSE c_alunos;
    END listar_alunos_disciplina;
END PKG_DISCIPLINA;
/

--Testes realizados no sql developer
BEGIN
    PKG_DISCIPLINA.cadastrar_disciplina('Matemática', 'Introdução à Matemática', 60);
END;

SELECT * FROM disciplina;

BEGIN
    PKG_DISCIPLINA.total_alunos_disciplina;
END;

BEGIN
    PKG_DISCIPLINA.media_idade_por_disciplina(2);
END;

BEGIN
    PKG_DISCIPLINA.listar_alunos_disciplina(2);
END;

--Exercício package_professor
CREATE OR REPLACE PACKAGE PKG_PROFESSOR AS
    PROCEDURE total_turmas_por_professor;

    PROCEDURE total_turmas(p_id_professor IN NUMBER);

    PROCEDURE professor_disciplina(p_id_disciplina IN NUMBER);
END PKG_PROFESSOR;
/

CREATE OR REPLACE PACKAGE BODY PKG_PROFESSOR AS
    PROCEDURE total_turmas_por_professor IS
        CURSOR c_turmas_professor IS
            SELECT p.nome, COUNT(t.id_turma) AS total_turmas
            FROM professor p
            JOIN turma t ON p.id_professor = t.id_professor
            GROUP BY p.nome
            HAVING COUNT(t.id_turma) > 1;

        v_nome_professor professor.nome%TYPE;
        v_total_turmas NUMBER;
    BEGIN
        OPEN c_turmas_professor;

        LOOP
            FETCH c_turmas_professor INTO v_nome_professor, v_total_turmas;
            EXIT WHEN c_turmas_professor%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('Professor: ' || v_nome_professor || ', Total de Turmas: ' || v_total_turmas);
        END LOOP;

        CLOSE c_turmas_professor;
    END total_turmas_por_professor;

    PROCEDURE total_turmas(p_id_professor IN NUMBER) IS
        v_total NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_total
        FROM turma
        WHERE id_professor = p_id_professor;

        DBMS_OUTPUT.PUT_LINE('Professor com ID ' || p_id_professor || ' tem ' || v_total || ' turmas.');
    END total_turmas;

    PROCEDURE professor_disciplina(p_id_disciplina IN NUMBER) IS
        v_nome_professor professor.nome%TYPE;
    BEGIN
        SELECT p.nome
        INTO v_nome_professor
        FROM professor p
        JOIN turma t ON p.id_professor = t.id_professor
        WHERE t.id_disciplina = p_id_disciplina;

        DBMS_OUTPUT.PUT_LINE('O professor da disciplina ' || p_id_disciplina || ' é: ' || v_nome_professor);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nenhum professor encontrado para a disciplina ' || p_id_disciplina);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Erro ao buscar professor para a disciplina ' || p_id_disciplina);
    END professor_disciplina;
END PKG_PROFESSOR;
/

--Testes realizados no sql developer
BEGIN
    PKG_PROFESSOR.total_turmas_por_professor;
END;

BEGIN
    PKG_PROFESSOR.total_turmas(1);
END;

BEGIN
    PKG_PROFESSOR.professor_disciplina(2);
END;

