class_name Options extends Node

@onready var event_bus: EventBus = get_node("/root/G_EventBus")

# TODO respect values in audio stream players

# Music volume out of 100
var music_volume: int = 100

# SFX volume out of 100
var sfx_volume: int = 100

func _ready():
    event_bus.music_volume_changed.connect(update_music_volume)
    event_bus.sfx_volume_changed.connect(update_sfx_volume)

func update_music_volume(percentage: int):
    music_volume = percentage

func update_sfx_volume(percentage: int):
    sfx_volume = percentage