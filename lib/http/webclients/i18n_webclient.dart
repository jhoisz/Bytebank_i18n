import 'dart:convert';

import '../webclient.dart';

const messagesUri =
    "https://gist.githubusercontent.com/jhoisz/1e324ecd83fe588f6018eef4629aed6f/raw/ac521cb0ba2a16c9ff280db5080394ffcf03057e/";

class I18NWebClient {
  final String viewKey;
  I18NWebClient({required this.viewKey});

  Future<Map<String, dynamic>?> findAll() async {
    try {
      final response = await client.get(Uri.parse("$messagesUri$viewKey.json"));

      final Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return decodedJson;
    } catch (e) {
      return null;
    }
  }
}
