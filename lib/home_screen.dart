import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List<String> imageUrls = [
      'https://cdn.pixabay.com/photo/2024/07/13/19/50/ai-generated-8892995_960_720.png',
      'https://cdn.pixabay.com/photo/2024/07/13/18/42/ai-generated-8892896_960_720.png',
      'https://cdn.pixabay.com/photo/2024/07/12/07/47/ai-generated-8889832_960_720.jpg',
      'https://cdn.pixabay.com/photo/2023/11/05/10/03/ai-generated-8366630_1280.jpg',
      'https://cdn.pixabay.com/photo/2023/08/02/06/02/piano-8164418_1280.jpg',
      'https://cdn.pixabay.com/photo/2017/08/21/08/10/car-2664447_960_720.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Imágenes'),
      ),
      body: OrientationBuilder(
        builder: (BuildContext context, Orientation orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            shrinkWrap: true,
            childAspectRatio: orientation == Orientation.portrait ? 1 : 2,
            children: List.generate(
                  imageUrls.length,
                  (index) => GestureDetector(
                      onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  fullscreenDialog: true,
                                  builder: (context) => FullImageScreen(imageUrl: imageUrls[index])
                              )
                          );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12.0),
                        child: Image.network(
                          imageUrls[index],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                value: (loadingProgress.expectedTotalBytes != null)
                                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                    : null,
                              ),
                            );
                          },
                        ),
                      ),
                  ),
            ),
          );
        }
      ),
    );
  }
}

class FullImageScreen extends StatelessWidget {
  final String imageUrl;

  const FullImageScreen({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pantalla completa'),
      ),
      body: Image.network(
        imageUrl,
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: (loadingProgress.expectedTotalBytes != null)
                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
            ),
          );
        },
      ),
    );
  }
}

