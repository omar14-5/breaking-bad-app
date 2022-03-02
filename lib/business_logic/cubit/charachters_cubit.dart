import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/repository/charachters_repository.dart';
import 'package:meta/meta.dart';

part 'charachters_state.dart';

class CharachtersCubit extends Cubit<CharachtersState> {
  final ChararactersRepository chararactersRepository;
  late List<dynamic> characters;

  CharachtersCubit(this.chararactersRepository) : super(CharachtersInitial());
  List<dynamic> getAllCharacters() {
    chararactersRepository.getAllCharacters().then((characters) {
      emit(Charactersloaded(characters));
      this.characters = characters;
    });

    return characters;
  }
}
