import 'package:flutter/material.dart';
import '../../../../../core/theme/app_color_theme.dart';
import '../../../../../core/theme/dimension_theme.dart';

class MovieRatingWidget extends StatelessWidget {
  final double rate;
  const MovieRatingWidget({super.key, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.star,color: AppColorTheme.accentColor),
        const SizedBox(width: DimensionsTheme.smallPadding),
        Text(rate.toString())
      ],
    );
  }
}
