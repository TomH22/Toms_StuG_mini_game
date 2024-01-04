extends Area2D

var my_hud: Node
var t_64bv: Node

#import "res://scenes/"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass



func _on_body_entered(body: RigidBody2D):
	if body == t_64bv:
		my_hud._on_show_won_game()
	else:
		body.queue_free()


func _on_won_game():
	pass # Replace with function body.
