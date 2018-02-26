extends Spatial

export var size = 2

var mouse_pos_x = 0
var mouse_pos_y = 0
var mouse_pos = Vector2(0, 0)

func _ready():
	var tiles = $GridMap.theme.get_item_list().size()
	for x in range (size):
		for y in range (size):
			$GridMap.set_cell_item(x - size/2, 0, y - size/2, 0) #randi() % tiles)
	pass

#func _input(event):
#	if event is InputEventMouseMotion:
##		$Selector.show()
#		pass
##		$selector.translate
#	pass
#
func _input(event):
	if event is InputEventMouseMotion:
		mouse_pos = event.position

func _physics_process(delta):
	var camera = $CameraGimball/inner_gimball/Camera
	var ray_origin = camera.project_ray_origin(mouse_pos)
	var ray_direction = camera.project_ray_normal(mouse_pos)
	
	var from = ray_origin
	var to = ray_origin + ray_direction * 1000
	
	var space_state = get_world().get_direct_space_state()
	var hit = space_state.intersect_ray(from, to)
	print(hit)
	if hit.size() != 0:
		print(hit)
