import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:magic_responsive/magic_responsive.dart';

void main() {
  Widget wrapForTest(Widget child) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Center(child: child),
    );
  }

  testWidgets('MagicFlex stays horizontal when there is enough room', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        SizedBox(
          width: 700,
          child: MagicFlex(
            minChildWidth: 280,
            children: const [
              SizedBox(height: 48, child: Text('One')),
              SizedBox(height: 48, child: Text('Two')),
            ],
          ),
        ),
      ),
    );

    final flex = tester.widget<Flex>(find.byType(Flex));
    expect(flex.direction, Axis.horizontal);
  });

  testWidgets('MagicFlex stacks vertically when width gets tight', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        SizedBox(
          width: 420,
          child: MagicFlex(
            minChildWidth: 260,
            children: const [
              SizedBox(height: 48, child: Text('One')),
              SizedBox(height: 48, child: Text('Two')),
            ],
          ),
        ),
      ),
    );

    final flex = tester.widget<Flex>(find.byType(Flex));
    expect(flex.direction, Axis.vertical);
  });

  testWidgets('MagicGrid derives a sensible column count', (tester) async {
    await tester.pumpWidget(
      wrapForTest(
        SizedBox(
          width: 760,
          child: MagicGrid(
            targetChildWidth: 220,
            children: List.generate(
              6,
              (index) => SizedBox(height: 64, child: Text('Item $index')),
            ),
          ),
        ),
      ),
    );

    final grid = tester.widget<GridView>(find.byType(GridView));
    final delegate =
        grid.gridDelegate as SliverGridDelegateWithFixedCrossAxisCount;

    expect(delegate.crossAxisCount, 3);
  });

  testWidgets('SmartContainer builds the adaptive container shell', (
    tester,
  ) async {
    await tester.pumpWidget(
      wrapForTest(
        const SizedBox(
          width: 1200,
          child: SmartContainer(
            maxWidth: 900,
            child: SizedBox(height: 80, child: Text('Content')),
          ),
        ),
      ),
    );

    final constrainedBox = tester.widget<ConstrainedBox>(
      find.byType(ConstrainedBox),
    );
    expect(constrainedBox.constraints.maxWidth, 900);
  });
}
