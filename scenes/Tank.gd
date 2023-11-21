extends CharacterBody2D

var explosion_scene = preload("res://scenes/explosion.tscn")

const SPEED = 60.0
const ROT_SPEED = 3
const RAD_45 = PI / 4.0	#0.78539816
var MAX_VELOCITY = 150  # Adjust the maximum velocity as needed
var ACCELERATION = 60   # Adjust the acceleration as needed
var DECELERATION = 120   # Adjust the deceleration as needed

var tank_track_velocity = 0.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var block_process = false


func _physics_process(_delta):
	pass

func _ready():
	pass

func _process(delta):
	if block_process:
		return
	# Tank control logic
	#var input_left_up = Input.is_action_pressed("left_up")
	#var input_left_down = Input.is_action_pressed("left_down")
	#var input_right_up = Input.is_action_pressed("right_up")
	#var input_right_down = Input.is_action_pressed("right_down")
	var input_move_tank = Input.is_action_pressed("move_tank")
	
	var tank_center_os = global_position
	var mouse_pos = get_viewport().get_mouse_position()
	var look_pos = mouse_pos - tank_center_os
	var look_vector = Vector2(cos(rotation), sin(rotation))
	var angle= look_pos.angle_to(look_vector)
	var move_speed_x = Vector2(cos(angle), 0)[0]
		
	if(input_move_tank):
		tank_track_velocity += ACCELERATION * move_speed_x * delta
			
		var rot = 0.0
		if move_speed_x > 0:
			rot = -sin(angle)
		else:
			rot = -sin(angle) / 5
		rotation = rotation + rot * delta * ROT_SPEED
	else:
		if tank_track_velocity > 0:
			tank_track_velocity -= DECELERATION * delta
		else:
			tank_track_velocity += DECELERATION * delta
	
	tank_track_velocity = clamp(tank_track_velocity, -MAX_VELOCITY, MAX_VELOCITY)
	velocity = look_vector * tank_track_velocity * delta * SPEED
	
	# Show speed
	var tank_speed = get_node(NodePath("../TankSpeed"))
	var speed = tank_track_velocity
	if speed > -1 and speed < 1:
		speed= 0
	var speed_format_text = "Speed: %+04.0f"
	var speed_text = speed_format_text % speed
	tank_speed.set_text(speed_text)	
	move_and_slide()


func _on_fire_pressed():
	print("tank._on_fire_pressed")
	var new_explosion = explosion_scene.instantiate()
	#new_explosion.rotation = rotation
	var tankPos = position
	var tankDir = Vector2.from_angle(rotation)
	var dist = 400
	new_explosion.position = tankPos + tankDir * dist
	$"..".add_child(new_explosion)


func _on_fire_button_down():
	block_process = true

func _on_fire_button_up():
	block_process = false
