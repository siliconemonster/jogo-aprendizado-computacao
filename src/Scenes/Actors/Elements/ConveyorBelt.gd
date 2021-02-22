tool
extends StaticBody2D

enum Tile {Middle, Start, End}
enum Colors {Green, Blue}

export(Tile) var conveyor_tile
export(Colors) var conveyor_color


func _ready() -> void:
	if not Engine.editor_hint:
		updatesSprites()


func _process(delta: float) -> void:
	if Engine.editor_hint:
		updatesSprites()
		return

func updatesSprites():
	$StartGreenConveyorBeltAnimatedTexture.visible = false
	$GreenConveyorBeltAnimatedTexture.visible = false
	$EndGreenConveyorBeltAnimatedTexture.visible = false
	
	$StartBlueConveyorBeltAnimatedTexture.visible = false
	$BlueConveyorBeltAnimatedTexture.visible = false
	$EndBlueConveyorBeltAnimatedTexture.visible = false
	
	if conveyor_color == Colors.Green:
		if conveyor_tile == Tile.Middle:
			$GreenConveyorBeltAnimatedTexture.visible = true
		elif conveyor_tile == Tile.Start:
			$StartGreenConveyorBeltAnimatedTexture.visible = true
		elif conveyor_tile == Tile.End:
			$EndGreenConveyorBeltAnimatedTexture.visible = true
	elif conveyor_color == Colors.Blue:
		if conveyor_tile == Tile.Middle:
			$BlueConveyorBeltAnimatedTexture.visible = true
		elif conveyor_tile == Tile.Start:
			$StartBlueConveyorBeltAnimatedTexture.visible = true
		elif conveyor_tile == Tile.End:
			$EndBlueConveyorBeltAnimatedTexture.visible = true
	return
