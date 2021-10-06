extends Enemy
class_name Bat

onready var m_bIsChasing: bool = false

func _take_damage(_iDamage: int):
	._take_damage(_iDamage)
	_start_chasing()

func _start_chasing():
	m_bIsChasing = true
	$CurlUpSprite.visible = false
	$Sprite.visible = true

func _process(delta):
	if m_bIsChasing:
		._process(delta)

func _physics_process(delta):
	._physics_process(delta)
	if !m_bIsChasing and m_nPlayer.position.y >= position.y:
		_start_chasing()
	if !m_bIsKnockingBack and m_bIsChasing:
		move_and_slide((m_nPlayer.position - position).normalized() * m_fMoveSpeed)
