extends Control


func _ready() -> void:
	for i in range(Pets.pet_sprites.size()):
		var new_panel: Panel = Panel.new()
		new_panel.custom_minimum_size = Vector2(150, 150)
		var new_texture_rect: TextureRect = TextureRect.new()
		new_texture_rect.size = Vector2(100, 100)
		new_texture_rect.position = Vector2(25, 25)
		new_texture_rect.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		new_texture_rect.texture = load(Pets.pet_sprites[i])
		new_panel.add_child(new_texture_rect)
		%GridContainer.add_child(new_panel)
		
	for i in range(Pets.pet_sprites.size()):
		if Pets.pet_unlock_status[i] == true:
			show_pet(i)
		else:
			hide_pet(i)


func hide_pet(pet_no: int) -> void:
	var cur_texture_rect: TextureRect = %GridContainer.get_child(pet_no).get_child(0)
	cur_texture_rect.modulate = Color(0.0, 0.0, 0.0, 1.0)

func show_pet(pet_no: int) -> void:
	var cur_texture_rect: TextureRect = %GridContainer.get_child(pet_no).get_child(0)
	cur_texture_rect.modulate = Color(1.0, 1.0, 1.0, 1.0)


func _on_close_button_pressed() -> void:
	queue_free()
