class_name StartButton extends Button

@onready var event_bus: EventBus = get_node("/root/G_EventBus")

func _on_pressed():
    event_bus.start_button_clicked.emit()
