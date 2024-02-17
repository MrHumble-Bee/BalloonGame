extends Control

var data = []
var font: Font
var chart_color: Color
var hist_bar_color: Color
var border_color: Color = Color(0,0,0)

func _ready():
	#font = preload("res://fonts/valorax-font/Valorax-lg25V.otf")
	font = preload(("res://fonts/Poppins-Black.ttf"))
	for i in range(get_parent().GAME_ROUNDS):
		data.append(0)
	chart_color = hex_to_color(0x000000)
	hist_bar_color = hex_to_color(0x4fa17a)

func _draw():
	print("Drew")
	# Clear the canvas by drawing a transparent rectangle
	var right_off_set = -20
	draw_rect(Rect2(0 + right_off_set, 0, size.x, size.y), Color(0, 0, 0, 0))
	 # Draw x-axis
	var x_axis_bgn = Vector2(0 + right_off_set, size.y)
	var x_axis_end = Vector2(size.x + right_off_set, size.y)
	draw_line(x_axis_bgn, x_axis_end, chart_color)

	# Draw y-axis
	var y_axis_bgn = Vector2(0 + right_off_set, size.y)
	var y_axis_end = Vector2(0 + right_off_set, 0)
	draw_line(y_axis_bgn, y_axis_end, chart_color)
	
	# Draw x-axis label
	var x_axis_label_offset = 20
	var x_label_position = Vector2(((x_axis_bgn.x + x_axis_end.x) / 3), size.y + x_axis_label_offset + 20)
	var x_label_color = Color(1,1,1)
	draw_string(font, x_label_position, "Balloon Index", HORIZONTAL_ALIGNMENT_CENTER, -1, 16, chart_color)
	# Draw y-axis label
	var y_label_position = Vector2(20 + right_off_set, (y_axis_bgn.y + y_axis_end.y) / 2)
	#draw_text(y_label_position, "Frequency", Color(1, 1, 1), align=Vector2.CENTER)
	
	# Draw histogram bars
	var bar_width = size.x / data.size()
	for i in range(data.size()):
		var bar_height = data[i] * (size.y / data.max()) # Scale data to fit within control height
		#draw_rect(Rect2((i * bar_width) + right_off_set, size.y - bar_height, bar_width, bar_height), hist_bar_color)
		draw_rect(Rect2((i * bar_width) + right_off_set, size.y - bar_height, bar_width, bar_height), border_color)
		draw_rect(Rect2((i * bar_width) + right_off_set + 1, size.y - bar_height + 1, bar_width - 2, bar_height - 2), hist_bar_color)
		
		if (i+1) % 5 == 0:
			draw_string(font, Vector2((i * bar_width) + right_off_set, size.y + x_axis_label_offset), "%d" % [i+1], HORIZONTAL_ALIGNMENT_CENTER, -1, 16, chart_color)
	var title_loc = Vector2(20,-10)
	draw_string(font, title_loc, "Cumulative Profits by Balloon", HORIZONTAL_ALIGNMENT_CENTER, -1, 18, chart_color)
func refresh_drawing(profit_data):
	data = profit_data
	queue_redraw()

func hex_to_color(hex):
	var red = (hex >> 24) & 0xFF
	var green = (hex >> 16) & 0xFF
	var blue = (hex >> 8) & 0xFF
	var alpha = 255.0
	return Color(red / 255.0, green / 255.0, blue / 255.0, alpha / 255.0)
