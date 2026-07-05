import 'dart:ui';

import '../models/country.dart';

class FlagPainter {
  const FlagPainter._();

  static void paint(Canvas canvas, Rect rect, Country country) {
    final background = Paint()..color = const Color(0xFFFFFFFF);
    final border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = const Color(0xFF101820).withValues(alpha: 0.28);

    final roundedRect = RRect.fromRectAndRadius(rect, const Radius.circular(5));
    canvas.drawRRect(roundedRect, background);

    final paragraphStyle = ParagraphStyle(
      textAlign: TextAlign.center,
      fontSize: rect.height * 0.82,
      maxLines: 1,
    );
    final textStyle = TextStyle(
      fontSize: rect.height * 0.82,
      color: const Color(0xFF101820),
      fontWeight: FontWeight.w700,
    );
    final builder = ParagraphBuilder(paragraphStyle)
      ..pushStyle(textStyle)
      ..addText(country.flagEmoji);
    final paragraph = builder.build()
      ..layout(ParagraphConstraints(width: rect.width));

    canvas.save();
    canvas.clipRRect(roundedRect);
    canvas.drawParagraph(
      paragraph,
      Offset(rect.left, rect.top + (rect.height - paragraph.height) / 2),
    );
    canvas.restore();
    canvas.drawRRect(roundedRect, border);
  }
}
