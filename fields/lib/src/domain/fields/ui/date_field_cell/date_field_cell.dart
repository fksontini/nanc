import 'package:fields/src/domain/fields/logic/date_field/date_field.dart';
import 'package:fields/src/domain/fields/ui/date_field_cell/date_mask.dart';
import 'package:fields/src/domain/fields/ui/date_field_cell/time_mask.dart';
import 'package:fields/src/domain/fields/ui/field_cell_mixin.dart';
import 'package:flutter/material.dart';
import 'package:tools/tools.dart';
import 'package:ui_kit/ui_kit.dart';

class DateFieldCell extends FieldCellWidget<DateField> {
  const DateFieldCell({
    required super.field,
    required super.creationMode,
    super.key,
  });

  @override
  State<DateFieldCell> createState() => _DateFieldCellState();
}

class _DateFieldCellState extends State<DateFieldCell> with FieldCellHelper<DateField, DateFieldCell>, KitFocusStreamMixin<DateFieldCell> {
  final FocusNode dateFocus = FocusNode();
  final FocusNode timeFocus = FocusNode();

  final RegExp dateTimeRegExp = RegExp(r'^(?<date>\d{4}-\d{2}-\d{2})T(?<time>\d{2}:\d{2}:\d{2})');
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  void controllerListener() {
    final DateTime? dateTime = DateTime.tryParse('${dateController.text}T${timeController.text}.000Z');
    pageBloc.updateValue(fieldId, dateTime?.toIso8601String());
    controller.text = dateTime?.toIso8601String() ?? '';
  }

  void focusListener() {
    if (dateFocus.hasFocus || timeFocus.hasFocus) {
      updateFocus(true);
    } else {
      updateFocus(false);
    }
  }

  void setDateAndTime() {
    final RegExpMatch? match = dateTimeRegExp.firstMatch(controller.text);
    final String? date = match?.namedGroup('date');
    final String? time = match?.namedGroup('time');
    if (date != null && time != null) {
      dateController.text = date;
      timeController.text = time;
    }
  }

  void initControllers() {
    setDateAndTime();
    dateController.addListener(controllerListener);
    timeController.addListener(controllerListener);
    dateFocus.addListener(focusListener);
    timeFocus.addListener(focusListener);
  }

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    dateController.removeListener(controllerListener);
    timeController.removeListener(controllerListener);
    dateFocus.removeListener(focusListener);
    timeFocus.removeListener(focusListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final String datePlaceholder = dateTimeRegExp.firstMatch(DateTime.now().toIso8601String())!.namedGroup('date')!;
    final String timePlaceholder = dateTimeRegExp.firstMatch(DateTime.now().toIso8601String())!.namedGroup('time')!;

    return KitSegmentedField(
      controller: controller,
      helper: helper,
      isChanged: pageBloc.fieldWasChanged(fieldId),
      focusStream: focusStream,
      validator: groupOfValidators([
        if (field.isRequired) isRequiredValidator,
      ]),
      children: [
        KitTextField(
          controller: dateController,
          decoration: context.kitDecorations.noneDecoration(context).copyWith(hintText: datePlaceholder),
          formatters: [
            DateMask(),
          ],
          focusNode: dateFocus,
        ),
        KitTextField(
          placeholder: timePlaceholder,
          controller: timeController,
          decoration: context.kitDecorations.noneDecoration(context).copyWith(hintText: timePlaceholder),
          formatters: [
            TimeMask(),
          ],
          focusNode: timeFocus,
        )
      ],
    );
  }
}
