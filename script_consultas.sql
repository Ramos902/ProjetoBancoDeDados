-- =============================================
-- FASE 4: Consultas e Business Intelligence
-- Projeto: Salão de Beleza / Estética
-- =============================================

-- =============================================
-- VIEW 1: Visão consolidada de cada agendamento
-- Base reutilizada pelas demais consultas
-- =============================================
CREATE OR REPLACE VIEW vw_agendamentos_completo AS
SELECT
    ag.ID                              AS agendamento_id,
    ag.Horario,
    DATE(ag.Horario)                   AS Data,
    TO_CHAR(ag.Horario, 'YYYY-MM')     AS AnoMes,
    EXTRACT(YEAR  FROM ag.Horario)     AS Ano,
    EXTRACT(MONTH FROM ag.Horario)     AS Mes,
    TO_CHAR(ag.Horario, 'TMMonth')     AS NomeMes,
    cl.ID                              AS cliente_id,
    cl.Nome                            AS cliente_nome,
    at.ID                              AS atendente_id,
    at.Nome                            AS atendente_nome,
    pg.Tipo                            AS pagamento_tipo,
    pg.Valor                           AS pagamento_valor,
    pr.ID                              AS procedimento_id,
    pr.Nome                            AS procedimento_nome,
    pr.Valor                           AS procedimento_valor
FROM Agendamento ag
JOIN Cliente     cl ON cl.ID = ag.fk_Cliente
JOIN Atendente   at ON at.ID = ag.fk_Atendente
LEFT JOIN Pagamento pg ON pg.ID = ag.fk_Pagamento
JOIN Procedimento_Agendamento pa ON pa.fk_Agendamento = ag.ID
JOIN Procedimento pr ON pr.ID = pa.fk_Procedimento;


-- =============================================
-- CONSULTA 1: Faturamento total por mês
-- Objetivo: acompanhar a evolução da receita ao longo do tempo
-- =============================================
CREATE OR REPLACE VIEW vw_faturamento_mensal AS
SELECT
    AnoMes,
    NomeMes,
    Ano,
    Mes,
    COUNT(DISTINCT agendamento_id)  AS total_agendamentos,
    SUM(procedimento_valor)         AS faturamento_bruto,
    ROUND(AVG(procedimento_valor), 2) AS ticket_medio
FROM vw_agendamentos_completo
GROUP BY AnoMes, NomeMes, Ano, Mes
ORDER BY AnoMes;

SELECT * FROM vw_faturamento_mensal;


-- =============================================
-- CONSULTA 2: Procedimentos mais realizados e mais lucrativos
-- Objetivo: identificar os serviços estrela do salão
-- =============================================
CREATE OR REPLACE VIEW vw_ranking_procedimentos AS
SELECT
    procedimento_nome,
    COUNT(*)                        AS vezes_realizado,
    SUM(procedimento_valor)         AS receita_total,
    ROUND(AVG(procedimento_valor), 2) AS valor_medio,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2
    )                               AS pct_participacao
FROM vw_agendamentos_completo
GROUP BY procedimento_nome
ORDER BY receita_total DESC;

SELECT * FROM vw_ranking_procedimentos;


-- =============================================
-- CONSULTA 3: Desempenho de cada atendente
-- Objetivo: avaliar produtividade e geração de receita por profissional
-- =============================================
CREATE OR REPLACE VIEW vw_desempenho_atendentes AS
SELECT
    at.ID                             AS atendente_id,
    at.Nome                           AS atendente_nome,
    at.Salario,
    COUNT(DISTINCT ag.ID)             AS total_atendimentos,
    SUM(pr.Valor)                     AS receita_gerada,
    ROUND(SUM(pr.Valor) / NULLIF(COUNT(DISTINCT ag.ID), 0), 2) AS ticket_medio,
    ROUND(SUM(pr.Valor) - at.Salario, 2) AS lucro_sobre_salario
