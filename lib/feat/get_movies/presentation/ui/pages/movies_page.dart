import '../../../../../core/theme/dimension_theme.dart';
import '../../bloc/movies_bloc.dart';
import '../../bloc/movies_events.dart';
import '../../bloc/movies_states.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widgets/loading_widget.dart';
import '../widgets/movie_widget.dart';

class MoviesPage extends StatelessWidget {
  const MoviesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies App")),
      body: BlocProvider(
        create: (_) => GetIt.instance.get<MoviesBloc>()..add(LoadMoviesEvent()),
        child: BlocBuilder<MoviesBloc, MoviesState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: DimensionsTheme.mediumPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Builder(
                    builder: (context) {
                      if (state.status == MoviesStatus.loading) {
                        return const LoadingWidget();
                      } else if (state.status == MoviesStatus.loaded) {
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: DimensionsTheme.mediumPadding),
                            itemCount: state.loadMoviesEntity!.movies.length,
                            itemBuilder: (context, index) => MovieWidget(
                                movie: state.loadMoviesEntity!.movies[index]),
                          ),
                        );
                      } else {
                        return Center(child: Text("${state.errorMessage}"));
                      }
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
