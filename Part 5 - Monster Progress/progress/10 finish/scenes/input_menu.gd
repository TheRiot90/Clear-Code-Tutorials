extends Control

var grid_button_scene = preload("res://scenes/grid_button.tscn")
var list_button_scene = preload("res://scenes/list_button.tscn")
const main_buttons = {
	Global.State.ATTACK: 'Attack',
	Global.State.DEFEND: 'Defend',
	Global.State.SWAP: 'Swap',
	Global.State.ITEM: 'Item',
}
var current_state: Global.State: set = state_handler
signal selected(state: Global.State, type)


func _ready() -> void:
	current_state = Global.State.MAIN


func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		current_state = Global.State.MAIN


func create_grid_buttons(state: Global.State, data: Dictionary):
	for i in $GridContainer.get_children():
		i.queue_free()
	for key in data:
		var grid_button = grid_button_scene.instantiate()
		grid_button.setup(state, key, data[key])
		$GridContainer.add_child(grid_button)
		grid_button.connect('press', button_handler)
	await get_tree().process_frame
	$GridContainer.get_child(0).grab_focus()


func create_list_buttons(state: Global.State, data: Array):
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()
	for i in data:
		var list_button = list_button_scene.instantiate()
		$ScrollContainer/VBoxContainer.add_child(list_button)
		list_button.setup(state, i)
		list_button.connect('press', button_handler)
	await get_tree().process_frame
	$ScrollContainer/VBoxContainer.get_child(0).grab_focus()


func button_handler(state, type):
	if state == Global.State.MAIN:
		current_state = type
		if type == Global.State.DEFEND:
			selected.emit(Global.State.DEFEND, type)
	else:
		selected.emit(state, type)


func state_handler(value):
	current_state = value
	match value:
		Global.State.ATTACK:
			var monster_attacks = Global.monster_data[Global.current_monster]['attacks']
			create_grid_buttons(Global.State.ATTACK, {
				monster_attacks[0]: Global.attack_data[monster_attacks[0]]['name'],
				monster_attacks[1]: Global.attack_data[monster_attacks[1]]['name'],
				monster_attacks[2]: Global.attack_data[monster_attacks[2]]['name'],
				monster_attacks[3]: Global.attack_data[monster_attacks[3]]['name'],
				})
			$GridContainer.show()
			$ScrollContainer.hide()
		Global.State.MAIN:
			create_grid_buttons(Global.State.MAIN, main_buttons)
			$GridContainer.show()
			$ScrollContainer.hide()
		Global.State.SWAP:
			create_list_buttons(Global.State.SWAP, Global.monsters)
			$GridContainer.hide()
			$ScrollContainer.show()
		Global.State.ITEM:
			create_list_buttons(Global.State.ITEM, Global.items)
			$GridContainer.hide()
			$ScrollContainer.show()


func _on_visibility_changed() -> void:
	current_state = Global.State.MAIN
