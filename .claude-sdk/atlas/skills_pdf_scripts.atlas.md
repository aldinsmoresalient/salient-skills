# FOLDER: skills/pdf/scripts

PURPOSE: [Describe purpose]
LAYER: unknown
RISK: low
FILES: 8

## KEY FILES
FILE: fill_fillable_fields.py
FILE: convert_pdf_to_images.py
FILE: extract_form_field_info.py
FILE: check_bounding_boxes.py
FILE: check_bounding_boxes_test.py
FILE: create_validation_image.py
FILE: fill_pdf_form_with_annotations.py
FILE: check_fillable_fields.py

## EXPORTS
EXPORT: class RectAndField:
EXPORT: def get_bounding_box_messages(fields_json_stream) -> list[str]:
EXPORT: class TestGetBoundingBoxMessages(unittest.TestCase):
EXPORT: def convert(pdf_path, output_dir, max_dim=1000):
EXPORT: def create_validation_image(page_number, fields_json_path, input_path, output_path):
EXPORT: def get_full_annotation_field_id(annotation):
EXPORT: def make_field_dict(field, field_id):
EXPORT: def get_field_info(reader: PdfReader):
EXPORT: def write_field_info(pdf_path: str, json_output_path: str):
EXPORT: def fill_pdf_fields(input_pdf_path: str, fields_json_path: str, output_pdf_path: str):
EXPORT: def validation_error_for_field_value(field_info, field_value):
EXPORT: def monkeypatch_pydpf_method():
EXPORT: def transform_coordinates(bbox, image_width, image_height, pdf_width, pdf_height):
EXPORT: def fill_pdf_form(input_pdf_path, fields_json_path, output_pdf_path):

## SEARCH ANCHORS
GREP: "function " in skills/pdf/scripts
GREP: "class " in skills/pdf/scripts
GREP: "export " in skills/pdf/scripts
GREP: "import.*from" in skills/pdf/scripts

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
