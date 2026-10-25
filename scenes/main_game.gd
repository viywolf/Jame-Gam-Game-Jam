extends Node2D

var cur_question_no: int = 0

var questions: Array[String] = [
	"Feed the creature a good meal!",
	"Play with the creature!",
	"Send the creature down a good path!",
]


enum AdjList{
	NAME, GROWTH_PATH, OPTIONS, SPRITE_PATH
}

# All pet names
enum{
	ROCK,
	SAUSAGE,
	FISH,
	EGGS,
	VEGETABLES,
	STICKS,
	BOWLING,
	BOOMERANG,
	PAPER_AIRPLANE,
	RACING,
	TOYS,
	FLASHLIGHT,
	MERRY_GO_ROUND,
	DOMINOES,
	OUTSIDE,
	DOG,
	JUMPING_JACKS,
	RUNNING,
	SWIMMING,
	SOFT_TOYS,
	CHESS,
	WALKING,
	SCHOOL,
	ROLLING,
	LIL_GUY,
	GROUND,
	IN_THE_AIR,
	FLYING,
	DOWNTOWN,
	FISHING,
	FENCING,
	ANTARTICA,
	DEAD,
	DEEP_UNDERWATER,
	SPINNING,
	DIVING,
	HOME,
	CAT_HOME,
	HOUSE,
}

var growth_adj_list: Array[Array] = [
	["Start", [SAUSAGE, EGGS, FISH, VEGETABLES], ["Sausage", "Eggs", "One Whole Stingray", "Brocolili"]],
	["Sausage", [PAPER_AIRPLANE, BOOMERANG, BOWLING, STICKS], ["Paper Airplane", "A Boomerang", "Let's Go Bowling", "Random Sticks From The Ground"]], 
	["Fish", [RACING, TOYS, FLASHLIGHT, MERRY_GO_ROUND], ["Race With The Other Creatures", "Random Toys", "A Flashlight", "Carnival Merry-Go-Round"]], 
	["Eggs", [RUNNING, CHESS, SOFT_TOYS, SWIMMING], ["Run Around The Block", "Chess", "Soft Toys", "Swim In The Lake"]], 
	["Vegetables", [DOMINOES, OUTSIDE, DOG, JUMPING_JACKS], ["Dominoes Pizza", "Touch Grass", "Dog.", "Force Them To Do Jumping Jacks"]], 
	["Sticks", [SCHOOL, WALKING, ROLLING, DOWNTOWN], ["Go To School", "Go Partying!!", "Go Rolling Around On The Ground", "Throw It Downtown!"]],
	["Bowling", [DOWNTOWN, ROLLING, LIL_GUY, SCHOOL], ["YEEHAW DOWNTOWN", "They See Me Rolling", "Your 'friend'", "School"]], 
	["Boomerang", [LIL_GUY, DEAD, DOWNTOWN, ROLLING], ["Your 'friend'", "Yeet outta the neighbour's window", "Downtown", "Roll roll roll"]], 
	["Paper airplane", [GROUND, IN_THE_AIR, FLYING, DOWNTOWN], ["To The Ground", "Float In The Air", "Soar Across The Skies", "Down down town"]], 
	["Racing", [FISHING, FENCING, ANTARTICA, DEAD], ["Fesh", "Fence", "Land Of The Anti-Bears", "To The Surface"], ], 
	["Toys", [ANTARTICA, DEAD, IN_THE_AIR, DEEP_UNDERWATER], ["Antartica", "To The Surface", "In The Aiiirrr~", "Deep Underwater"], ], 
	["Flashlight", [DEEP_UNDERWATER, DEAD, GROUND, LIL_GUY], ["Choose this option", "To The Surface", "Grounded For LIFE", "Civilization"], ], 
	["Merry go round", [SPINNING, SCHOOL, DOWNTOWN, HOME], ["Spinspinspinspinspinspin", "School Them", "Down down down town", "Let's go home!"]], 
	["Dominoes", [HOME, ROLLING, WALKING, SPINNING], ["Home home", "Rolllllipolliii", "Walk.", "Spinspinspin"]], 
	["Outside", [DOWNTOWN, SCHOOL, WALKING, LIL_GUY], ["Become a cowboy", "School", "Walking", "Care by childs"]], 
	["Dog", [WALKING, SPINNING, DIVING, LIL_GUY], ["Walking", "Spinning", "Diving", "Childcaring"]], 
	["Jumping jacks", [SCHOOL, HOME, DEAD, HOUSE], ["School", "Home", "Surface", "Become a house"]], 
	["Running", [HOME, SCHOOL, DIVING, ANTARTICA], ["Home", "School", "Diving", "Climb Mt Everest And Sleep With Trash"], ], 
	["Swimming", [SPINNING, DEAD, ANTARTICA, WALKING], ["Sping spin sping", "Surface", "Did you know there are penguins on Mt Everest?", "Walking"]], 
	["Soft toys", [ANTARTICA, CAT_HOME, HOUSE, DEAD], ["Mt Evereeset", "The Home Of Cats", "House", "Surrrrface"]], 
	["Chess", [WALKING, SCHOOL, ROLLING, DOWNTOWN], ["Party", "School", "Roll", "Down"]], 
	["Partying", [], [], ], 
	["School", [], [], ], 
	["Rolling", [], [], ], 
	["Lil guy", [], [], ], 
	["Ground", [], [], ], 
	["In the air", [], [], ], 
	["Flying", [], [], ], 
	["Downtown", [], [], ], 
	["Fishing", [], [], ], 
	["Fencing", [], [], ], 
	["Antartica", [], [], ], 
	["Surface", [], [], ], 
	["Deep underwater", [], [], ], 
	["Spinning", [], [], ], 
	["Diving", [], [], ], 
	["Home", [], [], ], 
	["Cat's home", [], [], ], 
	["House", [], [], ], 
]

