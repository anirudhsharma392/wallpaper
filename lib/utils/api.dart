import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:wallpaper/model/photo.dart';

class API {
  static final Dio _dio = Dio();
  static const String _apiKey =
      "563492ad6f917000010000017b85671f88a84d9c91fa41bfdb4ce641";

  ///url that returns a list of 30 photos
  static const String _url =
      'https://api.pexels.com/v1/curated?page=1&per_page=30';

  ///returns a list of photos or null in-case of error
  static Future<List<Photo>?> fetchPhotos() async {
    Response _response = await _dio.get(_url,
        options: Options(
          headers: {"Authorization": _apiKey},
        ));

    if (_response.statusCode == 200) {
      List<Photo> _photos = [];

      final json = _response.data;
      json["photos"].forEach((element) {
        _photos.add(Photo.fromJson(element));
      });

      return _photos;
    }
    try {} catch (e) {
      debugPrint(e.toString());
    }
    //in-case of error
    return null;
  }
}
