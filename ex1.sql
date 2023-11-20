CREATE DATABASE ex1
GO
USE ex1

GO
CREATE TABLE aluno(
ra            INT          NOT NULL,
nome          VARCHAR(30)  NOT NULL,
sobrenome     VARCHAR(30)  NOT NULL,
rua           VARCHAR(30)  NOT NULL,
num           INT          NOT NULL,
bairro        VARCHAR(30)  NOT NULL,
cep           CHAR(08)     NOT NULL,
telefone      CHAR(08)     NOT NULL
PRIMARY KEY (ra)
)

GO
CREATE TABLE curso(
cod             INT          NOT NULL,
nome            VARCHAR(30)  NOT NULL,
carga_horaria   INT          NOT NULL,
turno           VARCHAR(30)  NOT NULL
PRIMARY KEY (cod)
)

GO
CREATE TABLE disciplina(
cod_disc        INT          NOT NULL,
nome            VARCHAR(30)  NOT NULL,
carga_horaria   INT          NOT NULL,
turno           VARCHAR(30)  NOT NULL,
semestre        INT          NOT NULL
PRIMARY KEY(cod_disc)
)

INSERT INTO aluno VALUES 
(12345,	'José',	'Silva', 'Almirante Noronha', 236, 'Jardim São Paulo', '1589000', '69875287'),
(12346, 'Ana', 'Maria Bastos', 'Anhaia', 1568, 'Barra Funda', '3569000', '25698526'),
(12347, 'Mario',	'Santos','XV de Novembro', 1841, 'Centro', '1020030', ' ' ),
(12348, 'Marcia', 'Neves', 'Voluntários da Patria', 225, 'Santana', '2785090', '78964152')

INSERT INTO curso VALUES 
(1, 'Informática', 2800, 'Tarde'),
(2, 'Informática', 2800, 'Noite'),
(3, 'Logística', 2650, 'Tarde'),
(4, 'Logística', 2650, 'Noite'),
(5, 'Plásticos', 2500, 'Tarde'),
(6, 'Plásticos', 2500, 'Noite')

INSERT INTO disciplina VALUES
(1, 'Informática', 4, 'Tarde', 1),
(2, 'Informática', 4, 'Noite', 1),
(3, 'Quimica', 4, 'Tarde', 1),
(4, 'Quimica', 4, 'Noite', 1),
(5, 'Banco de Dados I', 2, 'Tarde', 3),
(6, 'Banco de Dados I', 2, 'Noite', 3),
(7, 'Estrutura de Dados', 4, 'Tarde', 4),
(8, 'Estrutura de Dados', 4, 'Noite', 4)

SELECT *
FROM aluno

SELECT *
FROM curso

SELECT *
FROM disciplina

--Concultar Nome e sobrenome, como nome completo dos Alunos Matriculados				
SELECT nome +' ' + sobrenome AS aluno
FROM aluno
WHERE ra IS NOT NULL

--Consultar Rua, nº , Bairro e CEP como Endereço do aluno que não tem telefone				
SELECT rua + ' '+CAST(num AS VARCHAR) +' '+ bairro + ' '+ cep  AS endereço
FROM aluno
WHERE telefone = ' '

--Consultar Telefone do aluno com RA 12348		
SELECT telefone
FROM aluno
WHERE ra = 12348

--Consultar Nome e Turno dos cursos com 2800 horas			
SELECT nome,
       turno
FROM curso
WHERE carga_horaria = 2800

--Consultar o semestre do curso de Banco de Dados I noite			
SELECT semestre
FROM disciplina
WHERE nome = 'Banco de Dados I'
