extends Node2D
class_name Entity

## An ECS entity.

var component_data: ComponentData

func _enter_tree() -> void:
	component_data = ComponentData.new(self, get_parent())
	for child in get_children():
		_set_up_component(child)

func add_component(node: Node) -> void:
	_set_up_component(node)
	add_child(node)

func remove_component(indentifier: String) -> void:
	assert(has_component(indentifier), "Component %s does not exist!" % indentifier)
	get_component(indentifier).queue_free()

## Calls a method on all components, if they have it.
func call_method(identifier: String, args: Array) -> void:
	for child in get_children():
		if not child.has_method(identifier):
			continue
		child.callv(identifier, args)

## Returns the component you specify.
func get_component(identifier: String) -> Node:
	return get_node(identifier)

## Returns all the components in a specific group
func get_components_in_group(indentifier: String) -> void:
	return get_tree().get_nodes_in_group(indentifier)

## Returns if the entity has a specific component
func has_component(indentifier: String) -> bool:
	return has_node(indentifier)

func _set_up_component(node: Node) -> void:
	node.set("component", component_data)
