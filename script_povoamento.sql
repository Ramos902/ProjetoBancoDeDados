-- =============================================
-- Fase 3: Implementação do Banco de Dados
-- Projeto: Salão de Beleza / Estética
-- =============================================

-- =============================================
-- POVOAMENTO
-- =============================================

-- Especialidades (10 registros)
INSERT INTO Especialidade (Nome) VALUES
    ('Corte Feminino'),
    ('Corte Masculino'),
    ('Coloração'),
    ('Manicure'),
    ('Pedicure'),
    ('Depilação'),
    ('Maquiagem'),
    ('Hidratação Capilar'),
    ('Design de Sobrancelha'),
    ('Escova Progressiva');

-- Atendentes (15 registros)
INSERT INTO Atendente (Nome, AnoNasc, DataInicio, DataFinal, Salario, Telefone) VALUES
    ('Ana Paula Ferreira',    '1990-03-15', '2019-01-10', NULL,         2800.00, '(15) 99101-1111'),
    ('Beatriz Souza Lima',    '1988-07-22', '2018-05-20', NULL,         3100.00, '(15) 99101-2222'),
    ('Camila Rodrigues',      '1995-11-08', '2021-03-01', NULL,         2600.00, '(15) 99101-3333'),
    ('Daniela Costa',         '1992-04-30', '2020-08-15', NULL,         2750.00, '(15) 99101-4444'),
    ('Elaine Martins',        '1985-09-12', '2015-02-01', NULL,         3500.00, '(15) 99101-5555'),
    ('Fernanda Alves',        '1997-01-25', '2022-06-10', NULL,         2400.00, '(15) 99101-6666'),
    ('Gabriela Mendes',       '1993-06-18', '2019-11-01', NULL,         2900.00, '(15) 99101-7777'),
    ('Helena Pereira',        '1991-12-03', '2020-01-20', NULL,         2700.00, '(15) 99101-8888'),
    ('Isabela Santos',        '1996-08-14', '2023-02-01', NULL,         2300.00, '(15) 99101-9999'),
    ('Juliana Oliveira',      '1989-05-27', '2017-07-05', NULL,         3200.00, '(15) 99102-1111'),
    ('Karla Nascimento',      '1994-02-09', '2021-09-15', NULL,         2650.00, '(15) 99102-2222'),
    ('Larissa Campos',        '1987-10-31', '2016-04-01', '2024-12-31', 3000.00, '(15) 99102-3333'),
    ('Mariana Teixeira',      '1998-03-20', '2023-08-01', NULL,         2250.00, '(15) 99102-4444'),
    ('Natália Gomes',         '1990-07-16', '2018-10-10', NULL,         2950.00, '(15) 99102-5555'),
    ('Patrícia Barbosa',      '1986-01-04', '2014-03-01', NULL,         3700.00, '(15) 99102-6666');

-- Atendente x Especialidade
INSERT INTO Atendente_Especialidade (fk_Atendente, fk_Especialidade) VALUES
    (1, 1), (1, 3), (1, 8),   -- Ana Paula: Corte Fem, Coloração, Hidratação
    (2, 1), (2, 10),           -- Beatriz: Corte Fem, Progressiva
    (3, 4), (3, 5),            -- Camila: Manicure, Pedicure
    (4, 6), (4, 9),            -- Daniela: Depilação, Design Sobrancelha
    (5, 1), (5, 2), (5, 3),   -- Elaine: Corte Fem, Masc, Coloração
    (6, 4), (6, 9),            -- Fernanda: Manicure, Design Sobrancelha
    (7, 7), (7, 9),            -- Gabriela: Maquiagem, Design Sobrancelha
    (8, 1), (8, 8),            -- Helena: Corte Fem, Hidratação
    (9, 4), (9, 5),            -- Isabela: Manicure, Pedicure
    (10, 2), (10, 3),          -- Juliana: Corte Masc, Coloração
    (11, 6), (11, 5),          -- Karla: Depilação, Pedicure
    (13, 4), (13, 5),          -- Mariana: Manicure, Pedicure
    (14, 1), (14, 10),         -- Natália: Corte Fem, Progressiva
    (15, 1), (15, 2), (15, 7); -- Patrícia: Corte Fem, Masc, Maquiagem

-- Procedimentos (10 registros)
INSERT INTO Procedimento (Nome, Valor) VALUES
    ('Corte Feminino',          60.00),
    ('Corte Masculino',         35.00),
    ('Coloração Completa',     150.00),
    ('Manicure Simples',        30.00),
    ('Pedicure Simples',        35.00),
    ('Depilação Pernas',        80.00),
    ('Maquiagem Social',       120.00),
    ('Hidratação Capilar',      80.00),
    ('Design de Sobrancelha',   25.00),
    ('Escova Progressiva',     250.00);

