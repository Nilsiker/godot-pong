extends CharacterBody2D
class_name Paddle

@export_enum("Player1", "Player2") var player: String

@export var _speed: float = 500
@export var _move_direction: float

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = _move_direction * Vector2.DOWN * _speed
	move_and_slide()

func _unhandled_input(event):
	if event is InputEventScreenTouch or event is InputEventScreenDrag:
		if player == "Player1" and event.position.x < 200:
			global_position.y = event.position.y
		elif player == "Player2" and event.position.x > 1000:
			global_position.y = event.position.y

	if player == "Player1":
		if event.is_action("w") or event.is_action("s"):
			_move_direction = Input.get_axis("w", "s")
	else:
		if event.is_action("ui_up") or event.is_action("ui_down"):
			_move_direction = Input.get_axis("ui_up", "ui_down")
