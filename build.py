import os
import fileinput

cmd_format = (
    "fpm --python-bin $(which python3) --python-pip $(which pip3)"
    " -s python -t deb -v {0} {1}"
)

for line in fileinput.input():
    pkg, version = line.strip().split("==")
    os.system(cmd_format.format(version, pkg))
    os.system("mv *.deb /result/")  # sigh
