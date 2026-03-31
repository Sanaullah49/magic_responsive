import 'package:flutter/widgets.dart';

/// A smart [Flex] that stays horizontal while each child has enough room and
/// collapses into a vertical stack when space gets tight.
///
/// The switch point is derived from [minChildWidth] and the number of children,
/// so most layouts do not need hard-coded screen breakpoints.
class MagicFlex extends StatelessWidget {
  /// The widgets to lay out.
  final List<Widget> children;

  /// The minimum width each child should get before the layout stacks.
  final double minChildWidth;

  /// Optional escape hatch for a fixed width threshold.
  final double? breakpoint;

  /// How the children should be placed along the main axis.
  final MainAxisAlignment mainAxisAlignment;

  /// How the children should be placed along the cross axis.
  final CrossAxisAlignment crossAxisAlignment;

  /// The gap between each child.
  final double spacing;

  /// The main axis size used while the layout is horizontal.
  final MainAxisSize mainAxisSize;

  /// The main axis size used while the layout is vertical.
  final MainAxisSize narrowMainAxisSize;

  /// Whether plain children should automatically expand to share horizontal
  /// space while the layout is wide.
  final bool expandChildrenWhenHorizontal;

  /// Duration used by the size animation when the layout changes.
  final Duration animationDuration;

  /// Curve used by the size animation when the layout changes.
  final Curve animationCurve;

  const MagicFlex({
    super.key,
    required this.children,
    this.minChildWidth = 280.0,
    this.breakpoint,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.spacing = 16.0,
    this.mainAxisSize = MainAxisSize.max,
    this.narrowMainAxisSize = MainAxisSize.min,
    this.expandChildrenWhenHorizontal = false,
    this.animationDuration = const Duration(milliseconds: 220),
    this.animationCurve = Curves.easeInOut,
  }) : assert(minChildWidth > 0),
       assert(spacing >= 0);

  @override
  Widget build(BuildContext context) {
    if (children.isEmpty) {
      return const SizedBox.shrink();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final direction = _resolveDirection(constraints);
        final arrangedChildren = _buildChildren(direction);

        return AnimatedSize(
          duration: animationDuration,
          curve: animationCurve,
          alignment: Alignment.topCenter,
          child: Flex(
            direction: direction,
            mainAxisAlignment: mainAxisAlignment,
            crossAxisAlignment: crossAxisAlignment,
            mainAxisSize: direction == Axis.horizontal
                ? mainAxisSize
                : narrowMainAxisSize,
            children: arrangedChildren,
          ),
        );
      },
    );
  }

  Axis _resolveDirection(BoxConstraints constraints) {
    if (children.length == 1) {
      return Axis.horizontal;
    }

    final availableWidth = constraints.maxWidth;
    if (!availableWidth.isFinite) {
      return Axis.horizontal;
    }

    if (breakpoint != null) {
      return availableWidth >= breakpoint! ? Axis.horizontal : Axis.vertical;
    }

    final gapCount = children.length > 1 ? children.length - 1 : 0;
    final totalSpacing = gapCount * spacing;
    final widthPerChild = (availableWidth - totalSpacing) / children.length;

    return widthPerChild >= minChildWidth ? Axis.horizontal : Axis.vertical;
  }

  List<Widget> _buildChildren(Axis direction) {
    final baseChildren =
        direction == Axis.horizontal && expandChildrenWhenHorizontal
        ? children.map((child) => Expanded(child: child)).toList()
        : children;

    if (spacing == 0 || baseChildren.length < 2) {
      return baseChildren;
    }

    final result = <Widget>[];
    for (var index = 0; index < baseChildren.length; index++) {
      result.add(baseChildren[index]);
      if (index == baseChildren.length - 1) {
        continue;
      }

      result.add(
        SizedBox(
          width: direction == Axis.horizontal ? spacing : 0,
          height: direction == Axis.vertical ? spacing : 0,
        ),
      );
    }
    return result;
  }
}
