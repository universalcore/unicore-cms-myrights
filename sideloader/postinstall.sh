pip="${VENV}/bin/pip"
cd /var/praekelt/unicore-cms-ebola/ && ./install_libgit2 && cd ~/

$pip install cffi praekelt-python-gitmodel
$pip install -e /var/praekelt/unicore-cms-ebola/
