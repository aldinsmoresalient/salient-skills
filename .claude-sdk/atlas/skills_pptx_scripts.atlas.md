# FOLDER: skills/pptx/scripts

PURPOSE: [Describe purpose]
LAYER: unknown
RISK: low
FILES: 5

## KEY FILES
FILE: html2pptx.js
FILE: thumbnail.py
FILE: rearrange.py
FILE: inventory.py
FILE: replace.py

## EXPORTS
EXPORT: module.exports = html2pptx;
EXPORT: def main():
EXPORT: class ShapeWithPosition:
EXPORT: class ParagraphData:
EXPORT: class ShapeData:
EXPORT: def is_valid_shape(shape: BaseShape) -> bool:
EXPORT: def collect_shapes_with_absolute_positions(
EXPORT: def sort_shapes_by_position(shapes: List[ShapeData]) -> List[ShapeData]:
EXPORT: def calculate_overlap(
EXPORT: def detect_overlaps(shapes: List[ShapeData]) -> None:
EXPORT: def extract_text_inventory(
EXPORT: def get_inventory_as_dict(pptx_path: Path, issues_only: bool = False) -> InventoryDict:
EXPORT: def save_inventory(inventory: InventoryData, output_path: Path) -> None:
EXPORT: def main():
EXPORT: def duplicate_slide(pres, index):
EXPORT: def delete_slide(pres, index):
EXPORT: def reorder_slides(pres, slide_index, target_index):
EXPORT: def rearrange_presentation(template_path, output_path, slide_sequence):
EXPORT: def clear_paragraph_bullets(paragraph):
EXPORT: def apply_paragraph_properties(paragraph, para_data: Dict[str, Any]):
EXPORT: def apply_font_properties(run, para_data: Dict[str, Any]):

## SEARCH ANCHORS
GREP: "function " in skills/pptx/scripts
GREP: "class " in skills/pptx/scripts
GREP: "export " in skills/pptx/scripts
GREP: "import.*from" in skills/pptx/scripts

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
