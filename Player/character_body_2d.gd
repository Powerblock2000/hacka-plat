extends CharacterBody2D

class_name Player

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

@onready var dash_timer: Timer = $DashTimer
@onready var timer: Timer = $Timer
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var _0_left: CPUParticles2D = $"0Left"
@onready var _1_left: CPUParticles2D = $"1Left"
@onready var _0_right: CPUParticles2D = $"0Right"
@onready var _1_right: CPUParticles2D = $"1Right"

var can_dash : bool = true
var dashing : bool = false
var dash_strength : float = 5

var direction : float

func _unhandled_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("PL_MV_Dash") and can_dash and not dashing and direction != 0:
		dashing = true
		timer.start(.2)
		print("Starting timer")

# Started with godot defualt code
var dash_dir : float
var dash_frame_one : bool = true
func _physics_process(delta: float) -> void: ## TODO Make dash work on y axis
	# Add the gravity.
	if not is_on_floor() and not dashing:
		velocity += get_gravity() * delta
	
	if not is_on_floor() and dashing:
		velocity.y = 0
	
	if not (get_parent() as WorldManager).can_move: return
	
	# Handle jump.
	if Input.is_action_just_pressed("PL_MV_Jump") and is_on_floor() or Input.is_action_pressed("PL_MV_Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("PL_MV_Left", "PL_MV_Right")
	if dashing and direction != 0.0 and can_dash and dash_frame_one:
		#print("Dashing baby")
		dash_dir = direction
		velocity.x = direction * SPEED * dash_strength
		dash_frame_one = false
	elif dashing and can_dash:
		velocity.x = dash_dir * SPEED * dash_strength
	elif direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var random : int = randi_range(0, 200)
	
	if direction == -1:
		animated_sprite_2d.play("DriveLeft")
		_0_left.emitting = false
		_1_left.emitting = false
		_0_right.emitting = true
		_1_right.emitting = true
	if direction == 1:
		animated_sprite_2d.play("DriveRight")
		_0_left.emitting = true
		_1_left.emitting = true
		_0_right.emitting = false
		_1_right.emitting = false
	if direction == 0 and random == 1 and animated_sprite_2d.animation != "Idle":
		animated_sprite_2d.play("Idle")
	if direction == 0:
		_0_left.emitting = false
		_1_left.emitting = false
		_0_right.emitting = false
		_1_right.emitting = false
	
	if not is_on_floor():
		_0_left.emitting = false
		_1_left.emitting = false
		_0_right.emitting = false
		_1_right.emitting = false
	
	move_and_slide()

var dash_timer_started : bool = false

func _on_dash_timer_timeout() -> void:
	dash_frame_one = true
	can_dash = true
	dash_timer_started = false

func _on_timer_timeout() -> void:
	print('Stop Dashin')
	timer.stop()
	dashing = false
	can_dash = false
	if dash_timer_started: return
	dash_timer_started = true
	dash_timer.start()
