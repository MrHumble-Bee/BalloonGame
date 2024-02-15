extends Node2D

const GAME_ROUNDS = 30
const prob_of_pop = 0.03
const val_inc_per_pump = 0.05
const balloon_sprite_growth_rate = 1.02

# Declare current_balloon_index as a property
var current_balloon_index = 0
var current_balloon_value = 0
var total_profit = 0
var sprite_node
var initial_balloon_size
var game_data
var balloon_data

# Called when the node enters the scene tree for the first time.
func _ready():
	$BgAudio.play()
	sprite_node = $Balloon
	initial_balloon_size = sprite_node.scale
	game_data = $TotalProfit
	balloon_data = $CurrentBalloonValue
	
	# Set the text content using BBCode
	game_data.bbcode_text = "Total Profit: $ %.2f\nBalloons Remaining: %d" % [total_profit, GAME_ROUNDS - current_balloon_index]
	balloon_data.bbcode_text = "Current Balloon Value: $ %.2f" % [self.current_balloon_value]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_data.bbcode_text = "Total Profit: $ %.2f\nBalloons Remaining: %d" % [total_profit, GAME_ROUNDS - current_balloon_index]
	balloon_data.bbcode_text = "Current Balloon Value: $ %.2f" % [self.current_balloon_value]
	if not $BgAudio.playing:
		$BgAudio.play()

func _on_pump_button_pressed():
	
	var rand = randf()
	if rand < prob_of_pop:
		# pop
		sprite_node.scale = initial_balloon_size
		self.current_balloon_value = 0
		self.current_balloon_index += 1
		$BalloonPopAudio.play()
		print("popped!")
	else:
		sprite_node.scale *= balloon_sprite_growth_rate
		self.current_balloon_value += val_inc_per_pump
		$BalloonPumpAudio.play()
		print(self.current_balloon_value)

func _on_sell_button_pressed():
	if self.current_balloon_index < GAME_ROUNDS:
		sprite_node.scale = initial_balloon_size
		self.total_profit += self.current_balloon_value
		self.current_balloon_value = 0
		self.current_balloon_index += 1
		$BalloonSellAudio.play()
		print(self.total_profit)