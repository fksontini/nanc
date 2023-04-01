import 'package:flutter/material.dart';
import 'package:icons/icons.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:nanc_renderer/src/domain/logic/tags/documentation/documentation.dart';
import 'package:nanc_renderer/src/domain/logic/tags/renderers/placeholder/placeholder_arguments.dart';
import 'package:nanc_renderer/src/domain/logic/tags/rich_renderer.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tag_description.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tag_renderer.dart';

TagRenderer placeholderRenderer() {
  return TagRenderer(
    icon: IconPack.flu_border_all_regular,
    tag: 'placeholder',
    pattern: RegExp(r'<placeholder.*/>'),
    endPattern: null,
    description: TagDescription(
      description: '''
# [Placeholder](https://api.flutter.dev/flutter/widgets/Placeholder-class.html)

A widget that draws a box that represents where other widgets will one day be added.

This widget is useful during development to indicate that the interface is not yet complete.

By default, the placeholder is sized to fit its container. If the placeholder is in an unbounded space, it will size itself according to the given [fallbackWidth](widgets/Placeholder/fallbackWidth.html) and [fallbackHeight](widgets/Placeholder/fallbackHeight.html).
''',
      arguments: [
        colorArg(),
        heightArg(),
        widthArg(),
        strokeWidthArg(),
        stringArg('text'),
      ],
      properties: [],
    ),
    example: '''
<safeArea>
  <center>
    <placeholder/>
  </center>
</safeArea>
''',
    builder: (BuildContext context, md.Element element, RichRenderer richRenderer) {
      final PlaceholderArguments arguments = PlaceholderArguments.fromJson(element.attributes);

      return Placeholder(
        color: arguments.color ?? Colors.black,
        fallbackHeight: arguments.height ?? 400,
        fallbackWidth: arguments.width ?? 400,
        strokeWidth: arguments.strokeWidth ?? 2,
        child: arguments.hasText ? Center(child: Text(arguments.text!)) : null,
      );
    },
  );
}
