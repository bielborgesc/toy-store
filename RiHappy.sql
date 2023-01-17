-- Criando base de dados --
CREATE DATABASE RIHAPPY;
-- Selecionando a base de dados --
USE RIHAPPY;
-- Criando Tabela Cliente --
CREATE TABLE CLIENTE(
	CPF VARCHAR(14),
    NOME VARCHAR(40) NOT NULL,
    NASCIMENTO DATE,
    RUA VARCHAR(50),
    BAIRRO VARCHAR(50),
    NUMERO NUMERIC(5),
    CIDADE VARCHAR(30),
    CONSTRAINT PK_CLIENTE PRIMARY KEY(CPF)
);

CREATE TABLE TEL_CLIENTES(
	ID_CLIENTE VARCHAR(14),
    TELEFONES VARCHAR(14),
    CONSTRAINT FK_CLIENTE FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(CPF)
);
-- Criando Tabela Funcionario --
CREATE TABLE FUNCIONARIO(
	NOME VARCHAR(40) NOT NULL,
    CPF VARCHAR(14),
	NUM_CART VARCHAR(14),
    NUMERO NUMERIC(5),
	BAIRRO VARCHAR(50),
    RUA VARCHAR(50),
    CIDADE VARCHAR(30),
    FUNÇÃO VARCHAR(20) NOT NULL,
    FERIAS DATE,
    DIA_NASC NUMERIC(2),
    MES_NASC NUMERIC(2),
    ANO_NASC NUMERIC(4),
    SALARIO NUMERIC(8,2),
    CONSTRAINT UNI_CPF_FUN UNIQUE(CPF),
    CONSTRAINT PK_FUN PRIMARY KEY(NUM_CART),
    CONSTRAINT CH_FUN_DIA CHECK(DIA_NASC < 31),
	CONSTRAINT CH_FUN_MES CHECK(MES_NASC < 12)
);
-- Dependente de Funcionario -- 
CREATE TABLE DEPENDENTES(
	ID_FUNC VARCHAR(14),
    NOME VARCHAR(40),
    DATA_NASC DATE NOT NULL,
    CONSTRAINT PK_DEP PRIMARY KEY(NOME),
    CONSTRAINT FK_DEP_FUN FOREIGN KEY(ID_FUNC) REFERENCES FUNCIONARIO(NUM_CART)
);

-- Criando Tabela Compra --
CREATE TABLE COMPRA(
	NOTA_FISCAL VARCHAR(10),
    ID_CLIENTE VARCHAR(14),
    ID_FUNCIONARIO VARCHAR(14),
    CONSTRAINT PK_COMPRA PRIMARY KEY(NOTA_FISCAL),
    CONSTRAINT PK_COMP_CLI FOREIGN KEY(ID_CLIENTE) REFERENCES CLIENTE(CPF),
    CONSTRAINT PK_COMP_FUN FOREIGN KEY(ID_FUNCIONARIO) REFERENCES FUNCIONARIO(NUM_CART)
);

-- Criando Tabela Brinquedos --
CREATE TABLE BRINQUEDO(
	ID VARCHAR(7),
    NOME VARCHAR(30) NOT NULL,
    QTDD_ESTOQUE NUMERIC(5) NOT NULL,
    CONSTRAINT PK_BRIN PRIMARY KEY(ID)
);

CREATE TABLE BRINQUEDO_PROMO(
	ID_BRINQUEDO VARCHAR(8),
    QTDD_MAX NUMERIC(5) NOT NULL,
    QTDD_DISPONIVEL NUMERIC(5),
    VALOR_DESC NUMERIC(3),
    CONSTRAINT FK_PRO_BRIN FOREIGN KEY(ID_BRINQUEDO) REFERENCES BRINQUEDO(ID),
    CONSTRAINT CH_PRO_BRI CHECK(QTDD_MAX > QTDD_DISPONIVEL)
);
-- Criando Tabela Setores --
CREATE TABLE SETORES(
	CATEGORIA VARCHAR(10),
    DESCRICAO VARCHAR(100),
    ID_GERENTE VARCHAR(14),
    CONSTRAINT PK_SE PRIMARY KEY(CATEGORIA),
    CONSTRAINT FK_SE_GER FOREIGN KEY(ID_GERENTE) REFERENCES FUNCIONARIO(NUM_CART)
);
-- Criando Tabela Fornecedor --
CREATE TABLE FORNECEDOR(
	CNPJ VARCHAR(18),
    NOME VARCHAR(100) NOT NULL,
    CONSTRAINT PK_FORN PRIMARY KEY(CNPJ)
);

