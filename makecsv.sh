#!/bin/bash

### Script pour télécharger un fichier csv des villes de France ###

for arg in $@
do
	if [[ $arg =~ ^([0-9]{2})$ ]]
	then
		reg_code=${BASH_REMATCH[1]}
		echo "Vous voulez des infos sur la région de code ${BASH_REMATCH[1]}"
	fi
done


if ! [ -d data ]   # si le dossier 'data' n'existe pas
then
	mkdir data 

	wget https://www.data.gouv.fr/fr/datasets/r/51606633-fb13-4820-b795-9a2a575a72f1 -O data/villes-france.csv   # on crée le dossier 'donnees' et on y met le csv des villes de France

	wget https://www.data.gouv.fr/fr/datasets/r/70cef74f-70b1-495a-8500-c089229c0254 -O data/departements-france.csv   # idem avec le csv des departements

	wget https://www.data.gouv.fr/fr/datasets/r/34fc7b52-ef11-4ab0-bc16-e1aae5c942e7 -O data/regions-france.csv   # idem pour les regions

fi


cd data

reg_name=$(awk -v rc=$reg_code 'BEGIN{FS=","} $3==rc' departements-france.csv | head -1 | cut -d',' -f4)

echo "Cette région porte le nom de $reg_name"

grep "$reg_name" villes-france.csv | cut -d',' -f2,7,3 | sed 's/,/:/g' > ../$reg_code.csv

