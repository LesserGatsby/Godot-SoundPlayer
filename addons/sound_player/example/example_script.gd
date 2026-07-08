extends Node

const JUMP = preload("uid://dmnp6yewmby5g")

@onready var tl: Button = %TL
@onready var tr: Button = %TR
@onready var bl: Button = %BL
@onready var br: Button = %BR
@onready var ctr: Button = %Ctr

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ctr.pressed.connect(play_neutral)
	
	tl.pressed.connect(play_at_location.bind(Vector2(-1000, -1000)))
	tr.pressed.connect(play_at_location.bind(Vector2(1000, -1000)))
	bl.pressed.connect(play_at_location.bind(Vector2(-1000, 1000)))
	br.pressed.connect(play_at_location.bind(Vector2(1000, 1000)))

func play_neutral():
	SoundPlayer.play_sound(JUMP)

func play_at_location(location : Vector2):
	SoundPlayer.play_sound_2d(JUMP, location)
