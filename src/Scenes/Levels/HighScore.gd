extends Label

var savegame = File.new() #file
var save_path = "user://savegame.save" #place of the file
var save_data = {"highscore": 0} #variable to store data



# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func read_savegame():
   savegame.open(save_path, File.READ) #open the file
   save_data = savegame.get_var() #get the value
   savegame.close() #close the file
   return save_data["highscore"] #return the value

# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = str(self.read_savegame())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
