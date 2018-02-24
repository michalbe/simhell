extends Control

func _ready():
	connect("toggled", self, "on_toggled")
	set_toggle_mode(true)


func on_toggled(pressed):
	if (pressed) :
		set_text("Build mode on")
	else:
		set_text("Build mode off")