-- Relacionamento Fornece --
CREATE TABLE FORNECE(
	ID_FORNECEDOR VARCHAR(18),
    ID_BRINQUEDO VARCHAR(8),
    CONSTRAINT FK_ID_FOR FOREIGN KEY(ID_FORNECEDOR) REFERENCES FORNECEDOR(CNPJ),
    CONSTRAINT FK_ID_BRI FOREIGN KEY(ID_BRINQUEDO) REFERENCES BRINQUEDO(ID)
);

-- Relacionamento Localizado --
CREATE TABLE LOCALIZADO(
	ID_SETOR VARCHAR(10),
    ID_BRINQUEDO VARCHAR(7),
    CONSTRAINT FK_ID_SET FOREIGN KEY(ID_SETOR) REFERENCES SETORES(CATEGORIA),
    CONSTRAINT FK_ID_BRI_LOC FOREIGN KEY(ID_BRINQUEDO) REFERENCES BRINQUEDO(ID)
);

-- Relacionamento Trabalha --
CREATE TABLE TRABALHA(
	ID_SETOR VARCHAR(10),
    ID_FUNCIONARIO VARCHAR(14),
    CONSTRAINT FK_ID_SET_TRAB FOREIGN KEY(ID_SETOR) REFERENCES SETORES(CATEGORIA),
    CONSTRAINT FK_ID_FUN_TRAB FOREIGN KEY(ID_FUNCIONARIO) REFERENCES FUNCIONARIO(NUM_CART)
);

-- Relacionamento Contem --
CREATE TABLE CONTEM(
	ID_COMPRA VARCHAR(10),
    ID_BRINQUEDO VARCHAR(7),
    QTDD NUMERIC(4) NOT NULL,
    CONSTRAINT FK_ID_COM FOREIGN KEY(ID_COMPRA) REFERENCES COMPRA(NOTA_FISCAL),
    CONSTRAINT FK_ID_BRI_CONT FOREIGN KEY(ID_BRINQUEDO) REFERENCES BRINQUEDO(ID)
);

-- Cadastrando Dados Cliente--
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('239.896.123-01','CARLOS ALVES DIAS','1986-05-31','Boa Vista','Planalto',9270,'Rio Branco');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('505.721.888-38','JOSE OLIVEIRA MENDES','1990-04-20','Tiradentes','Vila Nova',9746,'Lagarto');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('031.240.213-98','MARCIA SOUZA MOURA','1990-02-04','Doze','Boa Vista',7044,'Natal');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('606.235.708-07','FERNANDA CASTRO CARVALHO','1993-10-22','Santa Rita','Planalto',753,'São José');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('474.186.652-10','LUIZ DUARTE TEIXEIRA','1999-05-05','São Paulo','Centro',5398,'Almirante Tamandaré');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('426.982.139-65','LUIZ ALMEIDA CARDOSO','1982-12-30','São João','Boa Vista',6769,'Rio Branco');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('981.276.376-70','ANTONIA MIRANDA BATISTA','1997-06-21','Belo Horizonte','Vila Nova',9979,'Jaboatão dos Guararapes');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('689.885.681-25','ADRIANA BORGES BARBOSA','1997-07-27','Piauí','Vila Nova',9324,'Parnaíba');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('922.206.427-55','LUCAS DIAS LIMA','1991-01-12','São Jorge','Industrial',875,'Ariquemes');
INSERT INTO CLIENTE(CPF, NOME, NASCIMENTO, RUA, BAIRRO, NUMERO, CIDADE) VALUES('576.718.650-28','JULIANA GONÇALVES FERREIRA','1994-02-19','Castro Alves','Planalto',1317,'Boa Vista');

INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('239.896.123-01','(69)94608-8234');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('505.721.888-38','(69)43500-3824');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('505.721.888-38','(68)44451-3403');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('031.240.213-98','(41)68419-9124');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('606.235.708-07','(68)99157-2341');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('606.235.708-07','(41)90104-4331');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('474.186.652-10','(84)61943-2167');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('474.186.652-10','(84)97200-7432');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('474.186.652-10','(11)67024-3501');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('426.982.139-65','(11)96905-5990');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('981.276.376-70','(82)70039-6045');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('689.885.681-25','(82)91062-9212');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('922.206.427-55','(95)31092-2461');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('922.206.427-55','(83)12998-2610');
INSERT INTO TEL_CLIENTES(ID_CLIENTE, TELEFONES) VALUES ('576.718.650-28','(95)91199-9827');

-- Cadastrando Funcionarios --
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('FRANCISCO FREITAS DIAS', '238.711.320-98', '313.30199.12-9', 1458, 'Conjunto Habitacional Boa Vista', 'Rua Doutor Bilu', 'Aracaju', 'Gerente', '2021-09-22', 24, 7, 2001, 3373);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('PATRICIA FREITAS DIAS', '294.224.650-28', '486.57166.85-0', 3700, 'Centro', 'Acesso de Serviço PL 10', 'Manaus', 'Caixa', '2021-03-13', 15, 10, 1999, 5907);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('LUIZ PEREIRA DIAS', '500.279.040-24', '509.90764.11-3', 1325, 'Caixa DÁgua', 'Travessa das Flores', 'Maceió', 'Caixa', '2021-11-08', 25, 2, 2004, 978500);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('ANTONIA MACHADO FERREIRA', '908.603.740-25', '538.95419.11-5', 1706, 'Muca', 'Travessa José Rosendo dos Santos', 'Sinop', 'Limpeza', '2021-09-07', 27, 10, 1998, 6823);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('ALINE COSTA RIBEIRO', '775.493.430-20', '815.87478.19-1', 6115, 'Castelo Branco', 'Alameda dos José Carlos Vital', 'Belém', 'Limpeza', '2021-11-28', 15,  1, 1996, 6809);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('JOAO DUARTE RIBEIRO', '447.124.030-71', '235.24450.86-1', 4358, 'Rua Alasca', 'Rua Flora', 'Fortaleza', 'Vendedor', '2021-07-02', 7, 1, 1995, 4930);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('LUCAS SANTOS FREITAS', '504.579.890-17', '835.53142.56-1', 4418, 'Tarumã', 'Rua Plácido de Castro', 'Campina Grande', 'Gerente', '2021-02-27', 14, 8, 2002, 7362);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('JOSE NASCIMENTO MORAES', '687.901.030-09', '367.86690.96-9', 7581, 'Valparaíso', 'Vila Santos', 'São Mateus', 'Repositor', '2021-11-11', 26, 7, 1995, 8900);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('JOSE COSTA MORAES', '023.618.600-07', '620.70251.22-3', 7103, 'José Maksoud', 'Rua Blumenau', 'João Pessoa', 'Repositor', '2021-11-10', 4, 2, 1998, 1318);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('ADRIANA MARTINS COSTA', '702.588.520-70', '413.91246.58-2', 4086, 'Uruguai', 'Rua Kleber Afonso', 'Caruaru', 'Vendedor', '2021-08-13', 6, 11, 1997, 6997);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Gusttavo Colaço Lemos', '065.919.040-00', '202.44743.30-9', 168, 'Boa Vista', 'Espírito Santo', 'Novo Hamburgo', 'Gerente', '2021-03-13', 6, 1, 1997, 3309);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Sofia Vilante Reis', '485.034.230-22', '451.47672.12-0', 611, 'Santo Antônio', 'Dezessete', 'Ji-Paraná', 'Gerente', '2021-11-08', 5, 11, 1990, 3101);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Lisandra Caçoilo Ruas', '875.988.390-18', '118.63386.19-4', 206, 'São Francisco', 'Projetada', 'Mossoró', 'Gerente', '2021-09-07', 2, 12, 1993, 2182);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Rúbia Azambuja Lages', '668.611.700-54', '857.26456.96-8', 972, 'Santo Antônio', 'Treze de Maio', 'Águas Lindas de Goiás', 'Gerente', '2021-11-28', 5, 2, 1991, 6571);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Aleksandr Bogado Protásio', '848.150.140-94', '977.03603.73-9', 115, 'São Francisco', 'Quinze', 'Aracaju', 'Gerente', '2021-07-02', 11, 3, 2004, 4502);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Matilda Paião Bentes', '315.805.040-43', '469.32028.74-6', 398, 'São Cristóvão', 'Santo Antônio', 'Barcarena', 'Gerente', '2021-02-27', 11, 11, 1990, 4560);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Mia Veiga Uchoa', '494.816.910-20', '127.02166.92-1', 370, 'São José', 'da Paz', 'Santa Bárbara do Oeste', 'Gerente', '2021-11-11', 2, 10, 1994, 4329);
INSERT INTO FUNCIONARIO(NOME, CPF, NUM_CART, NUMERO, BAIRRO, RUA, CIDADE, FUNÇÃO, FERIAS, DIA_NASC, MES_NASC, ANO_NASC, Salario) VALUE('Elvira Cisneiros Melo', '720.395.730-62', '467.43146.83-0', 887, 'Vila Nova', 'Minas Gerais', 'Santana', 'Gerente', '2021-11-10', 1, 1, 1992, 5897);


