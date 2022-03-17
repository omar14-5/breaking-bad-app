import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/charachters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/data/models/characters.dart';

class CharcterDetailsScreen extends StatelessWidget {
  final Character character;

  const CharcterDetailsScreen({Key? key, required this.character})
      : super(key: key);

  //const CharcterDetailsScreen({Key? key}) : super(key: key);
  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 500,
      pinned: true,
      stretch: true,
      backgroundColor: Mycolors.mygrey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          character.nickName,
          textAlign: TextAlign.start,
        ),
        background: Hero(
          tag: character.charId,
          child: Image.network(
            character.image,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, String value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Mycolors.mywhite,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Mycolors.mywhite,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildProvider(double endIndent) {
    return Divider(
      height: 20,
      endIndent: endIndent,
      color: Mycolors.myYellow,
      thickness: 2,
    );
  }

  Widget checkIfQuotesLoaded(CharachtersState state) {
    if (state is Quotesloaded) {
      return displayRandomQuotesOrEmpetySpace(state);
    } else {
      return showProgressIndicator();
    }
  }

  Widget displayRandomQuotesOrEmpetySpace(state) {
    var quotes = (state).charQoutes;
    if (quotes.length != 0) {
      int randomQuotesIndex = Random().nextInt(quotes - 1);
      return Center(
        child: DefaultTextStyle(
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Mycolors.mywhite,
            shadows: [
              Shadow(
                blurRadius: 7,
                color: Mycolors.myYellow,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: AnimatedTextKit(
            repeatForever: true,
            animatedTexts: [
              FlickerAnimatedText(quotes[randomQuotesIndex].quote),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget showProgressIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: Mycolors.myYellow,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Mycolors.mygrey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      characterInfo('job: ', character.jobs.join(' _ ')),
                      buildProvider(340),
                      characterInfo(
                          'APPeared info: ', character.categoryForTwoSeries),
                      buildProvider(250),
                      characterInfo('seasons: ',
                          character.appearanceOfSeasons.join(' / ')),
                      buildProvider(300),
                      characterInfo('status: ', character.statusIfDeadOrAlive),
                      buildProvider(320),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : characterInfo('bettrer call sual season : ',
                              character.betterCallSaulAppearance.join(' / ')),
                      character.betterCallSaulAppearance.isEmpty
                          ? Container()
                          : buildProvider(130),
                      characterInfo('Actor/Actress: ', character.acotrName),
                      buildProvider(250),
                      SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<CharachtersCubit, CharachtersState>(
                        builder: (context, state) {
                          return checkIfQuotesLoaded(state);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 500,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
