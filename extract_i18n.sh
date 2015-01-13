#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsebola/locale

pot-create -o unicorecmsebola/locale/unicorecmsebola.pot unicorecmsebola/

declare -a arr=("eng_GB" "swa_TZ" "fre_FR")

for lang in "${arr[@]}"
do
    mkdir -p "unicorecmsebola/locale/""$lang""/LC_MESSAGES"

    if [ ! -f "unicorecmsebola/locale/""$lang""/LC_MESSAGES/unicorecmsebola.po" ]; then
        msginit -l $lang -i unicorecmsebola/locale/unicorecmsebola.pot -o unicorecmsebola/locale/$lang/LC_MESSAGES/unicorecmsebola.po
    fi

    msgmerge --update unicorecmsebola/locale/$lang/LC_MESSAGES/unicorecmsebola.po unicorecmsebola/locale/unicorecmsebola.pot
    msgfmt unicorecmsebola/locale/$lang/LC_MESSAGES/*.po -o unicorecmsebola/locale/$lang/LC_MESSAGES/unicorecmsebola.mo
done
