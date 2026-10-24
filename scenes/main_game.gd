extends Node2D

var cur_question_no: int = 0

var questions: Array[String] = [
	"What do you feed your creature?",
	"What do you let your creature play with?",
	"Which direction do you throw your creature?",
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
	PARTYING,
	SCHOOL,
	ROLLING,
	YEEHAW_DOWNTOWN,
	YOUR_FRIEND,
	NEIGHBOUR_WINDOW,
	GROUND,
	IN_THE_AIR,
	FLYING,
	DOWNTOWN,
	FISHING,
	FENCING,
	ANTARTICA,
	SURFACE,
	DEEP_UNDERWATER,
	CIVILIZATION,
	SPINNING,
	WALKING,
	CHILDCARE,
	DIVING,
	HOME,
	MT_EVEREST,
	CAT_HOME
}

var growth_adj_list: Array[Array] = [
	["Start", [SAUSAGE, EGGS, FISH, VEGETABLES], ["Sausage", "Eggs", "One Whole Stingray", "Brocolili"], "res://assets/icon.svg"], 
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


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Control/CurPetLabel.text = "Current Pet: " + str(growth_adj_list[cur_pet_type][AdjList.NAME])
	cur_count += delta / 2
	var rotation_offset: float = pingpong(cur_count, PI/8)
	$PetSprite.rotation = rotation_offset - PI/16
	var position_offset: float = pingpong(cur_count * 100, 20)
	$PetSprite.position.y = position_offset + 300
	


func update_options(pet_type: int) -> void:
	for i in range(%OptionsGridContainer.get_child_count()):
		var option: Button = %OptionsGridContainer.get_child(i)
		option.text = growth_adj_list[pet_type][AdjList.OPTIONS][i]


func option_pressed(option_no: int) -> void:
	cur_pet_type = growth_adj_list[cur_pet_type][AdjList.GROWTH_PATH][option_no]
	cur_question_no += 1
	update_options(cur_pet_type)
	%QuestionLabel.text = questions[cur_question_no]
	$PetSprite.texture = load(growth_adj_list[cur_pet_type][AdjList.SPRITE_PATH])
