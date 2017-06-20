import xml.dom.minidom
import subprocess
import argparse
import os


parser = argparse.ArgumentParser()
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
subprocess.call("sh install.sh", shell=True)

for module in modules:
    module_name = module.firstChild.nodeValue
    model_paths = os.path.join(os.getcwd(), 'model_definitions')
    arguments = "-u %s -p %s -b %s -r %s -m %s" % (git_username, git_password, git_branch, module_name, model_paths)
    shell_command = "sh install-module.sh %s" % arguments
    subprocess.call(shell_command, shell=True)

os.rmdir(os.path.join(os.getcwd(), 'model_definitions'))
os.remove(os.path.join(os.getcwd(), 'Download.py'))
