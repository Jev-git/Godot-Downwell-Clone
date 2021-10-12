extends KinematicBody2D
class_name Player

export var m_psBullet: PackedScene

export var m_fGravity: float = 20
export var m_fMoveSpeed: float = 200
export var m_fJumpHeight: float = -800
export var m_fFallSpeedWhileShooting: float = 50
export var m_fFallMultiplier: float = 4
export var m_fLowJumpMultiplier: float = 2.5

onready var m_nVulnerableTimer: Timer = $VulnerableTimer
onready var m_nVulnerableIntervalTimer: Timer = $VulnerableIntervalTimer
onready var m_bIsVulnerable: bool = false
onready var m_nSprite: Sprite = $Sprite

onready var m_nGunBootTimer: Timer = $GunBootCooldownTimer
onready var m_nBulletCount: BulletCount = get_parent().get_node("CanvasLayer/BulletCount")
onready var m_bGunBootOffCooldown: bool = true
onready var m_bTriggerReleased: bool = false
onready var m_bIsOnAirLastFrame: bool = true

onready var m_nHPCount: Node2D = get_parent().get_node("CanvasLayer/HPCount")

onready var m_nKnockbackTimer: Timer = $KnockbackTimer
onready var m_bIsBeingKnockedBack: bool = false
onready var m_bKnockbackToTheRight: bool = true
export var m_fKnockbackSpeed: float = 100

onready var m_fMovement: Vector2 = Vector2.ZERO

func get_class():
	return "Player"

func _ready():
	m_nGunBootTimer.connect("timeout", self, "_set_gun_boot_off_cooldown")
	m_nVulnerableTimer.connect("timeout", self, "_reset_vulnerability")
	m_nVulnerableIntervalTimer.connect("timeout", self, "_blinky_blinky")
	m_nKnockbackTimer.connect("timeout", self, "_stop_knockback")

func _set_gun_boot_off_cooldown():
	m_bGunBootOffCooldown = true

func _reset_vulnerability():
	m_bIsVulnerable = false
	m_nVulnerableIntervalTimer.stop()
	m_nSprite.visible = true

func _blinky_blinky():
	m_nSprite.visible = !m_nSprite.visible

func _stop_knockback():
	m_bIsBeingKnockedBack = false

func _physics_process(delta):
	m_fMovement.y += m_fGravity
	
	if Input.is_action_pressed("ui_right"):
		m_fMovement.x = m_fMoveSpeed
	elif Input.is_action_pressed("ui_left"):
		m_fMovement.x = -m_fMoveSpeed
	else:
		m_fMovement.x = 0
	
	if m_bIsBeingKnockedBack:
		m_fMovement.x += m_fKnockbackSpeed * (1 if m_bKnockbackToTheRight else - 1)
	
	if is_on_floor():
		if m_bIsOnAirLastFrame:
			m_nBulletCount.reload()
			m_bIsOnAirLastFrame = false
			m_nGunBootTimer.stop()
		
		m_bTriggerReleased = false
		if Input.is_action_just_pressed("ui_accept"):
			m_fMovement.y = m_fJumpHeight
	else:
		m_bIsOnAirLastFrame = true
		if Input.is_action_just_released("ui_accept"):
			m_bTriggerReleased = true
		if m_bTriggerReleased and Input.is_action_pressed("ui_accept") \
			and m_bGunBootOffCooldown and m_nBulletCount.m_iBulletLeft > 0:
			m_nBulletCount.shoot()
			m_fMovement.y = m_fFallSpeedWhileShooting
			m_bGunBootOffCooldown = false
			m_nGunBootTimer.start()
			
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

func take_damage(_vEnemyPosition: Vector2):
	m_nHPCount.take_damage()
	_knock_back(_vEnemyPosition.x < position.x)
	bounce()
	m_nVulnerableTimer.start()
	m_nVulnerableIntervalTimer.start()

func _knock_back(_bToTheRight: bool):
	m_nKnockbackTimer.start()
	m_bIsBeingKnockedBack = true
	m_bKnockbackToTheRight = _bToTheRight
