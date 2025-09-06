@tool
extends Button

@export var guide_action: GUIDEAction

@onready var _is_remapping: bool = false

@onready var _formatter: GUIDEInputFormatter = \
	GUIDEInputFormatter.for_active_contexts()

func _ready():
	text = guide_action.display_name

	if not Engine.is_editor_hint():
		GUIDE.input_mappings_changed.connect(_on_input_mappings_changed)
		_on_input_mappings_changed()

func _input(event):
	if not _is_remapping:
		return

	# TODO filter only to valid types of input
	if event.is_pressed():
		print("Mapping %s to %s" % [guide_action.display_name, event])
		_is_remapping = false

func _on_input_mappings_changed():
	var action_text := _formatter.action_as_text(guide_action)
	text = "%s - %s" % [guide_action.display_name, action_text]

func _on_pressed():
	if _is_remapping:
		return
	print("Remapping input %s" % guide_action.display_name)
	_is_remapping = true
