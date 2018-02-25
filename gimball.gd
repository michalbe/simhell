extends Spatial

# class member variables go here, for example:

var camera_speed = 2
var zoom_speed = 0.2
var default_camera_x = -0.45
var default_camera_y = 0.75


func _process(delta):
	if (Input.is_action_pressed("ui_left")):
		rotate_y(camera_speed * delta)
	if (Input.is_action_pressed("ui_right")):
		rotate_y(-camera_speed * delta)
	if (Input.is_action_pressed("ui_up")):
		$inner_gimball.rotate_x(-camera_speed * delta)
	if (Input.is_action_pressed("ui_down")):
		$inner_gimball.rotate_x(camera_speed * delta)
#	if Input.is_mouse_button_pressed(BUTTON_WHEEL_UP):
#	if Input.is_action_just_pressed("ui_zoom_in"):
#		print("HEYKA!")
#		set_scale(get_scale() + Vector3(zoom_speed, zoom_speed, zoom_speed) * delta)
##	if Input.is_action_just_pressed(BUTTON_RIGHT):
#	if Input.is_action_just_pressed("ui_zoom_out"):
#		set_scale(get_scale() - Vector3(zoom_speed, zoom_speed, zoom_speed) * delta)
#	print("outer")
#	print(get_rotation())
#	print("inner")
#	print($inner_gimball.get_rotation())
	
func _input(event):
	if event.is_pressed() and not event.is_echo():
		if event.button_index == BUTTON_WHEEL_UP and get_scale().x < 3:
			set_scale(get_scale() + Vector3(zoom_speed, zoom_speed, zoom_speed))
		if event.button_index == BUTTON_WHEEL_DOWN and get_scale().x > 0.5:
			set_scale(get_scale() - Vector3(zoom_speed, zoom_speed, zoom_speed))
			
func _ready():
	rotate_y(default_camera_y)
	$inner_gimball.rotate_x(default_camera_x)
	
	set_process_input(true)
	set_process(true)
	