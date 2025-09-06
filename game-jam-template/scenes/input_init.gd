extends Node

@export var mapping_context:GUIDEMappingContext

## Path where the remapping config is saved. This file may
## not exist if the player has not remapped their controls yet.
const REMAPPING_CONFIG_PATH:String = "user://remapping_config.tres"

func _ready():
	if ResourceLoader.exists(REMAPPING_CONFIG_PATH):
		var remapping_config:GUIDERemappingConfig = load(REMAPPING_CONFIG_PATH)
		GUIDE.set_remapping_config(remapping_config)

	GUIDE.enable_mapping_context(mapping_context)
