extends Spatial

export var size = 2

var cell_size = 0
var cell_height = 0
var mouse_pos = Vector2(0, 0)

func _ready():
	cell_size = $GridMap.cell_size.x
	cell_height = $GridMap.cell_size.y
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
	if $StatePanel.get_state() == $StatePanel.STATES.BUILDING:
		var camera = $CameraGimball/inner_gimball/Camera
		var ray_origin = camera.project_ray_origin(mouse_pos)
		var ray_direction = camera.project_ray_normal(mouse_pos)
		
		var from = ray_origin
		var to = ray_origin + ray_direction * 1000
		
		var space_state = get_world().get_direct_space_state()
		var hit = space_state.intersect_ray(from, to)
		if hit.size() != 0:
			$Selector.show()
			print(hit.position.x)
			print(int(hit.position.x/cell_size) * cell_size + cell_size/2)
			$Selector.set_translation(Vector3(int(round(hit.position.x/cell_size)) * cell_size + cell_size/2, cell_height + (cell_height/2), int(round(hit.position.z/cell_size)) * cell_size + cell_size/2))
		else:
			$Selector.hide()
	else:
		$Selector.hide()	
