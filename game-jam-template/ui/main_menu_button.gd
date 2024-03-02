class_name MainMenuButton extends Button

@onready var event_bus: EventBus = get_node("/root/G_EventBus")

func _on_pressed():
    event_bus.main_menu_clicked.emit()
