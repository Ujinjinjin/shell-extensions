function mts_vpn
    set rdp_port '3389'
    set rdp_ip '10.1.145.112'

    set connection_port '7658'
    set connection_ip (ifconfig eth0 | grep 'inet' | cut -d: -f2 | awk '{print $2}' | grep .)

    echo 'Connect to RDP using: '{$connection_ip}':'{$connection_port}
    echo {$connection_ip}':'{$connection_port} | clipboard

    sudo simpleproxy -L {$connection_port} -R {$rdp_ip}:{$rdp_port} -d
    sudo openconnect -u kagallad vpns.mts.ru/mts-fr
end