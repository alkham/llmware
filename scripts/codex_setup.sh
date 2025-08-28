#!/usr/bin/env bash
set -euxo pipefail

# Always run from repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

# Use project-local venv to avoid PEP 668
PY=python3.12
$PY -m venv .venv
source .venv/bin/activate

# Modern pip toolchain
python -m pip install -U pip setuptools wheel

# LLMWare wants installs from inside ./llmware
cd llmware
# Base requirements
pip install -r requirements.txt
# Optional extras (safe to skip if file absent)
if [ -f requirements_extras.txt ]; then
  pip install -r requirements_extras.txt
fi
