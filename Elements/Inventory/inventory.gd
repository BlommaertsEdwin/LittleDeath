class_name Inventory


var _content:Array[InventoryStack] = []

func add_item(item:Item):
	var typed_available_stacks = _content.filter(func(stack): return stack.get_type().name == item.name and not stack.is_full)
	if typed_available_stacks:
		typed_available_stacks[0].add_item(item)
	else:
		var new_stack = InventoryStack.new()
		new_stack.add_item(item)
		_content.append(new_stack)
	
func remove_item(item:Item):
	for stack in _content:
		if stack.get_stack_type().name == item.name:
			stack.remove_item(item)	
	
func get_items() -> Array[InventoryStack]:
	return _content


		
