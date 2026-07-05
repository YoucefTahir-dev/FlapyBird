import 'dart:math';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../flappy_quest_game.dart';
import '../flag_painter.dart';
import '../../models/country.dart';

class Bird extends PositionComponent
    with CollisionCallbacks, HasGameReference<FlappyQuestGame> {
  Bird({
    required Vector2 startPosition,
    required this.skinIndex,
    required this.country,
  }) : _startPosition = startPosition.clone(),
       super(
         position: startPosition,
         size: Vector2(46, 36),
         anchor: Anchor.center,
       );

  final Vector2 _startPosition;
  int skinIndex;
  Country? country;
  double velocityY = 0;
  double wingTime = 0;

  static const double gravity = 930;
  static const double flapVelocity = -340;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(
      CircleHitbox.relative(0.72, parentSize: size)
        ..collisionType = CollisionType.active,
    );
  }

  @override
  void update(double dt) {
    super.update(dt);
    wingTime += dt * 12;

    if (game.phase == GamePhase.playing) {
      velocityY += gravity * dt;
      position.y += velocityY * dt;
      angle = (velocityY / 620).clamp(-0.55, 0.85);

      if (position.y < 24) {
        position.y = 24;
        velocityY = 0;
      }
      if (position.y > game.groundTop() - size.y * 0.45) {
        game.endGame();
      }
    } else if (game.phase == GamePhase.menu) {
      position.y = _startPosition.y + sin(wingTime * 0.45) * 10;
      angle = sin(wingTime * 0.35) * 0.08;
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final colors = _skinColors();
    final body = Paint()..color = colors.body;
    final wing = Paint()..color = colors.wing;
    final beak = Paint()..color = const Color(0xFFFFA62B);
    final white = Paint()..color = const Color(0xFFFFFFFF);
    final black = Paint()..color = const Color(0xFF101820);

    canvas.drawOval(Rect.fromLTWH(2, 3, size.x - 8, size.y - 6), body);
    _paintCountryMotif(canvas);
    canvas.drawCircle(Offset(size.x * 0.68, size.y * 0.35), 8, white);
    canvas.drawCircle(Offset(size.x * 0.72, size.y * 0.35), 3.4, black);

    final beakPath = Path()
      ..moveTo(size.x - 3, size.y * 0.48)
      ..lineTo(size.x + 15, size.y * 0.39)
      ..lineTo(size.x - 2, size.y * 0.58)
      ..close();
    canvas.drawPath(beakPath, beak);

    final wingOffset = sin(wingTime) * 4;
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.x * 0.36, size.y * 0.58 + wingOffset),
        width: 22,
        height: 15,
      ),
      wing,
    );
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    game.endGame();
  }

  void flap() {
    velocityY = flapVelocity;
  }

  void reset({
    required Vector2 position,
    required int skinIndex,
    required Country? country,
  }) {
    this.position = position;
    this.skinIndex = skinIndex;
    this.country = country;
    velocityY = 0;
    angle = 0;
  }

  void _paintCountryMotif(Canvas canvas) {
    final selectedCountry = country;
    if (selectedCountry == null) {
      return;
    }
    final flagRect = Rect.fromLTWH(size.x * 0.16, size.y * 0.24, 22, 14);
    FlagPainter.paint(canvas, flagRect, selectedCountry);
  }

  _BirdColors _skinColors() {
    return switch (skinIndex) {
      1 => const _BirdColors(Color(0xFF56CCF2), Color(0xFF2F80ED)),
      2 => const _BirdColors(Color(0xFFFF6B6B), Color(0xFFFFD166)),
      _ => const _BirdColors(Color(0xFFFFD166), Color(0xFFEF476F)),
    };
  }
}

class _BirdColors {
  const _BirdColors(this.body, this.wing);

  final Color body;
  final Color wing;
}
