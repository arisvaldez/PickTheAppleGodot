extends Node


export (PackedScene) var Apple
export (PackedScene) var GoldenApple

export (int) var playtime


var level
var score
var time_left
var screensize
var playing = false


func _ready():
	randomize()
	screensize = get_viewport().get_visible_rect().size
	$Player.screensize = screensize
	$Player.hide()
	$Wolf.screensize = screensize
	$Wolf.hide()
	$CanvasLayer/TouchButtons.hide()
	


func _process(delta):
	if playing and $AppleContainer.get_child_count() == 0:
		AudioPlayer.play("level_up", 10)
		level += 1
		time_left += 6
		$Wolf.move()
		spawn_powerup()
		apple_spawn()


func new_game():
	playing = true
	level = 1
	score = 0
	time_left = playtime
	$Player.start($PlayerStart.position)
	$Player.show()
	$Wolf.show()
	$Wolf.setup($WolfStartPosition.position)
	$GameTimer.start()
	apple_spawn()
	$HUD.update_score(score)
	$HUD.update_time(time_left)
	AudioPlayer.background_music(true)
	$CanvasLayer/TouchButtons.show()
	


func apple_spawn():
	for i in 3 + level:
		var apple = Apple.instance()
		$AppleContainer.add_child(apple)
		apple.screensize = screensize
		
		apple.position = Vector2(
			rand_range(0, screensize.x),
			rand_range(0, screensize.x))


func _on_GameTimer_timeout():
	time_left -= 1
		
	if time_left < 0:
		game_over()
		time_left = 0
	
	$HUD.update_time(time_left)


func _on_Player_hurt():
	game_over()


func _on_Player_pickup(type):
	match type:
		"apples":
			score += 1
			$HUD.update_score(score)
			AudioPlayer.play("pickup_apple", 15)
		"powerups":
			time_left += 5
			AudioPlayer.play("powerups", 15)
			$HUD.update_time(time_left)


func game_over():
	AudioPlayer.play("die", 10)
	AudioPlayer.background_music(false)
	
	playing = false
	$GameTimer.stop()
	
	for apple in $AppleContainer.get_children():
		apple.queue_free()
	
	$HUD.show_gameover()
	$Player.die()
	$CanvasLayer/TouchButtons.hide()



func _on_HUD_start_game():
	new_game()


func spawn_powerup():
	$SpawnPowerUpTimer.wait_time = rand_range(5, 9)
	$SpawnPowerUpTimer.start()



func _on_SpawnPowerUpTimer_timeout():
	var p = GoldenApple.instance()
	add_child(p)
	p.screensize = screensize
	p.position = Vector2(rand_range(0, screensize.x), rand_range(0, screensize.y))

