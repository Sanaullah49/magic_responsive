import 'package:flutter/widgets.dart';

/// Keeps content readable by capping line length and scaling side padding with
/// the available width.
class MagicContainer extends StatelessWidget {
  /// The maximum width the content should ever reach.
  final double maxWidth;

  /// Optional fixed padding. When omitted, adaptive padding is used.
  final EdgeInsetsGeometry? padding;

  /// The minimum horizontal padding used by the adaptive mode.
  final double minHorizontalPadding;

  /// The maximum horizontal padding used by the adaptive mode.
  final double maxHorizontalPadding;

  /// The vertical padding used by the adaptive mode.
  final double verticalPadding;

  /// The percentage of the available width reserved as side breathing room.
  final double sidePaddingFactor;

  /// The alignment of the constrained content inside the available space.
  final AlignmentGeometry alignment;

  final Widget child;

  const MagicContainer({
    super.key,
    this.maxWidth = 1100.0,
    this.padding,
    this.minHorizontalPadding = 16.0,
    this.maxHorizontalPadding = 48.0,
    this.verticalPadding = 20.0,
    this.sidePaddingFactor = 0.06,
    this.alignment = Alignment.topCenter,
    required this.child,
  }) : assert(maxWidth > 0),
       assert(minHorizontalPadding >= 0),
       assert(maxHorizontalPadding >= minHorizontalPadding),
       assert(verticalPadding >= 0),
       assert(sidePaddingFactor >= 0);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final resolvedPadding =
            padding ?? _adaptivePadding(constraints.maxWidth);

        return Align(
          alignment: alignment,
          child: Padding(
            padding: resolvedPadding,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: child,
            ),
          ),
        );
      },
    );
  }

  EdgeInsets _adaptivePadding(double availableWidth) {
    if (!availableWidth.isFinite) {
      return EdgeInsets.symmetric(
        horizontal: minHorizontalPadding,
        vertical: verticalPadding,
      );
    }

    final horizontal = (availableWidth * sidePaddingFactor).clamp(
      minHorizontalPadding,
      maxHorizontalPadding,
    );

    return EdgeInsets.symmetric(
      horizontal: horizontal.toDouble(),
      vertical: verticalPadding,
    );
  }
}

/// Alias for [MagicContainer] with a more intent-focused name.
class SmartContainer extends MagicContainer {
  const SmartContainer({
    super.key,
    super.maxWidth,
    super.padding,
    super.minHorizontalPadding,
    super.maxHorizontalPadding,
    super.verticalPadding,
    super.sidePaddingFactor,
    super.alignment,
    required super.child,
  });
}
