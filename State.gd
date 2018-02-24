extends Node

var STATES = {
	"NORMAL": -1,
	"BUILDING": 1
}

var state = STATES.NORMAL

func _ready():
	$changeState.connect("toggled", self, "change_state")


func change_state(pressed):
	state *= -1
	print(state)

func get_state():
	return state