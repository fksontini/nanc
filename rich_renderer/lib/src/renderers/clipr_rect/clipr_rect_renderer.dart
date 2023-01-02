import 'package:flutter/material.dart';
import 'package:icons/icons.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:rich_renderer/rich_renderer.dart';
import 'package:rich_renderer/src/renderers/clipr_rect/clipr_rect_arguments.dart';
import 'package:rich_renderer/src/renderers/property/mapper/properties_extractor.dart';
import 'package:rich_renderer/src/tools/widgets_compactor.dart';

const String description = '''
# [Clipr Rect](https://api.flutter.dev/flutter/widgets/ClipRRect-class.html)

A widget that clips its child using a rounded rectangle.

By default, [ClipRRect](widgets/ClipRRect-class.html) uses its own bounds as the base rectangle for the clip, but the size and location of the clip can be customized using a custom [clipper](widgets/ClipRRect/clipper.html).
''';

TagRenderer clipRRectRenderer() {
  return TagRenderer(
    icon: IconPack.mdi_scissors_cutting,
    tag: 'clipRRect',
    pattern: RegExp(r'<clipRRect.*>'),
    endPattern: RegExp('</clipRRect>'),
    description: const TagDescription(
      description: description,
      arguments: [
        TagArgument('topLeft', {'double', 'null'}),
        TagArgument('topRight', {'double', 'null'}),
        TagArgument('bottomRight', {'double', 'null'}),
        TagArgument('bottomRight', {'double', 'null'}),
        TagArgument('bottomLeft', {'double', 'null'}),
        TagArgument('all', {'double', 'null'}),
      ],
      properties: [],
    ),
    example: '''
<container width="300" height="300" color="#457FDA">
  <center>
    <clipRRect topLeft="64" bottomRight="64">
      <container width="100" height="100" color="#7BDA45">
      </container>
    </clipRRect>
  </center>
</container>
''',
    builder: (BuildContext context, md.Element element, RichRenderer richRenderer) async {
      final ClipRRectArguments arguments = ClipRRectArguments.fromJson(element.attributes);
      final PropertiesExtractor extractor = PropertiesExtractor(context: context, rawChildren: await richRenderer.renderChildren(context, element.children));

      return ClipRRect(
        borderRadius: arguments.toBorderRadius(),
        child: compactWidgets(extractor.children),
      );
    },
  );
}
