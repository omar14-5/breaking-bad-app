import 'package:flutter/material.dart';
import 'package:flutter_breaking/business_logic/cubit/charachters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharcters;
  @override
  void initState() {
    super.initState();
    allCharcters =
        Blocprovider.of<CharachtersCubit>(context).getallCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mycolors.myYellow,
        title: Text(
          'character',
          style: TextStyle(color: Mycolors.mygrey),
        ),
      ),
    );
  }
}
