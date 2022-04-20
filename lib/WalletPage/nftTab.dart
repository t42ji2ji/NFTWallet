import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_demo/WalletPage/modal/NFTInfo.dart';
import 'package:wallet_demo/WalletPage/walletPage.dart';
import 'package:wallet_demo/abi/stream_chicken_2.g.dart';
import 'package:wallet_demo/utils/pageRoute.dart';
import 'package:wallet_demo/utils/theme.dart';
import 'package:web3dart/web3dart.dart';

import '../NFTDetailPage/nftDetailPage.dart';
import 'modal/wallets.dart';

final getNFTCollection = FutureProvider<List<NFTCollection>>((ref) async {
  final wIndex = ref.watch(walletIndexProvider);
  final List<Color> bgColors = [
    CustomTheme.primaryColor,
    CustomTheme.secondColor,
    Colors.deepPurpleAccent,
  ];
  Stream_chicken_2 contract =
      (WalletsHelper().wallets[wIndex].getChickContract());

  EthereumAddress myAddress = WalletsHelper().wallets[wIndex].eAddress;
  int balance = (await contract.balanceOf(myAddress)).toInt();
  print("balance $balance");
  List<int> myTokenId = [];
  int tokenId = 0;
  while (myTokenId.length != balance) {
    if (await contract.ownerOf(BigInt.from(tokenId)) == myAddress) {
      myTokenId.add(tokenId);
    }
    tokenId++;
  }

  List<String> tokenUris = [];
  for (var data in myTokenId) {
    var uri = await contract.tokenURI(BigInt.from(data));
    var httpClient = new HttpClient();
    var res = await httpClient.getUrl(Uri.parse(uri));
    var response = await res.close();
    var json = await response.transform(utf8.decoder).join();
    var d = jsonDecode(json);
    tokenUris.add(d['image']);
  }
  List<NFTInfo> nftInfos = List<NFTInfo>.generate(
      balance,
      (int index) => NFTInfo(
          tokenId: myTokenId[index],
          imgPath: tokenUris[index],
          bgColor: bgColors[index % 3]),
      growable: true);
  return [
    NFTCollection(
      name: await contract.name(),
      tokenCount: balance,
      tokenName: await contract.symbol(),
      nftInfos: nftInfos,
    ),
  ];
});

class NFTTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ref) {
    var nftCollections = ref.watch(getNFTCollection);

    return nftCollections.when(
        data: (data) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: data.length,
            itemBuilder: (context, index) {
              return _buildList(data[index]);
            },
          );
        },
        error: (err, stack) => Text('Error: $err'),
        loading: () => Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 5),
                Text(
                  "Searching Nft",
                  style: CustomTheme.textWhite,
                )
              ],
            )));
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
                    itemCount: nftCollection.nftInfos.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(slideRoute(NftDetailPage(
                              imgUrl: nftCollection.nftInfos[index].imgPath)));
                        },
                        child: Container(
                          height: 170,
                          width: 136,
                          margin: EdgeInsets.only(right: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: nftCollection.nftInfos[index].bgColor,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      nftCollection.nftInfos[index].imgPath))),
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
                              "#${nftCollection.nftInfos[index].tokenId.toString()}",
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
