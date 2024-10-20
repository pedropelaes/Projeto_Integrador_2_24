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
    DATA_NASCIMENTO DATE NOT NULL
);

-- Tabela EVENTOS
CREATE TABLE EVENTOS (
    ID_EVENTO INT PRIMARY KEY,
    TITULO VARCHAR2(50) NOT NULL,
    DESCRICAO VARCHAR2(150) NOT NULL,
    DATA_INICIO DATE NOT NULL,
    DATA_FIM DATE NOT NULL,
    STATUS VARCHAR2(255) NOT NULL,
    TOTAL_APOSTA INT NOT NULL,               -- Substituído VALOR_COTA por TOTAL_APOSTA
    RESULTADO_EVENTO CHAR(1)                 -- Novo campo, pode ser nulo ou não
);

-- Tabela WALLET
CREATE TABLE WALLET (
    ID_WALLET INT PRIMARY KEY,
    SALDO NUMBER(10, 2) NOT NULL
);


-- Tabela HISTORICO_APOSTAS
CREATE TABLE HISTORICO_APOSTAS (
    ID_APOSTA INT PRIMARY KEY,
    ID_EVENTO INT NOT NULL,      -- Chave estrangeira para EVENTOS
    ID_WALLET INT NOT NULL,      -- Chave estrangeira para WALLET
    HORA_APOSTA TIMESTAMP NOT NULL,
    DATA_APOSTA DATE NOT NULL,
    VALOR NUMBER(10, 2) NOT NULL,
    OPCAO_APOSTA CHAR(1) NOT NULL,  -- 'Y' ou 'N'
    FOREIGN KEY (ID_EVENTO) REFERENCES EVENTOS(ID_EVENTO),
    FOREIGN KEY (ID_WALLET) REFERENCES WALLET(ID_WALLET)
);

-- Tabela HISTORICO_TRANSACAO
CREATE TABLE HISTORICO_TRANSACAO (
    ID_TRANSACAO INT PRIMARY KEY,
    ID_WALLET INT NOT NULL,      -- Chave estrangeira para WALLET
    DATA_TRANSACAO DATE NOT NULL,
    HORA_TRANSACAO TIMESTAMP NOT NULL,
    VALOR NUMBER(10, 2) NOT NULL,
    FOREIGN KEY (ID_WALLET) REFERENCES WALLET(ID_WALLET)
);


-- Tabela WALLET (agora com FK)
ALTER TABLE WALLET
ADD ID_HIST_APOSTA INT; -- Chave estrangeira para Histórico de Apostas

ALTER TABLE WALLET
ADD ID_HIST_TRANSACAO INT;   -- Chave estrangeira para Histórico de Transações

ALTER TABLE WALLET
ADD FOREIGN KEY (ID_HIST_APOSTA) REFERENCES HISTORICO_APOSTAS(ID_APOSTA);

ALTER TABLE WALLET
ADD FOREIGN KEY (ID_HIST_TRANSACAO) REFERENCES HISTORICO_TRANSACAO(ID_TRANSACAO);



-- Tabela MODERADOR
CREATE TABLE MODERADOR (
    ID_MODERADOR INT PRIMARY KEY,
    EMAIL VARCHAR2(150) NOT NULL UNIQUE,  -- Atualizado para 150 caracteres
    NOME VARCHAR2(100) NOT NULL,           -- Atualizado para 100 caracteres
    SENHA VARCHAR2(50) NOT NULL,           -- Atualizado para 50 caracteres
    DATA_NASCIMENTO DATE NOT NULL
);


CREATE TABLE APOSTA(
    ID_APOSTA INT PRIMARY KEY,
    ID_USUARIO INT NOT NULL,
    ID_EVENTO INT NOT NULL,
    DATA_APOSTA DATE NOT NULL,
    FOREIGN KEY (ID_USUARIO) REFERENCES USUARIO(ID_USUARIO),
    FOREIGN KEY (ID_EVENTO) REFERENCES EVENTOS(ID_EVENTO)
);

ALTER TABLE APOSTA
MODIFY DATA_APOSTA NULL;