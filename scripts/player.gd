extends CharacterBody2D

@export var gravity = 1000
@export var speed = 600
@export var jump_force = 600
@onready var animated_sprite = $AnimatedSprite2D

var active = true

func _physics_process(delta):
	if is_on_floor() == false:
		velocity.y += gravity * delta
		if velocity.y > 500:
			velocity.y = 500
	
	var direction = 0
	if active == true:
		if Input.is_action_just_pressed("jump") && is_on_floor() == true:
			jump(jump_force)
		
		direction = Input.get_axis("move_left", "move_right")
	if direction != 0:
		animated_sprite.flip_h = (direction == -1)
	
	velocity.x = direction * speed 
	
	move_and_slide()
	update_animations(direction)

func jump(force):
	#AudioPlayer.play_sfx("jump")
	velocity.y = -force

func update_animations(direction):
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		if velocity.y <0:
			animated_sprite.play("Jump")
