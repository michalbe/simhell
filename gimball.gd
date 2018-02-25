extends Spatial

# class member variables go here, for example:

var camera_speed = 2
var zoom_speed = 0.8

func _process(delta):
	if (Input.is_action_pressed("ui_left")):
		rotate_y(camera_speed * delta)
	if (Input.is_action_pressed("ui_right")):
		rotate_y(-camera_speed * delta)
	if (Input.is_action_pressed("ui_up")):
		print("HELLO!")
		$inner_gimball.rotate_x(-camera_speed * delta)
	if (Input.is_action_pressed("ui_down")):
		$inner_gimball.rotate_x(camera_speed * delta)
	
#	print("outer")
#	print(get_rotation())
#	print("inner")
#	print($inner_gimball.get_rotation())
	
func _ready():
	rotate_y(0.75)
	$inner_gimball.rotate_x(-0.45)
	set_process(true)
	