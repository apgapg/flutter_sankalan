import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'blog_model.g.dart';

class BlogModel {
  List<ItemBlog> list;

  BlogModel._internal(this.list);

  factory BlogModel.fromJson(dynamic json) {
    return BlogModel.fromMapList(list: json as List);
  }

  factory BlogModel.fromMapList({List<dynamic> list}) {
    final items = list.cast<Map<String, Object>>().map((Map<String, Object> item) {
      return ItemBlog.fromJson(item);
    }).toList();

    return BlogModel._internal(items);
  }
}

@immutable
@JsonSerializable()
class ItemBlog {
  @JsonKey(required: true, disallowNullValue: true)
  final int id;
  @JsonKey(required: true, disallowNullValue: true)
  final String name;
  @JsonKey(required: true, disallowNullValue: true)
  final String title;
  @JsonKey(required: true, disallowNullValue: true)
  final String content;
  @JsonKey(required: true, disallowNullValue: true)
  final int views;

  ItemBlog(this.id, this.name, this.title, this.content, this.views);

  factory ItemBlog.fromJson(Map<String, dynamic> json) => _$ItemBlogFromJson(json);
}