-- Clientes (50 registros)
INSERT INTO Cliente (Nome, Telefone, Email, DataCadastro) VALUES
    ('Aline Souza',          '(15) 98800-0001', 'aline.souza@email.com',        '2023-01-15'),
    ('Bruna Carvalho',       '(15) 98800-0002', 'bruna.carvalho@email.com',     '2023-02-10'),
    ('Carolina Lima',        '(15) 98800-0003', 'carolina.lima@email.com',      '2023-02-20'),
    ('Débora Mendes',        '(15) 98800-0004', 'debora.mendes@email.com',      '2023-03-05'),
    ('Eduarda Fernandes',    '(15) 98800-0005', 'eduarda.fernandes@email.com',  '2023-03-18'),
    ('Flávia Costa',         '(15) 98800-0006', 'flavia.costa@email.com',       '2023-04-02'),
    ('Giovana Rocha',        '(15) 98800-0007', 'giovana.rocha@email.com',      '2023-04-20'),
    ('Heloísa Martins',      '(15) 98800-0008', 'heloisa.martins@email.com',    '2023-05-08'),
    ('Ingrid Nascimento',    '(15) 98800-0009', 'ingrid.nascimento@email.com',  '2023-05-25'),
    ('Jéssica Oliveira',     '(15) 98800-0010', 'jessica.oliveira@email.com',   '2023-06-10'),
    ('Karina Alves',         '(15) 98800-0011', 'karina.alves@email.com',       '2023-06-22'),
    ('Larissa Pereira',      '(15) 98800-0012', 'larissa.pereira@email.com',    '2023-07-01'),
    ('Marcia Teixeira',      '(15) 98800-0013', 'marcia.teixeira@email.com',    '2023-07-15'),
    ('Nathalia Santos',      '(15) 98800-0014', 'nathalia.santos@email.com',    '2023-08-03'),
    ('Olivia Gomes',         '(15) 98800-0015', 'olivia.gomes@email.com',       '2023-08-20'),
    ('Priscila Barbosa',     '(15) 98800-0016', 'priscila.barbosa@email.com',   '2023-09-05'),
    ('Queila Rodrigues',     '(15) 98800-0017', 'queila.rodrigues@email.com',   '2023-09-18'),
    ('Roberta Campos',       '(15) 98800-0018', 'roberta.campos@email.com',     '2023-10-02'),
    ('Sandra Moreira',       '(15) 98800-0019', 'sandra.moreira@email.com',     '2023-10-20'),
    ('Tatiana Cruz',         '(15) 98800-0020', 'tatiana.cruz@email.com',       '2023-11-08'),
    ('Úrsula Dias',          '(15) 98800-0021', 'ursula.dias@email.com',        '2023-11-25'),
    ('Viviane Freitas',      '(15) 98800-0022', 'viviane.freitas@email.com',    '2023-12-10'),
    ('Wanessa Castro',       '(15) 98800-0023', 'wanessa.castro@email.com',     '2024-01-05'),
    ('Xuxa Pinheiro',        '(15) 98800-0024', 'xuxa.pinheiro@email.com',      '2024-01-20'),
    ('Yasmin Ferreira',      '(15) 98800-0025', 'yasmin.ferreira@email.com',    '2024-02-08'),
    ('Zélia Monteiro',       '(15) 98800-0026', 'zelia.monteiro@email.com',     '2024-02-22'),
    ('Amanda Ribeiro',       '(15) 98800-0027', 'amanda.ribeiro@email.com',     '2024-03-10'),
    ('Bianca Cardoso',       '(15) 98800-0028', 'bianca.cardoso@email.com',     '2024-03-25'),
    ('Cristiane Nunes',      '(15) 98800-0029', 'cristiane.nunes@email.com',    '2024-04-08'),
    ('Denise Azevedo',       '(15) 98800-0030', 'denise.azevedo@email.com',     '2024-04-22'),
    ('Elisa Borges',         '(15) 98800-0031', 'elisa.borges@email.com',       '2024-05-05'),
    ('Fabiana Correia',      '(15) 98800-0032', 'fabiana.correia@email.com',    '2024-05-20'),
    ('Graziela Melo',        '(15) 98800-0033', 'graziela.melo@email.com',      '2024-06-03'),
    ('Hellen Vieira',        '(15) 98800-0034', 'hellen.vieira@email.com',      '2024-06-18'),
    ('Iara Cavalcante',      '(15) 98800-0035', 'iara.cavalcante@email.com',    '2024-07-01'),
    ('Joana Macedo',         '(15) 98800-0036', 'joana.macedo@email.com',       '2024-07-15'),
    ('Kelly Andrade',        '(15) 98800-0037', 'kelly.andrade@email.com',      '2024-08-02'),
    ('Lúcia Fonseca',        '(15) 98800-0038', 'lucia.fonseca@email.com',      '2024-08-20'),
    ('Mônica Tavares',       '(15) 98800-0039', 'monica.tavares@email.com',     '2024-09-05'),
    ('Norma Leal',           '(15) 98800-0040', 'norma.leal@email.com',         '2024-09-22'),
    ('Orlanda Pires',        '(15) 98800-0041', 'orlanda.pires@email.com',      '2024-10-08'),
    ('Paula Guimarães',      '(15) 98800-0042', 'paula.guimaraes@email.com',    '2024-10-25'),
    ('Renata Pacheco',       '(15) 98800-0043', 'renata.pacheco@email.com',     '2024-11-10'),
    ('Sabrina Vaz',          '(15) 98800-0044', 'sabrina.vaz@email.com',        '2024-11-28'),
    ('Telma Ramos',          '(15) 98800-0045', 'telma.ramos@email.com',        '2024-12-05'),
    ('Urânia Silva',         '(15) 98800-0046', 'urania.silva@email.com',       '2024-12-20'),
    ('Valdirene Souza',      '(15) 98800-0047', 'valdirene.souza@email.com',    '2025-01-08'),
    ('Wellington Brito',     '(15) 98800-0048', 'wellington.brito@email.com',   '2025-01-22'),
    ('Xênia Torres',         '(15) 98800-0049', 'xenia.torres@email.com',       '2025-02-10'),
    ('Yolanda Queiroz',      '(15) 98800-0050', 'yolanda.queiroz@email.com',    '2025-02-25');

