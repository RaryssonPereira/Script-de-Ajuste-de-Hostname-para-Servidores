# 🛠️ Script de Ajuste de Hostname com Shell Script

Este projeto contém um script escrito em **Shell Script (Bash)** para realizar configurações iniciais em servidores Linux, como **ajuste automático de hostname**, **geração de senha segura para o root** e **preparação para ferramentas de monitoramento**.

🎯 O objetivo principal é servir como **base de aprendizado para estudantes e iniciantes** em administração de servidores, automação com Bash e boas práticas de provisionamento.

---

## 📜 Sobre o script

**Arquivo**: `ajuste-hostname.sh`  
**Criado por**: [Rarysson](https://github.com/RaryssonPereira)  
**Objetivo**: Automatizar o ajuste de hostname com base no IP reverso (PTR), reforçar boas práticas de segurança (como senha forte para root) e introduzir integração com ferramentas como Zabbix e APIs externas.

---

## 📌 Funcionalidades

- Detecta automaticamente o **IP público** do servidor  
- Realiza consulta **DNS reversa (PTR)** para obter o hostname baseado no IP  
- Ajusta o **hostname do sistema** e arquivos relacionados  
- Gera uma **senha segura e aleatória** para o usuário root  
- Salva a nova senha em um diretório interno do sistema  
- Faz ajustes no agente de monitoramento (**Zabbix**, opcional)  
- Envia dados para uma **API externa** (trecho opcional e comentável)

---

## ⚙️ Pré-requisitos

- ✅ Sistema operacional Linux com suporte a Bash  
- ✅ Permissões de root (ou uso do `sudo`)  
- ✅ Ferramentas instaladas:

  - `curl`  
  - `dig` *(disponível via `dnsutils` ou `bind-utils`)*  
  - `awk`, `sed`, `tr`, `chpasswd`, `hostname`  
  - *(opcional)* `zabbix-agent`

---

## 📂 Arquivos afetados pelo script

- `/etc/hostname`  
- `/etc/hosts`  
- `/etc/issue`  
- `/etc/issue.net`  
- `/etc/zabbix/zabbix_agentd.conf` *(se existir)*  
- `/opt/nome-da-empresa/.passwd` *(senha root gerada)*

---

## 🚨 Avisos importantes

- O **hostname antigo será sobrescrito**  
- O **PTR (reverso) do IP precisa estar corretamente configurado**  
- A **senha do usuário root será alterada automaticamente** e salva localmente  
- O script **pode ser adaptado** para confirmar alterações críticas  
- As chamadas de **API externas são didáticas** e devem ser ajustadas para produção

---

## 🧠 Exemplos de aprendizado

- Automatizar tarefas com comandos Bash  
- Realizar substituições seguras com `sed`  
- Gerar senhas fortes com `/dev/urandom`  
- Manipular arquivos de configuração do sistema  
- Integrar Shell Script com APIs externas usando `curl`

---

## ▶️ Como usar

### 1. Torne o script executável

```bash
chmod +x ajuste-hostname.sh
```

### 2. Execute com permissões de root

```bash
sudo ./ajuste-hostname.sh
```

---

## 🧪 Sugestão

> Você pode comentar ou adaptar trechos do script para experimentar diferentes cenários de aprendizado.

---

## ❤️ Contribuindo

Sinta-se à vontade para contribuir com este projeto:  
- Relatando bugs  
- Sugerindo melhorias  
- Criando novas funcionalidades

Abra uma **Issue** ou envie um **Pull Request** ✨

---

## 📜 Licença

Distribuído sob a licença **MIT**.  
Você pode **usar, modificar e compartilhar** como quiser!

---

## ✨ Créditos

Criado com carinho por **Rarysson**,  
pensado para quem está começando e quer aprender Linux de forma prática, útil e automatizada. 🚀
