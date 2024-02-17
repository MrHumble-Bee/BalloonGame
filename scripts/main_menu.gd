extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$BgAudio.play() # Replace with function body.
	$Title.bbcode_text = "[center]WELCOME TO\nBALLOON SHOPPE!!!!!"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not $BgAudio.playing:
		$BgAudio.play()


func _on_play_button_pressed():
	var next_scene = "res://scenes/1_balloon_game.tscn"  # Update with the path to your next scene
	get_tree().change_scene_to_file(next_scene)

