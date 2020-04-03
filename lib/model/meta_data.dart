library link_preview;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'meta_data.g.dart';
part 'meta_data.freezed.dart';

@freezed
abstract class LinkMetaData with _$LinkMetaData {
  const factory LinkMetaData({
    @JsonKey(defaultValue: '') String title,
    @JsonKey(defaultValue: '') String description,
    @JsonKey(defaultValue: '') String image,
  }) = _LinkMetaData;

  factory LinkMetaData.fromJson(Map<String, dynamic> json) =>
      _$LinkMetaDataFromJson(json);
}
