import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'enums/status.dart';

class BackgroundMethod {
  static final Dio _dio = Dio();
  static const platform = MethodChannel('com.example.background/wallpaper');

  ///call this function to set wallpaper
  // homeScreenType = 1;
  // lockScreenType = 2;
  // bothScreenType = 3;
  static Future<Status> setWallpaper(String url, {int screenType = 3}) async {
    try {
      await Permission.storage.request();

      if (await Permission.storage.request().isGranted) {
        final dir = await getExternalStorageDirectory();
        final path = "${dir!.path}/wallpaper.jpeg";

        Status _status = await _downloadWallpaper(url, path);
        if (_status == Status.success) {
          return await _setWallpaper(path, screenType);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return Status.error;
  }

  //downloads the wallpaper from url and saves it in the path
  static Future<Status> _downloadWallpaper(String url, String path) async {
    Response a = await _dio.download(
      url,
      path,
      deleteOnError: true,
    );
    if (a.statusCode == 200) return Status.success;

    return Status.error;
  }

  //sets the wall paper using method channel
  static Future<Status> _setWallpaper(imagePath, int wallpaperType) async {
    final int result =
        await platform.invokeMethod('setWallpaper', [imagePath, wallpaperType]);

    //returns 0 in case of success
    if (result == 0) return Status.success;

    return Status.error;
  }
}
