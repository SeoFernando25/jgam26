extends Button

func _ready():
	self.pressed.connect(self.on_pressed)
	
func on_pressed():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
	

