#!/usr/bin/env bash
# Usage: ./scripts/setup.sh   (run from the repository root)
# Checks the tools the product track needs, checks the project is wired up, and says Ready.
# It never installs a tool for you and is safe to run more than once.
# Windows: run it in Git Bash or WSL, or use scripts\setup.cmd.
set -uo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PRODUCT="$ROOT/product"
FAIL=0

echo "Checking your tools"
if command -v git >/dev/null 2>&1; then
  echo "  $(git --version)"
  if [ -z "$(git config user.name || true)" ] || [ -z "$(git config user.email || true)" ]; then
    echo "  Stop: git does not know your name and email. Your commits need them. Run:"
    echo "    git config --global user.name \"Your Name\""
    echo "    git config --global user.email \"you@example.com\""
    FAIL=1
  fi
else
  echo "  Stop: git is not installed. Install it from https://git-scm.com and run this script again."
  FAIL=1
fi

if command -v uv >/dev/null 2>&1; then
  echo "  uv $(uv --version | awk '{print $2}')"
else
  echo "  Stop: uv is not installed. The BMad scripts use it. Install it with:"
  echo "    pip install uv        (or: brew install uv on a Mac)"
  FAIL=1
fi

if command -v code >/dev/null 2>&1; then
  echo "  VS Code command 'code' found"
else
  echo "  Note: the 'code' command was not found. You can still open the folder from VS Code with File > Open Folder."
fi

[ "$FAIL" -ne 0 ] && { echo; echo "Fix the items above, open a new terminal and run ./scripts/setup.sh again."; exit 1; }

echo
echo "Checking the project"
if [ ! -d "$PRODUCT/.agents/skills" ] || [ ! -d "$PRODUCT/_bmad" ]; then
  echo "  Stop: product/.agents/skills or product/_bmad is missing. Clone the repository again."
  exit 1
fi
SKILLS="$(ls "$PRODUCT/.agents/skills" | wc -l | tr -d ' ')"
echo "  $SKILLS BMad skill folders found in product/.agents/skills"

if grep -q '"figma"' "$PRODUCT/.vscode/mcp.json" 2>/dev/null; then
  echo "  Figma MCP server is listed in product/.vscode/mcp.json"
else
  echo "  Stop: the Figma server is missing from product/.vscode/mcp.json."
  exit 1
fi

ACTIVE="$(cd "$PRODUCT" && uv run --no-cache _bmad/scripts/resolve_config.py --project-root . --key core.active_initiative 2>/dev/null | tr -d '"[:space:]{}' | sed 's/^core\.active_initiative://')"
if [ -z "$ACTIVE" ]; then
  echo "  Stop: BMad could not read its configuration. Re-run this script. If it still fails, tell the presenter."
  exit 1
fi
echo "  Active initiative: $ACTIVE"

echo
echo "Ready. Open the product folder in VS Code."
echo "Next, once: in VS Code run MCP: List Servers, choose figma, Start Server, and sign in to Figma."
