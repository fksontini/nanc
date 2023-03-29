import 'dart:isolate';

import 'package:xml/xml.dart';

Future<XmlDocument> parse(String xml) async => Isolate.run(() => parseSync(xml));

XmlDocument parseSync(String xml) => XmlDocument.parse(_prepareXml(xml));

String _prepareXml(String html) {
  return '''
<?xml version="1.0"?>
<root>
  $html
</root>
''';
}
