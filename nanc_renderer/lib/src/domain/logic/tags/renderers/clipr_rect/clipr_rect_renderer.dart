import 'package:flutter/material.dart';
import 'package:icons/icons.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:nanc_renderer/src/domain/logic/tags/documentation/documentation.dart';
import 'package:nanc_renderer/src/domain/logic/tags/renderers/clipr_rect/clipr_rect_arguments.dart';
import 'package:nanc_renderer/src/domain/logic/tags/renderers/property/mapper/properties_extractor.dart';
import 'package:nanc_renderer/src/domain/logic/tags/rich_renderer.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tag_description.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tag_renderer.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tools/widgets_compactor.dart';

const String _description = '''
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
    description: TagDescription(
      description: _description,
      arguments: [
        topLeftArg(),
        topRightArg(),
        bottomRightArg(),
        bottomLeftArg(),
        allArg(),
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
    builder: (BuildContext context, md.Element element, RichRenderer richRenderer) {
      final ClipRRectArguments arguments = ClipRRectArguments.fromJson(element.attributes);
      final PropertiesExtractor extractor = PropertiesExtractor(context: context, rawChildren: richRenderer.renderChildren(context, element.children));

      return ClipRRect(
        borderRadius: arguments.toBorderRadius(),
        child: compactWidgets(extractor.children),
      );
    },
  );
}
