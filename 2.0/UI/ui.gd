class_name  UI extends CanvasLayer

@onready var tool_selector: ToolSelector = $ToolSelector

signal Tool_Changed(NewTool:InteractionToolUI)

func _on_tool_selector_tool_changed(NewTool: InteractionToolUI) -> void:
	emit_signal('Tool_Changed',NewTool)
