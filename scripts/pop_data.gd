extends Control

var data = []
var font: Font

func _ready():
	font = preload("res://fonts/valorax-font/Valorax-lg25V.otf")
	for i in range(50):
		data.append(0)

func _draw():
	print("Drew")
	# Clear the canvas by drawing a transparent rectangle
	draw_rect(Rect2(0, 0, size.x, size.y), Color(0, 0, 0, 0))
	 # Draw x-axis
	var x_axis_bgn = Vector2(0, size.y)
	var x_axis_end = Vector2(size.x, size.y)
	draw_line(x_axis_bgn, x_axis_end, Color(1, 1, 1))

	# Draw y-axis
	var y_axis_bgn = Vector2(0, size.y)
	var y_axis_end = Vector2(0, 0)
	draw_line(y_axis_bgn, y_axis_end, Color(1, 1, 1))
	
	# Draw x-axis label
	var x_label_position = Vector2((x_axis_bgn.x + x_axis_end.x) / 2, size.y - 30)
	var x_label_color = Color(1,1,1)
	draw_string(font, x_label_position, "Popped at x Pumps", HORIZONTAL_ALIGNMENT_CENTER)
	# Draw y-axis label
	var y_label_position = Vector2(20, (y_axis_bgn.y + y_axis_end.y) / 2)
	#draw_text(y_label_position, "Frequency", Color(1, 1, 1), align=Vector2.CENTER)
	
	# Draw histogram bars
	var bar_width = size.x / data.size()
	for i in range(data.size()):
		var bar_height = data[i] * (size.y / 5.0) # Scale data to fit within control height
		draw_rect(Rect2(i * bar_width, size.y - bar_height, bar_width, bar_height), Color(1, 0, 0))

func refresh_drawing(pop_data):
	data = pop_data
	queue_redraw()
