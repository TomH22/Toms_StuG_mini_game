extends RigidBody2D

@onready var entered : int
@onready var peacful : bool

# Called when the node enters the scene tree for the first time.
func _ready():
	init()
	
func set_peacful():
	peacful = true	

func init():
	entered = 0
	peacful = false
	$Node2D_Exclamation.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_rocket_timer_timeout():
	if $"../T-64BV_/Rocket".started == 0 and not peacful:
		print("time out")
		$"../T-64BV_/Rocket".started = 1
		$Node2D_Exclamation.visible = true
		$"../T-64BV_/Rocket".tank_pos = $"../Tank".global_position

func _on_area_2d_body_entered(body):
	if body.name == "Tank":
		print(name, " sees ", body.name)
		$Sprite2D.modulate = Color(1, 0.5, 0.5)
		$RocketTimer.start()


func _on_area_2d_body_exited(body):
	if body.name == "Tank":
		print(name, " lost sight of ", body.name)
		$Sprite2D.modulate = Color(1, 1, 1)
		$RocketTimer.stop()
