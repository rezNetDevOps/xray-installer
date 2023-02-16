# xray-installer

This script downloads and installs the Xray binary, prompts the user to select a template from the Xray-examples repository, downloads the template, and customizes it with the necessary configuration keys. Finally, it starts the Xray service with the customized config.

You will need to have the `jq` command-line tool installed to run the script. If you don't have jq installed, you can install it with the command `sudo apt-get install jq` (for Ubuntu or Debian) or `sudo yum install jq` (for CentOS or Red Hat).
