import 'dart:math';
import 'dart:ui';

import '../models/country.dart';

class FlagPainter {
  const FlagPainter._();

  static void paint(Canvas canvas, Rect rect, Country country) {
    final pattern = country.pattern;
    canvas.save();
    canvas.clipRRect(RRect.fromRectAndRadius(rect, const Radius.circular(5)));

    switch (pattern.layout) {
      case FlagLayout.vertical:
        _paintVertical(canvas, rect, pattern.colors);
      case FlagLayout.horizontal:
        _paintHorizontal(canvas, rect, pattern.colors);
      case FlagLayout.cross:
        _paintCross(canvas, rect, pattern);
      case FlagLayout.cantonStripes:
        _paintCantonStripes(canvas, rect, pattern);
    }

    if (country.code == 'dz') {
      _paintCrescentDot(
        canvas,
        rect,
        pattern.crossColor ?? const Color(0xFFD21034),
      );
    }
    if (country.code == 'ma' || country.code == 'tn') {
      _paintCenterStar(
        canvas,
        rect,
        pattern.starColor ?? const Color(0xFFFFFFFF),
      );
    }

    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = const Color(0xFF101820).withValues(alpha: 0.35);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(5)),
      border,
    );
    canvas.restore();
  }

  static void _paintVertical(Canvas canvas, Rect rect, List<Color> colors) {
    final paint = Paint();
    final stripeWidth = rect.width / colors.length;
    for (var i = 0; i < colors.length; i++) {
      paint.color = colors[i];
      canvas.drawRect(
        Rect.fromLTWH(
          rect.left + stripeWidth * i,
          rect.top,
          stripeWidth + 0.5,
          rect.height,
        ),
        paint,
      );
    }
  }

  static void _paintHorizontal(Canvas canvas, Rect rect, List<Color> colors) {
    final paint = Paint();
    final stripeHeight = rect.height / colors.length;
    for (var i = 0; i < colors.length; i++) {
      paint.color = colors[i];
      canvas.drawRect(
        Rect.fromLTWH(
          rect.left,
          rect.top + stripeHeight * i,
          rect.width,
          stripeHeight + 0.5,
        ),
        paint,
      );
    }
  }

  static void _paintCross(Canvas canvas, Rect rect, FlagPattern pattern) {
    final paint = Paint()..color = pattern.colors.first;
    canvas.drawRect(rect, paint);

    paint.color = pattern.starColor ?? const Color(0xFFFFFFFF);
    canvas.drawRect(
      Rect.fromCenter(
        center: rect.center,
        width: rect.width,
        height: rect.height * 0.38,
      ),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: rect.center,
        width: rect.width * 0.34,
        height: rect.height,
      ),
      paint,
    );

    paint.color = pattern.crossColor ?? const Color(0xFFC8102E);
    canvas.drawRect(
      Rect.fromCenter(
        center: rect.center,
        width: rect.width,
        height: rect.height * 0.2,
      ),
      paint,
    );
    canvas.drawRect(
      Rect.fromCenter(
        center: rect.center,
        width: rect.width * 0.18,
        height: rect.height,
      ),
      paint,
    );
  }

  static void _paintCantonStripes(
    Canvas canvas,
    Rect rect,
    FlagPattern pattern,
  ) {
    final stripeHeight = rect.height / 7;
    final paint = Paint();
    for (var i = 0; i < 7; i++) {
      paint.color = pattern.colors[i.isEven ? 0 : 1];
      canvas.drawRect(
        Rect.fromLTWH(
          rect.left,
          rect.top + stripeHeight * i,
          rect.width,
          stripeHeight + 0.5,
        ),
        paint,
      );
    }

    paint.color = pattern.cantonColor ?? const Color(0xFF3C3B6E);
    final canton = Rect.fromLTWH(
      rect.left,
      rect.top,
      rect.width * 0.48,
      rect.height * 0.54,
    );
    canvas.drawRect(canton, paint);

    paint.color = pattern.starColor ?? const Color(0xFFFFFFFF);
    for (var row = 0; row < 3; row++) {
      for (var col = 0; col < 4; col++) {
        canvas.drawCircle(
          Offset(
            canton.left + canton.width * (0.18 + col * 0.22),
            canton.top + canton.height * (0.22 + row * 0.28),
          ),
          1.2,
          paint,
        );
      }
    }
  }

  static void _paintCrescentDot(Canvas canvas, Rect rect, Color color) {
    final paint = Paint()..color = color;
    canvas.drawCircle(
      rect.center.translate(rect.width * 0.08, 0),
      rect.height * 0.24,
      paint,
    );
    paint.color = const Color(0xFFFFFFFF);
    canvas.drawCircle(
      rect.center.translate(rect.width * 0.15, 0),
      rect.height * 0.2,
      paint,
    );
    paint.color = color;
    canvas.drawCircle(
      rect.center.translate(rect.width * 0.28, 0),
      rect.height * 0.08,
      paint,
    );
  }

  static void _paintCenterStar(Canvas canvas, Rect rect, Color color) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = max(1.4, rect.height * 0.06)
      ..color = color;
    final path = Path();
    final center = rect.center;
    final radius = rect.height * 0.24;
    for (var i = 0; i < 6; i++) {
      final angle = -pi / 2 + i * 4 * pi / 5;
      final point = Offset(
        center.dx + cos(angle) * radius,
        center.dy + sin(angle) * radius,
      );
      if (i == 0) {
        path.moveTo(point.dx, point.dy);
      } else {
        path.lineTo(point.dx, point.dy);
      }
    }
    canvas.drawPath(path, paint);
  }
}
