import 'dart:ui';

import 'package:animetv/animations/Transitions.dart';
import 'package:animetv/constants.dart';
import 'package:animetv/models/FavouritedModel.dart';
import 'package:animetv/models/TwistModel.dart';
import 'package:animetv/pages/anime_info_page/AnimeInfoPage.dart';
import 'package:animetv/widgets/custom_shimmer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouritedAnimeTile extends StatelessWidget {
  const FavouritedAnimeTile({
    Key key,
    this.twistModel,
    this.favouritedModel,
  }) : super(key: key);

  final TwistModel twistModel;
  final FavouritedModel favouritedModel;

  String getImageUrl(BuildContext context) {
    var orientation = MediaQuery.of(context).orientation;
    if (orientation == Orientation.portrait) {
      return favouritedModel.posterURL ??
          favouritedModel.coverURL ??
          DEFAULT_IMAGE_URL;
    } else {
      return favouritedModel.coverURL ??
          favouritedModel.posterURL ??
          DEFAULT_IMAGE_URL;
    }
  }

  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).cardColor;
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: [
          Column(
            children: [
              Flexible(
                fit: FlexFit.loose,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: color,
                      ),
                    ),
                    Positioned.fill(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: getImageUrl(context),
                            width: double.infinity,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => CustomShimmer(),
                          )),
                    ),
                  ],
                ),
              ),
              Container(
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                color: color,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText(
                    twistModel.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Transitions.slideTransition(
                    context: context,
                    pageBuilder: () => AnimeInfoPage(
                      twistModel: twistModel,
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
