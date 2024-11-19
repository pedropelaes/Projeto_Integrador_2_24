-- Criar sequências para cada tabela
CREATE SEQUENCE SEQ_USUARIO START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_EVENTO START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_WALLET START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_HIST_TRANSACAO START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_HIST_APOSTAS START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_MODERADOR START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE SEQ_APOSTA START WITH 1 INCREMENT BY 1;

-- Tabela USUARIO
CREATE TABLE USUARIO (
    ID_USUARIO INT PRIMARY KEY,
    EMAIL VARCHAR2(150) NOT NULL UNIQUE,  -- Atualizado para 150 caracteres
    NOME VARCHAR2(100) NOT NULL,           -- Atualizado para 100 caracteres
    SENHA VARCHAR2(50) NOT NULL,           -- Atualizado para 50 caracteres
    DATA_NASCIMENTO DATE NOT NULL,
    TOKEN_SESSAO VARCHAR2(50)
);

-- Tabela EVENTOS
CREATE TABLE EVENTOS (
    ID_EVENTO INT PRIMARY KEY,
    TITULO VARCHAR2(50) NOT NULL UNIQUE,
    DESCRICAO VARCHAR2(150) NOT NULL,
    DATA_INICIO DATE NOT NULL,
    DATA_FIM DATE NOT NULL,
    DATA_EVENTO DATE NOT NULL,
    STATUS VARCHAR2(255) NOT NULL,
    valorCota INT NOT NULL,                  -- Valor da cota
    quantidadeCotas INT NOT NULL,
    TOTAL_APOSTA INT NOT NULL,               -- Substituído VALOR_COTA por TOTAL_APOSTA
    RESULTADO_EVENTO VARCHAR2(5),                 -- Novo campo, pode ser nulo ou não
    ID_CRIADOR INT,
    CONSTRAINT fk_criador FOREIGN KEY (ID_CRIADOR) REFERENCES USUARIO(id_usuario)
);

-- Tabela WALLET
CREATE TABLE WALLET (
    ID_WALLET INT PRIMARY KEY,
    SALDO NUMBER(10, 2) NOT NULL,
    id_usuario INT NOT NULL,                 -- FK para Usuario
    CONSTRAINT fk_usuario FOREIGN KEY (id_usuario) REFERENCES Usuario(id_usuario)
);

-- Tabela HISTORICO_APOSTAS
CREATE TABLE HISTORICO_APOSTAS (
    ID_APOSTA INT PRIMARY KEY,
    FK_ID_USUARIO INT NOT NULL,     -- Chave estrangeira para USUARIO
    FK_ID_EVENTO INT NOT NULL,      -- Chave estrangeira para EVENTOS
    FK_ID_WALLET INT NOT NULL,      -- Chave estrangeira para WALLET
    HORA_APOSTA TIMESTAMP NOT NULL,
    DATA_APOSTA DATE NOT NULL,
    COTAS INT NOT NULL,
    VALOR NUMBER(10, 2) NOT NULL,
    OPCAO_APOSTA INT NOT NULL,  -- '0' ou '1'
    CONSTRAINT FK_ID_USUARIO_ FOREIGN KEY (FK_ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    CONSTRAINT FK_ID_EVENTO FOREIGN KEY (FK_ID_EVENTO) REFERENCES EVENTOS(ID_EVENTO),
    CONSTRAINT FK_ID_WALLET FOREIGN KEY (FK_ID_WALLET) REFERENCES WALLET(ID_WALLET)
);

-- Tabela HISTORICO_TRANSACAO
CREATE TABLE HISTORICO_TRANSACAO (
    ID_TRANSACAO INT PRIMARY KEY,
    FK_ID_WALLET INT NOT NULL,      -- Chave estrangeira para WALLET
    TIPO_TRANSACAO VARCHAR2(150) NOT NULL,
    DATA_TRANSACAO DATE NOT NULL,
    HORA_TRANSACAO TIMESTAMP NOT NULL,
    VALOR NUMBER(10, 2) NOT NULL,
    CONSTRAINT FK_ID_WALLET_TRANSACAO FOREIGN KEY (FK_ID_WALLET) REFERENCES WALLET(ID_WALLET)
);

-- Tabela WALLET (agora com FK)
--ALTER TABLE WALLET
--ADD FK_ID_HIST_APOSTA INT; -- Chave estrangeira para Histórico de Apostas

--ALTER TABLE WALLET
--ADD FK_ID_HIST_TRANSACAO INT;   -- Chave estrangeira para Histórico de Transações

--ALTER TABLE WALLET
--ADD CONSTRAINT FK_ID_HIST_APOSTA FOREIGN KEY (FK_ID_HIST_APOSTA) REFERENCES HISTORICO_APOSTAS(ID_APOSTA);

--ALTER TABLE WALLET
--ADD CONSTRAINT FK_ID_HIST_TRANSACAO FOREIGN KEY (FK_ID_HIST_TRANSACAO) REFERENCES HISTORICO_TRANSACAO(ID_TRANSACAO);

-- Tabela MODERADOR
CREATE TABLE MODERADOR (
    ID_MODERADOR INT PRIMARY KEY,
    EMAIL VARCHAR2(150) NOT NULL UNIQUE,  -- Atualizado para 150 caracteres
    NOME VARCHAR2(100) NOT NULL,           -- Atualizado para 100 caracteres
    SENHA VARCHAR2(50) NOT NULL,           -- Atualizado para 50 caracteres
    DATA_NASCIMENTO DATE NOT NULL
);

INSERT INTO MODERADOR(ID_MODERADOR, EMAIL, NOME, SENHA, DATA_NASCIMENTO)
    VALUES(SEQ_MODERADOR.nextval, 'pedrao@admin.com', 'Pedro Facine', '123456', '10-10-2010');
COMMIT;
-- Tabela APOSTA
--CREATE TABLE APOSTA (
    --ID_APOSTA INT PRIMARY KEY,
   -- FK_ID_USUARIO INT NOT NULL,
   -- FK_ID_EVENTO INT NOT NULL,
  --  DATA_APOSTA DATE NOT NULL,
   -- ESCOLHA INT NOT NULL,               --0 ou 1
  --  CONSTRAINT FK_ID_USUARIO FOREIGN KEY (FK_ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
  --  CONSTRAINT FK_ID_EVENTO_APOSTA FOREIGN KEY (FK_ID_EVENTO) REFERENCES EVENTOS(ID_EVENTO)
--);

