extends Node2D

var infantry_enemy = load("res://scenes/infantry_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	var new_infantry_enemy =  infantry_enemy.instantiate()
	new_infantry_enemy.position = Vector2(50, 500)
	add_child(new_infantry_enemy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
