class_name hero extends CharacterBody2D

@export var move_speed : float = 80.0
@export var peek_duration : float = 0.45    # how long the hero stops and holds the look-back glance

var is_peeking : bool = false

@onready var sprite : AnimatedSprite2D = $AnimatedSprite2D
@onready var game_manager = get_parent().get_node("GameManager")
@onready var villain = get_parent().get_node("villain")

func _ready():
	sprite.play("run")

func _physics_process(_delta):
	# NOTE: the tiles carry no collision, so the ground is visual only —
	# the hero runs at a fixed Y (no gravity) and is grounded by placement.
	# While peeking the hero STOPS and glances back (velocity 0 + idle + flip);
	# the normal running stride resumes the moment the peek ends.
	if is_peeking:
		velocity.x = 0.0
		sprite.play("idle")
	else:
		velocity.x = move_speed
		sprite.play("run")
	move_and_slide()

func _unhandled_input(event):
	# peeking lives in _unhandled_input so on-screen HUD buttons (pause) get
	# first crack at a tap and can swallow it — a tap on a button no longer peeks
	if event.is_action_pressed("peek_back"):
		try_peek()

	if event is InputEventScreenTouch and event.pressed:
		try_peek()

func try_peek():
	# a hand has the hero — every tap goes toward breaking free, not peeking
	if game_manager.is_grabbed:
		game_manager.grab_tap()
		return

	# already mid-peek animation -> ignore
	if is_peeking:
		return

	# the game manager owns the anti-spam gate (cooldown + nerve) and
	# tells us whether this peek actually counted
	var accepted = game_manager.peek_trigger()
	if not accepted:
		return

	start_peek()

func start_peek():
	is_peeking = true

	# Turn around
	sprite.flip_h = true

	# Reveal villain briefly
	villain.show_temporarily()

	await get_tree().create_timer(peek_duration).timeout

	# Turn back forward
	sprite.flip_h = false
	is_peeking = false
	
func die():
	velocity = Vector2.ZERO
	sprite.play("death")
