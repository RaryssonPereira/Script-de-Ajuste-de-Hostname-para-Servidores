#!/bin/bash

# -----------------------------------------
# ajuste-hostname.sh
# Script interativo para ajustar hostname, gerar senha root segura e preparar servidor Linux.
# Adaptado para estudantes e iniciantes em administração de servidores e automação Bash.
# Criado por: Rarysson 💻
# -----------------------------------------

# === PERSONALIZAÇÃO NECESSÁRIA ===
# ⚠️ Substitua "XXX.XXX.XXX." e "YYY.YYY.YYY." pelos blocos IP reais do seu provedor.

IP_BLOCO=("XXX.XXX.XXX." "YYY.YYY.YYY.")  # <-- Personalizar com os blocos IP do seu provedor!

# === Funções de suporte ===
check_root() {
    if [[ $(id -u) -ne 0 ]]; then
        echo "⚠️ Este script deve ser executado como root. Execute com 'sudo'."
        exit 1
    fi
}

check_dependencies() {
    for pkg in curl dig; do
        if ! command -v $pkg &> /dev/null; then
            echo "⚠️ Dependência '$pkg' não encontrada. Instale com 'apt install $pkg' e tente novamente."
            exit 1
        fi
    done
}

backup_file() {
    local file=$1
    if [[ -f "$file" ]]; then
        cp "$file" "${file}.backup-$(date +%F-%H%M%S)"
        echo "🔄 Backup criado: ${file}.backup-$(date +%F-%H%M%S)"
    fi
}

log_action() {
    echo "$(date '+%F %T') - $1" >> /var/log/ajuste-hostname.log
}

# Checagem inicial
check_root
check_dependencies

# Obtém IP público do servidor
IP_EXTERNO=$(curl -s http://checkip.amazonaws.com)
echo "🌐 IP público detectado: $IP_EXTERNO"

# Pergunta se deseja realizar ajuste de hostname
read -p "Deseja ajustar automaticamente o hostname com base no DNS reverso? (s/n): " ajustar_hostname
if [[ "$ajustar_hostname" =~ ^[Ss]$ ]]; then
    pertence_bloco=false
    for bloco in "${IP_BLOCO[@]}"; do
        if [[ "$IP_EXTERNO" == *"$bloco"* ]]; then
            pertence_bloco=true
        fi
    done

    if $pertence_bloco; then
        echo "✅ IP pertence ao bloco definido. Tentando obter hostname reverso..."
        newhostname=$(dig -x $IP_EXTERNO +short | grep -Eo '[a-zA-Z0-9.-]+\.[a-z]{2,}' | head -n1)

        if [[ -n "$newhostname" ]]; then
            echo "✅ Hostname encontrado: $newhostname"
            
            # Backup e ajustes
            backup_file /etc/hostname
            backup_file /etc/hosts
            backup_file /etc/issue
            backup_file /etc/issue.net

            oldhostname=$(hostname -f)

            echo "$newhostname" > /etc/hostname
            hostname "$newhostname"
            
            # Atualização dos arquivos de configuração com novo hostname
            sed -i "s/$oldhostname/$newhostname/g" /etc/hosts
            sed -i "s/$oldhostname/$newhostname/g" /etc/issue
            sed -i "s/$oldhostname/$newhostname/g" /etc/issue.net

            echo "🚀 Hostname atualizado com sucesso para: $newhostname"
            log_action "Hostname alterado de $oldhostname para $newhostname"
        else
            echo "❌ Nenhum hostname reverso válido encontrado. Verifique o DNS PTR."
            log_action "Falha ao obter hostname reverso."
        fi
    else
        echo "❌ IP não pertence ao bloco definido. Nenhuma ação realizada."
        log_action "IP não pertencente ao bloco definido: $IP_EXTERNO"
    fi
fi

# Pergunta se deseja gerar nova senha root
read -p "Deseja gerar uma nova senha segura para o usuário root? (s/n): " gerar_senha
if [[ "$gerar_senha" =~ ^[Ss]$ ]]; then
    nova_senha=$(< /dev/urandom tr -dc '_A-Z-a-z-0-9' | head -c15)
    echo "root:$nova_senha" | chpasswd
    echo "✅ Senha gerada e aplicada com sucesso."

    # === PERSONALIZAÇÃO OPCIONAL ===
    # ⚠️ Informe um diretório adequado para armazenar a senha gerada ou aceite o padrão.
    read -p "Digite o diretório onde deseja salvar a senha (padrão: /opt/minhaempresa): " dir_senha
    dir_senha=${dir_senha:-"/opt/minhaempresa"}  # <-- Personalizar diretório padrão conforme desejado
    mkdir -p "$dir_senha"
    echo "Nova senha root: $nova_senha" > "$dir_senha/senha_root.txt"
    chmod 600 "$dir_senha/senha_root.txt"
    echo "🔑 Senha salva em: $dir_senha/senha_root.txt"
    log_action "Senha root gerada e armazenada em $dir_senha"
fi

# Pergunta sobre configuração do agente Zabbix
read -p "Deseja atualizar o hostname no agente Zabbix? (s/n): " zabbix_config
if [[ "$zabbix_config" =~ ^[Ss]$ ]]; then
    if [[ -f "/etc/zabbix/zabbix_agentd.conf" ]]; then
        host_zabbix=$(hostname -s)
        backup_file /etc/zabbix/zabbix_agentd.conf
        
        # Atualizando configuração do Zabbix
        sed -i "s/^Hostname=.*/Hostname=$host_zabbix/g" /etc/zabbix/zabbix_agentd.conf
        systemctl restart zabbix-agent
        echo "✅ Configuração do Zabbix atualizada para hostname: $host_zabbix"
        log_action "Hostname Zabbix atualizado para $host_zabbix"
    else
        echo "⚠️ Agente Zabbix não encontrado. Instale o Zabbix antes de usar esta opção."
    fi
fi

# === OPCIONAL ===
# ⚠️ Se quiser enviar dados a uma API personalizada, descomente e preencha os campos corretamente abaixo:

# curl -X POST https://sua-api.com/checkin \
#   --header "X-Api-Key: SUA_CHAVE_API" \
#   --data '{"name": "'"$host_zabbix"'", "timeout": 300}'

# <-- Personalizar URL da API e chave (se aplicável)

# Finalização
echo "🎉 Script finalizado com sucesso!"
echo "📄 Log das ações realizadas em /var/log/ajuste-hostname.log"
