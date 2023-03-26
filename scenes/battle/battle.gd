extends Node2D

@export var playerSprite: Sprite2D;
@export var cardPrefab: PackedScene;

@export var cardsNode: Node;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Add 4 cards to the cards node.
	for i in range(4):
		var card = cardPrefab.instantiate();
		card.labelNode.text = "FooBar";
		cardsNode.add_child(card);


# Called every frame. 'delta' is the elapsed time since the previous frame.
var elapsed = 0;
func _process(delta):
	elapsed += delta;
	if elapsed > 0.1:
		elapsed = 0;
		if playerSprite.modulate == Color.RED:
			playerSprite.modulate = Color.WHITE;
		else:
			playerSprite.modulate = Color.RED;
