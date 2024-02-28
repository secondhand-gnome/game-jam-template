class_name EventBus extends Node

signal start_button_clicked
signal main_menu_clicked
signal options_menu_opened
signal options_menu_closed

signal music_volume_changed(new_volume_linear: float)
signal sfx_volume_changed(new_volume_linear: float)

signal game_complete
signal game_over
