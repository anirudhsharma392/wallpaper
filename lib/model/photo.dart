class Photo {
  late final int id;
  late final int? width;
  late final int? height;
  late final String url;
  late final String? photographer;
  late final String? photographerUrl;
  late final int? photographerId;
  late final String? avgColor;
  late final Src src;
  late final bool? liked;
  late final String? alt;

  Photo(
      {id,
      width,
      height,
      url,
      photographer,
      photographerUrl,
      photographerId,
      avgColor,
      src,
      liked,
      alt});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id']??"";
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    json['src'] != null ? src = Src.fromJson(json['src']) : Src();
    liked = json['liked'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['width'] = width;
    data['height'] = height;
    data['url'] = url;
    data['photographer'] = photographer;
    data['photographer_url'] = photographerUrl;
    data['photographer_id'] = photographerId;
    data['avg_color'] = avgColor;
    data['src'] = src.toJson();
    data['liked'] = liked;
    data['alt'] = alt;
    return data;
  }
}

class Src {
  late final String? original;
  late final String? large2x;
  late final String? large;
  late final String? medium;
  late final String? small;
  late final String? portrait;
  late final String? landscape;
  late final String? tiny;

  Src({original, large2x, large, medium, small, portrait, landscape, tiny});

  Src.fromJson(Map<String, dynamic> json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['original'] = original;
    data['large2x'] = large2x;
    data['large'] = large;
    data['medium'] = medium;
    data['small'] = small;
    data['portrait'] = portrait;
    data['landscape'] = landscape;
    data['tiny'] = tiny;
    return data;
  }
}
