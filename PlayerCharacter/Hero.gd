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


# INPUT
func _input(event):
	if event.is_action_pressed("right_click"):
		button_down = true
		$HeroStateChart.send_event('to_moving')
		
	if event.is_action_released("right_click"):
		button_down = false
		$HeroStateChart.send_event("to_idle")


func MovementLoop(delta):
	destination = get_global_mouse_position() - global_position
	
	if destination.length() > 5:
		velocity = destination.normalized() * speed
	else:
		velocity = Vector2.ZERO
		$HeroStateChart.send_event("to_idle")
	animTree.set("parameters/Walking/blend_position", destination)
	move_and_slide()
	pass
	
func IdleLoop(delta):
	destination = get_global_mouse_position() - global_position
	animTree.set("parameters/Idle/blend_position", destination)
	if destination.length() > 5 and button_down:
		$HeroStateChart.send_event("to_moving")

 #SIGNALS
func _on_moving_state_processing(delta):
	MovementLoop(delta)
	
func _on_idle_state_processing(delta):
	IdleLoop(delta)

func _on_idle_state_entered():
	$HeroAnimationTree.get("parameters/playback").travel("Idle")

func _on_moving_state_entered():
	$HeroAnimationTree.get("parameters/playback").travel("Walking")
