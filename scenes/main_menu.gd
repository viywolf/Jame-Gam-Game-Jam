extends Node2D

var cur_count: float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	cur_count += delta / 4
	var rotation_offset: float = pingpong(cur_count, PI/8)
	$Logo.rotation = rotation_offset - PI/16
	var position_offset: float = pingpong(cur_count * 100, 20)
	$Logo.position.y = position_offset + 200


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/cutscene.tscn")


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_mute_button_pressed() -> void:
	AudioStreamPlayerGlobal.toggle_music()
