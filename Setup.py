import xml.dom.minidom
import subprocess
import argparse
import os


parser = argparse.ArgumentParser()
parser.add_argument('-p')
parser.add_argument('-b')
parser.add_argument('-r')

args = parser.parse_args()

doc = xml.dom.minidom.parse("pom.xml")
modules = doc.getElementsByTagName("module")
subprocess.call("sh init.sh", shell=True)

if not args.p:
    args.p = 'fhir,hml'

if not args.b:
    args.b = 'master'

for module in modules:
    module_name = module.firstChild.nodeValue
    model_paths = os.path.join(os.getcwd(), 'model_definitions')
    arguments = "-r %s -m %s -p %s -b %s" % (module_name, model_paths, args.p, args.b)
    shell_command = "sh install-module.sh %s" % arguments
    subprocess.call(shell_command, shell=True)

src_dir = os.getcwd() + '/'
download_script_path = os.path.join(src_dir, 'Download.py')
os.remove(download_script_path)
target_dir = os.path.join(src_dir, 'service-hml-fhir-converter-api/target/service-hml-fhir-converter-api-1.1.0-SNAPSHOT.jar')

subprocess.call("sh install.sh", shell=True)

if args.r and not args.r.isspace():
    run_args = "-e %s" % target_dir
    shell_command = "sh run.sh %s" % run_args
    subprocess.call(shell_command, shell=True)