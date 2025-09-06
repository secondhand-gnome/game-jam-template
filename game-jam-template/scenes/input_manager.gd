class_name InputManager
extends Node

var mapping_context: GUIDEMappingContext = \
	preload("res://input/guide_mapping_context.tres")

## Path where the remapping config is saved. This file may
## not exist if the player has not remapped their controls yet.
const REMAPPING_CONFIG_PATH:String = "user://remapping_config.tres"

var _remapper: GUIDERemapper = GUIDERemapper.new()

func _ready():
	var remapping_config: GUIDERemappingConfig = null
	if ResourceLoader.exists(REMAPPING_CONFIG_PATH):
		remapping_config = load(REMAPPING_CONFIG_PATH)
		GUIDE.set_remapping_config(remapping_config)

	GUIDE.enable_mapping_context(mapping_context)

	var mapping_contexts: Array[GUIDEMappingContext] = [mapping_context]
	_remapper.initialize(mapping_contexts, remapping_config)

func get_remapper() -> GUIDERemapper:
	return _remapper

func save_remaps():
	var new_remapping_config: GUIDERemappingConfig = _remapper.get_mapping_config()
	ResourceSaver.save(new_remapping_config, REMAPPING_CONFIG_PATH)
	GUIDE.set_remapping_config(new_remapping_config)
