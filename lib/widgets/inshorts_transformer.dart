import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:flutter/material.dart';

class InShortsTransformer extends PageTransformer {
  InShortsTransformer() : super(reverse: false);

  @override
  Widget transform(Widget child, TransformInfo info) {
    double position = info.position ?? 0;

    if (position <= 0) {
      const double MIN_SCALE = 0.75;
      // Scale the page down (between MIN_SCALE and 1)
      double scaleFactor = MIN_SCALE + (1 - MIN_SCALE) * (1 + position);

      return Opacity(
        opacity: 1.0 + position,
        child: Transform.translate(
          offset:  Offset(0.0, -position * (info.height ?? 0)),
          child: Transform.scale(
            scale: scaleFactor,
            child: child,
          ),
        ),
      );
    } else if (position <= 1) {
      return Opacity(
        opacity: 1.0,
        child: Transform.translate(
          offset: const Offset(0.0, 0.0),
          child: Transform.scale(
            scale: 1.0,
            child: child,
          ),
        ),
      );
    }

    return child;
  }
}