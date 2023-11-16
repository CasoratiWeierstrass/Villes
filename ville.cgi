#!/bin/bash

echo "Content-type: text/html"
echo ""


code_region=$CODE

bash makecsv.sh $code_region > tmp_file

nom_region=$(cat data/regions-france.csv | grep $code_region | cut -d"," -f2)

cat tmp_file | sed -E "s/:/ | /g" | \
sed -E "s/^/<li>/g"  | \
sed -E "s/$/<\/li>/g" | \

sed '1i\<h1> VILLES DANS LA REGION : '$nom_region'  -  code : '$code_region' </h1>' | \
sed '1i\<html><body><ul><pre>'

echo "</pre></ul></body></html>"

rm tmp_file