FROM Atendente at
LEFT JOIN Agendamento ag             ON ag.fk_Atendente = at.ID
LEFT JOIN Procedimento_Agendamento pa ON pa.fk_Agendamento = ag.ID
LEFT JOIN Procedimento pr            ON pr.ID = pa.fk_Procedimento
WHERE at.DataFinal IS NULL  -- apenas atendentes ativos
GROUP BY at.ID, at.Nome, at.Salario
ORDER BY receita_gerada DESC;

SELECT * FROM vw_desempenho_atendentes;


-- =============================================
-- CONSULTA 4: Clientes mais frequentes (ranking de fidelidade)
-- Objetivo: base para programa de fidelidade
-- =============================================
CREATE OR REPLACE VIEW vw_clientes_frequentes AS
SELECT
    cl.ID                              AS cliente_id,
    cl.Nome                            AS cliente_nome,
    cl.Email,
    cl.DataCadastro,
    COUNT(DISTINCT ag.ID)              AS total_visitas,
    SUM(pg.Valor)                      AS total_gasto,
    ROUND(AVG(pg.Valor), 2)            AS gasto_medio_por_visita,
    MAX(DATE(ag.Horario))              AS ultima_visita,
    CURRENT_DATE - MAX(DATE(ag.Horario)) AS dias_sem_visita
FROM Cliente cl
LEFT JOIN Agendamento ag ON ag.fk_Cliente = cl.ID
LEFT JOIN Pagamento pg   ON pg.ID = ag.fk_Pagamento
GROUP BY cl.ID, cl.Nome, cl.Email, cl.DataCadastro
ORDER BY total_visitas DESC, total_gasto DESC;

SELECT * FROM vw_clientes_frequentes;


-- =============================================
-- CONSULTA 5: Distribuição dos meios de pagamento
-- Objetivo: entender preferências de pagamento dos clientes
-- =============================================
CREATE OR REPLACE VIEW vw_meios_pagamento AS
SELECT
    pg.Tipo                          AS meio_pagamento,
    COUNT(*)                         AS quantidade,
    SUM(pg.Valor)                    AS valor_total,
    ROUND(AVG(pg.Valor), 2)          AS valor_medio,
    ROUND(
        COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2
    )                                AS pct_uso
FROM Pagamento pg
JOIN Agendamento ag ON ag.fk_Pagamento = pg.ID
GROUP BY pg.Tipo
ORDER BY quantidade DESC;

SELECT * FROM vw_meios_pagamento;


-- =============================================
-- CONSULTA 6: Horários de pico — agendamentos por dia da semana e turno
-- Objetivo: apoiar escala de atendentes
-- =============================================
CREATE OR REPLACE VIEW vw_horarios_pico AS
SELECT
    TO_CHAR(Horario, 'Day')          AS dia_semana,
    EXTRACT(DOW FROM Horario)        AS num_dia,   -- 0=Dom ... 6=Sáb
    CASE
        WHEN EXTRACT(HOUR FROM Horario) BETWEEN 8  AND 11 THEN 'Manhã'
        WHEN EXTRACT(HOUR FROM Horario) BETWEEN 12 AND 13 THEN 'Almoço'
        WHEN EXTRACT(HOUR FROM Horario) BETWEEN 14 AND 17 THEN 'Tarde'
        ELSE 'Noite'
    END                              AS turno,
    COUNT(*)                         AS agendamentos
FROM Agendamento
GROUP BY dia_semana, num_dia, turno
ORDER BY num_dia, turno;

SELECT * FROM vw_horarios_pico;


-- =============================================
-- CONSULTA 7: Especialidades mais demandadas por atendente
-- Objetivo: identificar gaps de cobertura e super-especialistas
-- =============================================
SELECT
    at.Nome                           AS atendente,
    esp.Nome                          AS especialidade,
    COUNT(DISTINCT pa.fk_Agendamento) AS agendamentos_na_especialidade
