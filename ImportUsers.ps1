# Définition des variables
$Domain = "viseo.local"
$BaseOU = "OU=Utilisateurs,DC=viseo,DC=local"  # Modifier l'OU si nécessaire
$CSVPath = "C:\Users\Administrateur\Documents\utilisateurs.csv"

# Vérifier si le module Active Directory est chargé
if (-not (Get-Module -Name ActiveDirectory -ListAvailable)) {
    Write-Host "Le module Active Directory n'est pas installé. Installez RSAT avant d'exécuter ce script." -ForegroundColor Red
    exit
}

# Vérifier si le fichier CSV existe
if (-Not (Test-Path $CSVPath)) {
    Write-Host "Le fichier CSV n'existe pas à l'emplacement : $CSVPath" -ForegroundColor Red
    exit
}

# Importer le fichier CSV
$Users = Import-Csv -Path $CSVPath

foreach ($User in $Users) {
    $FirstName = $User.FirstName
    $LastName = $User.LastName
    $Password = $User.Password
    $SamAccountName = ($FirstName.Substring(0,1) + $LastName).ToLower()  # Format JDurand
    $UserPrincipalName = "$SamAccountName@$Domain"
    $DisplayName = "$FirstName $LastName"

    # Vérifier si l'utilisateur existe déjà
    if (Get-ADUser -Filter "SamAccountName -eq '$SamAccountName'" -ErrorAction SilentlyContinue) {
        Write-Host "L'utilisateur '$SamAccountName' existe déjà." -ForegroundColor Yellow
        continue
    }

    # Création de l'utilisateur
    try {
        New-ADUser -Name $DisplayName `
                   -GivenName $FirstName `
                   -Surname $LastName `
                   -SamAccountName $SamAccountName `
                   -UserPrincipalName $UserPrincipalName `
                   -Path $BaseOU `
                   -AccountPassword (ConvertTo-SecureString $Password -AsPlainText -Force) `
                   -Enabled $true `
                   -ChangePasswordAtLogon $true

        Write-Host "Utilisateur '$DisplayName' créé avec succès dans '$BaseOU'." -ForegroundColor Green
    } catch {
        Write-Host "Erreur lors de la création de l'utilisateur '$DisplayName' : $_" -ForegroundColor Red
    }
}

Write-Host "Importation terminée." -ForegroundColor Cyan
