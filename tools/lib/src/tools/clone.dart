import 'dart:convert';

import 'package:tools/tools.dart';

// TODO(alphamikle): Make it faster, not by using json logic
Json clone(Json json) {
  return jsonDecode(jsonEncode(json)) as Json;
}
