#!/bin/bash
which -s brew
if [ $? -eq 0 ]; then
  cat casks | xargs brew install --casks
  cat leaves | xargs brew install
else
  echo "Brew is not installed"
fi
