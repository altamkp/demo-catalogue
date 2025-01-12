class_name Showroom
extends Node3D

signal pan_value_changed(value: float)
signal zoom_value_changed(value: float)

@export var near := 5.0
@export var far := 20.0

@onready var _camera_pivot: Node3D = $CameraPivot
@onready var _camera: Node3D = $CameraPivot/Camera3D

var pan_value: float:
    get: return fmod(rad_to_deg(_camera_pivot.rotation.y) + 360, 360)
    set(value): 
        _camera_pivot.rotation.y = deg_to_rad(value)
        pan_value_changed.emit(value)

var zoom_value: float:
    get: return (far - _camera.position.z) / (far - near)
    set(value): 
        _camera.position.z = far - (far - near) * value
        zoom_value_changed.emit(value)


func rotate_camera(delta_y: float):
    _camera_pivot.rotate_y(delta_y)
    pan_value_changed.emit(pan_value)


func zoom(delta: float):
    _camera.position = Vector3(0, 0, clamp(_camera.position.z - delta, near, far))
    zoom_value_changed.emit(zoom_value)
