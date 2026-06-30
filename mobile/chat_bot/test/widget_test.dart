import 'package:flutter_test/flutter_test.dart';

import 'package:chat_bot/main.dart';

void main() {
  testWidgets('Chat app renders input', (WidgetTester tester) async {
    await tester.pumpWidget(const ChatBotApp());

    expect(find.text('Chat Bot'), findsOneWidget);
    expect(find.text('Type your message...'), findsOneWidget);
  });
}
