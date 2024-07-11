import ipaddress

def summarize_networks(networks):
    """
    Toma una lista de redes en formato CIDR y devuelve la red sumarizada.
    """
    # Convertir las redes a objetos ip_network
    ip_networks = []
    for network in networks:
        try:
            ip_networks.append(ipaddress.ip_network(network, strict=False))
        except ValueError:
            print(f"Valor incorrecto: {network}. Por favor, ingrese una dirección de red válida en formato CIDR.")
            return None
    
    # Encontrar la red mínima y máxima
    min_ip = min(network.network_address for network in ip_networks)
    max_ip = max(network.broadcast_address for network in ip_networks)
    
    # Crear una nueva red que cubra la mínima y máxima IP
    new_network = ipaddress.ip_network(f"{min_ip}/{min_ip.max_prefixlen}", strict=False)
    
    # Ajustar la máscara de red para cubrir el rango de IPs
    while new_network.broadcast_address < max_ip:
        new_network = new_network.supernet()
    
    return new_network

def main():
    # Solicitar la cantidad de redes
    while True:
        try:
            n = int(input("¿Cuántas redes deseas sumarizar?: "))
            break
        except ValueError:
            print("\033[91m" + "Valor incorrecto. Por favor, ingrese un número entero." + "\033[0m")

    # Solicitar las redes en formato CIDR
    networks = []
    for i in range(n):
        while True:
            network = input(f"Ingrese la red #{i+1} en formato CIDR o red completa (ej. 192.168.1.0/24 o 150.125.15.64/26): ")
            try:
                ipaddress.ip_network(network, strict=False)  # Intentar crear el objeto ip_network
                networks.append(network)
                break
            except ValueError:
                print("\033[91m" + f"Valor incorrecto: {network}. Por favor, ingrese una dirección de red válida en formato CIDR." + "\033[0m")

    # Obtener la red sumarizada si hay redes válidas
    if networks:
        summarized_network = summarize_networks(networks)
        if summarized_network:
            # Imprimir el resultado en verde
            print("\033[92mRed sumarizada:\033[0m", summarized_network)

if __name__ == "__main__":
    main()
