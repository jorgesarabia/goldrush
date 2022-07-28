import 'package:flame/collisions.dart';
import 'package:flame/flame.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:goldrush/components/background.dart';
import 'package:goldrush/components/character.dart';
import 'package:goldrush/components/george.dart';
import 'package:goldrush/components/hud/hud.dart';
import 'package:goldrush/components/skeleton.dart';
import 'package:goldrush/components/zombie.dart';

void main() async {
  // Create an instance of the game
  final goldRush = GoldRush();

  // Setup Flutter widgets and start the game in full screen portrait orientation
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setPortrait();

  // Run the app, passing the games widget here
  runApp(GameWidget(game: goldRush));
}

class GoldRush extends FlameGame with HasCollisionDetection, HasDraggables, HasTappables {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    FlameAudio.bgm.initialize();
    await FlameAudio.audioCache.load('music/music.mp3');
    await FlameAudio.bgm.play('music/music.mp3');

    final hud = HudComponent();

    final george = George(
      position: Vector2(200, 400),
      size: Vector2(48.0, 48.0),
      speed: 40.0,
      hud: hud,
    );

    add(hud);
    add(Background(george));
    add(george);

    add(Zombie(position: Vector2(100, 200), size: Vector2(32.0, 64.0), speed: 20.0));
    add(Skeleton(position: Vector2(100, 600), size: Vector2(32.0, 64.0), speed: 60.0));

    add(ScreenHitbox());
  }

  @override
  void onRemove() {
    FlameAudio.bgm.stop();
    FlameAudio.audioCache.clearAll();
    super.onRemove();
  }

  @override
  void lifecycleStateChange(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.paused:
        children.forEach((component) {
          if (component is Character) {
            component.onPaused();
          }
        });
        break;
      case AppLifecycleState.resumed:
        children.forEach((component) {
          if (component is Character) {
            component.onResumed();
          }
        });
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }
}
