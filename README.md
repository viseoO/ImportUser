# Automatisation de l'installation d'Active Directory

Ce projet contient des scripts PowerShell permettant d'installer, de configurer un **contrôleur de domaine Active Directory** et d'importer des utilisateurs automatiquement.

### 1️⃣ **Pré-requis**  
- Un serveur Windows avec **PowerShell**  
- Une **IP statique** configurée  
- Un **compte administrateur**  

## Structure du projet 
    -   Vérification de l'adresse IP (statique obligatoire)  
    -   Installation du rôle **AD DS** 
    -   Redémarrage automatique après installation  
    -   Création des unités d'organisation 
    -   Ajout d'utilisateurs depuis un fichier CSV  
    -   Les utilisateurs devront créer un nouveau mot de passe lors de la première authentification
