# Script para PowerShell 7
# Autor: Israel Suárez
# Fecha: 12/06/2024

# Copiar las lineas de abajo comentadas e introducirlas manualmente en PowerShell 7
# Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
# Unblock-File -Path "C:\ruta_donde\se_guardo_el\netscanPS7.ps1"
# .\netscanPS7.ps1 -ExecutionPolicy Bypass

while ($true) {
    Write-Host "`n"
    Write-Host "Presione [0] para mostrar la tabla arp" -ForegroundColor Green
    Write-Host "Presione [1] para escanear los dispositivos conectados a la red" -ForegroundColor Green
    Write-Host "Presione [2] para escanear la vulnerabilidad de una IP" -ForegroundColor Green
    Write-Host "Presione [3] para escanear una IP con los 100 puertos más conocidos" -ForegroundColor Green
    Write-Host "Presione [4] para escanear una IP con un rango de puertos o puerto en específico" -ForegroundColor Green
    Write-Host "Presione [5] para escanear una IP y conocer el Sistema Operativo de un dispositivo" -ForegroundColor Green
    Write-Host "Presione [6] para salir" -ForegroundColor Red
    Write-Host "`n"
    
    Write-Host "Ingresa un número entre 0 y 6" -ForegroundColor Yellow
    $entrada = Read-Host

    if ($entrada -eq 6) {
        Write-Host "Saliendo del programa." -ForegroundColor Yellow
        break
    }

    switch ($entrada) {
        0 {
            arp -a
        }
        1 {
            $network = Read-Host "Ingrese la dirección IP a escanear (ejemplo 192.168.8.0/24)"
            nmap -sn $network
        }
        2 {
            $network1 = Read-Host "Ingrese la dirección IP a escanear (ejemplo 192.168.8.1)"
            nmap --script vuln $network1
        }
        3 {
            $network2 = Read-Host "Ingrese la dirección IP para escanear los 100 puertos más conocidos (ejemplo 192.168.8.1)"
            nmap -F $network2
        }
        4 {
            $entrada = Read-Host "Ingrese la dirección IP y el o los rangos de puertos a escanear (ejemplo 192.168.8.1  1-65535)"
            $parts = $entrada -split " "
            $network3 = $parts[0]
            $port = $parts[1]
            nmap -p $port $network3
        }
        5 {
            $network4 = Read-Host "Ingrese la dirección IP del dispositivo (ejemplo 192.168.8.49)"
            nmap -A -v $network4
        }
        default {
            Write-Host "Opción no válida. Por favor, ingrese un número entre 0 y 6."
            continue
        }
    }

    Write-Host "`n"
    $continuar = Read-Host "¿Desea realizar otro tipo de escaneo? [Y/n]"
    if ($continuar -ne "Y" -and $continuar -ne "y" -and $continuar -ne "") {
        Write-Host "Saliendo del programa."
        break
    }
}