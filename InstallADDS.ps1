# Installer le rôle AD DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Vérifier l'installation du rôle AD DS
Get-WindowsFeature -Name AD-Domain-Services

# Vérifier si l'adresse IP est en statique
$IPAddress = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null }).InterfaceAlias
$DHCPStatus = (Get-NetIPInterface -InterfaceAlias $IPAddress).Dhcp

if ($DHCPStatus -eq "Enabled") {
    Write-Host "❌ L'adresse IP est configurée en DHCP. Veuillez définir une IP statique avant de continuer." -ForegroundColor Red
    exit
} else {
    Write-Host "✅ L'adresse IP est bien configurée en statique." -ForegroundColor Green
}

# Redémarrage du service
Write-Host "✅ Rôle AD DS installé avec succès. Redémarrage du serveur en cours..." -ForegroundColor Green
Restart-Computer -Force
