# FOLDER: skills/pptx/ooxml/scripts

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
GREP: "function " in skills/pptx/ooxml/scripts
GREP: "class " in skills/pptx/ooxml/scripts
GREP: "export " in skills/pptx/ooxml/scripts
GREP: "import.*from" in skills/pptx/ooxml/scripts

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
