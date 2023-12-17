extends Node2D

var _left_score: float = 0
var _right_score: float = 0

var score_particles: PackedScene = preload("res://scenes/particles/score_particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

enum Side { 
	LEFT, 
	RIGHT 
}

func score(side: Side):
	update_score(side)
	spawn_score_particles($Ball.global_position)
	reposition_ball(side)
	$ScoreAudio.play()

func reposition_ball(side: Side):
	match side:
		Side.LEFT:
			$Ball.global_position = $BallSpawnPoint.global_position
			$Ball._velocity = Vector2.LEFT * 500
		Side.RIGHT:
			$Ball.global_position = $BallSpawnPoint.global_position
			$Ball._velocity = Vector2.RIGHT * 500	
	
func spawn_score_particles(position: Vector2):
	var particles = score_particles.instantiate()
	add_child(particles)
	particles.emitting = true
	particles.global_position = position
	particles.finished.connect(func(): particles.queue_free())

func update_score(side: Side):
	match side:
		Side.LEFT:
			_left_score += 1
			$HUD/MarginContainer/LeftScoreLabel.text = str(_left_score)
		Side.RIGHT:	
			_right_score += 1
			$HUD/MarginContainer/RightScoreLabel.text = str(_right_score)
