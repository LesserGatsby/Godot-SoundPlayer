extends Node
class_name AutoloadSoundPlayer
## Sound player addon to play 'fire and forget' sound effects.
## On playback completion, the audio player is cleaned up.

## A Defualt Polyphony Limit for all audio streams of 10.
const POLYPHONY_LIMIT : int = 10
var _sound_polyphony_limit : Dictionary[AudioStream, int] = {}
var _sound_polyphony_count : Dictionary[AudioStream, int] = {}

## Sets the polyphony limit for a given audio stream.
## Setting the limit to zero or below will set the limit to default
func set_sound_polyphony_limit(stream : AudioStream, limit : int):
	if limit >= 0:
		_sound_polyphony_limit[stream] = limit
	else:
		_sound_polyphony_limit.erase(stream)

func _increment_sound(stream : AudioStream):
	_sound_polyphony_count[stream] = _sound_polyphony_count.get(stream, 0) + 1

func _deccrement_sound(stream : AudioStream):
	_sound_polyphony_count[stream] = _sound_polyphony_count.get(stream, 0) - 1
	if _sound_polyphony_count[stream] <= 0:
		_sound_polyphony_count.erase(stream)

## Playes a specified audio stream with an [AudioStreamPlayer].  Pitch is set randomly based on pitch_range.
func play_sound(stream : AudioStream, volume_linear : float = 1.0, pitch_range : float = 0.05, bus_idx : int = 0) -> AudioStreamPlayer:
	var limit = _sound_polyphony_limit.get(stream, POLYPHONY_LIMIT)
	var count = _sound_polyphony_count.get(stream, 0)
	
	if count >= limit:
		return
	_increment_sound(stream)
	
	volume_linear = clamp(volume_linear, 0, 1)
	
	var player : AudioStreamPlayer = AudioStreamPlayer.new()
	player.bus = AudioServer.get_bus_name(bus_idx)
	player.stream = stream
	
	player.finished.connect(player.queue_free)
	player.finished.connect(_deccrement_sound.bind(stream))
	player.volume_linear = volume_linear
	player.pitch_scale = 1.0 + randf_range(-pitch_range, pitch_range)
	add_child(player)
	player.play()
	
	return player

## Playes a specified audio stream with an [AudioStreamPlayer2D].  Pitch is set randomly based on pitch_range.
func play_sound_2d(stream : AudioStream, location : Vector2, volume_linear : float = 1.0, pitch_range : float = 0.05, bus_idx : int = 0) -> AudioStreamPlayer2D:
	var limit = _sound_polyphony_limit.get(stream, POLYPHONY_LIMIT)
	var count = _sound_polyphony_count.get(stream, 0)
	
	if count >= limit:
		return
	_increment_sound(stream)
	
	volume_linear = clamp(volume_linear, 0, 1)
	
	var player : AudioStreamPlayer2D = AudioStreamPlayer2D.new()
	player.bus = AudioServer.get_bus_name(bus_idx)
	player.stream = stream
	
	
	player.finished.connect(player.queue_free)
	player.finished.connect(_deccrement_sound.bind(stream))
	player.volume_linear = volume_linear
	player.pitch_scale = 1.0 + randf_range(-pitch_range, pitch_range)
	add_child(player)
	player.play()
	
	player.position = location
	
	return player

## Playes a specified audio stream with an [AudioStreamPlayer3D].  Pitch is set randomly based on pitch_range.
func play_sound_3d(stream : AudioStream, location : Vector3, volume_linear : float = 1.0, pitch_range : float = 0.05, bus_idx : int = 0) -> AudioStreamPlayer3D:
	var limit = _sound_polyphony_limit.get(stream, POLYPHONY_LIMIT)
	var count = _sound_polyphony_count.get(stream, 0)
	
	if count >= limit:
		return
	_increment_sound(stream)
	
	volume_linear = clamp(volume_linear, 0, 1)
	
	var player : AudioStreamPlayer3D = AudioStreamPlayer3D.new()
	player.bus = AudioServer.get_bus_name(bus_idx)
	player.stream = stream
	
	
	player.finished.connect(player.queue_free)
	player.finished.connect(_deccrement_sound.bind(stream))
	player.volume_linear = volume_linear
	player.pitch_scale = 1.0 + randf_range(-pitch_range, pitch_range)
	add_child(player)
	player.play()
	
	player.position = location
	
	return player
