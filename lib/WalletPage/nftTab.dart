import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:wallet_demo/NFTDetailPage/NFTDetailPage.dart';
import 'package:wallet_demo/WalletPage/modal/NFTInfo.dart';
import 'package:wallet_demo/utils/pageRoute.dart';
import 'package:wallet_demo/utils/theme.dart';

class NFTTab extends StatefulWidget {
  const NFTTab({Key? key}) : super(key: key);

  @override
  State<NFTTab> createState() => _NFTTabState();
}

class _NFTTabState extends State<NFTTab> {
  final List<Color> bgColors = [
    CustomTheme.primaryColor,
    CustomTheme.secondColor,
    Colors.deepPurpleAccent,
  ];
  late List<NFTInfo> nftInfos = List<NFTInfo>.generate(
      6,
      (int index) => NFTInfo(
          tokenId: index,
          imgPath: "assets/chicken/ck-${index + 1}.png",
          bgColor: bgColors[index % 3]),
      growable: true);

  late List<NFTCollection> nftCollections = [
    NFTCollection(
      name: "Chicken1",
      tokenCount: 10,
      tokenName: "chk1",
      nftInfos: nftInfos,
    ),
    NFTCollection(
      name: "Chicken2",
      tokenCount: 15,
      tokenName: "chk2",
      nftInfos: nftInfos,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: nftCollections.length,
      itemBuilder: (context, index) {
        return _buildList(nftCollections[index]);
      },
    );
  }

  Widget _buildList(NFTCollection nftCollection) {
    return Container(
      height: 260,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      nftCollection.name,
                      style: CustomTheme.textWhite,
                    ),
                    Text(
                      nftCollection.tokenName,
                      style: CustomTheme.textSmallPrimary,
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Total: ',
                      style: CustomTheme.textWhite,
                    ),
                    Text(
                      nftCollection.tokenCount.toString(),
                      style: CustomTheme.textSmallPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 170,
                child: ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 24),
                    itemCount: nftInfos.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(slideRoute(NftDetailPage()));
                        },
                        child: Container(
                          height: 170,
                          width: 136,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: nftInfos[index].bgColor,
                              image: DecorationImage(
                                  image: AssetImage(nftInfos[index].imgPath))),
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    CustomTheme.bgColor.withAlpha(190),
                                    CustomTheme.bgColor.withAlpha(80),
                                    CustomTheme.bgColor.withAlpha(0),
                                    CustomTheme.bgColor.withAlpha(0),
                                  ],
                                )),
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "#${nftInfos[index].tokenId.toString()}",
                              style: CustomTheme.textWhite,
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}