-- Cadastro Dependentes -- 
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('313.30199.12-9', 'Ana Lalanda Silveira', '2014-09-20');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('313.30199.12-9', 'Muriel Rebocho Landim', '2005-11-03');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('313.30199.12-9', 'Ryan Barreto Pessoa', '2005-12-02');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('538.95419.11-5', 'Juliana Boto Ramos', '2005-07-31');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('538.95419.11-5', 'Rosário Lemos Quintal', '2014-07-15');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('235.24450.86-1', 'Cassandra Linhares Barreiros', '2014-01-15');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('367.86690.96-9', 'Dominique Valim Penteado', '2005-11-08');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('413.91246.58-2', 'Orlando César Salgado', '2005-06-01');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('835.53142.56-1', 'Enrique Figueira Horta', '2015-02-10');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('835.53142.56-1', 'Olga Casado Lara', '2014-09-16');
INSERT INTO DEPENDENTES(ID_FUNC, NOME, DATA_NASC) VALUES ('509.90764.11-3', 'Natália Rios Barreto', '2017-01-16');

-- Cadastrando Compras--
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('4420193952','239.896.123-01', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('3929139086','505.721.888-38', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('4826486696','505.721.888-38', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('9324593178','031.240.213-98', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('2803227583','606.235.708-07', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('8616510513','606.235.708-07', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('6557568242','474.186.652-10', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('5704613458','474.186.652-10', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('2166261477','474.186.652-10', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('3741338794','426.982.139-65', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('4206240831','981.276.376-70', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('8243352714','689.885.681-25', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('9045789357','922.206.427-55', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('6660014981','922.206.427-55', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('7157598880','576.718.650-28', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('6879694102','606.235.708-07', '509.90764.11-3');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('8250827259','576.718.650-28', '486.57166.85-0');
INSERT INTO COMPRA(NOTA_FISCAL, ID_CLIENTE, ID_FUNCIONARIO) VALUE ('6904067679','031.240.213-98', '509.90764.11-3');

-- Cadastrando Brinquedos --
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('V3J 2C4','Bola Futebol Nike', 743);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('B1U 2A8','Ludo', 549);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('J5I 2C7','Corda', 882);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('D8L 4G1','Hot Whels', 704);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('T6E 2D5','Quebra-Cabeça World', 290);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('I8V 7D1','Barbie', 376);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('I7C 7V7','Max Steel', 468);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('L1H 4W6','Polly', 839);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('R6L 1X8','Carrinho De Controle Remoto', 813);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('B5Z 0U6','Carrinho de Rolimã', 359);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('J4I 2C7','PS4', 501);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('D8N 0Y2','Xbox', 1000);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('G6D 6J8','Nitendo', 150);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('M2L 5N7','UNO', 864);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('B5G 8R3','Baralho', 841);
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('X5W 8C4','Espada Rei Artur', 842);

-- Cadastrando Brinquedos Promoção --
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('V3J 2C4',104, 105,5);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('B1U 2A8',107, 200,10);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('J5I 2C7',98, 150,15);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('D8L 4G1',10, 90,20);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('T6E 2D5',15, 118,25);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('I8V 7D1',12, 200,50);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('I7C 7V7',150, 200,75);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('L1H 4W6',92, 300,20);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('R6L 1X8',250, 301,10);
INSERT INTO BRINQUEDO_PROMO(ID_BRINQUEDO, QTDD_DISPONIVEL, QTDD_MAX, VALOR_DESC) VALUE('B5Z 0U6',302, 350,5);

-- Cadastrando Setores --
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Esporte', 'Todo tipo de equipamento', '202.44743.30-9');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Puzzle', 'Jogos que estimulam a memoria', '451.47672.12-0');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Bonecos', 'Bonecos de ação', '118.63386.19-4');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Carros', 'Carrinhos de brinquedos', '857.26456.96-8');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Video Game', 'Vários tipos de consoles', '977.03603.73-9');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Armas', 'Armas de brinquedo', '469.32028.74-6');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Street', 'Equipamentos para brincadeiras ao ar livre', '127.02166.92-1');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Cartas', 'Jogos que usam cartas', '467.43146.83-0');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Hot Whels', 'Um setor patrocinado', '313.30199.12-9');
INSERT INTO SETORES(CATEGORIA, DESCRICAO, ID_GERENTE) VALUES('Bonecas', 'Varios tipos de bonecas', '835.53142.56-1');

-- Cadastrando Fornecedores --
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Jaqueline e Cecília Toys Ltda', '61.736.017/0001-04');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Ruan e Levi Brinquedos ME', '96.793.514/0001-10');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Kaique e Antônia Brinks ME', '17.260.021/0001-49');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Henrique e Breno Herois Ltda', '26.062.884/0001-00');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Andrea e Thomas Contábil ME', '13.810.086/0001-60');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Rafael e Antonio Entregas Expressas ME', '94.633.274/0001-61');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Márcia e Marina Transportes ME', '33.367.916/0001-33');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Adriana e Letícia Locações de Automóveis ME', '65.586.777/0001-25');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Eliane e Francisco Filmagens ME', '92.877.888/0001-63');
INSERT INTO FORNECEDOR(NOME, CNPJ) VALUES('Louise e Henry Entregas Expressas Ltda', '76.656.312/0001-10');

-- Cadastrando Fornecimentos --
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('61.736.017/0001-04', 'V3J 2C4');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('96.793.514/0001-10', 'B1U 2A8');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('96.793.514/0001-10', 'J5I 2C7');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('17.260.021/0001-49', 'D8L 4G1');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('17.260.021/0001-49', 'T6E 2D5');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('26.062.884/0001-00', 'I8V 7D1');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('13.810.086/0001-60', 'I7C 7V7');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('13.810.086/0001-60', 'L1H 4W6');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('94.633.274/0001-61', 'R6L 1X8');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('94.633.274/0001-61', 'B5Z 0U6');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('33.367.916/0001-33', 'J4I 2C7');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('33.367.916/0001-33', 'D8N 0Y2');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('33.367.916/0001-33', 'G6D 6J8');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('65.586.777/0001-25', 'M2L 5N7');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('92.877.888/0001-63', 'B5G 8R3');
INSERT INTO FORNECE(ID_FORNECEDOR, ID_BRINQUEDO) VALUES('92.877.888/0001-63', 'X5W 8C4');

-- Cadastro de Localizações -- 
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Esporte', 'V3J 2C4');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Puzzle', 'B1U 2A8');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Puzzle', 'T6E 2D5');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Bonecos', 'I7C 7V7');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Carros', 'R6L 1X8');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Video Game','J4I 2C7');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Video Game','D8N 0Y2');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Video Game','G6D 6J8');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Armas', 'X5W 8C4');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Street', 'J5I 2C7');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Street', 'B5Z 0U6');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Cartas', 'M2L 5N7');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Cartas', 'B5G 8R3');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Hot Whels', 'D8L 4G1');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Bonecas', 'I8V 7D1');
INSERT INTO LOCALIZADO(ID_SETOR, ID_BRINQUEDO) VALUES ('Bonecas', 'L1H 4W6');

