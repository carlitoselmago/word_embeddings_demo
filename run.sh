#!/usr/bin/env sh
# Creates a local virtualenv (first run only), installs the dependencies and
# opens the notebook in Jupyter.
set -eu

cd "$(dirname "$0")"

VENV=.venv
NOTEBOOK=Word_Embeddings.ipynb

if [ ! -x "$VENV/bin/python" ]; then
    PY=$(command -v python3 || command -v python || true)
    if [ -z "$PY" ]; then
        echo "Python 3 is required: https://www.python.org/downloads/" >&2
        exit 1
    fi
    echo "Creating $VENV..."
    "$PY" -m venv "$VENV"
fi

. "$VENV/bin/activate"

echo "Installing dependencies..."
python -m pip install -q numpy notebook

exec jupyter notebook "$NOTEBOOK"
