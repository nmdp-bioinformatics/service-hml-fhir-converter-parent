# service-hml-fhir-converter-parent
This is a parent project to build and install service-hml-fhir-converter and service-hml-fhir-converter-api.

### Note
A variety of dependencies are needed to run the above mentioned projects. Currently, dependencies are not published in a hosted environment (such as Artifactory). This package will run the necessary Maven commands with arguments to install to your local maven repository.

### Prerequisites 
To build, install, and run this application, you will need to have the following installed on a Unix environment (** To come shortly: Windows / PS automated build)

- Java 8
- Maven 3 or greater
- Python 2.7

### Installation
Installation is automated, to install default package, simply issue the following command:

'python Setup.py [options]'

This will initiate downloading source code from github on the MASTER branch. Packages are built and installed in sequential order, this is maintained by build automation.

### Options

- '-b': Specify the branch to build the project agains (default is master).
- '-p': Specify the packages to create swagger-spec.yaml files for. These build swagger API and Models (default is:'fhir,hml'). Values must be a comma separated list of packages to build.
- '-r': Optional run command, value = 'run', this will run the application and startup endpoints / spring server after successful build.
