class_name OptionsMenu extends Container

@onready var event_bus: EventBus = get_node("/root/G_EventBus")
@onready var options: Options = get_node("/root/G_Options")

@onready var music_volume_slider = %MusicVolumeSlider
@onready var sfx_volume_slider = %SfxVolumeSlider

func _ready():
	music_volume_slider.set_value_no_signal(options.music_volume_linear * 100.0)
	sfx_volume_slider.set_value_no_signal(options.sfx_volume_linear * 100.0)

func _on_options_confirm_button_pressed():
	event_bus.options_menu_closed.emit()

func _on_music_volume_slider_value_changed(value: int):
	var linear_volume = float(value) / 100.0
	event_bus.music_volume_changed.emit(linear_volume)

func _on_sfx_volume_slider_value_changed(value: int):
	var linear_volume = float(value) / 100.0
	event_bus.sfx_volume_changed.emit(linear_volume)