-- Cadastro de Trabalhadores no Setor --
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Esporte', '538.95419.11-5');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Puzzle' , '815.87478.19-1');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Bonecos' , '815.87478.19-1');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Carros', '815.87478.19-1');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Video Game', '235.24450.86-1');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Armas', '235.24450.86-1');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Street', '235.24450.86-1');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Cartas' , '235.24450.86-1');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Cartas' , '367.86690.96-9');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Hot Whels', '367.86690.96-9');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Bonecas', '620.70251.22-3');
INSERT INTO TRABALHA(ID_SETOR, ID_FUNCIONARIO) VALUES ('Bonecas', '413.91246.58-2');

-- Cadastro Dos Brinquedos Na Compra --
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('4420193952', 'V3J 2C4', 25);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('3929139086', 'B1U 2A8', 11);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('4826486696', 'J5I 2C7', 13);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('9324593178', 'D8L 4G1', 35);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('2803227583', 'T6E 2D5', 33);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('8616510513', 'I8V 7D1', 20);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('6557568242', 'I7C 7V7', 46);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('5704613458', 'L1H 4W6', 23);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('2166261477', 'R6L 1X8', 37);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('3741338794', 'B5Z 0U6', 2);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('4206240831', 'J4I 2C7', 8);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('8243352714', 'D8N 0Y2', 25);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('9045789357', 'G6D 6J8', 4);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('6660014981', 'M2L 5N7', 36);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('7157598880', 'M2L 5N7', 44);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('6879694102', 'B5G 8R3', 18);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('8250827259', 'X5W 8C4', 18);
INSERT INTO CONTEM(ID_COMPRA, ID_BRINQUEDO, QTDD) VALUES('6904067679', 'X5W 8C4', 36);

