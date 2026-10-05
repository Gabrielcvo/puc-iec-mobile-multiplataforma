# ADR-0001: Stack mobile do VoleiApp

## Status

`Aceito`

**Data:** 2026-09-28
**Autor:** Gabriel Santiago Silva

## Contexto

- **Produto:** app para organizar partidas de vôlei entre amigos e grupos: criar partida, confirmar presença, definir times e receber lembretes.
- **Escala alvo:** centenas de usuários no início, com uso concentrado em fins de semana.
- **Time:** 1 desenvolvedor, com background em web (React/JavaScript) e sem experiência prévia em Kotlin, Swift ou Dart.
- **Restrições:** orçamento baixo (sem equipe dedicada por plataforma), prazo de 3 meses para o MVP e necessidade de rodar em Android e iOS.
- **Requisitos críticos:** notificações push (lembrete de partida), autenticação simples e atualização em tempo real da lista de presença.

## Decisão

Adotaremos React Native com Expo, com Supabase como backend, por permitir uma única base de código em JavaScript/TypeScript para Android e iOS, reaproveitando a experiência do time em React.

## Alternativas consideradas

| Alternativa | Prós | Contras |
|---|---|---|
| **React Native + Expo** (escolhida) | 1 codebase para as duas plataformas; reaproveita conhecimento de React; push, build e publicação facilitados pelo Expo (EAS); ecossistema grande | Camada de abstração sobre o nativo; módulos nativos específicos podem exigir configuração extra; atualizações do RN podem quebrar dependências |
| Flutter | 1 codebase, UI consistente e boa performance de renderização | Exige aprender Dart e um novo ecossistema, o que consome boa parte do prazo de 3 meses |
| PWA | Sem loja de apps, publicação instantânea, 1 codebase | Push no iOS só funciona com o app instalado na tela inicial; menos presença nas lojas e acesso limitado a recursos do dispositivo |
| Nativo (Kotlin + Swift) | Melhor performance e UX possíveis, acesso total às APIs | 2 codebases e 2 stacks novas para 1 dev: inviável no prazo e no orçamento |

## Consequências

**Positivas:** MVP mais rápido, um só código para manter, curva de aprendizado baixa e publicação nas duas lojas com o mesmo fluxo.

**Negativas:** dependência do ecossistema Expo/RN e do ritmo de atualizações; performance abaixo do nativo em telas muito pesadas (não é o caso aqui); casos de uso que exijam código nativo customizado aumentam a complexidade; lock-in parcial no Supabase como backend.

## Referências

- Expo Documentation — docs.expo.dev
- React Native Documentation — reactnative.dev
- Charland, A.; Leroux, B. (2011). *Mobile Application Development: Web vs. Native*. Communications of the ACM, 54(5).
- Airbnb Engineering (2018). Série *React Native at Airbnb*. Serve de contraponto, pois mostra os riscos de adotar RN em escala.
- Nygard, M. (2011). *Documenting Architecture Decisions*.
