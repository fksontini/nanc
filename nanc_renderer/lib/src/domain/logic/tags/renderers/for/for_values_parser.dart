import 'package:flutter/material.dart';
import '../../logic/for_storage.dart';
import '../../logic/page_data.dart';

final RegExp _rangeValuesRegExp = RegExp(r'(?<from>\d+)\.\.\.(?<to>\d+)');
final RegExp _valuesRegExp = RegExp(r'page.(?<expression>[-\w.]+)');
final RegExp _embedCycleRegExp = RegExp(r'cycle\(.*\)\(\d+\)\(value:::(?<valueName>.+)\)(?<expression>[-\w.]+)');

class ForValuesParser {
  ForValuesParser({
    required this.context,
    required this.valuesString,
  });

  final BuildContext context;
  final String valuesString;

  Iterable<Object?> get values => _iterator();

  bool get _isNumberedIterator => _fromNumber != null && _toNumber != null;
  bool get _isValuesIterator => _values != null;
  int? _fromNumber;
  int? _toNumber;
  List<Object?>? _values;

  void parseValues() {
    final RegExpMatch? match = _rangeValuesRegExp.firstMatch(valuesString);
    if (match != null) {
      _fromNumber = int.parse(match.namedGroup('from')!);
      _toNumber = int.parse(match.namedGroup('to')!);
      if (_fromNumber! > _toNumber!) {
        final int fromNumber = _fromNumber!;
        _fromNumber = _toNumber;
        _toNumber = fromNumber;
      }
      if (_fromNumber == _toNumber) {
        _toNumber = _toNumber! + 1;
      }
      return;
    }
    if (_valuesRegExp.hasMatch(valuesString)) {
      final dynamic values = PageData.findData(context: context, query: valuesString);
      if (values is Iterable) {
        _values = List.from(values);
      }
      return;
    }
    final RegExpMatch? embedCycleMatch = _embedCycleRegExp.firstMatch(valuesString);
    if (embedCycleMatch != null) {
      final dynamic values = ForStorage.findEmbedData(context, valuesString);
      if (values is Iterable) {
        _values = List.from(values);
      }
      return;
    }
    // TODO(alphamikle): Implement search of complex values in the global storage or values resolver
  }

  Iterable<Object?> _iterator() sync* {
    int index = _fromNumber ?? 0;
    if (_isNumberedIterator) {
      while (index < _toNumber!) {
        yield index;
        index++;
      }
    } else if (_isValuesIterator) {
      while (index < _values!.length) {
        yield _values![index];
        index++;
      }
    }
  }
}