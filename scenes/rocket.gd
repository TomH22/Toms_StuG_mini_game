extends Area2D

var explosion_scene = preload("res://scenes/explosion.tscn")

@onready var started : int
@onready var tank_pos : Vector2
@onready var balistic_easy_simulation : float
@onready var bes_v : Vector2
@onready var start_pos : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	start_pos = position
	init()

func init():
	position = start_pos
	started = 0
	tank_pos = Vector2(0, 0)
	balistic_easy_simulation = 0.0
	bes_v = Vector2(-3,-1)	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if started == 1:
		visible = true
		var a = (tank_pos - global_position).normalized()
		a = (a + bes_v).normalized()
		bes_v = bes_v * (1.0 - min(10.0 * delta, 1.0))
		
		var dist = tank_pos.distance_to(global_position)
		print(dist)	
		var speed = 6000

		if dist < 50:
			speed = 250
		elif dist < 100:
			speed = 750
		elif dist < 250:
			speed = 1500
		elif dist < 500:
			speed = 3000
		
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
			$"../../HUD"._on_show_lost_game()
			$"../../Tank/AudioExplosion".play()
	pass
