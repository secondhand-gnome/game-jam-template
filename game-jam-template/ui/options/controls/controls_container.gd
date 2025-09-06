extends VBoxContainer

const ICON_SIZE_PX: int = 48
var _formatter:GUIDEInputFormatter = GUIDEInputFormatter.new(ICON_SIZE_PX)

@onready var input_manager: InputManager = get_node("/root/G_InputManager")

func _ready():
	_build_interface()

func _build_interface():
	var remapper := input_manager.get_remapper()
	# get all items
	var items: Array[GUIDERemapper.ConfigItem] = \
		remapper.get_remappable_items()

	for item in items:
		var current_input: GUIDEInput = \
			remapper.get_bound_input_or_null(item)

		var row_container := HBoxContainer.new()
		add_child(row_container)

		var label: RichTextLabel = RichTextLabel.new()
		label.bbcode_enabled = true
		label.custom_minimum_size = Vector2(ICON_SIZE_PX, ICON_SIZE_PX)
		row_container.add_child(label)

		_apply_input(current_input, label)
		item.changed.connect(_apply_input.bind(label))

		var display_name: String
		if item._input_mapping.display_name != "":
			display_name = item._input_mapping.display_name
		else:
			display_name = item.display_name

		var name_label: Label = Label.new()
		name_label.text = display_name
		print_verbose("Add child %s" % display_name)
		row_container.add_child(name_label)

func _apply_input(input: GUIDEInput, label: RichTextLabel):
	if input == null:
		label.parse_bbcode("[color=gray]Not bound[/color]")
		return

	var icon:String = await _formatter.input_as_richtext_async(input)
	label.parse_bbcode(icon)
