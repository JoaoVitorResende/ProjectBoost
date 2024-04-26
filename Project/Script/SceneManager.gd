extends Node

func change_to_new_scene(next_level_file :String) -> void:
	get_tree().change_scene_to_file(next_level_file)

func restart_current_scene() -> void:
	get_tree().reload_current_scene()
