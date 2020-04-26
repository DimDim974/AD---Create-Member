# =======================================================
# NAME: FULL.ps1
# AUTHOR: SAUTRON Dimitri
# DATE: 05/08/2014
# VERSION: 0.9.7.4
# COMMENTS: Automatiser des tâches basic
# =======================================================

#Ajout de l'applet de commande ActiveRoles Management Shell pour Active Directory
Add-PSSnapin Quest.ActiveRoles.ADManagement 

$cp = read-host « Entre le nom d ouverture de session ADM  COMMUN\CP_ADM »
$pw = read-host « Entre ton mot de passe ADM » -AsSecureString
$dc = read-host « Entre le contrôleur de domaine »
$ou = read-host « Entre l unite d organisation »
$grp = read-host « Entre le nom du groupe »


$co = Connect-QADService –service $dc –ConnectionAccount $cp  –ConnectionPassword $pw

$name = read-host « Nom Prénom »
$mdp = read-host « mot de passe »
$UPN = read-host « Entrez le CP »
$des = read-host « Entrez la description »
$OU = Read-host « Entrez l OU »
$localisation = 'OU=Utilisateurs,OU=' +$OU+ ',DC=' +$dc+ ''
$firstname = read-host « Entrez le prénom »
$fastname = read-host « Entrez le nom »
$initials = read-host « Entrez les initials »
$display = read-host « Entrez le nom complet affiché : Nom,Prénom»


#Création d'un compte utilisateur
New-QADUser –name $name –ParentContainer $localisation –UserPassword ‘password92*’  -SamAccountName $UPN –UserPrincipalName $UPN –Description $des –LogonScript ‘TR\TR_scriptlogon.cmd’ –Initials $initials  -FirstName $firstname –LastName $fastname –DisplayName $name | add-QADmemberOf -Group $grp
