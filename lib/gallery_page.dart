import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_gallery_app/gallery_controller.dart';
import 'package:test_gallery_app/image_card_page.dart';

class GalleryPage extends StatelessWidget {
  final GalleryController controller = Get.put(GalleryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pixabay Gallery'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: controller.onSearchChanged,
              decoration: const InputDecoration(
                labelText: 'Search Images',
                suffixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
                  controller.loadMore();
                }
                return false;
              },
              child: Obx(() => GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: (MediaQuery.of(context).size.width ~/ 200)
                          .clamp(2, 5),
                    ),
                    itemCount: controller.images.length,
                    itemBuilder: (context, index) {
                      if (index == controller.images.length - 1 &&
                          controller.hasMore.isTrue) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return ImageCard(image: controller.images[index]);
                    },
                  )),
            ),
          ),
          Obx(() => controller.hasMore.isFalse && controller.images.isNotEmpty
              ? const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("No more images to show."),
                )
              : const SizedBox.shrink()),
        ],
      ),
    );
  }
}
