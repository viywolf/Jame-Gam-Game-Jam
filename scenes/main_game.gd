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
	CAT_HOME,
	HOUSE,
}

var growth_adj_list: Array[Array] = [
	["Start", [SAUSAGE, EGGS, FISH, VEGETABLES], ["Sausage", "Eggs", "One Whole Stingray", "Brocolili"], "res://assets/icon.svg"],
	["Sausage", [PAPER_AIRPLANE, BOOMERANG, BOWLING, STICKS], ["Paper Airplane", "A Boomerang", "Let's Go Bowling", "Random Sticks From The Ground"], ""], 
	["Fish", [RACING, TOYS, FLASHLIGHT, MERRY_GO_ROUND], ["Race With The Other Creatures", "Random Toys", "A Flashlight", "Carnival Merry-Go-Round"], ""], 
	["Eggs", [RUNNING, CHESS, SOFT_TOYS, SWIMMING], ["Run Around The Block", "Chess", "Soft Toys", "Swim In The Lake"], ""], 
	["Vegetables", [DOMINOES, OUTSIDE, DOG, JUMPING_JACKS], ["Dominoes Pizza", "Touch Grass", "Dog.", "Force Them To Do Jumping Jacks"], ""], 
	["Sticks", [SCHOOL, PARTYING, SCHOOL, SCHOOL], ["Go To School", "Go Partying!!", "???", "???"], ""],  #??? the diagram is so unclear
	["Bowling", [DOWNTOWN, ROLLING, YOUR_FRIEND, SCHOOL], ["YEEHAW DOWNTOWN", "They See Me Rolling", "Your 'friend'", "School"], ""], 
	["Boomerang", [YOUR_FRIEND, NEIGHBOUR_WINDOW, DOWNTOWN, ROLLING], ["Your 'friend'", "Yeet outta the neighbour's window", "Downtown", "Roll roll roll"], ""], 
	["Paper airplane", [GROUND, IN_THE_AIR, FLYING, DOWNTOWN], ["To The Ground", "Float In The Air", "Soar Across The Skies", "Down down town"], ""], 
	["Racing", [FISHING, FENCING, ANTARTICA, SURFACE], ["Fesh", "Fence", "Land Of The Anti-Bears", "To The Surface"], ""], 
	["Toys", [ANTARTICA, SURFACE, IN_THE_AIR, DEEP_UNDERWATER], ["Antartica", "To The Surface", "In The Aiiirrr~", "Deep Underwater"], ""], 
	["Flashlight", [DEEP_UNDERWATER, SURFACE, GROUND, CIVILIZATION], ["Choose this option", "To The Surface", "Grounded For LIFE", "Civilization"], ""], 
	["Merry go round", [SPINNING, SCHOOL, DOWNTOWN, HOME], ["Spinspinspinspinspinspin", "School Them", "Down down down town", "Let's go home!"], ""], 
	["Dominoes", [HOME, ROLLING, WALKING, SPINNING], ["Home home", "Rolllllipolliii", "Walk.", "Spinspinspin"], ""], 
	["Outside", [DOWNTOWN, SCHOOL, WALKING, CHILDCARE], ["Become a cowboy", "School", "Walking", "Care by childs"], ""], 
	["Dog", [WALKING, SPINNING, DIVING, CHILDCARE], ["Walking", "Spinning", "Diving", "Childcaring"], ""], 
	["Jumping jacks", [SCHOOL, HOME, SURFACE, HOUSE], ["School", "Home", "Surface", "Become a house"], ""], 
	["Running", [HOME, SCHOOL, DIVING, MT_EVEREST], ["Home", "School", "Diving", "Climb Mt Everest And Sleep With Trash"], ""], 
	["Swimming", [SPINNING, SURFACE, MT_EVEREST, WALKING], ["Sping spin sping", "Surface", "Did you know there are penguins on Mt Everest?", "Walking"], ""], 
	["Soft toys", [MT_EVEREST, CAT_HOME, HOUSE, SURFACE], ["Mt Evereeset", "The Home Of Cats", "House", "Surrrrface"], ""], 
	["Chess", [WALKING, PARTYING, ROLLING, DOWNTOWN], ["Walk", "Party", "Roll", "Down"], ""], 
	["Partying", [], [], ""], 
	["School", [], [], ""], 
	["Rolling", [], [], ""], 
	["Your friend", [], [], ""], 
	["Neighbour window", [], [], ""], 
	["Ground", [], [], ""], 
	["In the air", [], [], ""], 
	["Flying", [], [], ""], 
	["Downtown", [], [], ""], 
	["Fishing", [], [], ""], 
	["Fencing", [], [], ""], 
	["Antartica", [], [], ""], 
	["Surface", [], [], ""], 
	["Deep underwater", [], [], ""], 
	["Civilisation", [], [], ""], 
	["Spinning", [], [], ""], 
	["Walking", [], [], ""], 
	["Childcare", [], [], ""], 
	["Diving", [], [], ""], 
	["Home", [], [], ""], 
	["Mt everest", [], [], ""], 
	["Cat's home", [], [], ""], 
	["House", [], [], ""], 
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
	#$PetSprite.texture = load(growth_adj_list[cur_pet_type][AdjList.SPRITE_PATH])