-- Pagamentos (50 registros)
INSERT INTO Pagamento (Tipo, Valor) VALUES
    ('Pix',                  60.00),
    ('Cartão de Crédito',   150.00),
    ('Dinheiro',             30.00),
    ('Cartão de Débito',     35.00),
    ('Pix',                  80.00),
    ('Dinheiro',            120.00),
    ('Cartão de Crédito',   250.00),
    ('Pix',                  80.00),
    ('Cartão de Débito',     25.00),
    ('Dinheiro',             65.00),
    ('Pix',                  35.00),
    ('Cartão de Crédito',   180.00),
    ('Dinheiro',             55.00),
    ('Pix',                 110.00),
    ('Cartão de Débito',    250.00),
    ('Dinheiro',             30.00),
    ('Pix',                  95.00),
    ('Cartão de Crédito',    80.00),
    ('Cartão de Débito',     60.00),
    ('Pix',                 145.00),
    ('Dinheiro',             35.00),
    ('Pix',                  25.00),
    ('Cartão de Crédito',   330.00),
    ('Dinheiro',             80.00),
    ('Cartão de Débito',    120.00),
    ('Pix',                  60.00),
    ('Cartão de Crédito',   250.00),
    ('Dinheiro',             35.00),
    ('Pix',                  80.00),
    ('Cartão de Débito',     30.00),
    ('Pix',                 200.00),
    ('Cartão de Crédito',    65.00),
    ('Dinheiro',            150.00),
    ('Pix',                  55.00),
    ('Cartão de Débito',     25.00),
    ('Dinheiro',             35.00),
    ('Pix',                  90.00),
    ('Cartão de Crédito',   175.00),
    ('Cartão de Débito',     80.00),
    ('Pix',                  30.00),
    ('Dinheiro',            120.00),
    ('Pix',                  60.00),
    ('Cartão de Crédito',   250.00),
    ('Cartão de Débito',     35.00),
    ('Pix',                  80.00),
    ('Dinheiro',             25.00),
    ('Pix',                 145.00),
    ('Cartão de Crédito',    55.00),
    ('Cartão de Débito',     60.00),
    ('Pix',                 100.00);

