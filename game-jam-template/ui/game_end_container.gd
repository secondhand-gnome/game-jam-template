extends Container

@onready var event_bus: EventBus = get_node("/root/G_EventBus")

@onready var game_win_label: Label = %GameWinLabel
@onready var game_over_label: Label = %GameOverLabel

func _ready():
	visible = false
	event_bus.game_complete.connect(_on_game_complete)
	event_bus.game_over.connect(_on_game_over)

func _on_game_complete():
	visible = true
	game_win_label.visible = true

func _on_game_over():
	visible = true
	game_over_label.visible = true
