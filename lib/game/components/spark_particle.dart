import 'dart:ui';

import 'package:flame/components.dart';

class SparkParticle extends PositionComponent {
  SparkParticle({
    required Vector2 origin,
    required this.velocity,
    required this.color,
  }) : life = 0.75,
       super(position: origin, size: Vector2.all(7), anchor: Anchor.center);

  final Vector2 velocity;
  final Color color;
  double life;

  @override
  void update(double dt) {
    super.update(dt);
    life -= dt;
    velocity.y += 460 * dt;
    position += velocity * dt;
    angle += dt * 8;

    if (life <= 0) {
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final paint = Paint()..color = color.withValues(alpha: life.clamp(0, 1));
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromCenter(center: Offset.zero, width: size.x, height: size.y),
        const Radius.circular(2),
      ),
      paint,
    );
  }
}
