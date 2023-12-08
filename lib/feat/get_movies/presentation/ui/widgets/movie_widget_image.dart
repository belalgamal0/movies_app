import 'package:flutter/material.dart';
import '../../../../../core/network/network_image_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MoviesImageWidget extends StatelessWidget {
  final String imagePath;
  const MoviesImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: NetworkImageHelper.getImageUrl(imagePath: imagePath),
      height: MediaQuery.of(context).size.height / 3,
      width: MediaQuery.of(context).size.width,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) => Image.asset("assets/images/placeholder_image.png"),
    );
  }
}
