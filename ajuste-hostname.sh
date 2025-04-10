#!/bin/bash

# Script de ajuste automático de hostname e configurações básicas para servidores
# Adaptado para uso educacional e genérico (personalize conforme seu provedor)

# Obtém o IP público do servidor
IP_EXTERNO=$(curl -s http://checkip.amazonaws.com)

# Verifica se o IP público pertence ao(s) bloco(s) do seu provedor de hospedagem
# ⚠️ Substitua os valores "XXX.XXX.XXX." e "YYY.YYY.YYY." pelo início do(s) bloco(s) de IP público que você contratou
if [[ "$IP_EXTERNO" == *"XXX.XXX.XXX."* ]] || [[ "$IP_EXTERNO" == *"YYY.YYY.YYY."* ]]; then
    echo "O IP $IP_EXTERNO pertence ao bloco configurado. Tentando obter hostname reverso..."

    # Consulta reversa de DNS (PTR) e extração do hostname associado ao IP
    # ⚠️ Essa parte depende de o PTR estar corretamente configurado no painel DNS do seu provedor
    newhostname=$(dig -x $IP_EXTERNO +short | grep -Eo '[a-zA-Z0-9.-]+\.[a-z]{2,}' | head -n1)

    if [[ -n "$newhostname" ]]; then
        # Aplica novo hostname ao sistema
        echo "$newhostname" > /etc/hostname
        hostname "$newhostname"

        # Substitui referências do hostname antigo pelos valores atualizados nos arquivos padrão
        # ⚠️ Substitua "antigohostname" pelo hostname antigo presente nos seus arquivos (/etc/hosts, issue etc.)
        sed -i "s/antigohostname/$newhostname/g" /etc/hosts
        sed -i "s/antigohostname/$newhostname/g" /etc/issue
        sed -i "s/antigohostname/$newhostname/g" /etc/issue.net

        echo "Hostname atualizado com sucesso para: $newhostname"
    else
        echo "Nenhum hostname reverso válido encontrado. Verifique a configuração de DNS PTR."
    fi
else
    echo "O IP $IP_EXTERNO não pertence ao bloco definido. Nenhuma ação realizada."
fi

# Gera uma nova senha segura para o root
nova_senha=$(< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c15)
echo "root:$nova_senha" | chpasswd

# Armazena a nova senha root em um diretório seguro
# ⚠️ Substitua "/opt/minhaempresa" por um caminho adequado ao seu ambiente ou mantenha conforme preferir
mkdir -p /opt/minhaempresa
echo "Nova senha root: $nova_senha" > /opt/minhaempresa/senha_root.txt
chmod 600 /opt/minhaempresa/senha_root.txt

# Ajusta o hostname no agente Zabbix, se instalado
# host_zabbix=$(hostname -s)
# sed -i "s/Hostname=antigohostname/Hostname=$host_zabbix/g" /etc/zabbix/zabbix_agentd.conf 2>/dev/null

# (Opcional) Enviar dados para API de monitoramento (removido por segurança)
# ⚠️ Caso deseje usar esse recurso, descomente as linhas abaixo e insira sua URL da API e a chave de autenticação (API Key)
# curl -X POST https://sua-api.com/checkin \
#   --header "X-Api-Key: SUA_CHAVE_AQUI" \
#   --data '{"name": "'"$host_zabbix"'", "timeout": 300}'
