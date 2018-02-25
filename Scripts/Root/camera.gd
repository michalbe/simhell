extends Spatial

# class member variables go here, for example:

var is_dragged = false
var config = null

var camera_speed
var zoom_speed
var topmost_gimball_position
var downmost_gimball_position
var max_zoom
var min_zoom

func _ready():
	config = ConfigFile.new()
	var config_loaded = config.load("res://Config/camera.ini")
	if config_loaded == OK:
		rotate_y(config.get_value("defaults", "y"))
		$inner_gimball.rotate_x(config.get_value("defaults", "x"))
		
		camera_speed = config.get_value("speeds", "movement")
		zoom_speed = config.get_value("speeds", "zoom")
		downmost_gimball_position = config.get_value("limits", "downmost_gimball_position")
		topmost_gimball_position = config.get_value("limits", "topmost_gimball_position")
		max_zoom = config.get_value("limits", "max_zoom")
		min_zoom = config.get_value("limits", "min_zoom")

		set_process_input(true)
		set_process(true)
	
func _process(delta):
	if (Input.is_action_pressed("ui_left")):
		rotate_y(camera_speed * delta)
	if (Input.is_action_pressed("ui_right")):
		rotate_y(-camera_speed * delta)

	if (Input.is_action_pressed("ui_up") and $inner_gimball.rotation.x > topmost_gimball_position):
		$inner_gimball.rotate_x(-camera_speed * delta)
	if (Input.is_action_pressed("ui_down") and $inner_gimball.rotation.x < downmost_gimball_position):
		$inner_gimball.rotate_x(camera_speed * delta)
		

func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed() and not event.is_echo():
	#		Zoom OUT
			if event.button_index and event.button_index == BUTTON_WHEEL_DOWN and get_scale().x < max_zoom:
				set_scale(get_scale() + Vector3(zoom_speed, zoom_speed, zoom_speed))

	#		Zoom IN
			if event.button_index == BUTTON_WHEEL_UP and get_scale().x > min_zoom:
				set_scale(get_scale() - Vector3(zoom_speed, zoom_speed, zoom_speed))

		if event.button_index == BUTTON_RIGHT:
			is_dragged = event.is_pressed()
	
#	elif event is InputEventMouseMotion:
#	TODO: IMPLEMENT DRAGGING HERE
#		print("Mouse Motion at: ", event.position, is_dragged)
#		move_local_x(event.relative_x)
#		move_local_y(event.relative_y)

