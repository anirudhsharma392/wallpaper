import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:wallpaper/controller/central_state.dart';
import 'package:wallpaper/model/photo.dart';
import 'package:wallpaper/utils/colors.dart';
import 'package:wallpaper/utils/enums/status.dart';
import 'package:wallpaper/view/view_photo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    centralState.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        title: const Text(
          "Wallpaper",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Obx(() {
        final Status status = centralState.status.value;
        if (status == Status.loading || status == Status.init) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ));
        }
        if (status == Status.error) {
          return const Center(child: Text('Error occurred'));
        }

        return Body(photos: centralState.allPhotos);
      }),
    );
  }
}

class Body extends StatelessWidget {
  final List<Photo> photos;
  const Body({Key? key, required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: photos.length,
        padding: const EdgeInsets.all(32),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
        ),
        itemBuilder: (context, i) => PhotoBlock(photo: photos[i]));
  }
}

class PhotoBlock extends StatelessWidget {
  final Photo photo;
  const PhotoBlock({Key? key, required this.photo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.to(() => ViewPhotoPage(photo: photo)),
      child: Hero(
        tag: photo.id,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: const [BoxShadow(color: Colors.white60, blurRadius: 10)],
            borderRadius: BorderRadius.circular(16),
            image: DecorationImage(
              image: NetworkImage(
                photo.src.tiny ?? "",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
