CREATE DATABASE pedido
GO
USE pedido

GO
CREATE TABLE cliente(
codigo            INT           NOT NULL,
nome              VARCHAR(30)   NOT NULL,
logradouro        VARCHAR(50)   NOT NULL,
num               INT           NOT NULL,
telefone          CHAR(08)      NOT NULL,
data_nasc         DATE          NOT NULL
PRIMARY KEY (codigo)
)

GO 
CREATE TABLE fornecedor(
codigo        INT           NOT NULL,
nome          VARCHAR(30)   NOT NULL,
atividade     VARCHAR(50)   NOT NULL,
telefone      CHAR(08)      NOT NULL
PRIMARY KEY (codigo)
)

GO
CREATE TABLE produto(
codigo       INT           NOT NULL,
nome         VARCHAR(100)  NOT NULL,
valor_uni    DECIMAL(7,2)  NOT NULL,
qtd_estoque  INT           NOT NULL,
descricao    VARCHAR(200)  NOT NULL,
fornecedor   INT           NOT NULL
PRIMARY KEY (codigo)
FOREIGN KEY (fornecedor) REFERENCES fornecedor (codigo)
)

GO 
CREATE TABLE pedido(
cod              INT           NOT NULL,
cliente          INT           NOT NULL,
produto          INT           NOT NULL,
quantidade       INT           NOT NULL,
previsao_entrega DATE          NOT NULL
PRIMARY KEY (cod, cliente, produto)
FOREIGN KEY (cliente) REFERENCES cliente (codigo),
FOREIGN KEY (produto) REFERENCES produto (codigo)
)

DROP TABLE pedido

INSERT INTO cliente VALUES
(33601, 'Maria Clara', 'R. 1° de Abril', 870, 96325874, '2000-08-15'),
(33602, 'Alberto Souza', 'R. XV de Novembro', 987, 95873625, '1985-02-02'),
(33603, 'Sonia Silva', 'R. Voluntários da Pátria', 1151, 75418596, '1957-08-23'),
(33604, 'José Sobrinho', 'Av. Paulista', 250, 85236547, '1986-12-09'),
(33605, 'Carlos Camargo', 'Av. Tiquatira', 9652, 75896325, '1971-03-25')

INSERT INTO fornecedor VALUES
(1001, 'Estrela', 'Brinquedo', 41525898),
(1002, 'Lacta', 'Chocolate', 42698596),
(1003, 'Asus', 'Informática', 52014596),
(1004, 'Tramontina', 'Utensílios Domésticos', 50563985),
(1005, 'Grow', 'Brinquedos', 47896325),
(1006, 'Mattel', 'Bonecos', 59865898)

INSERT INTO produto VALUES
(1, 'Banco Imobiliário', 65.00, 15, 'Versão Super Luxo', 1001),
(2, 'Puzzle 5000 peças', 50.00, 5, 'Mapas Mundo', 1005),
(3, 'Faqueiro', 350.00, 0, '120 peças', 1004),
(4, 'Jogo para churrasco', 75.00, 3, '7 peças', 1004),
(5, 'Tablet', 750.00, 29, 'Tablet', 1003),
(6, 'Detetive', 49.00, 0, 'Nova Versão do Jogo', 1001),
(7, 'Chocolate com Paçoquinha', 6.00, 0, 'Barra', 1002),
(8, 'Galak', 5.00, 65, 'Barra', 1002)

INSERT INTO pedido VALUES
(99001, 33601, 1, 1, '2012-06-07'),
(99001, 33601, 2, 1, '2012-06-07'),
(99001, 33601, 8, 3, '2012-06-07'),
(99002, 33602, 2, 1, '2012-06-09'),
(99002, 33602, 4, 3, '2012-06-09'),
(99003, 33605, 5, 1, '2012-06-15')

--Consultar a quantidade, valor total e valor total com desconto (25%) dos itens comprados par Maria Clara.				
SELECT
    p.nome AS Nome_Produto,
    pe.quantidade,
    p.valor_uni,
    pe.quantidade * P.valor_uni AS Valor_Total,
    pe.quantidade * P.valor_uni * 0.75 AS Valor_Total_Com_Desconto
FROM produto p, pedido pe, cliente c
WHERE p.codigo = pe.produto
AND pe.cliente = c.codigo
AND c.nome = 'Maria Clara'

--Verificar quais brinquedos não tem itens em estoque.		
SELECT nome AS brinquedo
FROM  produto
WHERE qtd_estoque = 0

--Alterar para reduzir em 10% o valor das barras de chocolate.			
UPDATE produto 
SET valor_uni = valor_uni * 0.9
WHERE descricao LIKE 'Barra'
SELECT * FROM produto 

--Alterar a quantidade em estoque do faqueiro para 10 peças.			
UPDATE produto
SET qtd_estoque = 10
WHERE nome ='Faqueiro'
SELECT * FROM produto 

--Consultar quantos clientes tem mais de 40 anos.		
SELECT COUNT(*) AS quantidade_clientes_mais_de_40_anos
FROM cliente
WHERE DATEDIFF(YEAR, data_nasc, GETDATE()) > 40

--Consultar Nome e telefone dos fornecedores de Brinquedos e Chocolate.			
SELECT nome,
       telefone
FROM fornecedor
WHERE atividade LIKE 'Brinquedos' OR atividade = 
'Chocolate'

--Consultar nome e desconto de 25% no preço dos produtos que custam menos de R$50,00				
SELECT nome,
        CASE
        WHEN valor_uni < 50.00 THEN valor_uni * 0.75
        ELSE valor_uni
    END AS Preco_Com_Desconto
FROM produto
WHERE valor_uni < 50.00

--Consultar nome e aumento de 10% no preço dos produtos que custam mais de R$100,00				
SELECT nome,
        CASE
        WHEN valor_uni < 100.00 THEN valor_uni * 1.1
        ELSE valor_uni
    END AS Preco_Com_Desconto
FROM produto
WHERE valor_uni > 100.00

--Consultar desconto de 15% no valor total de cada produto da venda 99001.			
SELECT
    p.nome,
    pe.quantidade,
    p.valor_uni,
    0.15 * pe.quantidade * p.valor_uni AS Valor_Desconto,
    pe.quantidade * p.valor_uni * 0.85 AS Valor_Total_Com_Desconto
FROM produto p, pedido pe
WHERE p.codigo = pe.produto
AND pe.cod = 99001

--Consultar Código do pedido, nome do cliente e idade atual do cliente			
SELECT pe.cod,
       c.nome,
       DATEDIFF(YEAR, c.data_nasc, GETDATE()) AS idade_atual
FROM cliente c, pedido pe
WHERE c.codigo = pe.cliente