import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:web3dart/web3dart.dart';

import '../LoginPage/LoginButton.dart';
import '../abi/usdt.g.dart';
import '../utils/theme.dart';
import 'modal/tokenInfo.dart';
import 'modal/wallets.dart';
import 'walletPage.dart';

final getEthTokenBalance = FutureProvider<String>((ref) async {
  final wIndex = ref.watch(walletIndexProvider);
  var ethAmount = (await WalletsHelper().wallets[wIndex].balanceOf());
  print("ethAmount $ethAmount");

  return ethAmount.toStringAsFixed(3);
});

final getUsdtBalance = FutureProvider<String>((ref) async {
  final wIndex = ref.watch(walletIndexProvider);
  print("wIndex $wIndex");

  Usdt usdtContract = WalletsHelper().wallets[wIndex].getUsdtContract();
  var usdtAmount = (await usdtContract.balanceOf(
          EthereumAddress.fromHex(WalletsHelper().wallets[wIndex].address)))
      .toDouble();
  print("usdt $usdtAmount");
  return usdtAmount.toString();
});

class TokenTab extends ConsumerWidget {
  final List<String> walletBgs = [
    'assets/WalletPage/wallet-bg-01.png',
    'assets/WalletPage/wallet-bg-02.png',
    'assets/WalletPage/wallet-bg-03.png',
  ];

  final List<TokenInfo> tokens = [
    TokenInfo('assets/WalletPage/eth-token.png', 'ETH', 0.0),
    TokenInfo('assets/WalletPage/usdt-token.png', 'USDT', 0.0),
  ];

  // @override
  // void initState() {
  //   print('state change');
  //   asyncInit();
  // }

  // asyncInit(int index) async {
  //   print('change');
  //   await getUsdtBalance(index);
  //   await getEthTokenBalance(index);
  // }

  // getEthTokenBalance(int index) async {
  //   tokens[0].amount = (await WalletsHelper().wallets[index].balanceOf());
  // }

  // getUsdtBalance(int index) async {
  //   Usdt usdtContract = WalletsHelper().wallets[index].getUsdtContract();
  //   tokens[1].amount = (await usdtContract.balanceOf(
  //           EthereumAddress.fromHex(WalletsHelper().wallets[index].address)))
  //       .toDouble();
  //   tokens[1].name = (await usdtContract.symbol());
  // }

  // @override
  // Widget build(BuildContext context, ref) {
  //   return Text('data');
  // }
  @override
  Widget build(BuildContext context, ref) {
    ref.listen(getEthTokenBalance, (previous, next) {
      // if(previous !=next)
    });
    final ethAmount = ref.watch(getEthTokenBalance);
    final usdtAmount = ref.watch(getUsdtBalance);
    final wIndex = ref.watch(walletIndexProvider);
    // asyncInit(wIndex);
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
                  Text(
                    "${index == 0 ? ethAmount.value : usdtAmount.value}",
                    style: CustomTheme.textBlack,
                  ),
                  SizedBox(width: 10),
                  LoginButton(
                    onPress: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '轉帳 ',
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
