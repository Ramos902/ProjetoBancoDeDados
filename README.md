# ProjetoBancoDeDados

## Fase 1: Justificativa/Embasamento

1. O que é o negócio?

O setor de salões de beleza e estética é composto por empresas e profissionais que oferecem serviços e comercializam produtos relacionados aos cuidados com a aparência, saúde e bem-estar. Entre os principais serviços estão cortes de cabelo, manicure, pedicure, maquiagem, tratamentos estéticos, depilação, entre outros procedimentos voltados à estética pessoal.

2. Em que mercado ele está?

Ele se encontra no mercado de Beleza e bem-estar, de acordo com a pesquisa [Setor da beleza abre mais de 235 mil novos negócios e impulsiona empreendedorismo](https://g1.globo.com/jornal-nacional/noticia/2026/02/21/setor-da-beleza-abre-mais-de-235-mil-novos-negocios-e-impulsiona-empreendedorismo.ghtml), somente no ano de 2025 no Brasil foram registrados mais de 235 mil novos negócios nesse setor, demonstrando o crescimento da demanda e o fortalecimento do empreendedorismo na área.

3. Por que é relevante? 

Devido ao crescimento do setor de beleza e estética, torna-se essencial analisar os dados gerados pelo negócio para responder a perguntas importantes, como: **Quantos atendimentos foram realizados?**, **Em quais pontos o negócio está apresentando falhas?** e **Como é possível expandir a empresa de forma eficiente?**. Nesse contexto, a análise de dados desempenha um papel fundamental, permitindo que gestores tomem decisões mais estratégicas e fundamentadas. Para isso, é indispensável a utilização de um banco de dados estruturado, capaz de armazenar, organizar e disponibilizar as informações de forma segura e eficiente.

## Fase 2: Modelagem Conceitual do banco de dados (UML)

- Entregável: Diagrama Entidade-Relacionamento (DER), chaves primárias, chaves estrangeiras, relacionamentos, atributos mais relevantes.

```mermaid
erDiagram
    Atendente {
        int ID PK
        varchar Nome
        date AnoNasc
        date DataInicio
        date DataFinal
        float Salario
        varchar Telefone
    }

    Especialidade {
        int ID PK
        varchar Nome
    }

    Atendente_Especialidade {
        int fk_Atendente PK, FK
        int fk_Especialidade PK, FK
    }

    Cliente {
        int ID PK
        varchar Nome
        varchar Telefone
        varchar Email
        date DataCadastro
    }

    Agendamento {
        int ID PK
        datetime Horario
        int fk_Cliente FK
        int fk_Atendente FK
        int fk_Pagamento FK
    }

    Pagamento {
        int ID PK
        varchar Tipo
        float Valor
    }

    Procedimento {
        int ID PK
        varchar Nome
        float Valor
    }

    Procedimento_Agendamento {
        int fk_Agendamento PK, FK
        int fk_Procedimento PK, FK
    }

    Atendente ||--o{ Atendente_Especialidade : ""
    Especialidade ||--o{ Atendente_Especialidade : ""
    Cliente ||--o{ Agendamento : ""
    Atendente ||--o{ Agendamento : ""
    Pagamento ||--o| Agendamento : ""
    Agendamento ||--o{ Procedimento_Agendamento : ""
    Procedimento ||--o{ Procedimento_Agendamento : ""
```