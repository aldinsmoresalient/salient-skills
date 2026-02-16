# FOLDER: skills/slack-gif-creator/core

PURPOSE: Business logic
LAYER: business
RISK: medium
FILES: 4

## KEY FILES
FILE: validators.py
FILE: easing.py
FILE: gif_builder.py
FILE: frame_composer.py

## EXPORTS
EXPORT: def linear(t: float) -> float:
EXPORT: def ease_in_quad(t: float) -> float:
EXPORT: def ease_out_quad(t: float) -> float:
EXPORT: def ease_in_out_quad(t: float) -> float:
EXPORT: def ease_in_cubic(t: float) -> float:
EXPORT: def ease_out_cubic(t: float) -> float:
EXPORT: def ease_in_out_cubic(t: float) -> float:
EXPORT: def ease_in_bounce(t: float) -> float:
EXPORT: def ease_out_bounce(t: float) -> float:
EXPORT: def ease_in_out_bounce(t: float) -> float:
EXPORT: def ease_in_elastic(t: float) -> float:
EXPORT: def ease_out_elastic(t: float) -> float:
EXPORT: def ease_in_out_elastic(t: float) -> float:
EXPORT: def get_easing(name: str = "linear"):
EXPORT: def interpolate(start: float, end: float, t: float, easing: str = "linear") -> float:
EXPORT: def ease_back_in(t: float) -> float:
EXPORT: def ease_back_out(t: float) -> float:
EXPORT: def ease_back_in_out(t: float) -> float:
EXPORT: def apply_squash_stretch(
EXPORT: def calculate_arc_motion(

## SEARCH ANCHORS
GREP: "function " in skills/slack-gif-creator/core
GREP: "class " in skills/slack-gif-creator/core
GREP: "export " in skills/slack-gif-creator/core
GREP: "import.*from" in skills/slack-gif-creator/core

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
