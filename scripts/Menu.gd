extends Control

@export var playButton: Button
@export var resetButton: Button
@export var audioButton: Button
@export var quitButton: Button

# Called when the node enters the scene tree for the first time.
func _ready():
	Engine.time_scale = 0.0
	playButton.pressed.connect(_on_play_button_pressed)
	resetButton.pressed.connect(_on_reset_button_pressed)
	audioButton.pressed.connect(_on_audio_button_pressed)
	quitButton.pressed.connect(_on_quit_button_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_play_button_pressed():
	Engine.time_scale = 1.0
	visible = false

func _on_reset_button_pressed():
	get_tree().current_scene.reset_game()
	Engine.time_scale = 1.0
	visible = false

func _on_audio_button_pressed():
	if audioButton.text == "AUDIO: ON":
		audioButton.text = "AUDIO: OFF"
		AudioServer.set_bus_mute(0, true)
	else:
		audioButton.text = "AUDIO: ON"
		AudioServer.set_bus_mute(0, false)
		

func _on_quit_button_pressed():
	get_tree().quit()


func _notification(what):
	if what == NOTIFICATION_WM_GO_BACK_REQUEST or what == NOTIFICATION_WM_CLOSE_REQUEST:
		visible = true
		Engine.time_scale = 0.0

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		visible = true
		Engine.time_scale = 0.0
