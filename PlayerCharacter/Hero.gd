class_name Hero
extends CharacterBody2D

@onready var animated_sprite = $HeroSprite
@onready var anim = $HeroAnimationPlayer
@onready var animTree = $HeroAnimationTree
@onready var animState = animTree.get("parameters/playback")
@onready var destination = Vector2()
@onready var movement = Vector2()
@onready var herostatechart = $HeroStateChart
@onready var moving: bool = false
@export var MaxSpeed: int = 50
@export var Friction: float = 0.15
@export var Accelearation: int = 10
@export var speed = 500
@onready var button_down: bool = false

var inventory:Inventory = Inventory.new()


# INPUT
func _input(event):
	if event.is_action_pressed("right_click"):
		button_down = true
		$HeroStateChart.send_event('to_moving')

	if event.is_action_released("right_click"):
		button_down = false
		$HeroStateChart.send_event("to_idle")

	if event.is_action_pressed("left_click"):
		$HeroStateChart.send_event("to_attacking")
		
	#if event.is_action_released("left_click"):
		#$HeroStateChart.send_event("to_idle")


# STATE LOOPS
func MovementLoop(_delta):
	destination = get_global_mouse_position() - global_position
	
	if destination.length() > 5:
		velocity = destination.normalized() * speed
	else:
		velocity = Vector2.ZERO
		$HeroStateChart.send_event("to_idle")
	animTree.set("parameters/Walking/blend_position", destination)
	animTree.set("parameters/Attacking/blend_position", destination)
	move_and_slide()
	pass
	
func IdleLoop(_delta):
	destination = get_global_mouse_position() - global_position
	animTree.set("parameters/Idle/blend_position", destination)
	animTree.set("parameters/Attacking/blend_position", destination)
	if destination.length() > 5 and button_down:
		$HeroStateChart.send_event("to_moving")
		
func AttackingLoop(_delta):
	pass

# SIGNALS
func _on_moving_state_processing(delta):
	MovementLoop(delta)

func _on_idle_state_processing(delta):
	IdleLoop(delta)
	
func _on_attacking_state_processing(delta):
	AttackingLoop(delta)
	
func _on_idle_state_entered():
	$HeroAnimationTree.get("parameters/playback").travel("Idle")

func _on_moving_state_entered():
	$HeroAnimationTree.get("parameters/playback").travel("Walking")

func _on_attacking_state_entered():
	$HeroAnimationTree.get("parameters/playback").travel("Attacking")
	#$HeroAnimationTree.get("parameters/playback").travel("Idle")
	
# ANIMATION ENDINGS
func _attack_animation_finished():
	if button_down:
		herostatechart.send_event("to")
	else:
		herostatechart.send_event("to_idle")
		
# INVENTORY HANDLING
		
func on_item_picked_up(item:Item):
	print("It got a ", item.name)
	inventory.add_item(item)
	

