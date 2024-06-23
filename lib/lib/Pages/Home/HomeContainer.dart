import 'package:flutter/material.dart';

class HomeCont extends StatelessWidget {
  const HomeCont({Key? key, required this.onPressed, required this.image, required this.title, required this.subtitle});

  final String title;
  final String subtitle;
  final String image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top section with title and subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: GestureDetector(
                  onTap: onPressed,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              // Image or Video
              Image(
                fit: BoxFit.cover,
                image: AssetImage(image),
                height: 120,
                width: 120,
              ),
              SizedBox(height: 8.0),
              // Bottom section with like, share, and comment icons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite_border),
                        onPressed: () {
                          // Handle like button press
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.share),
                        onPressed: () {
                          // Handle share button press
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          // Handle comment button press
                        },
                      ),
                    ],
                  ),
                  // Other widgets like timestamp can be added here
                ],
              ),
            ],
          ),
        ),
    );
  }
}
