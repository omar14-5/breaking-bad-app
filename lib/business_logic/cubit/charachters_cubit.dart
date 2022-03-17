import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/data/models/quote.dart';
import 'package:flutter_breaking/data/repository/charachters_repository.dart';
import 'package:meta/meta.dart';

part 'charachters_state.dart';

class CharachtersCubit extends Cubit<CharachtersState> {
  final ChararactersRepository chararactersRepository;
  List<Character> characters = [];

  CharachtersCubit(this.chararactersRepository) : super(CharachtersInitial());
  List<Character> getAllCharacters() {
    chararactersRepository.getAllCharacters().then((characters) {
      emit(Charactersloaded(characters));
      this.characters = characters;
    });

    return characters;
  }

  void getQuotes(String charName) {
    chararactersRepository.getCharacterQuotes(charName).then((quotes) {
      emit(Quotesloaded(quotes));
    });
  }
}
