import 'package:flutter/material.dart';
import 'package:wallet_demo/WalletPage/modal/tokenInfo.dart';

class WalletInfo {
  List<NFTCollection> nftCollections = [];
  List<TokenInfo> tokens = [];
  final String address;

  WalletInfo({required this.address});
}

class NFTCollection {
  final List<NFTInfo> nftInfos;
  final String name;
  final String tokenName;
  final int tokenCount;

  NFTCollection({
    required this.nftInfos,
    required this.name,
    required this.tokenName,
    required this.tokenCount,
  });
}

class NFTInfo {
  final int tokenId;
  final String imgPath;
  final Color bgColor;
  final NFTMetaData metaData = NFTMetaData();

  NFTInfo({
    required this.tokenId,
    required this.imgPath,
    required this.bgColor,
  });
}

class NFTMetaData {
  final String body = '1';
  final String head = '5';
  final String beak = '3';
}