-- Agendamentos (50 registros)
INSERT INTO Agendamento (Horario, fk_Cliente, fk_Atendente, fk_Pagamento) VALUES
    ('2024-01-08 09:00', 1,  1,  1),
    ('2024-01-10 10:30', 2,  2,  2),
    ('2024-01-12 14:00', 3,  3,  3),
    ('2024-01-15 11:00', 4,  4,  4),
    ('2024-01-18 15:30', 5,  5,  5),
    ('2024-01-22 09:30', 6,  7,  6),
    ('2024-01-25 13:00', 7,  2,  7),
    ('2024-02-01 10:00', 8,  8,  8),
    ('2024-02-05 16:00', 9,  6,  9),
    ('2024-02-08 09:00', 10, 10, 10),
    ('2024-02-12 14:30', 11, 3,  11),
    ('2024-02-15 11:30', 12, 1,  12),
    ('2024-02-20 10:00', 13, 5,  13),
    ('2024-02-22 15:00', 14, 4,  14),
    ('2024-02-26 09:00', 15, 2,  15),
    ('2024-03-04 13:30', 16, 9,  16),
    ('2024-03-07 10:30', 17, 1,  17),
    ('2024-03-11 14:00', 18, 8,  18),
    ('2024-03-14 09:00', 19, 11, 19),
    ('2024-03-18 16:00', 20, 7,  20),
    ('2024-03-21 10:00', 21, 3,  21),
    ('2024-03-25 11:30', 22, 6,  22),
    ('2024-03-28 14:30', 23, 2,  23),
    ('2024-04-02 09:00', 24, 14, 24),
    ('2024-04-05 15:00', 25, 1,  25),
    ('2024-04-09 10:30', 26, 10, 26),
    ('2024-04-12 13:00', 27, 2,  27),
    ('2024-04-16 09:30', 28, 3,  28),
    ('2024-04-19 14:00', 29, 4,  29),
    ('2024-04-23 11:00', 30, 8,  30),
    ('2024-05-02 09:00', 31, 5,  31),
    ('2024-05-06 15:30', 32, 15, 32),
    ('2024-05-09 10:00', 33, 1,  33),
    ('2024-05-13 13:30', 34, 7,  34),
    ('2024-05-16 09:00', 35, 6,  35),
    ('2024-05-20 14:00', 36, 3,  36),
    ('2024-05-23 11:30', 37, 14, 37),
    ('2024-05-27 16:00', 38, 2,  38),
    ('2024-06-03 09:30', 39, 8,  39),
    ('2024-06-06 10:00', 40, 10, 40),
    ('2024-06-10 14:30', 41, 1,  41),
    ('2024-06-13 09:00', 42, 4,  42),
    ('2024-06-17 15:00', 43, 2,  43),
    ('2024-06-20 11:00', 44, 9,  44),
    ('2024-06-24 13:00', 45, 3,  45),
    ('2024-06-27 09:30', 46, 7,  46),
    ('2024-07-01 10:30', 47, 15, 47),
    ('2024-07-04 14:00', 48, 5,  48),
    ('2024-07-08 09:00', 49, 1,  49),
    ('2024-07-11 16:00', 50, 2,  50);

-- Procedimento_Agendamento (relaciona procedimentos a agendamentos)
INSERT INTO Procedimento_Agendamento (fk_Agendamento, fk_Procedimento) VALUES
    (1,  1),  -- Corte Feminino
    (2,  3),  -- Coloração
    (3,  4),  -- Manicure
    (4,  6),  -- Depilação
    (5,  8),  -- Hidratação
    (6,  7),  -- Maquiagem
    (7,  10), -- Progressiva
    (8,  8),  -- Hidratação
    (9,  9),  -- Design Sobrancelha
    (10, 2),  -- Corte Masculino
    (11, 4),  (11, 5),  -- Manicure + Pedicure
    (12, 3),  -- Coloração
    (13, 1),  -- Corte Feminino
    (14, 6),  -- Depilação
    (15, 10), -- Progressiva
    (16, 4),  -- Manicure
    (17, 1),  (17, 8),  -- Corte Feminino + Hidratação
    (18, 8),  -- Hidratação
    (19, 6),  (19, 9),  -- Depilação + Design Sobrancelha
    (20, 7),  -- Maquiagem
    (21, 5),  -- Pedicure
    (22, 9),  -- Design Sobrancelha
    (23, 3),  (23, 10), -- Coloração + Progressiva
    (24, 1),  -- Corte Feminino
    (25, 3),  -- Coloração
    (26, 2),  -- Corte Masculino
    (27, 10), -- Progressiva
    (28, 4),  (28, 5),  -- Manicure + Pedicure
    (29, 6),  -- Depilação
    (30, 1),  (30, 8),  -- Corte Feminino + Hidratação
    (31, 8),  -- Hidratação
    (32, 1),  (32, 7),  -- Corte Feminino + Maquiagem
    (33, 3),  -- Coloração
    (34, 7),  -- Maquiagem
    (35, 9),  -- Design Sobrancelha
    (36, 5),  -- Pedicure
    (37, 1),  -- Corte Feminino
    (38, 10), -- Progressiva
    (39, 4),  -- Manicure
    (40, 2),  -- Corte Masculino
    (41, 3),  (41, 8),  -- Coloração + Hidratação
    (42, 6),  -- Depilação
    (43, 10), -- Progressiva
    (44, 4),  (44, 5),  -- Manicure + Pedicure
    (45, 1),  -- Corte Feminino
    (46, 7),  (46, 9),  -- Maquiagem + Design Sobrancelha
    (47, 1),  (47, 7),  -- Corte Feminino + Maquiagem
    (48, 8),  -- Hidratação
    (49, 3),  -- Coloração
    (50, 10); -- Progressiva