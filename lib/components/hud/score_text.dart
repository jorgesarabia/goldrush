import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/palette.dart';
import 'package:flutter/cupertino.dart';

class ScoreText extends HudMarginComponent {
  ScoreText({
    super.margin,
  });

  int score = 0;
  String scoreText = "Score: ";
  late TextPaint _regularPaint;
  late TextComponent scoreTextComponent;

  @override
  Future<void> onLoad() async {
    super.onLoad();

    final textStyle = TextStyle(color: BasicPalette.blue.color, fontSize: 30.0);
    _regularPaint = TextPaint(style: textStyle);
    scoreTextComponent = TextComponent(text: scoreText + score.toString(), textRenderer: _regularPaint);

    add(scoreTextComponent);
  }

  void setScore(int score) {
    this.score += score;
    scoreTextComponent.text = scoreText + this.score.toString();
  }
}
