#!/bin/bash
find . -name '*.mo' -delete
mkdir -p unicorecmsebola/locale

pot-create -o unicorecmsebola/locale/unicorecmsebola.pot unicorecmsebola/

mkdir -p unicorecmsebola/locale/eng_UK/LC_MESSAGES
mkdir -p unicorecmsebola/locale/swh_TZ/LC_MESSAGES

# only uncomment if it's the 1st time
#msginit -l eng_UK -i unicorecmsebola/locale/unicorecmsebola.pot -o unicorecmsebola/locale/eng_UK/LC_MESSAGES/unicorecmsebola.po
#msginit -l swh_TZ -i unicorecmsebola/locale/unicorecmsebola.pot -o unicorecmsebola/locale/swh_TZ/LC_MESSAGES/unicorecmsebola.po

msgmerge --update unicorecmsebola/locale/eng_UK/LC_MESSAGES/unicorecmsebola.po unicorecmsebola/locale/unicorecmsebola.pot
msgmerge --update unicorecmsebola/locale/swh_TZ/LC_MESSAGES/unicorecmsebola.po unicorecmsebola/locale/unicorecmsebola.pot

msgfmt unicorecmsebola/locale/eng_UK/LC_MESSAGES/*.po -o unicorecmsebola/locale/eng_UK/LC_MESSAGES/unicorecmsebola.mo
msgfmt unicorecmsebola/locale/swh_TZ/LC_MESSAGES/*.po -o unicorecmsebola/locale/swh_TZ/LC_MESSAGES/unicorecmsebola.mo
