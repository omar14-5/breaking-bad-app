import 'package:flutter/material.dart';
import 'package:flutter_breaking/presentation/app_router.dart';

void main() {
  runApp(Breakingbadapp(
    appRouter: AppRouter(),
  ));
}

class Breakingbadapp extends StatelessWidget {
  final AppRouter appRouter;

  const Breakingbadapp({Key? key, required this.appRouter}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
