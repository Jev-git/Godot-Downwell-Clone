extends KinematicBody2D
class_name Player

export var m_fGravity: float = 20
export var m_fMoveSpeed: float = 200
export var m_fJumpHeight: float = -500
export var m_fFallMultiplier: float = 5.0
export var m_fLowJumpMultiplier: float = 3.5

onready var m_fMovement: Vector2 = Vector2.ZERO

func _physics_process(delta):
	m_fMovement.y += m_fGravity
	
	if Input.is_action_pressed("ui_right"):
		m_fMovement.x = m_fMoveSpeed
	elif Input.is_action_pressed("ui_left"):
		m_fMovement.x = -m_fMoveSpeed
	else:
		m_fMovement.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("ui_accept"):
			m_fMovement.y = m_fJumpHeight
	else:
		if m_fMovement.y > 0:
			m_fMovement.y += m_fGravity * (m_fFallMultiplier - 1)
		elif m_fMovement.y < 0 and !Input.is_action_pressed("ui_accept"):
			m_fMovement.y += m_fGravity * (m_fLowJumpMultiplier - 1)
	
	m_fMovement = move_and_slide(m_fMovement, Vector2.UP)
