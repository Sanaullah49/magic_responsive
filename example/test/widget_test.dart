import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('demo screen renders package messaging', (tester) async {
    await tester.pumpWidget(const MagicApp());

    expect(find.text('magic_responsive'), findsOneWidget);
    expect(
      find.textContaining('Responsive layouts that adapt to the space'),
      findsOneWidget,
    );
  });
}
