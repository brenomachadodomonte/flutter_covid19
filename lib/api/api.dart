import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map> loadData() async {
  String url = 'https://brasil.io/api/dataset/covid19/caso/data/?place_type=state&is_last=True';

  http.Response response = await http.get(url);
  return json.decode(response.body);
}
