import 'package:flutter_test/flutter_test.dart';
import 'package:hirehub/main.dart';

void main() {
  testWidgets('App renders HireHub title', (WidgetTester tester) async {
    await tester.pumpWidget(const HireHubApp());
    expect(find.text('HireHub'), findsOneWidget);
  });
}
