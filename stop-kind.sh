#!/usr/bin/env bash

OS=$(uname -s)

if kind get clusters | grep '^kind$' &> /dev/null ; then
   echo 'Deleting kind cluster "kind"...'
   kind delete cluster
else
  echo 'kind cluster "kind" not running.'
fi

if [ "$CODESPACES" = "true" ]; then
  echo "Running inside a GitHub Codespace; docker daemon does not need to be stopped."
elif [[ "$OS" = "Darwin" || "$OS" = "Linux" ]]; then
  if colima list --profile default --json | yq -e &> /dev/null ; then
    echo 'Stopping Colima "default" profile...'
    colima stop
  else
    echo 'Colima "default" profile not running.'
  fi
fi