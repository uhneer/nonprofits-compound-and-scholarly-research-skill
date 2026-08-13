#!/usr/bin/env bash
# Self-scaffolding bootstrap for the Compound & Scholarly Verification stack.
# Checks/installs prerequisites, then ensures the workspace exists.
# Idempotent: safe to run at the start of every run.
set -uo pipefail

echo "== prerequisites =="

# base tools
for tool in python3 curl; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "  ok: $tool"
  else
    echo "  missing: $tool (install via platform package manager, then re-run)"
    exit 1
  fi
done

# python environment: prefer an existing venv, else create one (PEP 668 safe)
if python3 -c "import sys; sys.exit(0 if sys.prefix != sys.base_prefix else 1)" 2>/dev/null; then
  echo "  ok: already inside a virtualenv ($(python3 -c 'import sys; print(sys.prefix)'))"
else
  VENV="${RESEARCHSTACK_VENV:-$HOME/.researchstack-venv}"
  if [ ! -x "$VENV/bin/python" ]; then
    echo "  creating venv: $VENV"
    python3 -m venv "$VENV" || { echo "  FAILED: python3 -m venv"; exit 1; }
  fi
  # shellcheck disable=SC1091
  source "$VENV/bin/activate"
  echo "  using venv: $VENV"
fi

# python packages (import names differ from package names: pymupdf -> fitz)
PYTHON="$([ -n "${VIRTUAL_ENV:-}" ] && echo "$VIRTUAL_ENV/bin/python" || echo python3)"
missing_pkgs=$("$PYTHON" - <<'EOF'
import importlib.util
wanted = {"scrapling": "scrapling", "nodriver": "nodriver", "pymupdf": "fitz", "pdfplumber": "pdfplumber"}
print(" ".join(pkg for pkg, mod in wanted.items() if importlib.util.find_spec(mod) is None))
EOF
)
if [ -n "$missing_pkgs" ]; then
  for pkg in $missing_pkgs; do
    echo "  installing: $pkg"
    "$PYTHON" -m pip install --quiet "$pkg" \
      || "$PYTHON" -m pip install --quiet --user "$pkg" \
      || echo "  WARN: failed to install $pkg (continue, retry later)"
  done
else
  echo "  ok: all python packages present"
fi

echo "== workspace =="
WS="${RESEARCHSTACK_WORKSPACE:-$HOME/ResearchStack}"
mkdir -p "$WS"
echo "  workspace: $WS"
echo
echo "bootstrap done. create the run folder when a run starts:"
echo "  mkdir -p \"$WS/<Run Context Name>/{Primary,Secondary,temp}\""
