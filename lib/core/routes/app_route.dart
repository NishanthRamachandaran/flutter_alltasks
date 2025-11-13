import 'package:auto_route/auto_route.dart';
import 'package:tasks/core/routes/app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
     //   AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: ProfileRoute.page,initial: true),
       // AutoRoute(page: UnifiedSearchRoute.page), 
      
      ];
}