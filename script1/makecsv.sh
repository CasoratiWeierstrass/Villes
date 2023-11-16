#!/bin/bash

### Script pour télécharger un fichier csv des villes de France ###

for arg in $@
do
	if [[ $arg =~ ^-rc=([0-9]{2})$ ]]
	then
		reg_code=${BASH_REMATCH[1]}
		echo "Vous voulez des infos sur la région de code ${BASH_REMATCH[1]}"
	fi
done


if ! [ -d donnees ]   # si le dossier 'donnees' n'existe pas
then
	mkdir donnees

	wget https://www.data.gouv.fr/fr/datasets/r/51606633-fb13-4820-b795-9a2a575a72f1 -O /home/louis/Projets_git/Villes/script1/donnees/villesdefrance.csv   # on crée le dossier 'donnees' et on y met le csv des villes de France

	wget https://www.data.gouv.fr/fr/datasets/r/70cef74f-70b1-495a-8500-c089229c0254 -O /home/louis/Projets_git/Villes/script1/donnees/departementsdefrance.csv   # idem avec le csv des departements
fi


cd donnees

reg_name=$(awk -v rc=$reg_code 'BEGIN{FS=","} $3==rc' departementsdefrance.csv | head -1 | cut -d',' -f4)

echo "Cette région porte le nom de $reg_name"

grep "$reg_name" villesdefrance.csv | cut -d',' -f2,7,3 | sed 's/,/:/g' > ../$reg_code.csv
