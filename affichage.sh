#!/bin/bash

if [ ! -d tmp ]
then 
	mkdir tmp
fi

code_region=$1

bash makecsv.sh $code_region

nom_region=$(cat data/regions-france.csv | grep $code_region | cut -d"," -f2)

fichier=$code_region.csv

if ! [ -f $fichier ]
then
	exit 1
fi

cp $fichier tmp/$1.html
mv $fichier tmp/
cd tmp
index=$1.html

sed -E -i "s/:/ | /g" $index

sed -E -i "s/^/<li>/g" $index
sed -E -i "s/$/<\/li>/g" $index

sed -i '1i\<h1> VILLES DANS LA REGION : '$nom_region'  -  code : '$code_region' </h1>' $index
sed -i '1i\<html><body><ul><pre>' $index

echo "</pre></ul></body></html>" >> $index


firefox $index
