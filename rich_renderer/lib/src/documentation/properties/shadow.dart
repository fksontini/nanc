import 'package:rich_renderer/src/documentation/arguments/decoration_arguments.dart';
import 'package:rich_renderer/src/documentation/arguments/scalar.dart';
import 'package:rich_renderer/src/tag_description.dart';

TagProperty shadowProp(String name) => TagProperty(
      name: name,
      arguments: [
        colorArg(),
        doubleArg('blurRadius'),
        doubleArg('spreadRadius'),
        doubleArg('offsetX'),
        doubleArg('offsetY'),
        blurStyleArg(),
      ],
      properties: [],
    );
