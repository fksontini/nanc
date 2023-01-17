import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tools/tools.dart';

part 'image_arguments.g.dart';

@JsonSerializable()
class ImageArguments {
  const ImageArguments({
    required this.ref,
    required this.color,
    required this.width,
    required this.height,
    required this.fit,
  });

  factory ImageArguments.fromJson(dynamic json) => _$ImageArgumentsFromJson(castToJson(json));

  final String? ref;

  @JsonKey(fromJson: colorFromJson, toJson: colorToJson)
  final Color? color;

  @JsonKey(fromJson: doubleOrNullFromJson)
  final double? width;

  @JsonKey(fromJson: doubleOrNullFromJson)
  final double? height;

  @JsonKey(unknownEnumValue: JsonKey.nullForUndefinedEnumValue)
  final BoxFit? fit;

  Json toJson() => _$ImageArgumentsToJson(this);
}
