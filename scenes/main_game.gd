extends Node2D

var cur_question_no: int = 0

var questions: Array[String] = [
	"What do you feed your creature?",
	"What do you let your creature play with?",
	"Which direction do you throw your creature?",
	"What career do you give your creature?",
]


enum AdjList{
	NAME, GROWTH_PATH, OPTIONS, SPRITE_PATH
}

# All pet names
enum{
	START,
	SAUSAGE,
	STINGRAY,
	EGG,
	DORITOS,
	SKATEBOARD,
	PHONE,
	CAR,
	BOWLING_PIN,
	GOLDFISH,
	BOOMERANG,
	TOY_BLOCKS,
	TOY_FISH,
	DOLLHOUSE,
	BOUNCY_CASTLE,
	OUTSIDE,
	WRENCH,
	NUMBERS,
	BOWLING_BALL,
	BOUNCY_BALL,
	DOG,
}

var growth_adj_list: Array[Array] = [
	["Start", [SAUSAGE, EGG, STINGRAY, DORITOS], ["Sausage", "Eggs", "One Whole Stingray", "Doritos (for breakfast)"], "res://assets/icon.svg"],
	["Sausage", [BOWLING_PIN, CAR, SKATEBOARD, PHONE], ["Bowling", "Toy Car", "Skateboard", "Phone"], "res://assets/icon.svg"],
	["Stingray", [BOOMERANG, GOLDFISH, TOY_BLOCKS, TOY_FISH], ["Boomerang", "Goldfish", "Toy Blocks", "Toy Fish"],"res://assets/icon.svg"],
	["Egg", [SAUSAGE, EGG, STINGRAY, DORITOS], ["Sausage", "Eggs", "One Whole Stingray", "Doritos (for breakfast)"],"res://assets/icon.svg"],
	["Doritos", [SAUSAGE, EGG, STINGRAY, DORITOS], ["Sausage", "Eggs", "One Whole Stingray", "Doritos (for breakfast)"],"res://assets/icon.svg"], 
]

var cur_pet_type: int = 0



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%QuestionLabel.text = questions[cur_question_no]
	for i in range(%OptionsGridContainer.get_child_count()):
		var option: Button = %OptionsGridContainer.get_child(i)
		option.pressed.connect(option_pressed.bind(i))
	update_options(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	$Control/CurPetLabel.text = "Current Pet: " + str(growth_adj_list[cur_pet_type][AdjList.NAME])
	


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
