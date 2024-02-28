class_name OptionsMenu extends Container

# TranslationServer.set_locale("es")
# TODO - Fix sound/music volume

@onready var event_bus: EventBus = get_node("/root/G_EventBus")
@onready var options: Options = get_node("/root/G_Options")

@onready var music_volume_slider = %MusicVolumeSlider
@onready var sfx_volume_slider = %SfxVolumeSlider

func _ready():
    music_volume_slider.set_value_no_signal(options.music_volume)
    sfx_volume_slider.set_value_no_signal(options.sfx_volume)

func _on_options_confirm_button_pressed():
    # TODO maybe save some data here?
    event_bus.options_menu_closed.emit()

func _on_music_volume_slider_value_changed(value: int):
    event_bus.music_volume_changed.emit(value)

func _on_sfx_volume_slider_value_changed(value: int):
    event_bus.sfx_volume_changed.emit(value)
