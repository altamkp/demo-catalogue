class_name ShowroomPage
extends Page

@export_group("Components")
@export var _showroom: Showroom
@export var _pan_slider: Slider
@export var _zoom_slider: Slider


func _ready():
    _pan_slider.value = _showroom.pan_value
    _zoom_slider.value = _showroom.zoom_value
    _showroom.pan_value_changed.connect(func(value): _pan_slider.value = value)
    _showroom.zoom_value_changed.connect(func(value): _zoom_slider.value = value)

    _pan_slider.value_changed.connect(func(value): _showroom.pan_value = value)
    _zoom_slider.value_changed.connect(func(value): _showroom.zoom_value = value)
