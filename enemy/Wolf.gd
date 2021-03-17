extends Area2D

var screensize = Vector2()

func setup(pos):
	position = pos


func move():
	var pos = Vector2(rand_range(0, screensize.x),rand_range(0, screensize.y))
	var tween = Tween.new()
	var duration 
	
	if abs(pos.x) > screensize.x / 2 or abs(pos.y) > screensize.y / 2:
		duration = 2.5
	else:
		duration = 1.0
	
	tween.interpolate_property(
		self,
		"position",
		position,
		pos,
		duration,
		Tween.TRANS_LINEAR,
		Tween.EASE_IN_OUT)
	
	add_child(tween)
	tween.start()
	
	yield(tween,"tween_completed")
	tween.queue_free()
