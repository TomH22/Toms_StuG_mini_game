extends Node2D

var infantry_enemy = load("res://scenes/infantry_enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func start_game():
	$HUD.visible = false	
	$"T-64BV_".visible = true
	$"T-64BV_".init()
	$"T-64BV_/Rocket".init()
	$Tank.init()

	get_tree().call_group("InfantryEnemies", "queue_free")
	
	var viewport_width = get_viewport_rect().size.x + 10
	var first_row_less = 200
	var viewport_height = get_viewport_rect().size.y - (get_viewport_rect().size.y / 3)
	var hori_count = 10
	var vert_count = 10
	var hori_dist = viewport_width / hori_count
	var vert_dist = viewport_height / vert_count
	
	var first_run = true
	var act_vert = 90
	while act_vert < viewport_height:
		var act_hori = 20
		while act_hori < (viewport_width - first_row_less):
			var randi = randi() % 20
			if randi > 16:
				var new_infantry_enemy =  infantry_enemy.instantiate()
				new_infantry_enemy.position = Vector2(act_hori, act_vert)
				add_child(new_infantry_enemy)
			act_hori += 50
		act_vert += 100
		first_row_less = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_hud_start_game():
	start_game()
