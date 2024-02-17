extends Control

var summary_stats_display_cn
var total_profit
var num_balloons_popped
var num_balloons_sold

# Called when the node enters the scene tree for the first time.
func _ready():
	summary_stats_display_cn = $ColorRect/SummaryStats # Replace with function body.
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	summary_stats_display_cn.bbcode_text = "End of Day %d!\n\nBalloon Sales Statistics:\n\nTotal Profit: %f\nBalloons Popped: %d\nBalloons Sold: %d" % [1, total_profit, num_balloons_popped, num_balloons_sold]


