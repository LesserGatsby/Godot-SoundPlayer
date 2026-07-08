@tool
extends EditorPlugin


func _enable_plugin() -> void:
	add_autoload_singleton("SoundPlayer", "res://addons/sound_player/sound.gd")


func _disable_plugin() -> void:
	remove_autoload_singleton("SoundPlayer")


func _enter_tree() -> void:
	# Initialization of the plugin goes here.
	pass


func _exit_tree() -> void:
	# Clean-up of the plugin goes here.
	pass
