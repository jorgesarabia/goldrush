import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'dart:ui';
import 'package:flame/palette.dart';
import 'package:flutter/material.dart';
import 'package:goldrush/components/george.dart';

class Background extends PositionComponent with Tappable {
  Background(this.george);

  final George george;

  static final backgroundPaint = BasicPalette.white.paint(); // The color of the background
  late double screenWidth, screenHeight;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Get the width and height of our screen canvas
    screenWidth = MediaQueryData.fromWindow(window).size.width;
    screenHeight = MediaQueryData.fromWindow(window).size.height;

    position = Vector2(0, 0);
    size = Vector2(screenWidth, screenHeight);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    canvas.drawRect(Rect.fromPoints(position.toOffset(), size.toOffset()), backgroundPaint);
  }

  @override
  bool onTapUp(TapUpInfo info) {
    george.moveToLocation(info);
    return true;
  }
}
