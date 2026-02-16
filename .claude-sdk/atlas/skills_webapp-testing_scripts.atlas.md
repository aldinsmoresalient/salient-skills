# FOLDER: skills/webapp-testing/scripts

PURPOSE: Tests
LAYER: test
RISK: low
FILES: 1

## KEY FILES
FILE: with_server.py

## EXPORTS
EXPORT: def is_server_ready(port, timeout=30):
EXPORT: def main():

## SEARCH ANCHORS
GREP: "function " in skills/webapp-testing/scripts
GREP: "class " in skills/webapp-testing/scripts
GREP: "export " in skills/webapp-testing/scripts
GREP: "import.*from" in skills/webapp-testing/scripts

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
