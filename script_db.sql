-- Active: 1782776592520@@localhost@5432@salaodebeleza
-- =============================================
-- Fase 3: Implementação do Banco de Dados
-- Projeto: Salão de Beleza / Estética
-- =============================================

CREATE DATABASE salaodebeleza;

CREATE TABLE Especialidade (
    ID   SERIAL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL
);

CREATE TABLE Atendente (
    ID         SERIAL PRIMARY KEY,
    Nome       VARCHAR(100) NOT NULL,
    AnoNasc    DATE,
    DataInicio DATE,
    DataFinal  DATE,
    Salario    NUMERIC(10, 2),
    Telefone   VARCHAR(20)
);

CREATE TABLE Atendente_Especialidade (
    fk_Atendente    INT NOT NULL REFERENCES Atendente(ID) ON DELETE CASCADE,
    fk_Especialidade INT NOT NULL REFERENCES Especialidade(ID) ON DELETE CASCADE,
    PRIMARY KEY (fk_Atendente, fk_Especialidade)
);

CREATE TABLE Cliente (
    ID           SERIAL PRIMARY KEY,
    Nome         VARCHAR(100) NOT NULL,
    Telefone     VARCHAR(20),
    Email        VARCHAR(150),
    DataCadastro DATE DEFAULT CURRENT_DATE
);

CREATE TABLE Pagamento (
    ID    SERIAL PRIMARY KEY,
    Tipo  VARCHAR(50),
    Valor NUMERIC(10, 2)
);

CREATE TABLE Agendamento (
    ID            SERIAL PRIMARY KEY,
    Horario       TIMESTAMP NOT NULL,
    fk_Cliente    INT NOT NULL REFERENCES Cliente(ID) ON DELETE RESTRICT,
    fk_Atendente  INT NOT NULL REFERENCES Atendente(ID) ON DELETE RESTRICT,
    fk_Pagamento  INT REFERENCES Pagamento(ID) ON DELETE SET NULL
);

CREATE TABLE Procedimento (
    ID    SERIAL PRIMARY KEY,
    Nome  VARCHAR(100) NOT NULL,
    Valor NUMERIC(10, 2)
);

CREATE TABLE Procedimento_Agendamento (
    fk_Agendamento  INT NOT NULL REFERENCES Agendamento(ID) ON DELETE CASCADE,
    fk_Procedimento INT NOT NULL REFERENCES Procedimento(ID) ON DELETE RESTRICT,
    PRIMARY KEY (fk_Agendamento, fk_Procedimento)
);

-- =============================================
-- Criação dos Indices
-- =============================================

-- Buscas frequentes por nome
CREATE INDEX idx_atendente_nome   ON Atendente(Nome);
CREATE INDEX idx_cliente_nome     ON Cliente(Nome);
CREATE INDEX idx_procedimento_nome ON Procedimento(Nome);

-- Filtros por período em agendamentos
CREATE INDEX idx_agendamento_horario    ON Agendamento(Horario);
CREATE INDEX idx_agendamento_atendente  ON Agendamento(fk_Atendente);
CREATE INDEX idx_agendamento_cliente    ON Agendamento(fk_Cliente);

-- Busca de clientes por email
CREATE INDEX idx_cliente_email ON Cliente(Email);

