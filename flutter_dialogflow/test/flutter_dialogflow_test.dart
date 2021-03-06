import 'package:test/test.dart';

import 'package:flutter_dialogflow/flutter_dialogflow.dart';

void main() {
  test('Test Dialogflow', () async {
    Dialogflow dialogflow =
    Dialogflow(
        token: "Your Token",
        sessionId: "1234");
    AIResponse response = await dialogflow.sendQuery("hello world");
    if (response.getStatus.getCode != 200)
      expect(false, throwsNoSuchMethodError);
  });
}
