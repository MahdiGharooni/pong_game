import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/helpers/constants.dart';
import 'package:pong_game/helpers/utils.dart';

class PlayerPaddle extends PositionComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  late final RectangleHitbox paddleHitBox;
  late final RectangleComponent paddle;
  KeyEventEnum keyPressed = KeyEventEnum.none;

  @override
  FutureOr<void> onLoad() {
    final worldRect = gameRef.size.toRect();

    size = Vector2(10, 100);
    position.x = worldRect.width * 0.9 - 10;
    position.y = worldRect.height / 2 - size.y / 2;
    paddle = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.blue,
    );
    paddleHitBox = RectangleHitbox(
      size: size,
    );

    final KeyboardListenerComponent keyboardListenerComponent =
        KeyboardListenerComponent(
      keyDown: {
        LogicalKeyboardKey.arrowDown: (keysPressed) {
          keyPressed = KeyEventEnum.down;
          return true;
        },
        LogicalKeyboardKey.arrowUp: (keysPressed) {
          keyPressed = KeyEventEnum.up;
          return true;
        },
      },
      keyUp: {
        LogicalKeyboardKey.arrowDown: (keysPressed) {
          keyPressed = KeyEventEnum.none;
          return true;
        },
        LogicalKeyboardKey.arrowUp: (keysPressed) {
          keyPressed = KeyEventEnum.none;
          return true;
        },
      },
    );

    addAll([
      paddle,
      paddleHitBox,
      keyboardListenerComponent,
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (keyPressed == KeyEventEnum.down) {
      final updatedPosition = position.y + initialSpeed * dt;
      if (updatedPosition < gameRef.size.y - paddle.height) {
        position.y = updatedPosition;
      }
    } else if (keyPressed == KeyEventEnum.up) {
      final updatePosition = position.y - initialSpeed * dt;
      if (updatePosition > 0) {
        position.y = updatePosition;
      }
    }
  }
}
