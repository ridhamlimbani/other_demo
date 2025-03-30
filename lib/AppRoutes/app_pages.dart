import 'package:filter_player/AppRoutes/app_routes.dart';
import 'package:filter_player/Screens/HomeScreen/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.homePage,
  routes: [
    /// =====> Home Page init <===== ///
    GoRoute(
      path: AppRoutes.homePage,
      builder: (context,state) => HomePage(),
    )
  ]
);