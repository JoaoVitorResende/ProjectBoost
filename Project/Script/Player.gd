extends RigidBody3D
## how much vertical force to apply when moving.
@export_range(750.0,3000.0) var thrust: float = 1000.0
@export var toque_thrust: float = 100.0
@export var scene_manager: Node
@onready var booster_particles: GPUParticles3D = $BoosterParticles
@onready var right_booster_particles: GPUParticles3D = $RightBoosterParticles
@onready var left_booster_particles: GPUParticles3D = $LeftBoosterParticles
@onready var explosion_particles: GPUParticles3D = $ExplosionParticles
@onready var success_particles: GPUParticles3D = $SuccessParticles

var is_changing_scenes: bool = false

func _process(delta: float) -> void:
	player_inputs(delta)

func player_inputs(delta):
	if Input.is_action_pressed("Boost"):
		apply_central_force(basis.y * delta * thrust)
		play_rocket_engine()
		booster_particles.emitting = true
	else:
		$AudioStreamPlayer.stop()
		booster_particles.emitting = false
	if Input.is_action_pressed("Turn_Left"):
		apply_torque(Vector3(0.0,0.0,toque_thrust * delta))
		right_booster_particles.emitting = true
	else:
		right_booster_particles.emitting = false
	if Input.is_action_pressed("Turn_Right"):
		apply_torque(Vector3(0.0,0.0,-toque_thrust * delta))
		left_booster_particles.emitting = true
	else:
		left_booster_particles.emitting = false

func _on_body_entered(body: Node) -> void:
	if "Goal" in body.get_groups() and !is_changing_scenes:
		complete_level(body.file_path)
	elif "Hazard" in body.get_groups() and !is_changing_scenes:
		crash_sequence()

func crash_sequence() -> void:
	wait_for_seconds_to_change(2.5,"restart")
	$AudioStreamPlayer.rocket_crash_audio()
	explosion_particles.emitting = true
	print("BOOMM")

func complete_level(next_level_file: String) -> void:
	wait_for_seconds_to_change(2.5,next_level_file)
	$AudioStreamPlayer.rocket_land_perfect()
	success_particles.emitting = true
	print("landingpad reached")

func wait_for_seconds_to_change(seconds: float,level: String):
	is_changing_scenes = true
	set_process(false)
	await get_tree().create_timer(seconds).timeout
	if level == "restart":
		scene_manager.restart_current_scene()
	else: 
		scene_manager.change_to_new_scene(level)

func play_rocket_engine():
	if $AudioStreamPlayer.playing == false:
		$AudioStreamPlayer.rocked_engine()
	
	
