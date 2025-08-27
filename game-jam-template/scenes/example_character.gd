extends Node2D

@export var move_action:GUIDEAction
@export var say_hi_action:GUIDEAction

func _ready():
	say_hi_action.triggered.connect(_say_hi)

func _process(delta):
	var move_axis := move_action.value_axis_2d
	if move_axis.x != 0.0 or move_axis.y != 0.0:
		print(move_axis)

func _say_hi():
	print("HI")
