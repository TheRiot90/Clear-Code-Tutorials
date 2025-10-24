extends Control

var is_player: bool
signal defeat(is_player: bool)
@onready var label = $PanelContainer/MarginContainer/VBoxContainer/Label
@onready var progress = $PanelContainer/MarginContainer/VBoxContainer/ProgressBar


func setup(monster: Global.Monster, player = true):
	var monster_data = Global.monster_data[monster]
	label.text = monster_data['name']
	progress.max_value = monster_data['max health']
	progress.value = progress.max_value
	is_player = player


func update(data: Dictionary):
	progress.value -= data['amount']


func _on_progress_bar_value_changed(value: float) -> void:
	if value <= 0:
		defeat.emit(is_player)
