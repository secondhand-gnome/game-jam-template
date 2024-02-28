class_name Hud extends Control

const R_OPTIONS_WINDOW: PackedScene = preload ("res://ui/options_window.tscn")

@onready var event_bus: EventBus = get_node("/root/G_EventBus")

@onready var options_window = null

func _ready():
    event_bus.options_menu_opened.connect(_on_options_menu_opened)
    event_bus.options_menu_closed.connect(_on_options_menu_closed)

func _on_options_menu_opened():
    options_window = R_OPTIONS_WINDOW.instantiate()
    add_child(options_window)
    print(get_viewport().size)
    options_window.size = get_viewport().size
    print("Created options window")

func _on_options_menu_closed():
    remove_child(options_window)
    print("Closed options window")
