import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nanc_renderer/nanc_renderer.dart';
import 'package:tools/tools.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../../service/config/config.dart';
import '../../../../service/init/data_repository.dart';
import '../../../general/logic/model/menu_element.dart';
import '../../logic/bloc/editor/editor_bloc.dart';
import '../../logic/bloc/editor/editor_state.dart';

class ManualMenu extends StatelessWidget {
  const ManualMenu({
    super.key,
  });

  Widget menuItemBuilder(BuildContext context, int index, TagRenderer renderer) {
    return BlocBuilder<EditorBloc, EditorState>(
      builder: (BuildContext context, EditorState state) {
        final EditorBloc manualBloc = context.read<EditorBloc>();
        final MenuElement element = MenuElement(title: capitalize(renderer.tag), url: renderer.tag);
        final bool isActive = element == state.activeElement;

        return Padding(
          padding: EdgeInsets.only(top: index == 0 ? kPadding : 0, bottom: kPadding),
          child: KitMenuItem(
            text: element.title,
            icon: renderer.icon,
            onPressed: () async => manualBloc.selectTag(element, renderer),
            isActive: isActive,
          ),
        );
      },
    );
  }

  List<TagRenderer> tagRenderers(BuildContext context) {
    final DataRepository dataRepository = context.read();
    return dataRepository.renderers.where((TagRenderer renderer) => renderer.tag.startsWith('prop:') == false).toList();
  }

  @override
  Widget build(BuildContext context) {
    final List<TagRenderer> renderers = tagRenderers(context);

    return Material(
      type: MaterialType.transparency,
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => menuItemBuilder(
          context,
          index,
          renderers[index],
        ),
        itemCount: renderers.length,
      ),
    );
  }
}
