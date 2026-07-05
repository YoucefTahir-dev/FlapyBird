import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../flappy_quest_game.dart';

class PipePair extends PositionComponent
    with HasGameReference<FlappyQuestGame> {
  PipePair({
    required double x,
    required this.gapCenterY,
    required this.gapHeight,
    required this.pipeWidth,
  }) : super(position: Vector2(x, 0));

  final double gapCenterY;
  final double gapHeight;
  final double pipeWidth;
  bool scored = false;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    final topHeight = gapCenterY - gapHeight / 2;
    final bottomY = gapCenterY + gapHeight / 2;
    final bottomHeight = game.groundTop() - bottomY;

    add(_Pipe(size: Vector2(pipeWidth, topHeight), isTop: true));
    add(
      _Pipe(
        position: Vector2(0, bottomY),
        size: Vector2(pipeWidth, bottomHeight),
        isTop: false,
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.phase != GamePhase.playing) {
      return;
    }

    position.x -= game.worldSpeed * dt;

    if (!scored && position.x + pipeWidth < game.bird.position.x) {
      scored = true;
      game.addPoint();
    }

    if (position.x < -pipeWidth - 32) {
      removeFromParent();
    }
  }
}

class _Pipe extends PositionComponent {
  _Pipe({super.position, required super.size, required this.isTop});

  final bool isTop;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox()..collisionType = CollisionType.passive);
  }

  @override
  void render(Canvas canvas) {
    final pipePaint = Paint()..color = const Color(0xFF168A49);
    final shadePaint = Paint()..color = const Color(0xFF0E6B39);
    final lipPaint = Paint()..color = const Color(0xFF2ECC71);

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(6, 0, size.x - 12, size.y),
        const Radius.circular(8),
      ),
      pipePaint,
    );
    canvas.drawRect(Rect.fromLTWH(size.x - 18, 0, 8, size.y), shadePaint);

    final lipY = isTop ? size.y - 22 : 0.0;
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, lipY, size.x, 22),
        const Radius.circular(7),
      ),
      lipPaint,
    );
    canvas.drawRect(Rect.fromLTWH(size.x - 14, lipY, 7, 22), shadePaint);
  }
}
