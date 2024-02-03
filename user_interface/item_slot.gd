extends PanelContainer
@onready var texture_rect:TextureRect = $TextureRect
@onready var label = $Label

func display(display_items):
	texture_rect.texture = display_items[0].icon
	label.text = str(display_items[1])
