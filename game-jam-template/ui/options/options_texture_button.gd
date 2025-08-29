class_name OptionsTextureButton extends TextureButton

@onready var event_bus: EventBus = get_node("/root/G_EventBus")

func _on_pressed():
	event_bus.options_menu_opened.emit()
