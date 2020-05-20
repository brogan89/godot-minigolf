extends RigidBody

export var strength := 1
export var reset_height := -3.0
export var fail_timeout := 0.5

signal hits_changed
signal fail
signal win

onready var ball_anchor = get_node('/root/Root/BallAnchor')

var hits := 0

func _ready():
	emit_signal("hits_changed", self)
	
func _physics_process(delta):
	if ball_anchor.get_global_transform().origin.y < reset_height:
		emit_signal("fail")

func _input(event):
	if Input.is_action_just_released("hit"):
		hit()

func hit():
	var forward: Vector3 = ball_anchor.get_global_transform().basis.z
	forward = forward.normalized() * -strength
	apply_central_impulse(forward)
	
	hits += 1
	emit_signal("hits_changed", self)

func win(player):
	emit_signal("win", player)
	
