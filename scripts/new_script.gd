extends Sprite2D

# Variables to control the balloon size
var original_scale = Vector2(1, 1)
var target_scale = Vector2(2, 2)  # Change this to adjust the target scale
var scale_speed = 1.01  # Change this to adjust the speed of scaling

func _ready():
	# Store the original scale of the balloon
	original_scale = self.scale

func _process(delta):
	# Check if the spacebar is pressed
	if Input.is_action_pressed("ui_accept"):
		# Increase the scale of the balloon towards the target scale
		self.scale *= scale_speed
	#else:
		## If the spacebar is not pressed, reset the scale to the original scale
		#self.scale = original_scale
