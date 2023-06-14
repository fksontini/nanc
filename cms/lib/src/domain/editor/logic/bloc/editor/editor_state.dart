import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:fields/fields.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nanc_renderer/nanc_renderer.dart';
import 'package:tools/tools.dart';

import '../../../../general/logic/model/menu_element.dart';

part 'editor_state.g.dart';

TagRenderer _rendererFrom(dynamic _) => TagRenderer.empty();

dynamic _rendererTo(dynamic _) => null;

@autoequal
@CopyWith()
@JsonSerializable()
class EditorState extends Equatable {
  const EditorState({
    required this.isLoading,
    required this.markdownContent,
    required this.contentType,
    required this.isSyncedWithFile,
    required this.activeElement,
    required this.activeTagRenderer,
  });

  factory EditorState.fromJson(dynamic json) => _$EditorStateFromJson(castToJson(json));

  factory EditorState.empty() => EditorState(
        isLoading: false,
        markdownContent: '',
        contentType: ScreenContentType.scrollable,
        isSyncedWithFile: false,
        activeElement: MenuElement.empty(),
        activeTagRenderer: TagRenderer.empty(),
      );

  final bool isLoading;
  final String markdownContent;
  final ScreenContentType contentType;
  final bool isSyncedWithFile;

  final MenuElement activeElement;

  @JsonKey(fromJson: _rendererFrom, toJson: _rendererTo)
  final TagRenderer activeTagRenderer;

  @override
  List<Object?> get props => _$props;

  Json toJson() => _$EditorStateToJson(this);
}
