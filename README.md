# exerciciosPackage

Pacote PKG_ALUNO

Funcionalidades do Pacote

1. Excluir Aluno
Nome da Procedure: excluir_aluno(p_id_aluno IN NUMBER)
Descrição: Exclui um aluno e todas as matrículas associadas ao seu ID.
Parâmetro:
  p_id_aluno: ID do aluno que será excluído.

2. Listar Alunos Maiores de 18 Anos
Nome da Procedure: listar_maiores_18
Descrição: Lista os nomes e as datas de nascimento de todos os alunos com mais de 18 anos.
Saída: Exibe os resultados no console usando DBMS_OUTPUT.PUT_LINE.

3. Listar Alunos de um Curso Específico
Nome da Procedure: cursor_por_curso(p_id_curso IN NUMBER)
Descrição: Lista os nomes dos alunos matriculados em um curso específico.
Parâmetro:
  p_id_curso: ID do curso cujos alunos serão listados.

Como Executar o Pacote

1. Configuração do Ambiente
Antes de executar o pacote, certifique-se de que:
  O banco de dados Oracle esteja configurado e as tabelas aluno, matricula, e disciplina estejam populadas.
  O usuário tenha as permissões adequadas para criar e executar pacotes.

2. Ativando o DBMS_OUTPUT
Para visualizar as mensagens exibidas pelas procedures:
  SET SERVEROUTPUT ON;

3. Criando o Pacote
Copie e cole o código do Pacote PKG_ALUNO no seu ambiente SQL Developer ou similar e execute o script.

4. Testando as Funcionalidades

4.1. Excluir um Aluno
Exclui o aluno com ID 1 e suas matrículas:
  BEGIN
      PKG_ALUNO.excluir_aluno(1);
  END;

Saída Esperada:
  Aluno e matrículas associadas excluídos com sucesso.

4.2. Listar Alunos Maiores de 18 Anos
Lista os alunos com mais de 18 anos:
  BEGIN
      PKG_ALUNO.listar_maiores_18;
  END;

Saída Esperada:
  Nome: João Silva, Data de Nascimento: 15/03/2000
  Nome: Maria Oliveira, Data de Nascimento: 08/12/1995

4.3. Listar Alunos de um Curso Específico
Lista os alunos do curso com ID 1:
  BEGIN
      PKG_ALUNO.cursor_por_curso(1);
  END;

Saída Esperada:
  Aluno: João Silva
  Aluno: Ana Santos

Pacote PKG_DISCIPLINA

Funcionalidades do Pacote

1. Cadastrar Disciplina
Nome da Procedure: cadastrar_disciplina(p_nome IN VARCHAR2, p_descricao IN VARCHAR2, p_carga_horaria IN NUMBER)
Descrição: Insere uma nova disciplina na tabela disciplina.
Parâmetros:
  p_nome: Nome da disciplina.
  p_descricao: Descrição da disciplina.
  p_carga_horaria: Carga horária da disciplina.
Saída: Confirmação no console.

2. Exibir Total de Alunos por Disciplina
Nome da Procedure: total_alunos_disciplina
Descrição: Lista o total de alunos matriculados em cada disciplina, exibindo apenas disciplinas com mais de 10 alunos.
Saída: Exibe os resultados no console.

3. Calcular Média de Idade por Disciplina
Nome da Procedure: media_idade_por_disciplina(p_id_disciplina IN NUMBER)
Descrição: Calcula a média de idade dos alunos matriculados em uma disciplina específica.
Parâmetros:
  p_id_disciplina: ID da disciplina para cálculo da média de idade.
Saída: Exibe a média de idade no console.

4. Listar Alunos Matriculados em uma Disciplina
Nome da Procedure: listar_alunos_disciplina(p_id_disciplina IN NUMBER)
Descrição: Lista os nomes dos alunos matriculados em uma disciplina específica.
Parâmetros:
  p_id_disciplina: ID da disciplina cujos alunos serão listados.
Saída: Exibe os nomes dos alunos no console.

Como Executar o Pacote

1. Configuração do Ambiente
Antes de executar o pacote, certifique-se de que:
  O banco de dados Oracle esteja configurado e as tabelas disciplina, matricula e aluno estejam populadas.
  O usuário tenha as permissões necessárias para criar e executar pacotes.

