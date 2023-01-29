import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

/// A component that renders the crate sprite, with a 16 x 16 size.
class Plant extends SpriteComponent {
  Plant() : super(size: Vector2.all(28));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('trees/36px-Maple_Stage_3.png');
  }
}

class Floor extends SpriteComponent {
  Floor() : super(size: Vector2.all(48));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('grid/120px-Flooring_29.png');
  }
}

// Game environement
class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    double pixels = 48;
    int x = 1;
    int y = 2;

    await add(PositionComponent(
      position: Vector2(pixels*x,pixels*y),
      children: [
        Floor(),
        Plant()
      ]
    ));
  }

  @override
  Color backgroundColor() => Colors.white;
}