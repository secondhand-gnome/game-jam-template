@tool
extends HBoxContainer

@export var guide_action: GUIDEAction

@onready var _name_label: Label = $ControlLabel
@onready var _icon_label: RichTextLabel = $ControlIcon

@onready var _formatter: GUIDEInputFormatter = \
	GUIDEInputFormatter.for_active_contexts()

func _ready():
	_name_label.text = guide_action.display_name

	if not Engine.is_editor_hint():
		GUIDE.input_mappings_changed.connect(_on_input_mappings_changed)
		_on_input_mappings_changed()

func _on_input_mappings_changed():
	var action_text := await _formatter.action_as_richtext_async(guide_action)
	_icon_label.text = action_text
