extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var tapped = false

func _ready():
	set_process_input(true)


func _draw():
    var r = Rect2( Vector2(), get_size() )
    if (tapped):
        draw_rect(r, Color(1,0,0) )
    else:
        draw_rect(r, Color(0,0,1) )

func _input(event):
	if event is InputEventMouseButton:
	    tapped = event.is_pressed()
	    update()