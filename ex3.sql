CREATE DATABASE ex3
GO
USE ex3

GO
CREATE TABLE paciente(
cpf           VARCHAR(11)  NOT NULL,
nome          VARCHAR(30)  NOT NULL,
rua           VARCHAR(30)  NOT NULL,
num           INT          NOT NULL,
bairro        VARCHAR(30)  NOT NULL,
telefone      CHAR(08)     NOT NULL,
data_nasc     DATE         NOT NULL,
PRIMARY KEY (cpf)
)

GO
CREATE TABLE medico(
cod              INT          NOT NULL,
nome             VARCHAR(30)  NOT NULL,
especialidade    VARCHAR(30)  NOT NULL
PRIMARY KEY(cod)
)

GO 
CREATE TABLE prontuario(
data_prontuario        DATE         NOT NULL,
cpf_paciente           VARCHAR(11)  NOT NULL,
cod_med                INT          NOT NULL,
diagnostico            VARCHAR(50)  NOT NULL,
medicamento            VARCHAR(50)  NOT NULL
PRIMARY KEY(data_prontuario, cpf_paciente, cod_med)
FOREIGN KEY(cpf_paciente) REFERENCES paciente(cpf),
FOREIGN KEY(cod_med) REFERENCES medico(cod)
)

DROP TABLE paciente

INSERT INTO paciente VALUES
('35454562890', 'Jos� Rubens', 'Campos Salles', 2750, 'Centro', '21450998', '1954-10-18'),
('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764', '1960-05-29'),
('82176534800', 'Marcos Aur�lio', 'Tim�teo Penteado', 236, 'Vila Galv�o', '68172651', '1980-09-24'),
('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Ros�lia', ' ', '1975-03-30'),
('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578', '1944-04-24')

INSERT INTO medico VALUES
(1, 'Wilson Cesar', 'Pediatra'),
(2, 'Marcia Matos', 'Geriatra'),
(3, 'Carolina Oliveira', 'Ortopedista'),
(4, 'Vinicius Araujo', 'Cl�nico Geral')

INSERT INTO prontuario VALUES
('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra'),
('2020-09-10', '92173458910', 2, 'Renite Al�rgica', 'Allegra'),
('2020-09-12', '29865439810', 1, 'Inflama��o de garganta', 'Nimesulida'),
('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu'),
('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin'),
('2020-09-15', '12386758770', 3, 'Bra�o Quebrado', 'Dorflex + Gesso')

--Consultar:				
--Nome e Endere�o (concatenado) dos pacientes com mais de 50 anos				
SELECT nome,
       rua +' '+ CAST(num AS VARCHAR) + ' '+ bairro AS endere�o
FROM paciente
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 50

--Qual a especialidade de Carolina Oliveira	
SELECT especialidade
FROM medico
WHERE nome = 'Carolina Oliveira'
			
--Qual medicamento receitado para reumatismo				
SELECT medicamento
FROM   prontuario
WHERE diagnostico = 'reumatismo'