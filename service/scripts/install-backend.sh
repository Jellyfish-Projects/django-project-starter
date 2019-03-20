#!/bin/bash

virtualenv=false;

while getopts "v" opt
do
    case $opt in
        v) virtualenv=true;;
    esac
done

if [ "$virtualenv" = true ] ; then
    virtualenv -p python3 ./venv;
    source ./venv/bin/activate;
fi

pip install -r requirements.txt;
