#! /bin/bash
set -e

find ./unicorecmsmyrights -name '*.py' | xargs pep8
find ./unicorecmsmyrights -name '*.py' | xargs pyflakes
py.test --verbose --cov ./unicorecmsmyrights unicorecmsmyrights
