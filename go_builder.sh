#!/bin/bash
set -e

mkdir -p $OUTPUT_BINARIES
mkdir -p $GOPACKAGES

echo ' '
echo '------------------'
echo "Adding user $DO_USER"
echo '------------------'
echo ' '

useradd $DO_USER -u $DO_UID


echo '------------------'
echo "Reading $GOREPOS and fetching with git"
echo '------------------'
echo ' '


# REMOVE OLD PACKAGES
set -x
cd $GOPACKAGES
rm -rf $GOPACKAGES/*

# Clone GIT REPOS TO GET PAKCAGES
cat $INPUT_REPOS | while read package
do
  cd $GOPACKAGES
  go get $package && cd $OUTPUT_BINARIES && go build $package
done
set +x

chown -R $DO_USER:$DO_USER /gowork
ls -alsht $OUTPUT_BINARIES
