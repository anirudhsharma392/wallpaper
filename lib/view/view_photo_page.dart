import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/utils/background_method.dart';
import 'package:wallpaper/utils/colors.dart';
import 'package:wallpaper/utils/enums/status.dart';
import 'package:wallpaper/utils/toast_message.dart';
import 'package:flutter/foundation.dart';

class ViewPhotoPage extends StatelessWidget {
  final Photo photo;
  const ViewPhotoPage({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Hero(
              tag: photo.id,
              child: Image.network(
                photo.src.large2x ?? "",
                fit: BoxFit.cover,
              )),
        ),
        Material(
          color: appBarColor.withOpacity(0.7),
          child: Container(
            height: 80,
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _TextButton(
                  child: const Icon(
                    Icons.arrow_back_sharp,
                    color: Colors.white,
                  ),
                  onTap: Get.back,
                ),
                Flexible(
                    child: Text(
                  "-  ${photo.photographer ?? ""}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 15, color: Colors.white70),
                )),
                _TextButton(
                  child: const Text(
                    'Set',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  onTap: () {
                    showDialog(
                        context: context,
                        //barrierDismissible: false,
                        builder: (_) =>
                            _SetDialogue(url: photo.src.large2x ?? ""));
                  },
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SetDialogue extends StatelessWidget {
  final String url;
  const _SetDialogue({Key? key, required this.url}) : super(key: key);

  onTap(int type) async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      Get.back();
      final Status status =
          await BackgroundMethod.setWallpaper(url, screenType: type);
      if (status == Status.success) {
        showToast("Wallpaper set successfully");
        Get.back();
        return;
      }
      showToast("Error occurred");
      return;
    }
    showToast("Only supported on Android");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        titlePadding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        titleTextStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        backgroundColor: backgroundColor,
        alignment: Alignment.center,
        title: const Text('Set Wallpaper for'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                _Button(
                  text: 'Home Screen',
                  onTap: () => onTap(1),
                ),
                const SizedBox(
                  width: 16,
                ),
                _Button(
                  text: 'Lock Screen',
                  onTap: () => onTap(2),
                )
              ],
            ),
            Row(
              children: [
                _Button(
                  text: 'Both',
                  onTap: () => onTap(3),
                ),
                const SizedBox(
                  width: 16,
                ),
                _Button(
                  text: 'Cancel',
                  onTap: () => Get.back(),
                )
              ],
            ),
          ],
        ));
  }
}

class _Button extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  const _Button({Key? key, this.text = "", required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white70,
          primary: appBarColor,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
        ),
        onPressed: onTap,
        child: Text(text),
      ),
    );
  }
}

class _TextButton extends StatelessWidget {
  final void Function()? onTap;
  final Widget child;
  const _TextButton({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
              (Set<MaterialState> states) {
            return Colors.white12;
          }),
        ),
        onPressed: onTap,
        child: child);
  }
}
