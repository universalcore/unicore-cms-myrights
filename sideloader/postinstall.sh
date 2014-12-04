pip="${VENV}/bin/pip"

cd "${INSTALLDIR}/${REPO}/"

$pip install -e "${INSTALLDIR}/${REPO}/"

ini_files="ebola.*.ini"

for ini in $ini_files
do
    `which eg-tools` resync -c $ini -m unicore.content.models.Category -r true -f mappings/category.mapping.json
    `which eg-tools` resync -c $ini -m unicore.content.models.Page -f mappings/page.mapping.json
    `which eg-tools` resync -c $ini -m unicore.content.models.Localisation -f mappings/localisation.mapping.json
done
