class_name Book
extends Node

@export var flip_time := 0.5

var _index := 0

@onready var _pages: Node = $Pages

@onready var _prev_button: Button = $Controls/PrevButton
@onready var _next_button: Button = $Controls/NextButton


func _ready():
    assert(_pages.get_child_count() > 0, "Book contains no pages")

    _prev_button.pressed.connect(_flip_prev_async)
    _next_button.pressed.connect(_flip_next_async)
    _update_control_buttons()


func _flip_prev_async():
    if _index <= 0:
        return

    var prev: Page = _get_page(_index - 1)
    prev.position = Vector2(-get_viewport().get_visible_rect().size.x, 0)
    prev.show()
    var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
    tween.tween_property(prev, "position:x", 0, flip_time)

    _index -= 1
    _update_control_buttons()
    await tween.finished


func _flip_next_async():
    if _index >= _pages.get_child_count() - 1:
        return
    
    var curr: Page = _get_page(_index)
    var tween := create_tween().set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_OUT)
    tween.tween_property(curr, "position:x", -get_viewport().get_visible_rect().size.x, flip_time)
    _index += 1
    _update_control_buttons()
    await tween.finished
    curr.hide()


func _get_page(index: int) -> Page:
    var corrected := _pages.get_child_count() - 1 - index
    return _pages.get_child(corrected) if index >= 0 and index < _pages.get_child_count() else null


func _update_control_buttons():
    _prev_button.disabled = _index <= 0
    _next_button.disabled = _index >= _pages.get_child_count() - 1
