start-kind:
  #!/usr/bin/env bash
  set -euo pipefail
  ARCH=$(uname -m)
  OS=$(uname -s)

  if [ "${CODESPACES:-}" = "true" ]; then
    echo "Running inside a GitHub Codespace; docker daemon should already be available."
  elif ! docker info >/dev/null 2>&1; then
    if [[ "$OS" = "Darwin" || "$OS" = "Linux" ]]; then
      if \
        colima list --profile default --json | 
        yq -e 'select(.status == "Running")' &> /dev/null
      then
        echo 'Colima "default" profile already started'
      else
        echo 'Starting Colima "default" profile...'
        colima start
      fi
    else
      echo "Arch: ${ARCH}, OS: ${OS}."
      echo "❌ Docker daemon is not running or not accessible. Start a docker daemon first."
      exit 1
    fi
  fi

  if kind get clusters | grep '^kind$' &> /dev/null ; then
    echo 'kind cluster "kind" already started'
  else
    echo 'Starting kind cluster "kind"...'
    kind create cluster
  fi

stop-kind:
  #!/usr/bin/env bash
  set -euo pipefail
  OS=$(uname -s)

  if kind get clusters | grep '^kind$' &> /dev/null ; then
    echo 'Deleting kind cluster "kind"...'
    kind delete cluster
  else
    echo 'kind cluster "kind" not running.'
  fi

  if [ "${CODESPACES:-}" = "true" ]; then
    echo "Running inside a GitHub Codespace; docker daemon does not need to be stopped."
  elif [[ "$OS" = "Darwin" || "$OS" = "Linux" ]]; then
    if colima list --profile default --json | yq -e &> /dev/null ; then
      echo 'Stopping Colima "default" profile...'
      colima stop
    else
      echo 'Colima "default" profile not running.'
    fi
  fi