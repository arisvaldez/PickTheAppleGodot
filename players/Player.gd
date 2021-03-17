extends Area2D

signal pickup
signal hurt


export (int) var speed
var velocity = Vector2()
var screensize = Vector2(440, 704)



func _process(delta):
	get_input()
	
	position += velocity * delta
	
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)
	
	if velocity.length() > 0:
		$AnimatedSprite.animation = "run"
		$AnimatedSprite.flip_h = velocity.x > 0
	else:
		$AnimatedSprite.animation = "idle"


func get_input():
	velocity = Vector2()
	
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed


func start(pos):
	set_process(true)
	position = pos
	$AnimatedSprite.animation = "idle"


func die():
	$AnimatedSprite.animation = "hurt"
	set_process(false)


func _on_Player_area_entered(area):
	if area.is_in_group("apples"):
		area.pickup()
		emit_signal("pickup","apples")
	if area.is_in_group("powerups"):
		area.pickup()
		emit_signal("pickup","powerups")
	if area.is_in_group("enemy"):
		emit_signal("hurt")
		die()


func _on_DirectionsButtons_button_pressed(vel):
	velocity = vel
