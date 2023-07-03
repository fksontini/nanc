import 'dart:async';

import 'package:cms/cms.dart';
import 'package:config/config.dart';
import 'package:flutter/material.dart';
import 'package:icons/icons.dart';
import 'package:model/model.dart';
import 'package:tools/tools.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../../../service/tools/complex_title_tools.dart';
import '../../logic/selector_field/selector_field.dart';
import '../../logic/selector_field/title_fields.dart';
import '../field_cell_mixin.dart';

const String kLoadingText = 'Loading...';

class SelectorFieldCell extends FieldCellWidget<SelectorField> {
  const SelectorFieldCell({
    required super.field,
    required super.creationMode,
    super.key,
  });

  @override
  State<SelectorFieldCell> createState() => _SelectorFieldCellState();
}

class _SelectorFieldCellState extends State<SelectorFieldCell> with FieldCellHelper<SelectorField, SelectorFieldCell> {
  String get eventBusId => [
        runtimeType.toString(),
        model.id,
        model.idField.id,
        ...titleFields.toFieldsIds(),
      ].join();

  String get virtualField => widget.field.virtualField;

  List<TitleField> get titleFields => field.titleFields;

  Model get model => field.model;
  late final EventBus eventBus = read();
  bool isPreloading = false;
  final StreamController<bool> isLoadingFullPageData = StreamController.broadcast();
  bool isError = false;

  Future<List<Json>> finder(String searchQuery) async {
    isLoadingFullPageData.add(true);
    try {
      final ICollectionProvider entityListProvider = read();
      final List<String> values = splitComplexTitle(
        query: searchQuery,
        titleFields: field.titleFields,
      ).where((String value) => value.trim().isNotEmpty).toList();
      final List<QueryValueField> queryValues = [];
      final List<String> titleFieldsIds = field.titleFields.toFieldsIds();

      for (final String titleFieldId in titleFieldsIds) {
        for (final String value in values) {
          queryValues.add(
            QueryValueField(
              fieldId: titleFieldId,
              value: value,
              type: QueryFieldType.contains,
            ),
          );
        }
      }

      final CollectionResponseDto result = await entityListProvider.fetchPageList(
        model: model,
        subset: [
          model.idField.id,
          ...titleFields.toFieldsIds(),
        ],
        query: QueryOrField(fields: queryValues),
        params: ParamsDto(
          page: 1,
          limit: 50,
          sort: Sort(
            fieldId: model.idField.id,
            order: Order.asc,
          ),
        ),
      );
      if (isError) {
        safeSetState(() => isError = false);
      }
      isLoadingFullPageData.add(false);
      return result.data;
    } catch (error) {
      isLoadingFullPageData.add(false);
      safeSetState(() {
        isPreloading = false;
        isError = true;
      });
      throw error.toHumanException('Related data loading failed!');
    }
  }

  Future<void> updateValue(Json json) async {
    final String pageId = json[field.model.idField.id].toString();
    final List<String> titleSegments = titleFields.toTitleSegments(json);
    final String title = titleSegments.join();
    pageBloc.updateValue(fieldId, pageId);
    controller.text = title;
    unawaited(updateVirtualField(pageId));
  }

  Widget itemBuilder(BuildContext context, Json data) {
    bool isSelected = false;
    final dynamic dataId = data[field.model.idField.id];
    final dynamic value = pageBloc.valueForKey(fieldId);
    if (value != null) {
      isSelected = value == dataId;
    }

    final String title = titleFields.toTitleSegments(data).join();

    return KitListTile(
      title: title,
      isSelected: isSelected,
    );
  }

  Future<void> saveEventHandler(Model entity) async {
    if (mounted) {
      await preload();
    }
  }

  Future<void> preload() async {
    safeSetState(() => isPreloading = true);
    try {
      controller.text = kLoadingText;
      final String? pageId = pageBloc.valueForKey(fieldId) as String?;
      if (pageId == null) {
        controller.clear();
        safeSetState(() => isPreloading = false);
        return;
      }
      final Json data = await read<IPageProvider>().fetchPageData(
        model: model,
        id: pageId,
        subset: [
          model.idField.id,
          ...titleFields.toFieldsIds(),
        ],
      );
      final String title = titleFields.toTitleSegments(data).join();
      controller.text = title;
      if (mounted) {
        safeSetState(() => isPreloading = false);
        unawaited(updateVirtualField(pageId));
      }
    } catch (error) {
      safeSetState(() {
        isPreloading = false;
        isError = true;
      });
      throw error.toHumanException('Related data loading failed!');
    }
  }

  Future<void> updateVirtualField(String pageId) async {
    isLoadingFullPageData.add(true);
    try {
      final Json? data = await safeRead<PageBloc>()?.loadPageData(model: model, pageId: pageId);
      safeRead<PageBloc>()?.updateValue(virtualField, data);
      isLoadingFullPageData.add(false);
    } catch (error) {
      isLoadingFullPageData.add(false);
      throw error.toHumanException('Virtual field data loading failed!');
    }
  }

  Future<void> clearField() async {
    controller.text = '';
    safeRead<PageBloc>()?.updateValue(fieldId, null);
    safeRead<PageBloc>()?.updateValue(virtualField, null);
  }

  @override
  void initState() {
    super.initState();
    unawaited(preload());
    eventBus.onEvent(consumer: eventBusId, eventId: PageEvents.save, handler: saveEventHandler);
  }

  @override
  void dispose() {
    eventBus.unsubscribeFromEvent(consumer: eventBusId, eventId: PageEvents.save);
    unawaited(isLoadingFullPageData.close());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        KitShimmerSwitcher(
          showShimmer: isPreloading || isError,
          color: isError ? context.theme.colorScheme.error.o50 : null,
          child: KitAutocompleteTextField(
            controller: controller,
            finder: finder,
            placeholder: 'Write something to search...',
            helper: helper,
            onSelect: updateValue,
            itemBuilder: itemBuilder,
            isChanged: pageBloc.fieldWasChanged(fieldId),
            isRequired: field.isRequired,
            suffix: StreamBuilder(
              initialData: false,
              stream: isLoadingFullPageData.stream,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) => KitCirclePreloader(
                isLoading: snapshot.data ?? false,
              ),
            ),
          ),
        ),
        Positioned(
          top: 5,
          right: 4,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: StreamBuilder(
              stream: isLoadingFullPageData.stream,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                return snapshot.data ?? false || isPreloading
                    ? const SizedBox.shrink()
                    : KitTooltip(
                        text: 'Clear field',
                        child: IconButton(
                          color: context.theme.colorScheme.primary,
                          onPressed: clearField,
                          icon: const Icon(IconPack.mdi_delete_sweep_outline),
                        ),
                      );
              },
            ),
          ),
        ),
      ],
    );
  }
}
