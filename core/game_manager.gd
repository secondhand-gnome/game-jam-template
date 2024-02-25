class_name GameManager extends Node

const MAIN_MENU_SCENE: PackedScene = preload ("res://scenes/main_menu.tscn")
const GAME_ROOT_SCENE: PackedScene = preload ("res://scenes/root.tscn")

@onready var event_bus: EventBus = get_node("/root/G_EventBus")
@onready var level_manager: LevelManager = get_node("/root/G_LevelManager")

# Called when the game first starts
func _ready():
    level_manager.level_number = 1

    event_bus.start_button_clicked.connect(_on_start_button_clicked)
    event_bus.main_menu_clicked.connect(_on_main_menu_clicked)
    print("GameManager ready")

func _on_start_button_clicked():
    print("START")
    get_tree().change_scene_to_packed(GAME_ROOT_SCENE)

func _on_main_menu_clicked():
    print("MAIN")
    get_tree().change_scene_to_packed(MAIN_MENU_SCENE)
