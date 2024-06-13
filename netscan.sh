#!/bin/bash
# Script para Bash
# Autor: Israel Suárez
# Fecha: 12/06/2024

while true; do
    echo ""
    echo -e "\e[32mPresione [0] para mostrar la tabla arp\e[0m"
    echo -e "\e[32mPresione [1] para escanear los dispositivos conectados a la red\e[0m"
    echo -e "\e[32mPresione [2] para escanear la vulnerabilidad de una IP\e[0m"
    echo -e "\e[32mPresione [3] para escanear una IP con los 100 puertos más conocidos\e[0m"
    echo -e "\e[32mPresione [4] para escanear una IP con un rango de puertos o puerto en específico\e[0m"
    echo -e "\e[32mPresione [5] para escanear una IP y conocer el Sistema Operativo de un dispositivo\e[0m"
    echo -e "\e[31mPresione [6] para salir\e[0m"
    echo ""
    
    echo -e "\e[33mIngresa un número entre 0 y 6\e[0m"
    read -r entrada

    if [[ "$entrada" -eq 6 ]]; then
        echo -e "\e[33mSaliendo del programa.\e[0m"
        break
    fi

    case "$entrada" in
        0)
            arp -a
            ;;
        1)
            echo "Ingrese la dirección IP a escanear (ejemplo 192.168.8.0/24)"
            read -r network
            nmap -sn "$network"
            ;;
        2)
            echo "Ingrese la dirección IP a escanear (ejemplo 192.168.8.1)"
            read -r network1
            nmap --script vuln "$network1"
            ;;
        3)
            echo "Ingrese la dirección IP para escanear los 100 puertos más conocidos (ejemplo 192.168.8.1)"
            read -r network2
            nmap -P -F -n "$network2"
            ;;
        4)
            echo "Ingrese la dirección IP y el o los rangos de puertos a escanear (ejemplo 192.168.8.1 1-65535)"
            read -r entrada
            IFS=' ' read -r -a parts <<< "$entrada"
            network3=${parts[0]}
            port=${parts[1]}
            nmap -p "$port" "$network3"
            ;;
        5)
            echo "Ingrese la dirección IP del dispositivo (ejemplo 192.168.8.49)"
            read -r network4
            nmap -A -v "$network4"
            ;;
        *)
            echo "Opción no válida. Por favor, ingrese un número entre 0 y 6."
            continue
            ;;
    esac

    echo ""
    echo "¿Desea realizar otro tipo de escaneo? [Y/n]"
    read -r continuar
    if [[ "$continuar" != "Y" && "$continuar" != "y" && "$continuar" != "" ]]; then
        echo "Saliendo del programa."
        break
    fi
done
