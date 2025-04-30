@tool
class_name ControllerIcons
extends Resource

# Face Buttons
@export_category("Face Buttons")
@export var face_button_up: Texture2D
@export var face_button_right: Texture2D
@export var face_button_down: Texture2D
@export var face_button_left: Texture2D

# Bumpers/Triggers
@export_category("Bumpers/Triggers")
@export var left_bumper: Texture2D
@export var left_trigger: Texture2D
@export var right_bumper: Texture2D
@export var right_trigger: Texture2D

# DPad
@export_category("DPad")
@export var dpad_up: Texture2D
@export var dpad_right: Texture2D
@export var dpad_down: Texture2D
@export var dpad_left: Texture2D

# Pause/Options
@export_category("Pause/Options")
@export var start_button: Texture2D
@export var back_button: Texture2D

# Analog Sticks
@export_category("Analog Sticks")
@export var left_stick_in: Texture2D
@export var right_stick_in: Texture2D

@export_category("Face Button Extras")
@export var face_button_up_extra: Texture2D
@export var face_button_right_extra: Texture2D
@export var face_button_down_extra: Texture2D
@export var face_button_left_extra: Texture2D

@export_category("Others")
## Corresponds to the Sony PS, Xbox Home button.
@export var guide_button: Texture2D
## Corresponds to Xbox share button, PS5 microphone button, Nintendo Switch capture button.
@export var misc1: Texture2D
## Game controller SDL touchpad button (the big button on PS5)
@export var touchpad: Texture2D
@export var paddle1: Texture2D
@export var paddle2: Texture2D
@export var paddle3: Texture2D
@export var paddle4: Texture2D
