extends Area2D

var explosion_scene = preload("res://scenes/explosion.tscn")

@onready var started = 0
@onready var tank_pos = Vector2(0, 0)
@onready var balistic_easy_simulation = 0.0
@onready var bes_v = Vector2(-3,-1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started == 1:
		var a = (tank_pos - global_position).normalized()
		a = (a + bes_v).normalized()
		bes_v = bes_v * (1.0 - min(10.0 * delta, 1.0))
		
		var dist = tank_pos.distance_to(global_position)
		print(dist)	
		var speed = 12000

		if dist < 50:
			speed = 500
		elif dist < 100:
			speed = 1500
		elif dist < 250:
			speed = 3000
		elif dist < 500:
			speed = 6000
		
		global_position = global_position + a * delta * speed
		global_rotation = a.angle() + PI

		if dist < 90:
			visible = false
			started = 2
			# Explosion
			print("explo")
			var new_explosion = explosion_scene.instantiate()
			new_explosion.position = position
			new_explosion.scale = Vector2(5.0, 5.0)
			$"..".add_child(new_explosion)
	pass