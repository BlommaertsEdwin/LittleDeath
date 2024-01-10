extends CharacterBody2D

@onready var animated_sprite = $HeroSprite
@onready var anim = $HeroAnimationPlayer
@onready var animTree = $HeroAnimationTree
@onready var destination = Vector2()
@onready var movement = Vector2()
@onready var herostatechart = $HeroStateChart
@export var MaxSpeed: int = 50
@export var Friction: float = 0.15
@export var Accelearation: int = 10
@export var speed = 0


# INPUT
func _unhandled_input(event):
	if event.is_action_pressed("move") and state != DEAD:
		destination = get_global_mouse_position()

	
func MovementLoop(delta):
	speed = Accelearation * delta
	if speed >= MaxSpeed:
			speed = MaxSpeed
	movement = position.direction_to(destination) * speed

	
func _physics_process(delta):
	
	
	
	
	
	match state:
		MOVE:
			MovementLoop(delta)
		#ATTACK:
			#AttackLoop(delta)
		#DEAD:
			#DeadLoop(delta)

