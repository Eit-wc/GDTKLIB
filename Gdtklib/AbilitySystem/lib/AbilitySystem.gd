extends Node
class_name AbilitySystem

var ability_list:Dictionary = {}
var attribute_set: AbilityAttributeSet = null


# Called when the node enters the scene tree for the first time.
func _ready():
        for c in get_children():
                if c is Ability:
                        ability_list[c.name] = c
                elif c is AbilityAttributeSet:
                        attribute_set = c
	pass # Replace with function body.

# ability
func use_ability(ability_name: String,val = null):
	ability_list[ability_name].active(val)

func has_ability(ability_name: String):
	return ability_list.has(ability_name)

# attribute
func has_attribute(attribute_name: String) -> bool:
	return attribute_set.attribute_dict.has(attribute_name)

func get_attribute(attribute_name: String) -> float:
	return attribute_set.attribute_dict[attribute_name].current_value

# tag
func has_tag(tag: String) -> bool:
	return attribute_set.attribute_tag.has_tag(tag)

func add_tag(tag: String,val = true):
	attribute_set.attribute_tag.add_tag(tag,val)

func remove_tag(tag: String):
	attribute_set.attribute_tag.remove_tag(tag)

func get_tag(tag: String):
	return attribute_set.attribute_tag.get_tag(tag)