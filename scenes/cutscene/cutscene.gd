extends Node2D

var skipFrame = false

var currentFrame = 0
@export var image: Array[Texture] = [];

var tween_a = null
var tween_b = null

func _input(event):
	if event.is_action_pressed("ui_accept"):
		swap_frame()

func swap_frame():
	
	if tween_a != null or tween_b != null:
		tween_a.stop()
		tween_b.stop()
		print("Skipping")
		$CurrentSprite.texture = image[currentFrame]
		$CurrentSprite.modulate = Color.WHITE
		$NextSprite.modulate = Color.TRANSPARENT
		tween_a = null
		tween_b = null
		return
		
	currentFrame += 1

	if currentFrame == image.size():
		get_tree().change_scene_to_file("res://scenes/battle/battle.tscn")
		return


	$NextSprite.texture = image[currentFrame]
	$NextSprite.modulate = Color.TRANSPARENT


	tween_a = get_tree().create_tween()
	tween_b = get_tree().create_tween()
	var transitionTime = 0.25
	tween_a.tween_property($NextSprite, "modulate", Color.WHITE, transitionTime)
	tween_b.tween_property($CurrentSprite, "modulate", Color.TRANSPARENT, transitionTime)
	await tween_a.finished
	await tween_b.finished
	tween_a = null
	tween_b = null
	$CurrentSprite.texture = $NextSprite.texture
	$CurrentSprite.modulate = Color.WHITE
	$NextSprite.modulate = Color.TRANSPARENT
	print("finished", currentFrame)

func _ready():
	$CurrentSprite.modulate = Color.WHITE
	$CurrentSprite.texture = image[0]

	$NextSprite.modulate = Color.WHITE
	


