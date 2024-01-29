import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong_game/components/ai_paddle.dart';
import 'package:pong_game/components/ball.dart';
import 'package:pong_game/components/player_paddle.dart';
import 'package:pong_game/components/score.dart';

class PongGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {

  int rightScore = 0;
  int leftScore = 0;

  @override
  FutureOr<void> onLoad() {
    addAll([
      ScreenHitbox(),
      PlayerPaddle(),
      AIPaddle(),
      Ball(),
      Score(),
    ]);
    return super.onLoad();
  }

  @override
  KeyEventResult onKeyEvent(
      RawKeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    super.onKeyEvent(event, keysPressed);

    return KeyEventResult.handled;
  }
}
