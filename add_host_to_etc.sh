#!/bin/bash

#
# To add your host into /hosts file run script as follows:
# ./add_host_to_etc.sh HostIP HostName
# ./add_host_to_etc.sh 127.0.0.1 Localhost
#

[ $EUID -eq 0 ] || { echo "Run this script as root"; exit 1; }

path=default

case "$(uname -sr)" in
   Darwin*)
     path="/private/etc/hosts"
     ;;

   Linux*)
     path="/etc/hosts"
     ;;

   CYGWIN*|MINGW*|MINGW32*|MSYS*)
     path="c:\Windows\System32\Drivers\etc\hosts"
     ;;
   *)
     echo 'Script does not support your OS'; exit 1;
     ;;
esac

case "$1" in
  -h)
     echo "Execute script, as args provide Host IP and Host name that you want to set";;

  --help)
     echo "Execute script, as args provide Host IP and Host name that you want to set";;
  
  *)
     [ $# -eq 2 ] || { echo "Provide Host IP and Host name that you want to set"; exit 1; } 
     echo "$1    $2" >> $path
     ;;
esac

