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
('35454562890', 'José Rubens', 'Campos Salles', 2750, 'Centro', '21450998', '1954-10-18'),
('29865439810', 'Ana Claudia', 'Sete de Setembro', 178, 'Centro', '97382764', '1960-05-29'),
('82176534800', 'Marcos Aurélio', 'Timóteo Penteado', 236, 'Vila Galvão', '68172651', '1980-09-24'),
('12386758770', 'Maria Rita', 'Castello Branco', 7765, 'Vila Rosália', ' ', '1975-03-30'),
('92173458910', 'Joana de Souza', 'XV de Novembro', 298, 'Centro', '21276578', '1944-04-24')

INSERT INTO medico VALUES
(1, 'Wilson Cesar', 'Pediatra'),
(2, 'Marcia Matos', 'Geriatra'),
(3, 'Carolina Oliveira', 'Ortopedista'),
(4, 'Vinicius Araujo', 'Clínico Geral')

INSERT INTO prontuario VALUES
('2020-09-10', '35454562890', 2, 'Reumatismo', 'Celebra'),
('2020-09-10', '92173458910', 2, 'Renite Alérgica', 'Allegra'),
('2020-09-12', '29865439810', 1, 'Inflamação de garganta', 'Nimesulida'),
('2020-09-13', '35454562890', 2, 'H1N1', 'Tamiflu'),
('2020-09-15', '82176534800', 4, 'Gripe', 'Resprin'),
('2020-09-15', '12386758770', 3, 'Braço Quebrado', 'Dorflex + Gesso')

--Consultar:				
--Nome e Endereço (concatenado) dos pacientes com mais de 50 anos				
SELECT nome,
       rua +' '+ CAST(num AS VARCHAR) + ' '+ bairro AS endereço
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

--Consultar em subqueries:													
--Diagnóstico e Medicamento do paciente José Rubens em suas consultas						 							
SELECT p.diagnostico,
       p.medicamento
FROM prontuario p INNER JOIN paciente pac
ON p.cpf_paciente = pac.cpf
WHERE pac.nome = 'José Rubens'
--Nome e especialidade do(s) Médico(s) que atenderam José Rubens. Caso a especialidade tenha mais de 3 letras, mostrar apenas as 3 primeiras letras concatenada com um ponto final (.)													
SELECT m.nome,
       CASE
        WHEN LEN(m.especialidade) <= 3 THEN especialidade
        ELSE LEFT(m.especialidade, 3) + '.'
    END AS especialidade_abreviada
FROM prontuario p INNER JOIN paciente pac
ON p.cpf_paciente = pac.cpf
INNER JOIN medico m ON p.cod_med = m.cod 
WHERE pac.nome = 'José Rubens'

--CPF (Com a máscara XXX.XXX.XXX-XX), Nome, Endereço completo (Rua, nº - Bairro), Telefone (Caso nulo, mostrar um traço (-)) dos pacientes do médico Vinicius
SELECT
    FORMAT(CAST(pac.cpf AS BIGINT), '###.###.###-##') AS cpf_formatado,
    pac.nome,
    pac.rua +' '+ CAST(pac.num AS VARCHAR) + ' '+ pac.bairro AS endereco,
    ISNULL(STUFF(CONVERT(VARCHAR, pac.telefone), 5, 0, '-'), '-') AS telefone
FROM
    paciente pac
INNER JOIN
    prontuario p ON pac.cpf = p.cpf_paciente
INNER JOIN
    medico m ON p.cod_med = m.cod
WHERE
    m.nome = 'Vinicius Araujo';										
--Quantos dias fazem da consulta de Maria Rita até hoje	
SELECT
    DATEDIFF(DAY, p.data_prontuario, GETDATE()) AS dias_passados
FROM
    prontuario p
INNER JOIN
    paciente pac ON p.cpf_paciente = pac.cpf
WHERE
    pac.nome = 'Maria Rita'

--Alterar o telefone da paciente Maria Rita, para 98345621	
UPDATE
    paciente
SET
    telefone = '98345621'
WHERE
    nome = 'Maria Rita'
				
--Alterar o Endereço de Joana de Souza para Voluntários da Pátria, 1980, Jd. Aeroporto					
UPDATE
    paciente
SET
    rua = 'Voluntários da Pátria',
	num = 1980,
	bairro = 'Jd. Aeroporto'
WHERE
    nome = 'Joana de Souza'
FROM   prontuario
WHERE diagnostico = 'reumatismo'
