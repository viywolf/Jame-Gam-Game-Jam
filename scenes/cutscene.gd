extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimationPlayer.play("reveal")
	await $AnimationPlayer.animation_finished
	$Control.show()
	if Pets.pet_unlock_status[0] == true:
		$Control/NewLabel.show()
	var tween = get_tree().create_tween()
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 25, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y + 50, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 25, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y + 50, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 25, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y + 50, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 25, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y + 50, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 25, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y + 50, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 25, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y + 50, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 25, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y + 50, 2)
	tween.tween_property($Sprite2D, "position:y",$Sprite2D.position.y - 10, 2)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/main_game.tscn")
