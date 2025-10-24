extends Control

@export var animation_index: int


func _ready() -> void:
	# player monster setup
	Global.current_monster = Global.monsters.pop_at(0)
	$Monsters/Player.texture = load(Global.monster_data[Global.current_monster]['back texture'])
	
	# enemy monster setup
	Global.current_enemy = Global.Monster.values().pick_random()
	var new_atlas: AtlasTexture = AtlasTexture.new()
	new_atlas.atlas = load(Global.monster_data[Global.current_enemy]['front texture'])
	$Monsters/Enemy.texture = new_atlas
	new_atlas.region = Rect2i(Vector2i.ZERO, Vector2i(96,96))
	
	$AttackSprite.hide()

func _process(delta: float) -> void:
	var atlas = $Monsters/Enemy.texture as AtlasTexture
	atlas.region = Rect2i(Vector2i(96 * animation_index,0), Vector2i(96,96))

func _on_input_menu_selected(state: int, type: Variant) -> void:
	match state:
		Global.State.ATTACK:
			var target = $Monsters/Enemy if Global.attack_data[type]['target'] else $Monsters/Player
			attack(target, type)
		Global.State.SWAP:
			Global.monsters.append(Global.current_monster)
			$Monsters/Player.texture = load(Global.monster_data[type]['back texture'])
			Global.current_monster = type
			Global.monsters.erase(type)
	
	
func attack(target: TextureRect, attack_type: Global.Attack):
	$AttackSprite.show()
	$AttackSprite.frame = 0
	$AttackSprite.texture = load(Global.attack_data[attack_type]['animation'])
	var pos = target.get_rect().position + target.get_rect().size / 2
	$AttackSprite.position = pos
	
	var tween = create_tween()
	tween.tween_property($AttackSprite, 'frame', 3, 0.6).from(0)
	tween.tween_property($AttackSprite, 'visible', false, 0)
	