FROM Atendente at
JOIN Atendente_Especialidade ae  ON ae.fk_Atendente = at.ID
JOIN Especialidade esp           ON esp.ID = ae.fk_Especialidade
LEFT JOIN Agendamento ag         ON ag.fk_Atendente = at.ID
LEFT JOIN Procedimento_Agendamento pa ON pa.fk_Agendamento = ag.ID
LEFT JOIN Procedimento pr        ON pr.ID = pa.fk_Procedimento
                                AND pr.Nome = esp.Nome
GROUP BY at.Nome, esp.Nome
ORDER BY at.Nome, agendamentos_na_especialidade DESC;


-- =============================================
-- CONSULTA 8: Clientes em risco de churn (sem visita há mais de 60 dias)
-- Objetivo: acionar campanhas de retenção
-- =============================================
SELECT
    cl.Nome                            AS cliente,
    cl.Email,
    cl.Telefone,
    MAX(DATE(ag.Horario))              AS ultima_visita,
    CURRENT_DATE - MAX(DATE(ag.Horario)) AS dias_ausente,
    COUNT(ag.ID)                       AS total_visitas_historico
FROM Cliente cl
LEFT JOIN Agendamento ag ON ag.fk_Cliente = cl.ID
GROUP BY cl.ID, cl.Nome, cl.Email, cl.Telefone
HAVING CURRENT_DATE - MAX(DATE(ag.Horario)) > 60
    OR MAX(ag.ID) IS NULL
ORDER BY dias_ausente DESC NULLS FIRST;


-- =============================================
-- CONSULTA 9: Ticket médio por combinação de procedimentos
-- Objetivo: identificar combos mais rentáveis para promover
-- =============================================
SELECT
    STRING_AGG(pr.Nome, ' + ' ORDER BY pr.Nome) AS combo_procedimentos,
    COUNT(*)                                      AS vezes_realizado,
    SUM(pr.Valor)                                 AS receita_total,
    ROUND(AVG(pr.Valor), 2)                       AS valor_medio_por_item
FROM Procedimento_Agendamento pa
JOIN Procedimento pr ON pr.ID = pa.fk_Procedimento
JOIN (
    -- Apenas agendamentos com mais de 1 procedimento
    SELECT fk_Agendamento
    FROM Procedimento_Agendamento
    GROUP BY fk_Agendamento
    HAVING COUNT(*) > 1
) combos ON combos.fk_Agendamento = pa.fk_Agendamento
GROUP BY pa.fk_Agendamento
ORDER BY receita_total DESC;


-- =============================================
-- CONSULTA 10: Comparativo mensal — mês atual vs mês anterior
-- Objetivo: KPI principal do dashboard (crescimento MoM)
-- =============================================
WITH receita_por_mes AS (
    SELECT
        TO_CHAR(ag.Horario, 'YYYY-MM') AS ano_mes,
        SUM(pg.Valor)                  AS receita,
        COUNT(DISTINCT ag.ID)          AS agendamentos
    FROM Agendamento ag
    JOIN Pagamento pg ON pg.ID = ag.fk_Pagamento
    GROUP BY ano_mes
)
SELECT
    atual.ano_mes,
    atual.agendamentos                              AS agendamentos_atual,
    anterior.agendamentos                           AS agendamentos_anterior,
    atual.receita                                   AS receita_atual,
    anterior.receita                                AS receita_anterior,
    atual.receita - anterior.receita                AS variacao_absoluta,
    ROUND(
        (atual.receita - anterior.receita)
        / NULLIF(anterior.receita, 0) * 100, 2
    )                                               AS variacao_pct
FROM receita_por_mes atual
LEFT JOIN receita_por_mes anterior
    ON anterior.ano_mes = TO_CHAR(
        TO_DATE(atual.ano_mes, 'YYYY-MM') - INTERVAL '1 month',
        'YYYY-MM'
    )
ORDER BY atual.ano_mes;