-- Uptades --
SET SQL_SAFE_UPDATES=0;
-- Aumento de 5% para todos os Gerentes
UPDATE FUNCIONARIO SET Salario = Salario*1.05 WHERE FUNÇÃO = 'Gerente';
-- Mudando a cidade do CARLOS ALVES DIAS
UPDATE CLIENTE SET CIDADE = 'São Carlos' WHERE CPF = '239.896.123-01';
-- Mudando o numero de telefone do CARLOS ALVES DIAS
UPDATE TEL_CLIENTES SET TELEFONES = '(17)99305-3105' WHERE ID_CLIENTE = '239.896.123-01';
-- Mudando a data de nascimento  da Ana Lalanda
UPDATE DEPENDENTES SET DATA_NASC = '2000-01-01' WHERE NOME = 'Ana Lalanda Silveira';
-- Trocando o nome do brinquedo Bola
UPDATE BRINQUEDO SET NOME = 'Bola Adidas' WHERE NOME = 'Bola Futebol Nike';
-- Aumentando a quantidade disponivel do brinquedo ludo 
UPDATE BRINQUEDO_PROMO SET QTDD_DISPONIVEL = QTDD_DISPONIVEL + 3 WHERE ID_BRINQUEDO = 'B1U 2A8';
-- Trocando o nome de uma transportadora
UPDATE FORNECEDOR SET NOME = 'Márcia e Amarilda Locações ME' WHERE CNPJ = '61.736.017/0001-04';
-- Alterando a descriçao de um setor
UPDATE SETORES SET DESCRICAO = 'Setor será fechado em 25/07' WHERE CATEGORIA = 'Hot Whels';
-- Nivelando Salarios dos gerentes
UPDATE FUNCIONARIO SET SALARIO = 4000 WHERE FUNÇÃO = 'Gerente';
-- Corrigindo a qtdd de uma compra
UPDATE CONTEM SET QTDD = 20 WHERE ID_COMPRA = '4420193952';
-- Exibir Dados -- 
SELECT * FROM CLIENTE;
SELECT * FROM TEL_CLIENTES;
SELECT * FROM COMPRA;
SELECT * FROM FUNCIONARIO;
SELECT * FROM DEPENDENTES;
SELECT * FROM BRINQUEDO;
SELECT * FROM BRINQUEDO_PROMO;
SELECT * FROM SETORES;
SELECT * FROM FORNECEDOR;
SELECT * FROM FORNECE;
SELECT * FROM LOCALIZADO;
SELECT * FROM TRABALHA;
SELECT * FROM CONTEM;

