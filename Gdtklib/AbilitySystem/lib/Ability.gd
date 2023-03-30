extends Node
class_name Ability

# This class is the base class for all abilities. Abilities are used to give the behavior to the player and enemies and any networked objects.
@onready var ability_system: AbilitySystem = get_parent()

# condition before using the ability
@export var much_have_tag: Array[String] = []
@export var much_not_have_tag: Array[String] = []

# effect after using the ability
@export var add_tag: Array[String] = []
@export var remove_tag: Array[String] = []

# cooldown time in seconds after using the ability (set to -1 to disable cooldown) 
@export var cooldown: float = -1.0
var cooldown_timer: float = 0.0

# effect after cooldown
@export var add_tag_after_cooldown: Array[String] = []
@export var remove_tag_after_cooldown: Array[String] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(cooldown > 0.0)
	pass # Replace with function body.

func _process(delta):
	cooldown_timer += delta
	if cooldown_timer >= cooldown:
		for tag in add_tag_after_cooldown:
			ability_system.add_tag(tag)
		for tag in remove_tag_after_cooldown:
			ability_system.remove_tag(tag)
		set_process(false)

# the override function for check the resource
func _check_resource():
	return true

# the override function for consuming the resource
func _consume_resource():
	pass

# the override function for main ability logic
func _task(val = null):
	pass

func can_use_ability():
	if cooldown_timer < cooldown:
		return false
	for tag in much_have_tag:
		if not ability_system.has_tag(tag):
			return false
	for tag in much_not_have_tag:
		if ability_system.has_tag(tag):
			return false
	if not _check_resource():
		return false
	return true

@rpc("reliable")
func active_rpc(val=null):
	_consume_resource()
	_task(val)
	cooldown_timer = 0.0
	set_process(cooldown > 0.0)
	for tag in add_tag:
		ability_system.add_tag(tag)
	for tag in remove_tag:
		ability_system.remove_tag(tag)

func active(val=null):
	if is_multiplayer_authority() and can_use_ability():
		rpc("active_rpc", val)
		