var cur_pet_type: int = 0

var cur_count: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%QuestionLabel.text = questions[cur_question_no]
	for i in range(%OptionsGridContainer.get_child_count()):
		var option: Button = %OptionsGridContainer.get_child(i)
		option.pressed.connect(option_pressed.bind(i))
	update_options(0)
	
	for i in range(growth_adj_list.size()):
		growth_adj_list[i].append(Pets.pet_sprites[i])
		
	Pets.pet_unlock_status[0] = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/CurPetLabel.text = "Current Pet: " + str(growth_adj_list[cur_pet_type][AdjList.NAME])
	cur_count += delta / 2
	var rotation_offset: float = pingpong(cur_count, PI/8)
	$PetSprite.rotation = rotation_offset - PI/16
	var position_offset: float = pingpong(cur_count * 100, 20)
	$PetSprite.position.y = position_offset + 250
	%NewUnlockLabel.rotation = rotation_offset / 2 - PI/32


func update_options(pet_type: int) -> void:
	%ReplayButton.hide()
	%OptionsGridContainer.show()
	%QuestionLabel.text = questions[cur_question_no]
	for i in range(%OptionsGridContainer.get_child_count()):
		var option: Button = %OptionsGridContainer.get_child(i)
		option.text = growth_adj_list[pet_type][AdjList.OPTIONS][i]


func show_end_of_path() -> void:
	%OptionsGridContainer.hide()
	%ReplayButton.show()
	

func option_pressed(option_no: int) -> void:
	%OptionsGridContainer.hide()
	%QuestionLabel.hide()
	$Control/ViewUnlockMenuButton.hide()
	
	AudioStreamPlayerGlobal.play_drum_roll()
	var tween = get_tree().create_tween()
	tween.tween_property($PetSprite, "rotation", 0, 0.5)
	tween.tween_property($PetSprite, "rotation", 8*PI, 1.5)
	tween.tween_property($PetSprite, "rotation", 0, 0.5)
	await tween.finished
	cur_pet_type = growth_adj_list[cur_pet_type][AdjList.GROWTH_PATH][option_no]
	
	if Pets.pet_unlock_status[cur_pet_type] == false:
		Pets.pet_unlock_status[cur_pet_type] = true
		%NewUnlockLabel.show()
		
	if growth_adj_list[cur_pet_type].size() < 4:
		$PetSprite.texture = load("res://assets/icon.svg")
	else:
		$PetSprite.texture = load(growth_adj_list[cur_pet_type][AdjList.SPRITE_PATH])
	
	tween = get_tree().create_tween()
	tween.tween_property($PetSprite, "rotation", 0, 1.5)
	await tween.finished
	
	cur_question_no += 1
	if cur_question_no < 3:
		update_options(cur_pet_type)
	else:
		show_end_of_path()
		%QuestionLabel.text = "Congrats! You have sucessfully raised your creature (?)"
		
	%QuestionLabel.show()
	$Control/ViewUnlockMenuButton.show()


func _on_replay_button_pressed() -> void:
	cur_question_no = 0
	cur_pet_type = 0
	update_options(0)
	$PetSprite.texture = load(growth_adj_list[cur_pet_type][AdjList.SPRITE_PATH])
	get_tree().change_scene_to_file("res://scenes/cutscene.tscn")


func _on_view_unlock_menu_button_pressed() -> void:
	add_child(load("res://scenes/unlock_menu.tscn").instantiate())
	%NewUnlockLabel.hide()
