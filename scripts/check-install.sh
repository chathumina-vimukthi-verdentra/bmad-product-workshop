#!/usr/bin/env bash
# Usage: ./scripts/check-install.sh   (from the repository root)
# Compares every skill's computedHash in product/skills-lock.json with the baseline stored in
# scripts/baseline-skills-lock.json. Prints OK, or lists the skills that drifted. Needs uv, not node.
# Exit code: 0 OK, 1 drift, 2 no lock file.
set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BASE="$ROOT/scripts/baseline-skills-lock.json"
FOUND="$ROOT/product/skills-lock.json"
command -v uv >/dev/null 2>&1 || { echo "Stop: uv is not installed."; exit 1; }
[ -f "$BASE" ] || { echo "Stop: baseline lock not found at $BASE."; exit 1; }
[ -f "$FOUND" ] || { echo "No skills-lock.json in product/. BMad is not installed there."; exit 2; }
uv run --no-project python - "$BASE" "$FOUND" <<'PY'
import json, sys
base = json.load(open(sys.argv[1])).get("skills", {})
found = json.load(open(sys.argv[2])).get("skills", {})
changed = [n for n in base if n in found and base[n].get("computedHash") != found[n].get("computedHash")]
missing = [n for n in base if n not in found]
extra = [n for n in found if n not in base]
if not (changed or missing or extra):
    print(f"OK: all {len(base)} skills match the baseline.")
    sys.exit(0)
print(f"DRIFT: {len(changed)+len(missing)+len(extra)} difference(s) from the baseline of {len(base)} skills.")
for title, items in (("Different hash", changed), ("Missing", missing), ("Not in the baseline", extra)):
    if items:
        print(title + ":")
        for n in items: print("  " + n)
print("A drift means this install is a different version of BMad than the reference. The reference output may then differ from what you see.")
sys.exit(1)
PY
