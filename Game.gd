extends Spatial

var size = 10
# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	
	for x in range (size):
		for y in range (size):
			print(x)
			print(y)
			$GridMap.set_cell_item(x - size/2, 0, y - size/2, 0)
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
