# Définir le domaine cible
$Domain = "DC=viseo,DC=local"

# Liste des OUs à créer
$OUs = @(
    "ADMIN",
    "Utilisateurs",
    "IT",
    "HR",
    "Finance",
    "Marketing"
)

# Création des OUs
foreach ($OU in $OUs) {
    $OUPath = "OU=$OU,$Domain"
    
    # Vérifier si l'OU existe déjà
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$OUPath'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $OU -Path $Domain -ProtectedFromAccidentalDeletion $true
        Write-Host "OU créée : $OU"
    } else {
        Write-Host "L'OU '$OU' existe déjà."
    }
}

Write-Host "Toutes les OUs ont été traitées."
