import 'dart:developer';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';

/// A component that renders the crate sprite, with a 16 x 16 size.
class Plant extends SpriteComponent {
  int stage;

  Plant({required this.stage}) : super(size: Vector2.all(28));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('trees/36px-Maple_Stage_3.png');
  }
}

class Floor extends SpriteComponent  with Tappable, Notifier{
  Floor() : super(size: Vector2.all(48));

  bool _beenPressed = false;

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('grid/120px-Flooring_29.png');
  }

  @override
  bool onTapUp(TapUpInfo info) {
    _beenPressed = false;
    return true;
  }

  @override
  bool onTapDown(_) {
    _beenPressed = true;
    return true;
  }

  @override
  bool onTapCancel() {
    _beenPressed = false;
    return true;
  }

}

// Game environement
class MyGame extends FlameGame with HasTappables {

  int _currentIndex = 0;
  final int _offsetX = 10;
  final int _offsetY = 128;
  final double _pixels = 49;
  final int _size = 8;

  Future<void> _generateFloor() async {
    for(int x=0; x<_size; x++) {
      for(int y=0;y<_size;y++) {
        await add(PositionComponent(
          position: Vector2(_offsetX+_pixels*x, _offsetY+_pixels*y),
            children: [
              Floor(),
            ]
        ));
      }
    }
  }

  @override
    Future<void> onLoad() async {
      await _generateFloor();
  }

  @override
  Color backgroundColor() => const Color(0xfff6dcc1);

  void create() {
    int currentX = _currentIndex%_size;
    int currentY = _currentIndex~/_size;
    add(PositionComponent(
        position: Vector2(_offsetX+_pixels*currentX, _offsetY+_pixels*currentY),
        children: [
          Plant(stage: 1),
        ]
    ));

    _currentIndex++;
  }
}