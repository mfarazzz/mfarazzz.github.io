import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final dynamic
      image; // This should include all necessary data like URL, likes, views

  const ImageCard({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Here, implement navigation to full screen view
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FullScreenImage(image: image['largeImageURL']),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Image.network(
                image['webformatURL'],
                fit: BoxFit.cover,
              ),
            ),
            ListTile(
              title: Text('${image['likes']} Likes'),
              subtitle: Text('${image['views']} Views'),
            ),
          ],
        ),
      ),
    );
  }
}

class FullScreenImage extends StatelessWidget {
  final String image;
  const FullScreenImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Full Image'),
      ),
      body: Center(
        child: Image.network(image),
      ),
    );
  }
}
