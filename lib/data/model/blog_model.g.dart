// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemBlog _$ItemBlogFromJson(Map<String, dynamic> json) {
  $checkKeys(json,
      requiredKeys: ['id', 'name', 'title', 'content', 'views'],
      disallowNullValues: ['id', 'name', 'title', 'content', 'views']);
  return ItemBlog(json['id'] as int, json['name'] as String,
      json['title'] as String, json['content'] as String, json['views'] as int);
}

Map<String, dynamic> _$ItemBlogToJson(ItemBlog instance) {
  var val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('title', instance.title);
  writeNotNull('content', instance.content);
  writeNotNull('views', instance.views);
  return val;
}
