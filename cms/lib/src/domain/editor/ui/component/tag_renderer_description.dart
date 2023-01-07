import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:rich_renderer/rich_renderer.dart';
import 'package:ui_kit/ui_kit.dart';

class TagRendererDescription extends StatelessWidget {
  const TagRendererDescription({
    required this.tagName,
    required this.withChildren,
    required this.description,
    super.key,
  });

  final String tagName;
  final bool withChildren;
  final TagDescription description;

  List<String> buildArgumentCode(String tagName, TagArgument argument) {
    final List<String> exampleCode = [
      '<$tagName ${argument.name}="${argument.values.join(' | ')}" ..... ',
    ];
    if (withChildren) {
      exampleCode[0] = '${exampleCode.last}>';
      exampleCode.addAll([
        if (description.properties.isNotEmpty) '  <!-- Properties -->',
        '  <!-- Children / child widgets -->',
        '</$tagName>',
      ]);
    } else {
      exampleCode[0] = '${exampleCode.last}/>';
    }
    return exampleCode;
  }

  Widget buildArgument(String tagName, TagArgument argument) {
    final List<String> exampleCode = buildArgumentCode(tagName, argument);

    return Padding(
      padding: const EdgeInsets.only(bottom: Gap.large),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: Gap.regular),
            child: MarkdownBody(
              data: '### **${argument.name}**',
            ),
          ),
          if (argument.description.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.regular),
              child: MarkdownBody(
                data: argument.description,
              ),
            ),
          HighlightView(
            exampleCode.join('\n'),
            language: 'html',
            theme: githubTheme,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  List<String> buildPropertyCode(String parentTagName, TagProperty property, [int level = 0]) {
    final List<String> exampleCode = [
      '<$parentTagName ..... >',
    ];
    final List<String> propertyArgumentsCode = [];

    for (final TagArgument argument in property.arguments) {
      propertyArgumentsCode.addAll([
        '${argument.name}="${argument.values.join(' | ')}"',
      ]);
    }

    exampleCode.addAll([
      '  <prop:${property.name} ${propertyArgumentsCode.join(' ')}${property.withChildren ? '>' : '/>'}',
    ]);

    if (property.withChildren) {
      exampleCode.addAll([
        '    <!-- Children properties -->',
        '  </prop:${property.name}>',
        '</$parentTagName>',
      ]);
    } else {
      exampleCode.addAll([
        '</$parentTagName>',
      ]);
    }

    return exampleCode;
  }

  List<Widget> buildProperty(String tagName, TagProperty property, [String parentPropertyName = '']) {
    final List<Widget> result = [];
    result.add(
      Padding(
        padding: const EdgeInsets.only(bottom: Gap.large),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: Gap.regular),
              child: MarkdownBody(
                data: '### ${parentPropertyName.isEmpty ? '' : '**$parentPropertyName** - '}**${property.name}**',
              ),
            ),
            if (property.description.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: Gap.regular),
                child: MarkdownBody(
                  data: property.description,
                ),
              ),
            HighlightView(
              buildPropertyCode(tagName, property).join('\n'),
              language: 'html',
              theme: githubTheme,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
    for (final TagProperty childProperty in property.properties) {
      result.addAll(buildProperty('prop:${property.name}', childProperty, property.name));
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        /// ? DESCRIPTION
        MarkdownBody(
          data: description.description,
        ),

        /// ? ARGUMENTS
        if (description.arguments.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(top: Gap.large, bottom: Gap.large),
            child: MarkdownBody(
              data: '''
## Arguments

An argument is a widget parameter or a widget property. The argument value specifies the type of value to accept, or lists the possible values in case only they can be used.

Most of the Arguments are optional and may be omitted, unless otherwise stated.

For example:

```
<widget argumentName="argumentValue" ..... >
  <!-- Something else -->
</widget>
```

**"....."** means the rest of arguments of the widget
''',
            ),
          ),
        for (final TagArgument argument in description.arguments) buildArgument(tagName, argument),

        /// ? PROPERTIES
        if (description.properties.isNotEmpty)
          const Padding(
            padding: EdgeInsets.only(top: Gap.large, bottom: Gap.large),
            child: MarkdownBody(
              data: '''
## Properties

A property is a more complex type of argument for widgets (or other properties). If the widget parameter to be configured is not a scalar type or enum, but a class - then it forms a property parameter.

All the Properties are optional and may be omitted.

For example:

```
<widget ..... >
  <prop:propertyWithoutChildrenProperties ..... />
  <prop:propertyWithChildrenProperties ..... >
    <prop:childProperty ..... />
    <prop:anotherChildProperty ..... >
      <!-- etc. -->
    </prop:anotherChildProperty>
  </prop:propertyWithChildrenProperties>
</widget>
```

**"....."** means the rest of arguments of the widget or property
''',
            ),
          ),
        for (final TagProperty property in description.properties) ...buildProperty(tagName, property),
      ],
    );
  }
}