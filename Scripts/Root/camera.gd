extends Spatial

# class member variables go here, for example:

var is_dragged = false
onready var config = load("res://Scripts/Root/utils/config.gd").new()

export var default_camera_x = 0
export var default_camera_y = 0
export var camera_speed = 0
export var zoom_speed = 0
export var topmost_gimball_position = 0
export var downmost_gimball_position = 0
export var max_zoom = 0
export var min_zoom = 0

func _ready():
	print(config)
	var config_loaded = config.load("camera.ini")
	if config_loaded == OK:
		default_camera_y = config.load_value(default_camera_y, "defaults", "y")
		default_camera_x = config.load_value(default_camera_x, "defaults", "x")
		camera_speed = config.load_value(camera_speed, "speeds", "movement")
		zoom_speed = config.load_value(zoom_speed, "speeds", "zoom")
		downmost_gimball_position = config.load_value(downmost_gimball_position, "limits", "downmost_gimball_position")
		topmost_gimball_position = config.load_value(topmost_gimball_position, "limits", "topmost_gimball_position")
		max_zoom = config.load_value(max_zoom, "limits", "max_zoom")
		min_zoom = config.load_value(min_zoom, "limits", "min_zoom")
		
		rotate_y(default_camera_y)
		$inner_gimball.rotate_x(default_camera_x)

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