-- Consultas no Banco

-- Exibir o nome de todos os gerentes ou Caixas que trabalham na 
-- empresa com salario menor que 60000, e ordene os salarios em ordem decrescente
SELECT NOME, FUNÇÃO, SALARIO 
FROM FUNCIONARIO 
WHERE (FUNÇÃO = 'Gerente' OR FUNÇÃO = 'Caixa')
AND SALARIO < 60000
ORDER BY SALARIO DESC;
-- Mostre todos os Clientes que moram em uma cidade que o nome dela começa com 'S' ou a segunda letra é 'A'
-- e que nasceram entre de 1990 e 2000, e ordene do mais velho até o mais novo
SELECT NOME, CIDADE, NASCIMENTO
FROM CLIENTE 
WHERE (CIDADE LIKE  'S%' OR CIDADE LIKE '_a%') 
AND NASCIMENTO BETWEEN '1990-01-01' AND '2000-01-01'
ORDER BY NASCIMENTO;
-- Liste todos os dependentes que possuem o id do funcionario = '313.30199.12-9 ou '835.53142.56-1' 
-- E que ultima letra do nome seja 'A'
-- Mostre os nomes dos dependentes com a letra Maiuscula e apenas as 10 primeiras letras
SELECT UPPER(SUBSTR(NOME,1,10)) AS NOME, ID_FUNC 
FROM DEPENDENTES
WHERE ID_FUNC IN ('835.53142.56-1', '313.30199.12-9') AND NOME LIKE '%a';
-- Consulte todos os dependentes do Funcionario FRANCISCO FREITAS DIAS
SELECT F.NOME, F.NUM_CART, D.NOME AS DEPENDENTE
FROM FUNCIONARIO F JOIN DEPENDENTES D
ON F.NUM_CART = D.ID_FUNC
WHERE F.NOME = 'FRANCISCO FREITAS DIAS';
-- Consulte as compras que PATRICIA FREITAS DIAS efetivou e exibiba a nota fiscal de cada compra
SELECT F.NOME AS FUNCIONARIO, C.NOTA_FISCAL
FROM FUNCIONARIO F JOIN COMPRA C
ON F.NUM_CART = ID_FUNCIONARIO
WHERE F.NOME = 'PATRICIA FREITAS DIAS';
-- Consulte as compras que PATRICIA FREITAS DIAS efetivou e 
-- exibiba a nota fiscal e o nome dos clientes para quem ele vendeu
SELECT F.NOME AS FUNCIONARIO, C.NOTA_FISCAL, CL.NOME
FROM FUNCIONARIO F JOIN COMPRA C
ON F.NUM_CART = ID_FUNCIONARIO
JOIN CLIENTE CL
ON CL.CPF = C.ID_CLIENTE
WHERE F.NOME = 'PATRICIA FREITAS DIAS';
-- Consulte as compras que PATRICIA FREITAS DIAS efetivou e 
-- exibiba a nota fiscal e o nome dos clientes para quem ele vendeu.
-- Mostre também os produtos levados pelos clientes
SELECT F.NOME AS FUNCIONARIO, C.NOTA_FISCAL, CL.NOME, B.NOME AS BRINQUEDO
FROM FUNCIONARIO F JOIN COMPRA C
ON F.NUM_CART = ID_FUNCIONARIO
JOIN CLIENTE CL
ON CL.CPF = C.ID_CLIENTE
JOIN CONTEM CO
ON C.NOTA_FISCAL = ID_COMPRA
JOIN BRINQUEDO B
ON B.ID = CO.ID_BRINQUEDO
WHERE F.NOME = 'PATRICIA FREITAS DIAS';
-- Exibir os setores que tem pessoas na Limpeza
SELECT S.CATEGORIA AS SETOR
FROM SETORES S JOIN TRABALHA T
ON S.CATEGORIA = ID_SETOR
WHERE T.ID_FUNCIONARIO IN (SELECT NUM_CART
							FROM FUNCIONARIO F
                            WHERE F.FUNÇÃO = 'Limpeza');
