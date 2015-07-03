#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsmyrights/locale

pot-create -o unicorecmsmyrights/locale/unicorecmsmyrights.pot unicorecmsmyrights/

declare -a arr=("eng_GB" "hin_IN")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsmyrights/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsmyrights/locale/""$lang""/LC_MESSAGES/unicorecmsmyrights.po" ]; then
        msginit -l $lang -i unicorecmsmyrights/locale/unicorecmsmyrights.pot -o unicorecmsmyrights/locale/$lang/LC_MESSAGES/unicorecmsmyrights.po
    fi

    msgmerge --update unicorecmsmyrights/locale/$lang/LC_MESSAGES/unicorecmsmyrights.po unicorecmsmyrights/locale/unicorecmsmyrights.pot
    msgfmt unicorecmsmyrights/locale/$lang/LC_MESSAGES/*.po -o unicorecmsmyrights/locale/$lang/LC_MESSAGES/unicorecmsmyrights.mo
done
