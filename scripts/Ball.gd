extends RigidBody2D
class_name Ball

@export var _speed: float = 200;

var _velocity: Vector2;
var bounce_particles = preload("res://scenes/particles/bounce_particles.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	_velocity = Vector2.LEFT * _speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(_velocity * delta)
	if collision:
		if collision.get_collider_shape().name == "Left":
			get_tree().current_scene.score(1)
		elif collision.get_collider_shape().name == "Right":
			get_tree().current_scene.score(0)
		else:
			_velocity = _velocity.bounce(collision.get_normal()) + collision.get_collider_velocity()
			spawn_bounce_particles()
			$BounceAudio.play()

func spawn_bounce_particles():
	var p = bounce_particles.instantiate()
	p.finished.connect(func(): p.queue_free())

	add_child(p)
	p.emitting = true
