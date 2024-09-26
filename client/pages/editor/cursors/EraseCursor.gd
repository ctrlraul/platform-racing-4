extends Node2D

signal level_event

@onready var layers = get_node("../../../Layers")


func on_mouse_down():
	pass


func on_drag():
	var layer: ParallaxBackground = layers.get_node(layers.get_target_layer())
	var tilemap: TileMap = layer.get_node("TileMap")
	var camera: Camera2D = get_viewport().get_camera_2d()
	var mouse_position = tilemap.get_local_mouse_position() + camera.get_screen_center_position() - (camera.get_screen_center_position() * (1/layer.follow_viewport_scale))
	var coords = tilemap.local_to_map(mouse_position)
	var atlas_coords = tilemap.get_cell_atlas_coords(0, coords)
	if atlas_coords != Vector2i(-1, -1):
		emit_signal("level_event", {
			"type": EditorEvents.SET_TILE,
			"layer_name": layers.get_target_layer(),
			"coords": coords,
			"block_id": 0
		})


func on_mouse_up():
	pass
