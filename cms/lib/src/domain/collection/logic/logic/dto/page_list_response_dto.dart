import 'package:autoequal/autoequal.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tools/tools.dart';

part 'page_list_response_dto.g.dart';

const List<String> _possibleTotalPagesKeys = [
  'totalPages',
  'total_pages',
  'total',
];

int _findTotalPagesKey(DJson parentObject, String defaultKey) {
  for (final dynamic key in _possibleTotalPagesKeys) {
    final dynamic value = parentObject[key.toString()];
    if (value is int) {
      return value;
    }
  }
  return 0;
}

@autoequal
@CopyWith()
@JsonSerializable()
class PageListResponseDto extends Equatable {
  const PageListResponseDto({
    required this.page,
    required this.totalPages,
    required this.data,
  });

  factory PageListResponseDto.fromJson(dynamic json) => _$PageListResponseDtoFromJson(castToJson(json));

  @JsonKey(defaultValue: 1)
  final int page;

  @JsonKey(readValue: _findTotalPagesKey)
  final int totalPages;

  final List<Json> data;

  Json toJson() => _$PageListResponseDtoToJson(this);

  @override
  List<Object?> get props => _$props;
}
