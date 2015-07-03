#! /bin/bash
set -e

find ./unicorecmsebola -name '*.py' | xargs pep8
find ./unicorecmsebola -name '*.py' | xargs pyflakes
py.test --verbose --cov ./unicorecmsebola unicorecmsebola
