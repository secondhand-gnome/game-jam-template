class_name EventBus extends Node

signal start_button_clicked
signal main_menu_clicked
signal options_menu_opened

signal music_volume_changed(new_volume: int)
signal sfx_volume_changed(new_volume: int)

signal game_complete
signal game_over
