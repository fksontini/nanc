import 'package:flutter/cupertino.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:markdown_code_push_core/markdown_code_push_core.dart';
import 'package:rich_renderer/rich_renderer.dart';
import 'package:rich_renderer/src/logic/substitutor.dart';
import 'package:tools/tools.dart';

WidgetConfig createRichWidgetConfig({
  required BuildContext context,
  required RichRenderer richRenderer,
}) {
  return WidgetConfig(
    custom: richRenderer.builders.map(
      (Tag tag, TagRenderer renderer) => MapEntry(
        tag,
        (md.Element node) {
          final md.Element newNode = Substitutor.enrichElement(context: context, node: node);
          // ignore: use_build_context_synchronously
          final Widget? child = renderer.builder(context, newNode, richRenderer);
          if (child != null) {
            return child;
          }
          return null;
        },
      ),
    ),
  );
}
