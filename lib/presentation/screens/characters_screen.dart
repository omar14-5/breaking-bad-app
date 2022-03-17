import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/charachters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';
import 'package:flutter_breaking/presentation/widgets/character_item.dart';
import 'package:flutter_offline/flutter_offline.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  _CharactersScreenState createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharcters;
  late List<Character> searchForCharcter;
  bool isSearching = false;
  final searcTextController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
        controller: searcTextController,
        cursorColor: Mycolors.mygrey,
        decoration: InputDecoration(
          hintText: 'find a character',
          border: InputBorder.none,
          hintStyle: TextStyle(color: Mycolors.mygrey, fontSize: 18),
        ),
        style: TextStyle(color: Mycolors.mygrey, fontSize: 18),
        onChanged: (searchedCharacter) {
          addSearchedForItemToSearchedList(searchedCharacter);
        });
  }

  void addSearchedForItemToSearchedList(String searchedCharacter) {
    searchForCharcter = allCharcters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacter))
        .toList();
    setState(() {});
  }

  List<Widget> buildAppBarAction() {
    if (isSearching) {
      return [
        IconButton(
            onPressed: () {
              clearSearch();
              Navigator.pop(context);
            },
            icon: Icon(Icons.clear, color: Mycolors.mygrey)),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: Icon(
            Icons.search,
            color: Mycolors.mygrey,
          ),
        ),
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));
    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searcTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharachtersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharachtersCubit, CharachtersState>(
        builder: (context, state) {
      if (state is Charactersloaded) {
        allCharcters = (state).characters;
        return buildLodedListWidget();
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Mycolors.myYellow,
      ),
    );
  }

  Widget buildLodedListWidget() {
    return SingleChildScrollView(
      child: Container(
        color: Mycolors.mygrey,
        child: Column(
          children: [
            buildCharacterList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharacterList() {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
        ),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: allCharcters.length,
        itemBuilder: (ctx, index) {
          return CharacterItem(
            character: searcTextController.text.isEmpty
                ? allCharcters[index]
                : searchForCharcter[index],
          );
        });
  }

  Widget buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: Mycolors.mygrey),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
        color: Mycolors.mywhite,
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'can\'t connect',
              style: TextStyle(
                fontSize: 30,
                color: Mycolors.mygrey,
              ),
            ),
            Image.asset('assets/images/nointernet.png')
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Mycolors.myYellow,
        leading: isSearching
            ? BackButton(
                color: Mycolors.mygrey,
              )
            : Container(),
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarAction(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;
          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
    );
  }
}
