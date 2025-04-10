# 🛠️ Script de Ajuste de Hostname com Shell Script

Este projeto contém um script escrito em Shell Script (Bash) para realizar configurações iniciais em servidores Linux, como ajuste automático de hostname, geração de senha segura para o root e preparação para ferramentas de monitoramento.

O objetivo principal é servir como base de aprendizado para estudantes e iniciantes em administração de servidores, automação com bash e boas práticas de provisionamento.

---

## 📌 Funcionalidades

- Detecta automaticamente o IP público do servidor.
- Realiza consulta DNS reversa (PTR) para obter o hostname baseado no IP.
- Ajusta o hostname do sistema e arquivos relacionados.
- Gera uma nova senha segura e aleatória para o usuário root.
- Salva a nova senha em um diretório interno do sistema.
- Faz ajustes no agente de monitoramento (Zabbix, opcional).
- Envia dados para uma API externa (opcional – trecho comentável para estudo).

---

## ⚙️ Pré-requisitos

- Sistema operacional Linux com Bash.
- Permissões de root (ou uso de sudo).
- Ferramentas instaladas:
  - curl
  - dig (disponível em dnsutils ou bind-utils)
  - awk, sed, tr, chpasswd, hostname
  - (opcional) zabbix-agent

---

## 📂 Arquivos afetados pelo script

- /etc/hostname
- /etc/hosts
- /etc/issue
- /etc/issue.net
- /etc/zabbix/zabbix_agentd.conf (se existir)
- /opt/nome-da-empresa/.passwd (senha root gerada)

---

## 🚨 Avisos importantes

- O hostname antigo será sobrescrito.
- Certifique-se de que o reverso (PTR) do IP esteja corretamente configurado para evitar falhas na execução.
- A senha do usuário root será automaticamente alterada e salva localmente.
- O script pode ser adaptado para pedir confirmação antes de aplicar alterações críticas.
- As chamadas de API externas estão presentes apenas como exemplo didático e devem ser removidas ou ajustadas para ambientes reais.

---

## 🧠 Exemplos de aprendizado que o script proporciona

- Como usar comandos bash para automação de tarefas.
- Como realizar substituições seguras com sed.
- Como gerar senhas fortes com /dev/urandom.
- Como manipular arquivos de configuração do sistema.
- Como integrar Shell Script com uma API (via curl).

---

## 📝 Exemplo de uso

```bash
chmod +x ajuste-host.sh
sudo ./ajuste-host.sh
