import 'dart:async';

import 'package:additions/src/rich_click_delegate/rich_click_handler.dart';
import 'package:flutter/material.dart';
import 'package:rich_renderer/rich_renderer.dart' as r;

class _RichClickDelegate {
  factory _RichClickDelegate({
    required BuildContext context,
    List<RichClickHandler> handlers = const [],
  }) =>
      _instance ??= _RichClickDelegate._(context: context, handlers: handlers);

  _RichClickDelegate._({
    required this.context,
    required this.handlers,
  });

  static _RichClickDelegate? _instance;

  final BuildContext context;
  final List<RichClickHandler> handlers;

  Future<void> handler(String argument) async {
    for (final handler in handlers) {
      final FutureOr<bool> canHandleRaw = handler.test(context, argument);
      bool canHandle = false;
      if (canHandleRaw is Future) {
        canHandle = await canHandleRaw;
      } else {
        canHandle = canHandleRaw;
      }
      if (canHandle) {
        // ignore: use_build_context_synchronously
        final FutureOr<void> resultRaw = handler.handler(context, argument);
        if (resultRaw is Future) {
          await resultRaw;
        }
      }
    }
  }
}

r.Action clickHandler({
  required BuildContext context,
  List<RichClickHandler> handlers = const [],
}) {
  final _RichClickDelegate delegate = _RichClickDelegate(context: context, handlers: handlers);
  return delegate.handler;
}
