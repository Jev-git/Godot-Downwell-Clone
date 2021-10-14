extends Enemy
class_name Turtle

func _physics_process(delta):
	._physics_process(delta)
	move_and_slide(Vector2.DOWN * 50)
