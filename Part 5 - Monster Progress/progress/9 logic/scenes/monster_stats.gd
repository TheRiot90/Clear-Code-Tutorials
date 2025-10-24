extends Control

var is_player: bool
signal defeat(is_player: bool)

func setup(monster: Global.Monster, player = true):
	var monster_data = Global.monster_data[monster]
	$VBoxContainer/Label.text = monster_data['name']
	$VBoxContainer/ProgressBar.max_value = monster_data['max health']
	$VBoxContainer/ProgressBar.value = $VBoxContainer/ProgressBar.max_value
	is_player = player

func update(data: Dictionary):
	$VBoxContainer/ProgressBar.value -= data['amount']


func _on_progress_bar_value_changed(value: float) -> void:
	if value <= 0:
		defeat.emit(is_player)
