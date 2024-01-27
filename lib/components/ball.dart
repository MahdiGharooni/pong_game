import 'dart:math' as math;
import 'dart:ui';
import 'dart:async' as dartAsync;

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/components/ai_paddle.dart';
import 'package:pong_game/components/player_paddle.dart';
import 'package:pong_game/components/score.dart';
import 'package:pong_game/helpers/constants.dart';
import 'package:pong_game/pong_game.dart';

class Ball extends CircleComponent
    with HasGameRef<PongGame>, CollisionCallbacks {
  Ball() {
    paint = Paint()..color = Colors.white;
    radius = 10;
  }

  double speed = initialSpeed;
  late Vector2 velocity;
  static const degree = math.pi / 180;

  @override
  Future<void> onLoad() {
    _resetBall;

    final hitBox = CircleHitbox(radius: radius);

    addAll([
      hitBox,
    ]);
    return super.onLoad();
  }

  @override
  void update(double dt) {
    super.update(dt);
    speed += (dt * 10);
    position += velocity * dt;
    print('speed is : $speed');
  }

  @override
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    final collisionPoint = intersectionPoints.first;
    Score score =
        gameRef.children.singleWhere((element) => element is Score) as Score;

    if (other is ScreenHitbox) {
      // left
      if (collisionPoint.x == 0) {
        score.rightScore++;
        dartAsync.Timer(const Duration(seconds: 1), () {
          _resetBall;
        });
      }
      // right
      if (collisionPoint.x == gameRef.size.x) {
        score.leftScore++;
        dartAsync.Timer(const Duration(seconds: 1), () {
          _resetBall;
        });
      }
      // top
      if (collisionPoint.y == 0) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
      // bottom
      if (collisionPoint.y == gameRef.size.y) {
        velocity.x = velocity.x;
        velocity.y = -velocity.y;
      }
    } else if (other is PlayerPaddle) {
      velocity.x = -velocity.x;
      velocity.y = velocity.y;
    } else if (other is AIPaddle) {
      velocity.x = -velocity.x;
      velocity.y = velocity.y;
    }
  }

  void get _resetBall {
    speed = initialSpeed;
    position = gameRef.size / 2;
    final spawnAngle = getSpawnAngle;
    final vx = math.cos(spawnAngle * degree) * speed;
    final vy = math.sin(spawnAngle * degree) * speed;
    velocity = Vector2(vx, vy);
  }

  double get getSpawnAngle {
    final sideToThrow = math.Random().nextBool();
    final random = math.Random().nextDouble();
    final spawnAngle = sideToThrow
        ? lerpDouble(-35, 35, random)!
        : lerpDouble(145, 215, random)!;
    return spawnAngle;
  }
}
