import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/components/ball.dart';
import 'package:pong_game/helpers/constants.dart';

class AIPaddle extends PositionComponent
    with HasGameRef<FlameGame>, CollisionCallbacks {
  late final RectangleHitbox paddleHitBox;
  late final RectangleComponent paddle;

  @override
  FutureOr<void> onLoad() {
    final worldRect = gameRef.size.toRect();

    size = Vector2(10, 100);
    position.x = worldRect.width * 0.1;
    position.y = worldRect.height / 2 - size.y / 2;
    paddle = RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.red,
    );
    paddleHitBox = RectangleHitbox(
      size: size,
    );

    addAll([
      paddle,
      paddleHitBox,
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    final ball =
        gameRef.children.singleWhere((element) => element is Ball) as Ball;

    final ballPositionWrtPaddleHeight = ball.y + (size.y);
    final isOutOfBounds =
        ballPositionWrtPaddleHeight > gameRef.size.y || ball.y < 0;
    final updatedPosition = ball.y;

    if (!isOutOfBounds) {
      if (ball.y > position.y) {
        position.y += ((initialSpeed - 40) * dt);
      }

      if (ball.y < position.y) {
        position.y -= ((initialSpeed - 40) * dt);
      }
    }

    super.update(dt);
  }
}
