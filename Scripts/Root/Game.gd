extends Spatial

export var size = 2
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	var tiles = $GridMap.theme.get_item_list().size()
	for x in range (size):
		for y in range (size):
			$GridMap.set_cell_item(x - size/2, 0, y - size/2, 0) #randi() % tiles)
	pass

func _input(event):
	if event is InputEventMouseMotion:
#		$Selector.show()
		pass
#		$selector.translate
	pass
			
#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
