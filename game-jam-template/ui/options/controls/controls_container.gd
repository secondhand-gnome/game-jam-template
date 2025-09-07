extends Control

const ICON_SIZE_PX: int = 48
const ICON_SIZE_PX_LONG: int = 200
var _formatter: GUIDEInputFormatter = GUIDEInputFormatter.new(ICON_SIZE_PX)

@onready var input_manager: InputManager = get_node("/root/G_InputManager")

@onready var _control_list: Container = %ControlList
@onready var _input_detector: GUIDEInputDetector = %GUIDEInputDetector
@onready var _status_label: RichTextLabel = %StatusLabel

func _ready():
	_build_interface()

func _item_name(item: GUIDERemapper.ConfigItem) -> String:
	if item._input_mapping.display_name != "":
		return item._input_mapping.display_name
	else:
		return item.display_name

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

		var name_label: Label = Label.new()
		name_label.text = _item_name(item)
		name_label.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		row_container.add_child(name_label)

		var label: RichTextLabel = RichTextLabel.new()
		label.bbcode_enabled = true
		label.fit_content = true
		label.scroll_active = false
		label.custom_minimum_size = Vector2(ICON_SIZE_PX_LONG, ICON_SIZE_PX)
		label.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
		row_container.add_child(label)

		_apply_input(current_input, label)
		item.changed.connect(_apply_input.bind(label))

		var remap_button := Button.new()
		remap_button.text = "BTN_CONTROL_REMAP"
		remap_button.pressed.connect(func():
			_rebind(item)
		)
		row_container.add_child(remap_button)

		var restore_default_button := Button.new()
		restore_default_button.text = "BTN_CONTROL_DEFAULT"
		restore_default_button.pressed.connect(func():
			_restore_default(item)
		)
		row_container.add_child(restore_default_button)

func _apply_input(input: GUIDEInput, label: RichTextLabel):
	if input == null:
		label.parse_bbcode("[color=gray]%s[/color]" % tr("LABEL_CONTROL_UNASSIGNED"))
		return

	var icon: String = await _formatter.input_as_richtext_async(input)
	label.parse_bbcode(icon)

func _rebind(item: GUIDERemapper.ConfigItem):
	var remapper := input_manager.get_remapper()

	# Detect BOOL only, instead of trying to use axis (item.value_type)
	_input_detector.detect(GUIDEAction.GUIDEActionValueType.BOOL)

	# Show "Esc to cancel"
	var abort_detection_input: GUIDEInput = _input_detector.abort_detection_on[0]
	var abort_icon: String = await _formatter.input_as_richtext_async(abort_detection_input)
	var status_message: String = tr("STATUS_CONTROL_ABORT").replace(":?", abort_icon)
	_status_label.parse_bbcode(status_message)

	var input: GUIDEInput = await _input_detector.input_detected
	print("Reassigning GUIDE action %s" % _item_name(item))
	if input != null:
		_bind(item, input)
		_status_label.parse_bbcode("Changes will apply after game reset")
	else:
		_status_label.clear()

func _bind(item: GUIDERemapper.ConfigItem, input: GUIDEInput):
	# TODO for some reason, this gets finicky if we're using defaults and switch to some non-default
	var remapper := input_manager.get_remapper()
	remapper.set_bound_input(item, input)
	print("Set action %s to %s" % [_item_name(item), input])
	# TODO handle collisions
	input_manager.save_remaps()

func _restore_default(item: GUIDERemapper.ConfigItem):
	var remapper := input_manager.get_remapper()
	print("Restoring default GUIDE action for %s" % _item_name(item))
	var default_input := remapper.get_default_input(item)
	_bind(item, default_input)
