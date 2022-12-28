import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tools/tools.dart';

part 'gradient_arguments.g.dart';

@JsonSerializable()
class GradientArguments {
  const GradientArguments({
    required this.tileMode,
  });

  factory GradientArguments.fromJson(dynamic json) => _$GradientArgumentsFromJson(castToJson(json));

  final TileMode? tileMode;

  Json toJson() => _$GradientArgumentsToJson(this);
}
