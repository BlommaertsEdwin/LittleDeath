extends CollisionShape2D


func on_item_picked_up(item:Item):
	print("It got a ", item.name)
