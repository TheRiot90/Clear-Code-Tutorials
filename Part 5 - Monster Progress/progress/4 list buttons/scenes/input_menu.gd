extends Control

var grid_button_scene = preload("res://scenes/grid_button.tscn")
var list_button_scene = preload("res://scenes/list_button.tscn")
const main_buttons = {
	Global.State.ATTACK: 'Attack',
	Global.State.DEFEND: 'Defend',
	Global.State.SWAP: 'Swap',
	Global.State.ITEM: 'Item',
}


func _ready() -> void:
	#create_grid_buttons(Global.State.MAIN, main_buttons)
	#var monster_attacks = Global.monster_data[Global.current_monster]['attacks']
	#create_grid_buttons(Global.State.ATTACK, {
		#monster_attacks[0]: Global.attack_data[monster_attacks[0]]['name'],
		#monster_attacks[1]: Global.attack_data[monster_attacks[1]]['name'],
		#monster_attacks[2]: Global.attack_data[monster_attacks[2]]['name'],
		#monster_attacks[3]: Global.attack_data[monster_attacks[3]]['name'],
	#})
	create_list_buttons(Global.State.SWAP, Global.monsters)
	#create_list_buttons(Global.State.ITEM, Global.items)

func create_grid_buttons(state: Global.State, data: Dictionary):
	for i in $GridContainer.get_children():
		i.queue_free()
	for key in data:
		var grid_button = grid_button_scene.instantiate()
		grid_button.setup(state, key, data[key])
		$GridContainer.add_child(grid_button)
		grid_button.connect('press', button_handler)


func create_list_buttons(state: Global.State, data: Array):
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()
	for i in data:
		var list_button = list_button_scene.instantiate()
		$ScrollContainer/VBoxContainer.add_child(list_button)
		list_button.setup(state, i)
		list_button.connect('press', button_handler)

func button_handler(state, type):
	print(state)
	print(type)
