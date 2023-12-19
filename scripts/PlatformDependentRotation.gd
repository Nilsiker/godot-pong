extends Node

@export var _rotation_offset: float

func _ready():
	if OS.get_name() == "Android":
		get_parent().rotation_degrees = _rotation_offset;
	else:
		get_parent().rotation_degrees = 0;
