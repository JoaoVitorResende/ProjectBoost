extends AnimatableBody3D
@export var destination: Vector3
@export_range(1.0,3.0) var duration : float

func _ready() -> void:
	var tween = create_tween()
	tween.set_loops()
	tween.set_trans(tween.TRANS_SINE)
	tween.tween_property(self, "global_position", global_position + destination, duration)
	tween.tween_property(self, "global_position", global_position, duration)
