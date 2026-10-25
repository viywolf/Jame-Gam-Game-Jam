extends AudioStreamPlayer


func toggle_music() -> void:
	if self.playing == true:
		self.playing = false
	else:
		self.playing = true

func play_drum_roll() -> void:
	$Drumroll.stop()
	if self.playing:
		$Drumroll.play()
