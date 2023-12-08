import 'package:flutter/material.dart';
import '../../../../../core/theme/app_color_theme.dart';
import '../../../../../core/theme/app_text_theme.dart';
import '../../../../../core/theme/dimension_theme.dart';
import '../../../domain/entity/movie.dart';
import 'movie_rate_widget.dart';
import 'movie_widget_image.dart';

class MovieWidget extends StatelessWidget {
  final Movie movie;
  const MovieWidget({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: DimensionsTheme.smallMargin),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
          border: Border.all(color: AppColorTheme.borderColor),
          borderRadius: BorderRadius.circular(DimensionsTheme.semiCirularRadius)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MoviesImageWidget(imagePath: movie.moviePoster),
          Text(movie.movieTitle, style: AppTextTheme.black16Bold),
          Text(movie.movieOverview),
          MovieRatingWidget(rate: movie.movieRate)
        ].asMap().entries.map(
          (entry) {
            final index = entry.key;
            final widget = entry.value;
            return Padding(
              padding: index == 0 ? EdgeInsets.zero // No padding for the first widget
                  : const EdgeInsets.all(DimensionsTheme.smallPadding), // Padding for others
              child: widget
            );
          },
        ).toList(),
      ),
    );
  }
}
