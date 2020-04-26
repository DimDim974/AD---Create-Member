# =======================================================
# NAME: FULL.ps1
# AUTHOR: SAUTRON Dimitri,UP Informatique - ASTI - ILOG - SNCF
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

#Afficher les listes de diffusion
#get-QADGroup -GroupType 'Distribution'

# Ajouter des groupes a un utilisateur 
#$user = read-host « Entrez user »
#Get-QADUSER $user | add-QADMemberOf -group '_tr_etc_cpft_ttng_e_gg','_tr_etc_cpft_z2n_3d_e_gg'

#Les groupes d'un user
#$user = read-host « Entrez user »
#Get-QADUSER $user | Get-QADGroup

#Récuperer tout les utilisateurs d'une OU
#Get-QADUser -Searchroot "OU=Utilisateurs,OU=TR-Capitole,OU=Tours,OU=Ressources_Locales,DC=COMMUN,DC=AD,DC=SNCF,DC=FR" | Select-Object Name, LogonName, SamAccountName| Export-csv d:\capitole.csv -Delimiter ";"

#Ajouter des membres a un groupe
#add-qadgroupmember '_tr_drh_rh_e_gg' -Member '7610967R'

#Récupere les ordinateurs inactifs depuis 180 jours
#Get-QADComputer -SearchRoot "OU=Tours,OU=Ressources_Locales,DC=COMMUN,DC=AD,DC=SNCF,DC=FR" -InactiveFor 180

#Récupére les ordinateurs inactifs depuis 180 jrs et export vers fichier CSV
#Get-QADComputer -SearchRoot "OU=Tours,OU=Ressources_Locales,DC=COMMUN,DC=AD,DC=SNCF,DC=FR" -InactiveFor 180 | Out-File "D:\test.csv"

#Récupérer les comptes génériques
#$user = read-host 'Entrez le CP'
#Get-QADUSER $user -searchroot 'OU=Comptes_Generiques,OU=Tours,OU=Ressources_Locales,DC=COMMUN,DC=AD,DC=SNCF,DC=FR' | Select-Object Name, LogonName, SamAccountName, Email | Export-csv d:\data2.csv -Delimiter ";" 

#Récupere les ordinateurs inactifs depuis 180 jrs et les exports vers un format CSV
#Get-QADComputer -SearchRoot "OU=Tours,OU=Ressources_Locales,DC=COMMUN,DC=AD,DC=SNCF,DC=FR" -InactiveFor 180 | Export-Csv "D:\test.csv"

#Manipuler la base de registre
#$nom_machine = read-host
#$distant=[microsoft.win32.registrykey]::openremotebasekey("LOCALMACHINE",$nom_machine)
#$val=$distant.opensubkey("SYSTEM\currentcontrolset\control\terminal server")
#$val.getvalue("fdenytsconnections") 


#get-qaduser 7008935H | rename-QADObject -Identity 'CN=MANDROU Dominique (TR) ,OU=Utilisateurs,OU=EIMM_St-Pierre-des-Corps,OU=Tours,OU=Ressources_Locales,DC=COMMUN,DC=AD,DC=SNCF,DC=FR'

