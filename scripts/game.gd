#extends Node2D
extends Control

const GAME_ROUNDS = 20
const prob_of_pop = 0.03
const val_inc_per_pump = 0.05
const balloon_sprite_growth_rate = 1.02

# Declare current_balloon_index as a property
var current_balloon_index = 0
var current_balloon_value = 0
var total_profit = 0
var num_balloons_popped = 0

var sprite_node
var initial_balloon_size
var game_data
var balloon_data

var pop_data = []
var pop_data_display_cn
var profit_data = []
var profit_data_display_cn

# Called when the node enters the scene tree for the first time.
func _ready():
	pop_data_display_cn = get_node("PopDataDisplay")
	profit_data_display_cn = get_node("ProfitDataDisplay")
	initialize_game_data()
	$BgAudio.play()
	sprite_node = $Control/Balloon
	initial_balloon_size = sprite_node.scale
	game_data = $TotalProfit
	balloon_data = $CurrentBalloonValue
	#print(pop_data)
	
	# Set the text content using BBCode
	game_data.bbcode_text = "Total Profit: $ %.2f\n\nBalloons Remaining: %d\nBalloons Popped: %d\nBalloons Sold: %d" % [total_profit, GAME_ROUNDS - current_balloon_index, num_balloons_popped, self.current_balloon_index - num_balloons_popped]
	balloon_data.bbcode_text = "Current Balloon Value: $ %.2f" % [self.current_balloon_value]

func initialize_game_data():
	for i in range(1):
		pop_data.append(0)
	for i in range(GAME_ROUNDS):
		profit_data.append(0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	game_data.bbcode_text = "Total Profit: $ %.2f\n\nBalloons Remaining: %d\nBalloons Popped: %d\nBalloons Sold: %d" % [total_profit, GAME_ROUNDS - current_balloon_index, num_balloons_popped, self.current_balloon_index - num_balloons_popped]
	balloon_data.bbcode_text = "Current Balloon Value: $ %.2f" % [self.current_balloon_value]
	if not $BgAudio.playing:
		$BgAudio.play()
	if Input.is_action_pressed("ui_accept"):  # "ui_accept" is the default action name for the spacebar
		_on_pump_button_pressed()

func _on_pump_button_pressed():
	if self.current_balloon_index >= GAME_ROUNDS:
		game_end()
		return
		
	var rand = randf()
	if rand < prob_of_pop:
		# pop
		sprite_node.scale = initial_balloon_size
		var pumps_til_pop = int(self.current_balloon_value / val_inc_per_pump)
		while len(pop_data) <= pumps_til_pop:
			pop_data.append(0)
		pop_data[pumps_til_pop] += 1
		
		# Profit Update
		profit_data[self.current_balloon_index] = self.total_profit
		
		print(pop_data)
		self.current_balloon_value = 0
		self.current_balloon_index += 1
		num_balloons_popped += 1
		$BalloonPopAudio.play()
		pop_data_display_cn.refresh_drawing(pop_data)
		profit_data_display_cn.refresh_drawing(profit_data)
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
		profit_data[self.current_balloon_index] = self.total_profit
		profit_data_display_cn.refresh_drawing(profit_data)
		self.current_balloon_value = 0
		self.current_balloon_index += 1
		$BalloonSellAudio.play()
		print(self.total_profit)

func game_end():
	$EodBoarder.visible = true
	$EodBoarder/EodFill/SummaryStats.bbcode_text = "\n\tEnd of Day %d!\n\n\tBalloon Sales Statistics:\n\n\t\tTotal Profit: $ %.2f\n\n\t\tBalloons Remaining: %d\n\t\tBalloons Popped: %d\n\t\tBalloons Sold: %d" % [1, total_profit, GAME_ROUNDS - current_balloon_index, num_balloons_popped, self.current_balloon_index - num_balloons_popped]
	





func _on_play_again_button_pressed():
	# Get the current scene's filename
	var current_scene = "res://scenes/1_balloon_game.tscn"
	
	# Reload the current scene
	get_tree().change_scene_to_file(current_scene)
