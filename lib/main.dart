import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'core/routes/route_generator.dart';
import 'core/theme/app_color_theme.dart';
import 'injection_container.dart' as di;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await di.configureDependencies();
  await dotenv.load(fileName: ".env");
  runApp(const MoviesApp());
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movies App',
      theme: ThemeData(
        iconTheme: const IconThemeData(color: AppColorTheme.primaryColor),
        appBarTheme: const AppBarTheme(
            centerTitle: true, 
            backgroundColor: AppColorTheme.primaryColor),
      ),
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
