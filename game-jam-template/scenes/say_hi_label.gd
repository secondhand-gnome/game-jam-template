extends RichTextLabel

@export var say_hi_action:GUIDEAction

@onready var _formatter: GUIDEInputFormatter = \
	GUIDEInputFormatter.for_active_contexts()

func _ready():
	GUIDE.input_mappings_changed.connect(_on_input_mappings_changed)
	_on_input_mappings_changed()

func _on_input_mappings_changed():
	var action_text := await _formatter.action_as_richtext_async(say_hi_action)
	text = tr("Press %s to [b]Say Hi[/b]") % [action_text]
