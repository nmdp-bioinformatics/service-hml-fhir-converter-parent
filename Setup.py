import xml.dom.minidom
import subprocess
import argparse
import os

parser = argparse.ArgumenParser()
parser.add_argument('-u')
parser.add_argument('-p')
parser.add_argument('-b')

args = parser.parse_args()

if args.b == None:
    args.b = 'master'

git_username = args.u
git_password = args.p
git_branch = args.b

doc = xml.dom.minidom.parse("pom.xml")
modules = doc.getElementsByTagName("module")
subprocess.call("install.sh")

for module in modules:
    module_name = module.firstChild.nodeValue
    subprocess.call("install-module.sh -u %s -p %s -b %s -r %s -m %s" % git_username % \
        git_password % git_branch % module_name % os.path.join(os.getswd(), 'model_definitions'))
    