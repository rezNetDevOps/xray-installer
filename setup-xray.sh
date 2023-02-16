#!/bin/bash

# Download and install Xray
curl -L https://github.com/XTLS/Xray-core/releases/latest/download/Xray-linux-64.zip -o xray.zip
unzip xray.zip
sudo mv xray /usr/local/bin/
sudo chmod +x /usr/local/bin/xray

# Choose a template from the Xray-examples repository
echo "Choose a template from the Xray-examples repository:"
OPTIONS=("vless-websocket-tls" "trojan-websocket-tls" "vmess-websocket-tls" "vmess-tcp-tls" "vless-tcp-tls")
select TEMPLATE in "${OPTIONS[@]}"; do
    case $TEMPLATE in
        "vless-websocket-tls")
            TEMPLATE_URL="https://raw.githubusercontent.com/XTLS/Xray-examples/main/VLESS/VLESS%20over%20WebSocket%20(TLS)/server.json"
            break
            ;;
        "trojan-websocket-tls")
            TEMPLATE_URL="https://raw.githubusercontent.com/XTLS/Xray-examples/main/Trojan/Trojan%20over%20WebSocket%20(TLS)/server.json"
            break
            ;;
        "vmess-websocket-tls")
            TEMPLATE_URL="https://raw.githubusercontent.com/XTLS/Xray-examples/main/VMess/VMess%20over%20WebSocket%20(TLS)/server.json"
            break
            ;;
        "vmess-tcp-tls")
            TEMPLATE_URL="https://raw.githubusercontent.com/XTLS/Xray-examples/main/VMess/VMess%20over%20TCP%20(TLS)/server.json"
            break
            ;;
        "vless-tcp-tls")
            TEMPLATE_URL="https://raw.githubusercontent.com/XTLS/Xray-examples/main/VLESS/VLESS%20over%20TCP%20(TLS)/server.json"
            break
            ;;
        *) echo "Invalid option $REPLY";;
    esac
done

# Download and customize the template
curl -L $TEMPLATE_URL -o server.json
echo "Enter the necessary configuration keys (e.g. \"address\", \"port\", etc.):"
read CONFIG_KEYS
for key in $CONFIG_KEYS; do
    echo "Enter the value for $key:"
    read value
    jq ".$key=\"$value\"" server.json > tmp.json
    mv tmp.json server.json
done

# Start the Xray service with the customized config
sudo xray -config server.json
