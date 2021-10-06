extends KinematicBody2D
class_name Player

export var m_psBullet: PackedScene

export var m_fGravity: float = 20
export var m_fMoveSpeed: float = 200
export var m_fJumpHeight: float = -800
export var m_fFallSpeedWhileShooting: float = 50
export var m_fFallMultiplier: float = 4
export var m_fLowJumpMultiplier: float = 2.5

onready var m_nGunBootTimer: Timer = $GunBootCooldownTimer
export var m_fShootInterval: float = 0.05
onready var m_nBulletCount: BulletCount = get_parent().get_node("BulletCount")
onready var m_bGunBootOffCooldown: bool = true
onready var m_bTriggerReleased: bool = false
onready var m_bIsOnAirLastFrame: bool = true

onready var m_fMovement: Vector2 = Vector2.ZERO

signal shoot
signal landed

func get_class():
	return "Player"

func _ready():
	m_nGunBootTimer.connect("timeout", self, "_set_gun_boot_off_cooldown")

func _set_gun_boot_off_cooldown():
	m_bGunBootOffCooldown = true

func _physics_process(delta):
	m_fMovement.y += m_fGravity
	
	if Input.is_action_pressed("ui_right"):
		m_fMovement.x = m_fMoveSpeed
	elif Input.is_action_pressed("ui_left"):
		m_fMovement.x = -m_fMoveSpeed
	else:
		m_fMovement.x = 0
	
	if is_on_floor():
		if m_bIsOnAirLastFrame:
			emit_signal("landed")
			m_bIsOnAirLastFrame = false
		
		m_bTriggerReleased = false
		if Input.is_action_just_pressed("ui_accept"):
			m_fMovement.y = m_fJumpHeight
	else:
		m_bIsOnAirLastFrame = true
		if Input.is_action_just_released("ui_accept"):
			m_bTriggerReleased = true
		if m_bTriggerReleased and Input.is_action_pressed("ui_accept") \
			and m_bGunBootOffCooldown and m_nBulletCount.m_iBulletLeft > 0:
			emit_signal("shoot")
			m_fMovement.y = m_fFallSpeedWhileShooting
			m_bGunBootOffCooldown = false
			m_nGunBootTimer.start(m_fShootInterval)
			
			var nBullet: Bullet = m_psBullet.instance()
			nBullet.global_position = $BulletSpawnPos.global_position
			get_tree().get_current_scene().add_child(nBullet)
		else:
			if m_fMovement.y > 0:
				m_fMovement.y += m_fGravity * (m_fFallMultiplier - 1)
			elif m_fMovement.y < 0 and !Input.is_action_pressed("ui_accept"):
				m_fMovement.y += m_fGravity * (m_fLowJumpMultiplier - 1)
	
	m_fMovement = move_and_slide(m_fMovement, Vector2.UP)

func bounce():
	m_fMovement.y = m_fJumpHeight
