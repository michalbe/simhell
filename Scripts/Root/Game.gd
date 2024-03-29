extends Spatial

export var size = 2

var cell_size = 0
var cell_height = 0
var mouse_pos = Vector2(0, 0)
var is_mouse_button_pressed = false
var starting_cell
var end_cell

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
	elif event is InputEventMouseButton and event.is_pressed() and not event.is_echo():
		is_mouse_button_pressed = event.button_index == BUTTON_LEFT
	else:
		is_mouse_button_pressed = false
			

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
			var x = int(round(hit.position.x/cell_size))
			var y = int(round(hit.position.z/cell_size))
			if is_mouse_button_pressed:
				# DRAWING
				if not starting_cell:
					#DRAWING HAS JUST STARTED
					starting_cell = Vector2(x, y)
				else:
					end_cell = Vector2(x, y)
					var scale_x = abs(starting_cell.x - x)
					var scale_y = abs(starting_cell.y - y)
					scale_x = 1 if scale_x == 0 else scale_x
					scale_y = 1 if scale_y == 0 else scale_y
					var middle_position = (Vector2(starting_cell.x  * cell_size + cell_size/2, starting_cell.y  * cell_size + cell_size/2) - Vector2(x  * cell_size + cell_size/2, y  * cell_size + cell_size/2)) / 2 + Vector2(x  * cell_size + cell_size/2, y  * cell_size + cell_size/2)
					if scale_x != 1 or scale_y != 1:
						$Selector.set_translation(Vector3(middle_position.x - cell_size/2, cell_height + (cell_height/2), middle_position.y - cell_size/2))
						$Selector.set_scale(Vector3(scale_x, 1, scale_y))
			else:
				# BUILDING LOGIC HERE
				if starting_cell and end_cell:
					spawn_building(starting_cell, end_cell)
				starting_cell = null
				end_cell = null
				$Selector.set_scale(Vector3(1, 1, 1))
				# Moving the selector
				$Selector.show()
				if (x > size/2 || x < -size/2 || y < -size/2 || y > size/2) :
					pass
				else:
					$Selector.set_translation(Vector3(x  * cell_size + cell_size/2, cell_height + (cell_height/2), y  * cell_size + cell_size/2))
		else:
			$Selector.hide()
	else:
		$Selector.hide()	

func spawn_building(start_point, end_point):
	var width = abs(start_point.x - end_point.x)
	var height = abs(start_point.y - end_point.y)
	
	var draw_from_x = min(start_point.x, end_point.x)
	var draw_from_y = min(start_point.y, end_point.y)
	
	for x in range (width):
		for y in range (height):
			if x == 0:
				if y == 0:
					$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 0, 0)
				elif y == height - 1:
					$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 0, 16)
				else:
					$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 1, 16)
			elif x == width-1:
				if y == 0:
					$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 0, 22)
				elif y == height - 1:
					$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 0, 10)
				else:
					$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 1, 22)
			elif y == 0:
				$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 1, 0)
			elif y == height-1:		
				$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 1, 10)
			else:
				$WallMap.set_cell_item(draw_from_x + x, 0, draw_from_y + y, 2, 0)
	