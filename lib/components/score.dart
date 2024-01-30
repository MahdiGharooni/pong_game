import 'dart:async';
import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';

class Score extends TextComponent with HasGameRef<FlameGame> {
  late int rightScore;
  late int leftScore;

  @override
  FutureOr<void> onLoad() {
    rightScore = 0;
    leftScore = 0;

    position.x = gameRef.size.x / 2;
    position.y = gameRef.size.y * 0.1;
    text= '$leftScore     $rightScore';

    return super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    text = '$leftScore     $rightScore';
    super.render(canvas);
  }
}
