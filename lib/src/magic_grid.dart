import 'dart:math' as math;

import 'package:flutter/widgets.dart';

/// A grid that derives its column count from the available width and a target
/// tile width.
class MagicGrid extends StatelessWidget {
  /// The preferred width for each tile.
  final double targetChildWidth;

  /// A floor that prevents tiles from becoming too narrow.
  final double minChildWidth;

  /// Deprecated alias kept for early adopters.
  final double? itemMinWidth;

  /// The spacing between items horizontally.
  final double crossAxisSpacing;

  /// The spacing between items vertically.
  final double mainAxisSpacing;

  /// The aspect ratio of each item (width / height).
  final double childAspectRatio;

  /// The widgets to display in the grid.
  final List<Widget> children;

  /// Optional cap on the number of columns.
  final int? maxColumns;

  /// Whether the grid should shrink-wrap its contents.
  final bool shrinkWrap;

  /// Scroll physics for the grid.
  final ScrollPhysics? physics;

  /// Optional padding applied around the grid.
  final EdgeInsetsGeometry? padding;

  const MagicGrid({
    super.key,
    this.targetChildWidth = 240.0,
    this.minChildWidth = 160.0,
    this.itemMinWidth,
    this.crossAxisSpacing = 12.0,
    this.mainAxisSpacing = 12.0,
    this.childAspectRatio = 1.0,
    required this.children,
    this.maxColumns,
    this.shrinkWrap = false,
    this.physics,
    this.padding,
  }) : assert(targetChildWidth > 0),
       assert(minChildWidth > 0),
       assert(crossAxisSpacing >= 0),
       assert(mainAxisSpacing >= 0),
       assert(childAspectRatio > 0),
       assert(maxColumns == null || maxColumns > 0);

  @override
  Widget build(BuildContext context) {
    final effectiveTargetWidth = itemMinWidth ?? targetChildWidth;

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _resolveCrossAxisCount(
          availableWidth: constraints.maxWidth,
          targetWidth: effectiveTargetWidth,
        );

        return GridView.builder(
          padding: padding,
          shrinkWrap: shrinkWrap,
          physics: physics,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: children.length,
          itemBuilder: (context, index) => children[index],
        );
      },
    );
  }

  int _resolveCrossAxisCount({
    required double availableWidth,
    required double targetWidth,
  }) {
    if (!availableWidth.isFinite) {
      return maxColumns ?? 1;
    }

    var count =
        ((availableWidth + crossAxisSpacing) / (targetWidth + crossAxisSpacing))
            .floor();
    count = math.max(1, count);

    if (maxColumns != null) {
      count = math.min(count, maxColumns!);
    }

    while (count > 1) {
      final itemWidth =
          (availableWidth - ((count - 1) * crossAxisSpacing)) / count;
      if (itemWidth >= minChildWidth) {
        break;
      }
      count -= 1;
    }

    return count;
  }
}
