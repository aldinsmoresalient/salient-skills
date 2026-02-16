# FOLDER: skills/skill-creator/scripts

PURPOSE: [Describe purpose]
LAYER: unknown
RISK: low
FILES: 3

## KEY FILES
FILE: init_skill.py
FILE: package_skill.py
FILE: quick_validate.py

## EXPORTS
EXPORT: def main():
EXPORT: def title_case_skill_name(skill_name):
EXPORT: def init_skill(skill_name, path):
EXPORT: def main():
EXPORT: def package_skill(skill_path, output_dir=None):
EXPORT: def main():
EXPORT: def validate_skill(skill_path):

## SEARCH ANCHORS
GREP: "function " in skills/skill-creator/scripts
GREP: "class " in skills/skill-creator/scripts
GREP: "export " in skills/skill-creator/scripts
GREP: "import.*from" in skills/skill-creator/scripts

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
