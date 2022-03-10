import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/charachters_cubit.dart';
import 'package:flutter_breaking/constants/strings.dart';
import 'package:flutter_breaking/data/repository/charachters_repository.dart';
import 'package:flutter_breaking/data/web_services/characters_web_services.dart';
import 'package:flutter_breaking/presentation/screens/characters_detials.dart';
import 'package:flutter_breaking/presentation/screens/characters_screen.dart';

class AppRouter {
  late ChararactersRepository chararactersRepository;
  late CharachtersCubit charachtersCubit;

  AppRouter() {
    chararactersRepository = ChararactersRepository(CharactersWebServices());
    charachtersCubit = CharachtersCubit(chararactersRepository);
  }
  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charachtersCubit,
            child: CharactersScreen(),
          ),
        );

      case characterDetailsScreen:
        return MaterialPageRoute(builder: (_) => CharcterDetailsScreen());
    }
  }
}
