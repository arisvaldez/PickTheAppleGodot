extends CanvasLayer

signal start_game

func _ready():
	$Control/StartButton.grab_focus()
	

func update_score(value):
	$Control/HBoxContainer/ScoreLabel.text = str(value)


func update_time(value):
	$Control/HBoxContainer/TimeLabel.text = str(value)


func show_message(text):
	$Control/MessageLabel.text = text
	$Control/MessageLabel.show()
	$MessageTimer.start()


func _on_MessageTimer_timeout():
	$Control/MessageLabel.hide()


func _on_StartButton_pressed():
	$Control/StartButton.hide()
	$Control/MessageLabel.hide()
	emit_signal("start_game")


func show_gameover():
	show_message("Game Over!")
	yield($MessageTimer,"timeout")
	$Control/StartButton.show()
	$Control/StartButton.grab_focus()
	$Control/MessageLabel.text = "Pick The Apple!"
	$Control/MessageLabel.show()
	
	
