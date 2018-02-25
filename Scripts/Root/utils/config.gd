extends Object

var config

func load(url):
	config = ConfigFile.new()
	var config_loaded = config.load("res://Config/" + url)
	return config_loaded

func load_value(variable, namespace, key):
	return variable if variable else config.get_value(namespace, key)
