import 'package:flutter_test/flutter_test.dart';
import 'package:newsfeed/main.dart';

void main() {
  testWidgets('App starts and shows Home Screen', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsFeedApp());
    expect(find.text('THE DAILY CHRONICLE'), findsOneWidget);
  });

  testWidgets('Bottom navigation bar is present', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsFeedApp());
    expect(find.text('HOME'), findsOneWidget);
    expect(find.text('SECTIONS'), findsOneWidget);
    expect(find.text('SAVED'), findsOneWidget);
    expect(find.text('PROFILE'), findsOneWidget);
  });

  testWidgets('Category chips are visible', (WidgetTester tester) async {
    await tester.pumpWidget(const NewsFeedApp());
    await tester.pump();
    expect(find.text('Home'), findsOneWidget);
    expect(find.text('World'), findsOneWidget);
    expect(find.text('Arts'), findsOneWidget);
    expect(find.text('Science'), findsOneWidget);
  });
}
