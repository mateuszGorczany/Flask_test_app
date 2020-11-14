#!/usr/bin/env bash

pip install virtualenv
virtualenv venv --distribute
. venv/bin/activate 
pip install -r requirements.txt