2. Ativando o DBMS_OUTPUT
Para visualizar as mensagens exibidas pelas procedures:
  SET SERVEROUTPUT ON;

3. Criando o Pacote
Copie e cole o código do Pacote PKG_DISCIPLINA no seu ambiente SQL Developer ou similar e execute o script.

4. Testando as Funcionalidades

4.1. Cadastrar uma Disciplina
Insere uma nova disciplina no banco de dados:
  BEGIN
      PKG_DISCIPLINA.cadastrar_disciplina('Matemática', 'Disciplina de Álgebra Básica', 80);
  END;

Saída Esperada:
  Disciplina cadastrada com sucesso: Matemática

4.2. Exibir Total de Alunos por Disciplina
Exibe o total de alunos matriculados em disciplinas com mais de 10 alunos:
  BEGIN
      PKG_DISCIPLINA.total_alunos_disciplina;
  END;

Saída Esperada:
  Disciplina: Matemática, Total de Alunos: 25
  Disciplina: Física, Total de Alunos: 15

4.3. Calcular Média de Idade por Disciplina
Calcula a média de idade dos alunos matriculados na disciplina com ID 1:
  BEGIN
      PKG_DISCIPLINA.media_idade_por_disciplina(1);
  END;

Saída Esperada:
  Média de idade para a disciplina 1: 22.5

4.4. Listar Alunos Matriculados em uma Disciplina
Lista os alunos matriculados na disciplina com ID 1:
  BEGIN
      PKG_DISCIPLINA.listar_alunos_disciplina(1);
  END;

Saída Esperada:
  Aluno: João Silva
  Aluno: Maria Oliveira
  Aluno: Pedro Santos

Pacote PKG_PROFESSOR

Funcionalidades do Pacote

1. Listar Professores com Mais de uma Turma
Nome da Procedure: total_turmas_por_professor
Descrição: Lista os nomes dos professores e o número total de turmas que lecionam, exibindo apenas aqueles que possuem mais de uma turma.
Saída: Exibe os resultados no console.

2. Exibir Total de Turmas de um Professor
Nome da Procedure: total_turmas(p_id_professor IN NUMBER)
Descrição: Exibe o total de turmas em que um professor atua como responsável.
Parâmetro:
  p_id_professor: ID do professor cujo total de turmas será exibido.
Saída: Exibe o total de turmas no console.

3. Identificar o Professor de uma Disciplina
Nome da Procedure: professor_disciplina(p_id_disciplina IN NUMBER)
Descrição: Exibe o nome do professor responsável por uma disciplina específica.
Parâmetro:
  p_id_disciplina: ID da disciplina cujo professor será exibido.
Saída: Exibe o nome do professor no console.

Como Executar o Pacote

1. Configuração do Ambiente
Antes de executar o pacote, certifique-se de que:
  O banco de dados Oracle esteja configurado e as tabelas professor, turma, e disciplina estejam populadas.
  O usuário tenha as permissões necessárias para criar e executar pacotes.

2. Ativando o DBMS_OUTPUT
Para visualizar as mensagens exibidas pelas procedures:
  SET SERVEROUTPUT ON;

3. Criando o Pacote
Copie e cole o código do Pacote PKG_PROFESSOR no seu ambiente SQL Developer ou similar e execute o script.

4. Testando as Funcionalidades

4.1. Listar Professores com Mais de uma Turma
Lista os professores que lecionam em mais de uma turma:
  BEGIN
      PKG_PROFESSOR.total_turmas_por_professor;
  END;

Saída Esperada:
  Professor: João Silva, Total de Turmas: 3
  Professor: Maria Souza, Total de Turmas: 5

4.2. Exibir Total de Turmas de um Professor
Exibe o total de turmas para o professor com ID 1:

  BEGIN
      PKG_PROFESSOR.total_turmas(1);
  END;

Saída Esperada:

  Professor com ID 1 tem 3 turmas.

4.3. Identificar o Professor de uma Disciplina
Exibe o nome do professor responsável pela disciplina com ID 2:
  BEGIN
      PKG_PROFESSOR.professor_disciplina(2);
  END;

Saída Esperada:
  O professor da disciplina 2 é: João Silva

Se não houver professor associado, a saída será:
  Nenhum professor encontrado para a disciplina 2.
