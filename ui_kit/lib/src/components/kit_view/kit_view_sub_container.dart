import 'package:flutter/material.dart';
import 'package:tools/tools.dart';

class KitViewSubContainer extends StatelessWidget {
  const KitViewSubContainer({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.theme.colorScheme.background,
      child: child,
    );
  }
}
