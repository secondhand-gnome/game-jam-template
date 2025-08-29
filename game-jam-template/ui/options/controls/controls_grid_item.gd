extends RichTextLabel

@export var guide_action: GUIDEAction

@onready var _formatter: GUIDEInputFormatter = \
	GUIDEInputFormatter.for_active_contexts()

func _ready():
	GUIDE.input_mappings_changed.connect(_on_input_mappings_changed)
	_on_input_mappings_changed()

func _on_input_mappings_changed():
	var action_text := await _formatter.action_as_richtext_async(guide_action)
	text = action_text
