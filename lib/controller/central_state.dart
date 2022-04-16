import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/utils/api.dart';
import 'package:wallpaper/utils/background_method.dart';
import 'package:wallpaper/utils/enums/status.dart';

class CentralState extends GetxController {
  Rx<Status> status = Status.init.obs;

  List<Photo> allPhotos = [];

  init() async {
    status.value = Status.loading;
    List<Photo>? res = await API.fetchPhotos();
    if (res == null) {
      status.value = Status.error;
    } else {
      allPhotos.clear();
      allPhotos = res;
      status.value = Status.success;
    }
  }
}

final CentralState centralState = Get.put(CentralState());
