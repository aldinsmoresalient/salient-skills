# FOLDER: skills/mcp-builder/scripts

PURPOSE: UI components
LAYER: presentation
RISK: low
FILES: 2

## KEY FILES
FILE: evaluation.py
FILE: connections.py

## EXPORTS
EXPORT: class MCPConnection(ABC):
EXPORT: class MCPConnectionStdio(MCPConnection):
EXPORT: class MCPConnectionSSE(MCPConnection):
EXPORT: class MCPConnectionHTTP(MCPConnection):
EXPORT: def create_connection(
EXPORT: def parse_evaluation_file(file_path: Path) -> list[dict[str, Any]]:
EXPORT: def extract_xml_content(text: str, tag: str) -> str | None:
EXPORT: def parse_headers(header_list: list[str]) -> dict[str, str]:
EXPORT: def parse_env_vars(env_list: list[str]) -> dict[str, str]:

## SEARCH ANCHORS
GREP: "function " in skills/mcp-builder/scripts
GREP: "class " in skills/mcp-builder/scripts
GREP: "export " in skills/mcp-builder/scripts
GREP: "import.*from" in skills/mcp-builder/scripts

## DEPENDENCIES

## NOTES
[Add folder-specific notes here]
