extends AudioStreamPlayer
@export_file() var explosion
@export_file() var perfect_land
@export_file() var rocket_engine

func rocket_crash_audio():
	stream = load(explosion)
	play()

func rocket_land_perfect():
	stream = load(perfect_land)
	play()

func rocked_engine():
	stream = load(rocket_engine)
	play()
