extends Node

var config_file = ConfigFile.new()

export var config_name = "cfg"
export var config_extension = "txt"

onready var file_path = OS.get_user_data_dir() + "/" + config_name + "." + config_extension

#ENG - you can add everething in this dictionary;RUS - в этот словарь можно добавить все, что угодно
export var standart_config = {
	"video_graphics":
		{
		"vsync":true,
		"ssao":false,
		"msaa":1,
		"fxaa":true
		},
	"audio_settings":
		{"master_volume":0}
}

func config_load(path: String = file_path):
	config_file = ConfigFile.new()
	var data = standart_config
	
	config_file.load(path)
	
	for section in config_file.get_sections():
		for parameter in config_file.get_section_keys(section):
			data[section][parameter] = config_file.get_value(section,parameter)
	
	return data

func config_save(settings: Dictionary = standart_config, path: String = file_path):
	config_file = ConfigFile.new()
	
	for section in settings.keys():
		for parameter in settings.get(section):
			config_file.set_value(section,parameter,settings.get(section).get(parameter))
	
	config_file.save(path)
	#OS.shell_open(path)
