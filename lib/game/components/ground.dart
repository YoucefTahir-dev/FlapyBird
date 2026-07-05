import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../flappy_quest_game.dart';

class Ground extends PositionComponent with HasGameReference<FlappyQuestGame> {
  Ground({required this.topY});

  final double topY;
  double scroll = 0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    position = Vector2(0, topY);
    size = Vector2(game.size.x, game.size.y - topY);
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.phase == GamePhase.playing) {
      scroll = (scroll + game.worldSpeed * dt) % 48;
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = const Color(0xFF7AC943);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, size.y), paint);

    paint.color = const Color(0xFF4F9D42);
    canvas.drawRect(Rect.fromLTWH(0, 0, size.x, 10), paint);

    paint.color = const Color(0xFFB0843E);
    for (double x = -48 - scroll; x < size.x + 48; x += 48) {
      canvas.drawRect(Rect.fromLTWH(x, 26, 28, 8), paint);
      canvas.drawRect(Rect.fromLTWH(x + 18, 52, 24, 7), paint);
    }
  }
}
