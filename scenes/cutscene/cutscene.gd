extends Node2D


@export var image: Array[Texture] = [];

@onready var texture_rect = $CurrentSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	# Get the modulate color of the CurrentSprite.
	var tween = get_tree().create_tween()
	
	$CurrentSprite.texture = image[0]
	$CurrentSprite.modulate = Color.TRANSPARENT

	# Fade in the first image.
	tween.tween_property($CurrentSprite, "modulate", Color.WHITE, 1)
	await tween.finished

	# For each image
	for i in range(image.size()):
		# Set the texture to the current image.
		$CurrentSprite.modulate = Color.WHITE
		$CurrentSprite.texture = image[i]
		if i < image.size() - 1:
			$NextSprite.texture = image[i+1]
		else:
			$NextSprite.modulate = Color.TRANSPARENT


		var tween_a = get_tree().create_tween()
		var tween_b = get_tree().create_tween()
		# Fade in the next image and fade out the current image.
		tween_a.tween_property($NextSprite, "modulate", Color.WHITE, 1)
		tween_b.tween_property($CurrentSprite, "modulate", Color.TRANSPARENT, 1)
		await tween_b.finished
		# Wait 2 seconds.
		$CurrentSprite.modulate = Color.WHITE
		$CurrentSprite.texture = $NextSprite.texture
		# Set the next image.
		if i < image.size() - 1:
			$NextSprite.texture = image[i + 1]
		else:
			$NextSprite.texture = image[0]
		tween = get_tree().create_tween()
		tween.tween_property($NextSprite, "modulate", Color.TRANSPARENT, 1)
		await tween.finished
		
	# Fade out the last image.
	tween = get_tree().create_tween()
	tween.tween_property($CurrentSprite, "modulate", Color.BLACK, 1)
	tween.tween_property($CurrentSprite, "modulate", Color.BLACK, 1)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/battle/battle.tscn")
	


