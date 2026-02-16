# FOLDER: skills/docx/ooxml/scripts

PURPOSE: [Describe purpose]
LAYER: unknown
RISK: low
FILES: 3

## KEY FILES
FILE: pack.py
FILE: validate.py
FILE: unpack.py

## EXPORTS
EXPORT: def main():
EXPORT: def pack_document(input_dir, output_file, validate=False):
EXPORT: def validate_document(doc_path):
EXPORT: def condense_xml(xml_file):
EXPORT: def main():

## SEARCH ANCHORS
GREP: "function " in skills/docx/ooxml/scripts
GREP: "class " in skills/docx/ooxml/scripts
GREP: "export " in skills/docx/ooxml/scripts
GREP: "import.*from" in skills/docx/ooxml/scripts

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
