extends Node
class_name AbilityAttribute

# This class uses to store the variable that might be replication over the network. Also, iteration over time.
@export var base_value:float = 0
@export var current_value:float = 0

@export var max_value:float = INF
@export var min_value:float = -INF

# replication rate is the rate that the value will be replication over the network. If the value is -1, it will not replication over the network. the unit is second.
@export var replication_rate:float = -1

# iteration speed is the value that will be added to the current value every second. In order to make the value to the base value. If the value is -1, it will not iteration over time.
@export var iteration_speed:float = -1

@onready var ability_system = get_node("../..")
@onready var ability_set = get_parent()

var replication_timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	if is_multiplayer_authority() and replication_rate > 0:
		#create timer 
		replication_timer = Timer.new()
		replication_timer.set_wait_time(replication_rate)
		replication_timer.set_one_shot(false)
		replication_timer.set_autostart(true)
		replication_timer.connect("timeout", self.replication)
		add_child(replication_timer)
		replication_timer.start()

	if iteration_speed > 0:
		set_physics_process(true)
	else:
		set_process(false)
		set_physics_process(false)

func set_value(val):
	base_value = val
	if iteration_speed > 0:
		current_value = base_value

func replication():
	rpc("remote_replication", base_value)

@rpc
func remote_replication(val):
	base_value = val

func _physics_process(delta):
	if iteration_speed > 0:
		current_value += iteration_speed * delta
		current_value = clamp(current_value, min_value, max_value)
	pass
