class_name ShowroomCameraController
extends Control

@export var rotate_sensitivity := 0.01
@export var zoom_sensitivity := 0.50

var _is_pressed := false

@onready var _showroom: Showroom = $SubViewport/Showroom


func _gui_input(event: InputEvent):
    var button = event as InputEventMouseButton
    if button:
        match button.button_index:
            MOUSE_BUTTON_LEFT:
                _is_pressed = button.pressed
            MOUSE_BUTTON_WHEEL_DOWN:
                _showroom.zoom(-zoom_sensitivity)
            MOUSE_BUTTON_WHEEL_UP:
                _showroom.zoom(zoom_sensitivity)

    var motion = event as InputEventMouseMotion
    if motion and _is_pressed:
        _showroom.rotate_camera(-motion.relative.x * rotate_sensitivity)
