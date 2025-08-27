class_name Options extends Node

var music_volume_linear: float = 0.9
var sfx_volume_linear: float = 0.9

@onready var event_bus: EventBus = get_node("/root/G_EventBus")
@onready var audio_bus_music := AudioServer.get_bus_index("Music")
@onready var audio_bus_sfx := AudioServer.get_bus_index("SFX")

func _ready():
	event_bus.music_volume_changed.connect(update_music_volume)
	event_bus.sfx_volume_changed.connect(update_sfx_volume)

func update_music_volume(linear_volume: float):
	music_volume_linear = linear_volume
	var music_volume_db = linear_to_db(linear_volume)
	AudioServer.set_bus_volume_db(audio_bus_music, music_volume_db)

func update_sfx_volume(linear_volume: float):
	sfx_volume_linear = linear_volume
	var sfx_volume_db = linear_to_db(linear_volume)
	AudioServer.set_bus_volume_db(audio_bus_sfx, sfx_volume_db)
