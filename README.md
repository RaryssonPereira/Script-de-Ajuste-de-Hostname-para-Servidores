# 🛠️ Script de Ajuste de Hostname com Shell Script

Este projeto contém um script interativo escrito em **Shell Script (Bash)** para realizar configurações iniciais em servidores Linux, como **ajuste automático de hostname**, **geração interativa de senha segura para o root** e **integração básica com ferramentas de monitoramento**.

🎯 O objetivo principal é servir como **base de aprendizado para estudantes e iniciantes** em administração de servidores, automação com Bash e boas práticas de provisionamento.

---

## 📜 Sobre o script

**Arquivo**: `ajuste-hostname.sh`  
**Criado por**: [Rarysson](https://github.com/RaryssonPereira)  
**Objetivo**: Automatizar o ajuste de hostname com base no DNS reverso (PTR), reforçar boas práticas de segurança (como senha forte para root) e introduzir integração opcional com ferramentas como Zabbix e APIs externas, sempre com interatividade para o usuário.

---

## 📌 Funcionalidades

- Detecta automaticamente o **IP público** do servidor.
- Realiza consulta **DNS reversa (PTR)** para obter automaticamente o hostname baseado no IP.
- Ajusta interativamente o **hostname do sistema** e arquivos relacionados.
- Gera uma **senha segura e aleatória** para o usuário root.
- Permite personalizar o local onde a nova senha será salva.
- Faz ajustes opcionais no agente de monitoramento **Zabbix**.
- Oferece opção comentada para envio de dados a uma **API externa** (exemplo didático).

---

## ⚙️ Pré-requisitos

- ✅ Sistema operacional Linux com suporte ao Bash.
- ✅ Permissões de root (ou uso do `sudo`).
- ✅ Ferramentas essenciais instaladas:

  - `curl`
  - `dig` *(disponível via `dnsutils` ou `bind-utils`)*
  - `awk`, `sed`, `tr`, `chpasswd`, `hostname`
  - *(opcional)* `zabbix-agent`

---

## 📝 Personalizações necessárias

- **Bloco(s) IP do seu servidor** (substitua no script).
- **Diretório padrão** para armazenamento da senha gerada (opcional).
- **Dados para integração com API externa** (opcional, comentado).

---

## 📂 Arquivos afetados pelo script

- `/etc/hostname`
- `/etc/hosts`
- `/etc/issue`
- `/etc/issue.net`
- `/etc/zabbix/zabbix_agentd.conf` *(se existir)*
- Diretório escolhido para armazenamento da senha root.

---

## 🚨 Avisos importantes

- O **hostname antigo será sobrescrito** (backup automático realizado antes das alterações).
- O **DNS reverso (PTR)** precisa estar configurado corretamente para obter o hostname.
- A **senha do usuário root será alterada automaticamente** e salva no diretório indicado.
- Todas as ações críticas são realizadas após confirmação do usuário.
- As chamadas de **API externas são ilustrativas** e devem ser adaptadas para uso real.

---

## 🧠 Exemplos de aprendizado

- Automatizar tarefas interativas com comandos Bash.
- Realizar backups antes de mudanças críticas.
- Gerar senhas seguras automaticamente com `/dev/urandom`.
- Manipular arquivos de configuração com segurança.
- Integrar Shell Script com APIs externas utilizando `curl`.
- Boas práticas de segurança em scripts Linux.

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

Siga as instruções interativas durante a execução do script.

---

## 🧪 Sugestão

> Experimente comentar ou adaptar trechos do script para entender melhor seu funcionamento e aprender mais sobre Shell Script.

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
Você pode **usar, modificar e compartilhar** livremente!

---

## ✨ Créditos

Criado com carinho por **Rarysson**,  
pensado especialmente para quem está começando e deseja aprender administração Linux e automação de forma prática, interativa e segura! 🚀
