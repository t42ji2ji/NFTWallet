import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:wallet_demo/LoginPage/LoginButton.dart';
import 'package:wallet_demo/utils/theme.dart';

import 'modal/tokenInfo.dart';

class TokenTab extends StatefulWidget {
  const TokenTab({Key? key}) : super(key: key);

  @override
  State<TokenTab> createState() => _TokenTabState();
}

class _TokenTabState extends State<TokenTab> {
  List<String> walletBgs = [
    'assets/WalletPage/wallet-bg-01.png',
    'assets/WalletPage/wallet-bg-02.png',
    'assets/WalletPage/wallet-bg-03.png',
  ];

  List<TokenInfo> tokens = [
    TokenInfo('assets/WalletPage/eth-token.png', 'ETH', 123.123),
    TokenInfo('assets/WalletPage/usdt-token.png', 'USDT', 123.123),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tokens.length,
      padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: LoginButton(
            color: Colors.white,
            onPress: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                children: [
                  Image.asset(
                    tokens[index].imgPath,
                    width: 25,
                  ),
                  SizedBox(width: 8),
                  Text(
                    tokens[index].name,
                    style: CustomTheme.textBlack,
                  ),
                  Spacer(),
                  Text(tokens[index].amount.toString()),
                  SizedBox(width: 10),
                  LoginButton(
                    onPress: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '轉帳',
                        style: CustomTheme.textBlack,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
