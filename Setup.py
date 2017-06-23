import xml.dom.minidom
import subprocess
import argparse
import os


parser = argparse.ArgumentParser()
parser.add_argument('-p')
parser.add_argument('-b')

args = parser.parse_args()

doc = xml.dom.minidom.parse("pom.xml")
modules = doc.getElementsByTagName("module")
subprocess.call("sh install.sh", shell=True)

if not args.b:
    args.b = 'master'

for module in modules:
    module_name = module.firstChild.nodeValue
    model_paths = os.path.join(os.getcwd(), 'model_definitions')
    arguments = "-r %s -m %s -p %s -b %s" % (module_name, model_paths, args.p, args.b)
    shell_command = "sh install-module.sh %s" % arguments
    subprocess.call(shell_command, shell=True)

os.rmdir(os.path.join(os.getcwd(), 'model_definitions'))
os.remove(os.path.join(os.getcwd(), 'Download.py'))
