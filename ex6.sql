CREATE DATABASE viagem
GO
USE viagem

GO
CREATE TABLE Motorista(			
Codigo				INT				NOT NULL,	
Nome				VARCHAR(50)		NOT NULL,
Data_nascimento		DATE			NOT NULL,
Naturalidade		VARCHAR(30)		NOT NULL
PRIMARY KEY (Codigo)
)

INSERT INTO Motorista VALUES
(12341,	'Julio Cesar',		'1978-04-18',	'São Paulo'),
(12342,	'Mario Carmo',		'2002-07-29',	'Americana'),
(12343,	'Lucio Castro',		'1969-12-01',	'Campinas'),
(12344,	'André Figueiredo',	'1999-05-14',	'São Paulo'),
(12345,	'Luiz Carlos',		'2001-01-09',	'São Paulo')

GO
CREATE TABLE Onibus(			
Placa			CHAR(07)			NOT NULL,
Marca			VARCHAR(15)			NOT NULL,
Ano				INT					NOT NULL,
Descricao		VARCHAR(30)			NOT NULL
PRIMARY KEY (Placa)
)


INSERT INTO	Onibus VALUES
('adf0965',   	'Mercedes', 1999,	'Leito'),               
('bhg7654',  	'Mercedes', 2002,	'Sem Banheiro'),        
('dtr2093',   	'Mercedes',	2001,	'Ar Condicionado'),     
('gui7625',  	'Volvo', 2001,	'Ar Condicionado')    

GO
CREATE TABLE Viagem(					
Codigo				INT			NOT NULL,
Onibus				CHAR(7)			NOT NULL,
Motorista			INT			NOT NULL,
Hora_Saida			TIME		NOT NULL,
Hora_Chegada		TIME		NOT NULL,		
Destino				VARCHAR(20)	NOT NULL
PRIMARY KEY (Codigo, Onibus, Motorista)
FOREIGN KEY (Onibus) REFERENCES Onibus(Placa),
FOREIGN KEY (Motorista) REFERENCES Motorista(Codigo)
)


INSERT INTO Viagem VALUES
(101,	'adf0965', 12343,	'10:00:00',	'12:00:00',	'Campinas'),
(102,	'gui7625', 12341,	'07:00:00',	'12:00:00',	'Araraquara'),
(103,	'bhg7654', 12345,	'14:00:00',	'22:00:00',	'Rio de Janeiro'),
(104,	'dtr2093', 12344,	'18:00:00',	'21:00:00',	'Sorocaba')

Select * from Viagem
Select * from Onibus
Select * from Motorista

-- Consultar, da tabela viagem, todas as horas de chegada e saída, convertidas em formato HH:mm (108) e seus destinos
SELECT CONVERT( VARCHAR(5), Hora_Chegada, 108) AS  Hora_Chegada,
       CONVERT( VARCHAR(5), Hora_Saida, 108) AS Hora_Saida,
	   Destino
FROM Viagem
		
-- Consultar, com subquery, o nome do motorista que viaja para Sorocaba	
SELECT Nome
FROM Motorista
WHERE Nome IN(
SELECT DISTINCT m.Nome
FROM Motorista m, Viagem v
WHERE m.Codigo = v.Motorista
AND v.Destino = 'Sorocaba' )

-- Consultar, com subquery, a descrição do ônibus que vai para o Rio de Janeiro		
SELECT Descricao
FROM Onibus
WHERE Descricao IN(
SELECT DISTINCT o.Descricao
FROM Onibus o, Viagem v
WHERE o.Placa = v.Onibus
AND v.Destino = 'Rio de Janeiro')

					
-- Consultar, com Subquery, a descrição, a marca e o ano do ônibus dirigido por Luiz Carlos		
SELECT          o.Marca,
				o.Placa
FROM Onibus o, Viagem v, Motorista m
WHERE o.Placa = v.Onibus
AND v.Motorista	= m.Codigo
AND m.Nome IN(
SELECT DISTINCT m.Nome
FROM Onibus o, Viagem v, Motorista m
WHERE o.Placa = v.Onibus
AND v.Motorista	= m.Codigo	
AND m.Nome = 'Luiz Carlos' )

-- Consultar o nome, a idade e a naturalidade dos motoristas com mais de 30 anos			
SELECT Nome,
       DATEDIFF(YEAR, Data_nascimento, GETDATE()) AS Idade
FROM Motorista	
WHERE  DATEDIFF(YEAR, Data_nascimento, GETDATE()) IN (
SELECT DISTINCT  DATEDIFF(YEAR, Data_nascimento, GETDATE()) AS Idade
FROM Motorista
WHERE  DATEDIFF(YEAR, Data_nascimento, GETDATE()) > 30 )


