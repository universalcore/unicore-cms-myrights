pip="${VENV}/bin/pip"

cd "${INSTALLDIR}/${REPO}/"

$pip install -e "${INSTALLDIR}/${REPO}/"

ini_files="/var/praekelt/unicore-mc/project/configs/frontend_settings/myrights_*.ini"

for ini in $ini_files
do
    `which eg-tools` resync -c $ini -m unicore.content.models.Category -r true -f "${INSTALLDIR}/${REPO}/mappings/category.mapping.json"
    `which eg-tools` resync -c $ini -m unicore.content.models.Page -f "${INSTALLDIR}/${REPO}/mappings/page.mapping.json"
    `which eg-tools` resync -c $ini -m unicore.content.models.Localisation -f "${INSTALLDIR}/${REPO}/mappings/localisation.mapping.json"
    touch $ini
done
