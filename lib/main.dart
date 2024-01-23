import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:pong_game/pong_game.dart';

void main() {
  final game = PongGame();
  runApp(GameWidget(game: game));
}
