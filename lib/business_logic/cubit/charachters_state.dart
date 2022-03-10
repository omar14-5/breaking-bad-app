part of 'charachters_cubit.dart';

@immutable
abstract class CharachtersState {}

class CharachtersInitial extends CharachtersState {}

class Charactersloaded extends CharachtersState {
  final List<Character> characters;

  Charactersloaded(this.characters);
}
