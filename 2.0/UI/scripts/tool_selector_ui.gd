class_name ToolSelector
extends VBoxContainer

@export var Tools: Array[InteractionToolUI] = []

@export var ToolButtonGroup:ButtonGroup
var _buttons:Array[Button] = []
var _selectedTool: InteractionToolUI

signal Tool_Changed(NewTool:InteractionToolUI)

func _ready() -> void:
	var first:bool
	for tool in Tools:
		var tool_option: Button = Button.new()
		tool_option.pressed.connect(_tool_selected.bind(tool))
		tool_option.name = tool.Name + ' Tool Select'
		tool_option.text = tool.Name
		tool_option.toggle_mode = true
		tool_option.button_group = ToolButtonGroup
		_buttons.append(tool_option)
		add_child(tool_option)
		if not first:
			first = true
			tool_option.button_pressed = true
			tool_option.emit_signal('pressed')

func _tool_selected(Tool : InteractionToolUI) -> void:
	if _selectedTool != Tool:
		_selectedTool = Tool
		emit_signal('Tool_Changed',Tool)


func _input(event: InputEvent) -> void:
	if event.is_action("tool_1_select"):
		_buttons[0].button_pressed = true
		_tool_selected(Tools[0])
	elif event.is_action("tool_2_select"):
		_buttons[1].button_pressed = true
		_tool_selected(Tools[1])
