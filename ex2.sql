CREATE DATABASE ex2
GO
USE ex2

GO
CREATE TABLE carro(
placa  VARCHAR(07)  NOT NULL,
marca  VARCHAR(30)  NOT NULL,
modelo VARCHAR(30)  NOT NULL,
cor    VARCHAR(15)  NOT NULL,
ano    INT          NOT NULL
PRIMARY KEY (placa)
)

GO
CREATE TABLE peca(
cod    INT           NOT NULL,
nome   VARCHAR(30)   NOT NULL,
valor  DECIMAL(7,2)  NOT NULL
PRIMARY KEY(cod)
)

GO
CREATE TABLE servico(
carro         VARCHAR(07)   NOT NULL,
peca          INT           NOT NULL,
quant         INT           NOT NULL,
valor         DECIMAL(7,2)  NOT NULL,
data_servico  DATE          NOT NULL
PRIMARY KEY(carro, peca, data_servico),
FOREIGN KEY (carro) REFERENCES cliente(carro),
FOREIGN KEY (peca) REFERENCES peca(cod)
)
GO
CREATE TABLE cliente(
nome          VARCHAR(30)  NOT NULL,
logradouro    VARCHAR(30)  NOT NULL,
num           INT          NOT NULL,
bairro        VARCHAR(30)  NOT NULL,
telefone      CHAR(09)     NOT NULL,
carro         VARCHAR(07)  NOT NULL
PRIMARY KEY (carro)
FOREIGN KEY (carro) REFERENCES carro (placa)
)

DROP TABLE cliente

INSERT INTO cliente VALUES
('João Alves', 'R. Pereira Barreto', 1258, 'Jd. Oliveiras', '2154-9658', 'DXO9876'),
('Ana Maria', 'R. 7 de Setembro', 259, 'Centro', '9658-8541', 'LKM7380'),
('Clara Oliveira', 'Av. Nações Unidas', 10254, 'Pinheiros', '2458-9658', 'EGT4631'),
('José Simões', 'R. XV de Novembro', 36, 'Água Branca', '7895-2459', 'BCD7521'),
('Paula Rocha', 'R. Anhaia', 548, 'Barra Funda', '6958-2548', 'AFT9087')

INSERT INTO carro VALUES
('AFT9087', 'VW', 'Gol', 'Preto', 2007),
('DXO9876', 'Ford', 'Ka', 'Azul', 2000),
('EGT4631', 'Renault', 'Clio', 'Verde', 2004),
('LKM7380', 'Fiat', 'Palio', 'Prata', 1997),
('BCD7521', 'Ford', 'Fiesta', 'Preto', 1999)

INSERT INTO peca VALUES
(1, 'Vela', 70),
(2, 'Correia Dentada', 125),
(3, 'Trambulador', 90),
(4, 'Filtro de Ar', 30)

INSERT INTO servico VALUES
('DXO9876', 1, 4, 280, '2020-08-01'),
('DXO9876', 4, 1, 30, '2020-08-01'),
('EGT4631', 3, 1, 90, '2020-08-02'),
('DXO9876', 2, 1, 125, '2020-08-07')

-- Consultar em Subqueries
-- Telefone do dono do carro Ka, Azul
SELECT c.telefone
FROM cliente c
INNER JOIN carro car ON c.carro = car.placa
WHERE car.modelo = 'Ka' AND car.cor = 'Azul'

--Endereço concatenado do cliente que fez o serviço do dia 2020-08-02				
SELECT c.logradouro +' '+ CAST(c.num AS VARCHAR) +' '+ c.bairro AS endereço
FROM cliente c INNER JOIN servico s
ON c.carro = s.carro
WHERE data_servico = '2020-08-02'

--Consultar:				
--Placas dos carros de anos anteriores a 2001	
SELECT placa
FROM carro
WHERE ano < 2001
			
--Marca, modelo e cor, concatenado dos carros posteriores a 2005	
SELECT marca +' '+ modelo +' '+ cor AS Marca_modelo_cor
FROM carro
WHERE ano>2005
			
--Código e nome das peças que custam menos de R$80,00				
SELECT cod,
       nome
FROM peca
WHERE valor < 80.00

