extends CanvasLayer

#var ias = load("res://scenes/enemy.tscn")
#var iasi = load("res://scenes/infantry_enemy.tscn")

signal start_game

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_start_button_pressed():
	start_game.emit()
	pass # Replace with function body.

func show_restart_menu():
	get_tree().call_group("InfantryEnemies", "set_peacful")
	$"../T-64BV_".peacful = true
	visible = true
	$Message.visible = true
	$StartButton.text = "Restart"
	

func _on_show_won_game():
	show_restart_menu()
	$Message.text = "Won"
	$"../T-64BV_".visible = false

func _on_show_lost_game():
	show_restart_menu()
	$Message.text = "Lost"
	$"../Tank".visible = false
	$"../Tank".destroys = true	
