from git import Repo

import xml.dom.minidom
import pdb


doc = xml.dom.minidom.parse("pom.xml")
modules = doc.getElementsByTagName("module")

for module in modules:
    dir = module.firstChild.nodeValue

pdb.set_trace()