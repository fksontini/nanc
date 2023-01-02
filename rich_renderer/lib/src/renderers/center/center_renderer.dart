import 'package:flutter/material.dart';
import 'package:icons/icons.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:rich_renderer/rich_renderer.dart';
import 'package:rich_renderer/src/renderers/center/center_arguments.dart';
import 'package:rich_renderer/src/renderers/property/mapper/properties_extractor.dart';
import 'package:rich_renderer/src/tools/widgets_compactor.dart';

const String description = '''
# [Center](https://api.flutter.dev/flutter/widgets/Center-class.html)

A widget that centers its child within itself.

This widget will be as big as possible if its dimensions are constrained and [widthFactor](widgets/Align/widthFactor.html) and [heightFactor](widgets/Align/heightFactor.html) are null. If a dimension is unconstrained and the corresponding size factor is null then the widget will match its child's size in that dimension. If a size factor is non-null then the corresponding dimension of this widget will be the product of the child's dimension and the size factor. For example if widthFactor is 2.0 then the width of this widget will always be twice its child's width.
''';

TagRenderer centerRenderer() {
  return TagRenderer(
    icon: IconPack.flu_center_vertical_regular,
    tag: 'center',
    pattern: RegExp(r'<center.*>'),
    endPattern: RegExp('</center>'),
    description: const TagDescription(
      description: description,
      arguments: [
        TagArgument('heightFactor', {'double', 'null'}),
        TagArgument('widthFactor', {'double', 'null'}),
      ],
      properties: [],
    ),
    example: '''
<container width="300" height="300" color="#457FDA">
  <center widthFactor="1" heightFactor="1">
    <container width="100" height="100" color="#7BDA45">
    </container>
  </center>
</container>
''',
    builder: (BuildContext context, md.Element element, RichRenderer richRenderer) async {
      final CenterArguments arguments = CenterArguments.fromJson(element.attributes);
      final PropertiesExtractor extractor = PropertiesExtractor(context: context, rawChildren: await richRenderer.renderChildren(context, element.children));

      return Center(
        heightFactor: arguments.heightFactor,
        widthFactor: arguments.widthFactor,
        child: compactWidgets(extractor.children),
      );
    },
  );
}
