CREATE DATABASE venda_ex4
GO
USE  venda_ex4


CREATE TABLE cliente(
cpf       VARCHAR(12)         NOT NULL,
nome	  VARCHAR(30)         NOT NULL,
telefone  CHAR(09)
PRIMARY KEY (cpf)
)

GO
CREATE TABLE fornecedor (
id				INT				 NOT NULL,
nome			VARCHAR(30)		 NOT NULL,
logradouro		VARCHAR(80)		 NOT NULL,
num				INT				 NOT NULL,
complemento		VARCHAR(30)		 NOT NULL,
cidade			VARCHAR(30)		 NOT NULL
PRIMARY KEY(id)
)

GO
CREATE TABLE produto (
codigo		INT			    NOT NULL,
descricao	VARCHAR(100)	NOT NULL,
fornecedor	INT				NOT NULL,
preco		DECIMAL(7,2)    NOT NULL
PRIMARY KEY(codigo)
FOREIGN KEY (fornecedor) REFERENCES fornecedor(id)
)

GO
CREATE TABLE venda (
cod 			INT			NOT NULL,
produto			INT			NOT NULL,
cliente			VARCHAR(12) NOT NULL,
quantidade		INT			NOT NULL,
valor_total DECIMAL(7,2)    NOT NULL,
data_venda DATE             NOT NULL
PRIMARY KEY(cod, produto, cliente)
FOREIGN KEY (produto) REFERENCES produto (codigo),
FOREIGN KEY (cliente) REFERENCES cliente(cpf)
)
GO

INSERT INTO cliente VALUES
('345789092-90', 'Julio Cesar', '8273-6541'),
('251865337-10', 'Maria Antonia', '8765-2314'),
('876273154-16', 'Luiz Carlos', '6128-9012'),
('791826398-00', 'Paulo Cesar', '9076-5273')

INSERT INTO fornecedor VALUES
(1, 'LG', 'Rod. Bandeirantes', 70000, 'Km 70', 'Itapeva'),
(2, 'Asus', 'Av. Nações Unidas', 10206, 'Sala 225', 'São Paulo'),
(3, 'AMD', 'Av. Nações Unidas', 10206, 'Sala 1095', 'São Paulo'),
(4, 'Leadership', 'Av. Nações Unidas', 10206, 'Sala 87', 'São Paulo'),
(5, 'Inno', 'Av. Nações Unidas', 10206, 'Sala 34', 'São Paulo')

INSERT INTO produto VALUES
(1, 'Monitor 19 pol.', 1, 449.99),
(2, 'Netbook 1GB Ram 4 Gb HD', 2, 699.99),
(3, 'Gravador de DVD - Sata', 1, 99.99),
(4, 'Leitor de CD', 1, 49.99),
(5, 'Processador - Phenom X3 - 2.1GHz', 3, 349.99),
(6, 'Mouse', 4, 19.99),
(7, 'Teclado', 4, 25.99),
(8, 'Placa de Video - Nvidia 9800 GTX - 256MB/256 bits', 5, 599.99)

INSERT INTO venda VALUES
(1, 1, '251865337-10', 1, 449.99, '2009-09-03'),
(2, 4, '251865337-10', 1, 49.99, '2009-09-03'),
(3, 5, '251865337-10', 1, 349.99, '2009-09-03'),
(4, 6, '791826398-00', 4, 79.96, '2009-09-06'),
(5, 8, '876273154-16', 1, 599.99, '2009-09-06'),
(6, 3, '876273154-16', 1, 99.99, '2009-09-06'),
(7, 7, '876273154-16', 1, 25.99, '2009-09-06'),
(4, 2, '345789092-90', 2, 1399.98, '2009-09-08')

--Consultar no formato dd/mm/aaaa: Data da Venda 4		
SELECT CONVERT(VARCHAR, data_venda, 101) AS data_formatada
FROM venda
WHERE cod = 4

--Inserir na tabela Fornecedor, a coluna Telefone e os seguintes dados:	
--1	7216-5371
--2	8715-3738
--4	3654-6289

ALTER TABLE fornecedor
ADD telefone CHAR(09)

UPDATE fornecedor
SET telefone = '7216-5371'
WHERE ID = 1

UPDATE fornecedor
SET telefone = '8715-3738'
WHERE ID = 2

UPDATE fornecedor
SET telefone = '3654-6289'
WHERE ID = 4

--Consultar por ordem alfabética de nome, o nome, o enderço concatenado e o telefone dos fornecedores						
SELECT nome,
       logradouro +' '+CAST(num AS VARCHAR )+' ' +complemento,
	   telefone
FROM fornecedor
ORDER BY nome

--Consultar:						
--Produto, quantidade e valor total do comprado por Julio Cesar					
SELECT p.descricao,
       v.quantidade,
       v.valor_total 
FROM produto p, venda v, cliente c
 WHERE p.codigo = v.produto
AND v.cliente = c.cpf
AND c.nome = 'Julio Cesar'

--Data, no formato dd/mm/aaaa e valor total do produto comprado por  Paulo Cesar
SELECT CONVERT(VARCHAR, data_venda, 101) AS data_formatada,
       p.descricao,
       v.valor_total 
FROM produto p, venda v, cliente c
WHERE p.codigo = v.produto
AND v.cliente = c.cpf
AND c.nome = 'Paulo Cesar'

--Consultar, em ordem decrescente, o nome e o preço de todos os produtos 	
SELECT descricao,
       preco
FROM produto
ORDER BY preco DESC, descricao DESC