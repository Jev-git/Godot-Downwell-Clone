extends Enemy
class_name BadBubble

func _physics_process(delta):
	._physics_process(delta)
	if !m_bIsKnockingBack:
		move_and_slide((m_nPlayer.position - position).normalized() * m_fMoveSpeed)
