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
  go get $package && \
  cd $OUTPUT_BINARIES && \
  GOOS=windows GOARCH=amd64 go build -o ${package}-windows.exe ${package} && mv ${package}-windows.exe ./$(basename ${package})-windows.exe
  GOOS=linux GOARCH=amd64 go build -o ${package}-linux ${package} && mv ${package}-linux ./$(basename ${package})-linux
  GOOS=darwin GOARCH=amd64 go build -o ${package}-darwin ${package} && mv ${package}-darwin ./$(basename ${package})-darwin
done
set +x

chown -R $DO_USER:$DO_USER /gowork
ls -alsht $OUTPUT_BINARIES
