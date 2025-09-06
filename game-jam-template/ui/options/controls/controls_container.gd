extends Control

const ICON_SIZE_PX: int = 48
var _formatter:GUIDEInputFormatter = GUIDEInputFormatter.new(ICON_SIZE_PX)

@onready var input_manager: InputManager = get_node("/root/G_InputManager")

@onready var _control_list: Container = %ControlList
@onready var _input_detector: GUIDEInputDetector = %GUIDEInputDetector

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
		_control_list.add_child(row_container)

		var display_name: String
		if item._input_mapping.display_name != "":
			display_name = item._input_mapping.display_name
		else:
			display_name = item.display_name

		var name_label: Label = Label.new()
		name_label.text = display_name
		name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row_container.add_child(name_label)

		var label: RichTextLabel = RichTextLabel.new()
		label.bbcode_enabled = true
		label.custom_minimum_size = Vector2(ICON_SIZE_PX, ICON_SIZE_PX)
		row_container.add_child(label)

		_apply_input(current_input, label)
		item.changed.connect(_apply_input.bind(label))

		var remap_button := Button.new()
		remap_button.text = tr("BTN_CONTROL_REMAP")
		row_container.add_child(remap_button)

func _apply_input(input: GUIDEInput, label: RichTextLabel):
	if input == null:
		label.parse_bbcode("[color=gray]Not bound[/color]")
		return

	var icon:String = await _formatter.input_as_richtext_async(input)
	label.parse_bbcode(icon)

func _rebind(item: GUIDERemapper.ConfigItem):
	_input_detector.detect(item.value_type)