-- Liste os brinquedos que não estão em promoção
SELECT B.NOME
FROM BRINQUEDO B
WHERE NOT EXISTS (SELECT ID_BRINQUEDO 
					FROM BRINQUEDO_PROMO PO
                    WHERE PO.ID_BRINQUEDO = B.ID);
-- Liste os brinquedos que tiveram uma quantidade comprada maior que 30
SELECT B.NOME, SUM(C.QTDD) AS QTDD_COMPRADA
FROM BRINQUEDO B JOIN CONTEM C
ON C.ID_BRINQUEDO = B.ID
GROUP BY B.NOME
HAVING QTDD_COMPRADA > 30;
-- Liste o brinquedo que foram contidos em mais de uma venda
SELECT B.NOME, COUNT(B.NOME) AS QTDD
FROM BRINQUEDO B JOIN CONTEM C
ON C.ID_BRINQUEDO = B.ID
GROUP BY B.NOME
HAVING QTDD > 1;
-- Liste todos os brinquedos que estão no setor de Video Game ou Puzzle e a sua quantidade
SELECT NOME, QTDD_ESTOQUE
FROM BRINQUEDO
WHERE ID IN (SELECT ID_BRINQUEDO
				FROM LOCALIZADO
                WHERE ID_SETOR IN (SELECT CATEGORIA
									FROM SETORES
                                    WHERE CATEGORIA IN ('Video Game','Puzzle')));
-- Junte a tabela de clientes e de funcionarios e exiba seus nomes e CPFs
SELECT NOME, CPF FROM FUNCIONARIO
UNION ALL
SELECT NOME, CPF FROM CLIENTE;
-- Cadastro de um novo brinquedo para testar o que foi solicitado abaixo pois todos os brinquedos ja foram comprados ao menos uma vez
INSERT INTO BRINQUEDO(ID, NOME, QTDD_ESTOQUE) VALUES('C4B 8D3','Peão', 743);
-- Liste os brinquedos comprados e as suas quantidades inclusives aqueles que não foram comprados
SELECT B.NOME, B.QTDD_ESTOQUE, C.ID_COMPRA
FROM BRINQUEDO B LEFT JOIN CONTEM C
ON B.ID = C.ID_BRINQUEDO;
-- Mostre os brinquedos e seus fornecedores assim como os que não tem fornecedores
SELECT B.NOME, F.NOME AS FORNECEDOR
FROM BRINQUEDO B LEFT JOIN FORNECE FE
ON B.ID = FE.ID_BRINQUEDO
LEFT JOIN FORNECEDOR F
ON F.CNPJ = FE.ID_FORNECEDOR
ORDER BY F.NOME, B.NOME;