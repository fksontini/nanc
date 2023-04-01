import 'package:flutter/material.dart';
import 'package:icons/icons.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:nanc_renderer/src/domain/logic/tags/documentation/documentation.dart';
import 'package:nanc_renderer/src/domain/logic/tags/renderers/physical_model/physical_model_arguments.dart';
import 'package:nanc_renderer/src/domain/logic/tags/renderers/property/mapper/properties_extractor.dart';
import 'package:nanc_renderer/src/domain/logic/tags/renderers/property/mapper/properties_list.dart';
import 'package:nanc_renderer/src/domain/logic/tags/rich_renderer.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tag_description.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tag_renderer.dart';
import 'package:nanc_renderer/src/domain/logic/tags/tools/widgets_compactor.dart';

TagRenderer physicalModelRenderer() {
  return TagRenderer(
    icon: IconPack.mdi_box_shadow,
    tag: 'physicalModel',
    pattern: RegExp(r'<physicalModel.*>'),
    endPattern: RegExp('</physicalModel>'),
    description: TagDescription(
      description: '''
# [Physical Model](https://api.flutter.dev/flutter/widgets/PhysicalModel-class.html)

A widget representing a physical layer that clips its children to a shape.

Physical layers cast shadows based on an [elevation](widgets/PhysicalModel/elevation.html) which is nominally in logical pixels, coming vertically out of the rendering surface.

For shapes that cannot be expressed as a rectangle with rounded corners use [PhysicalShape](widgets/PhysicalShape-class.html).
''',
      arguments: [
        colorArg(),
        clipArg(),
        elevationArg(),
        colorArg('shadowColor'),
        shapeArg(),
      ],
      properties: [
        borderRadiusProp(),
      ],
    ),
    example: '''
<safeArea>
  <center>
  <physicalModel elevation="20" shape="circle">
    <prop:borderRadius all="0"/>
    <container width="100" height="100" color="#457FDA">
      <prop:decoration>
        <prop:borderRadius all="100"/>
      </prop:decoration>
    </container>
  </physicalModel>
  </center>
</safeArea>
''',
    builder: (BuildContext context, md.Element element, RichRenderer richRenderer) {
      final PhysicalModelArguments arguments = PhysicalModelArguments.fromJson(element.attributes);
      final PropertiesExtractor extractor = PropertiesExtractor(context: context, rawChildren: richRenderer.renderChildren(context, element.children));

      return PhysicalModel(
        color: arguments.color ?? Colors.transparent,
        borderRadius: extractor.getProperty(borderRadius),
        clipBehavior: arguments.clip ?? Clip.none,
        elevation: arguments.elevation ?? 0,
        shadowColor: arguments.shadowColor ?? Colors.black,
        shape: arguments.shape ?? BoxShape.rectangle,
        child: compactWidgets(extractor.children),
      );
    },
  );
}
