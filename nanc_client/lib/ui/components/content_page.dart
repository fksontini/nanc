import 'package:additions/additions.dart';
import 'package:flutter/material.dart';
import 'package:nanc_renderer/nanc_renderer.dart';
import 'package:rich_renderer/rich_renderer.dart';
import 'package:tools/tools.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({
    required this.pageData,
    required this.content,
    required this.renderer,
    required this.preloader,
    super.key,
  });

  final Json pageData;
  final String content;
  final TagsRenderer renderer;
  final Widget preloader;

  @override
  Widget build(BuildContext context) {
    return XmlWidgetsSliverList(
      markdownContent: content,
      pageData: pageData,
      renderer: renderer,
      widgetsFilter: forWidgetFilter,
      imageLoadingBuilder: imageLoadingBuilder,
      imageErrorBuilder: imageErrorBuilder,
      imageFrameBuilder: imageFrameBuilder,
      preloader: preloader,
    );
  }
}
