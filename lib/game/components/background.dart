import 'dart:math';
import 'dart:ui';

import 'package:flame/components.dart';

class Background extends Component with HasGameReference {
  Background({required this.nightMode});

  final bool nightMode;

  final Paint _paint = Paint();

  @override
  void render(Canvas canvas) {
    final rect = Offset.zero & Size(game.size.x, game.size.y);
    final top = nightMode ? const Color(0xFF0B1026) : const Color(0xFF73D2F6);
    final bottom = nightMode
        ? const Color(0xFF1C2541)
        : const Color(0xFFE9F8A6);

    _paint.shader = Gradient.linear(rect.topCenter, rect.bottomCenter, [
      top,
      bottom,
    ]);
    canvas.drawRect(rect, _paint);
    _paint.shader = null;

    _drawCelestialBody(canvas);
    _drawHills(canvas);
    _drawClouds(canvas);
  }

  void _drawCelestialBody(Canvas canvas) {
    _paint.color = nightMode
        ? const Color(0xFFEAF2FF)
        : const Color(0xFFFFE066);
    canvas.drawCircle(
      Offset(game.size.x * 0.78, game.size.y * 0.16),
      34,
      _paint,
    );

    if (nightMode) {
      _paint.color = const Color(0xFFD6E6FF).withValues(alpha: 0.85);
      for (final star in const [
        Offset(38, 82),
        Offset(112, 150),
        Offset(246, 62),
        Offset(316, 190),
        Offset(58, 260),
      ]) {
        canvas.drawCircle(star, 2.2, _paint);
      }
    }
  }

  void _drawClouds(Canvas canvas) {
    if (nightMode) {
      return;
    }
    _paint.color = const Color(0xFFFFFFFF).withValues(alpha: 0.75);
    _cloud(canvas, Offset(game.size.x * 0.22, game.size.y * 0.18), 1);
    _cloud(canvas, Offset(game.size.x * 0.74, game.size.y * 0.32), 0.8);
  }

  void _cloud(Canvas canvas, Offset center, double scale) {
    canvas.drawOval(
      Rect.fromCenter(center: center, width: 104 * scale, height: 34 * scale),
      _paint,
    );
    canvas.drawCircle(
      center.translate(-32 * scale, -8 * scale),
      22 * scale,
      _paint,
    );
    canvas.drawCircle(
      center.translate(8 * scale, -17 * scale),
      29 * scale,
      _paint,
    );
    canvas.drawCircle(
      center.translate(42 * scale, -6 * scale),
      19 * scale,
      _paint,
    );
  }

  void _drawHills(Canvas canvas) {
    final base = game.size.y * 0.78;
    final path = Path()
      ..moveTo(0, base)
      ..quadraticBezierTo(
        game.size.x * 0.2,
        base - 52,
        game.size.x * 0.42,
        base,
      )
      ..quadraticBezierTo(game.size.x * 0.62, base + 38, game.size.x, base - 20)
      ..lineTo(game.size.x, game.size.y)
      ..lineTo(0, game.size.y)
      ..close();

    _paint.color = nightMode
        ? const Color(0xFF274060).withValues(alpha: 0.9)
        : const Color(0xFF6ABF69).withValues(alpha: 0.72);
    canvas.drawPath(path, _paint);

    _paint.color = nightMode
        ? const Color(0xFF1B2D45).withValues(alpha: 0.88)
        : const Color(0xFF3FA34D).withValues(alpha: 0.7);
    for (var i = 0; i < 8; i++) {
      final x = i * game.size.x / 7;
      canvas.drawCircle(Offset(x, base + 45 + sin(i) * 14), 56, _paint);
    }
  }
}
