import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

import 'package:flutter/material.dart';
import 'package:wallet_demo/WalletPage/modal/wallets.dart';
import 'package:web3dart/web3dart.dart';

import '../WalletPage/walletPage.dart';
import '../abi/stream_chicken_2.g.dart';
import '../modals/AppInfo.dart';
import '../utils/web3Helper.dart';
import 'loginPageState.dart';

class LoginPageNotifier extends StateNotifier<LoginPageState> {
  bool isConnectWallet = false;
  final WalletConnectHelper walletConnectHelper = WalletConnectHelper(
    AppInfo(
      name: "Chick Wallet",
      url: "https://chick.wallet.mobile.com",
    ),
  );
  String publicWalletAddress = "";
  String address = "";
  late Stream_chicken_2 contract;
  late Web3Client web3client;

  LoginPageNotifier(LoginPageState state) : super(state);

  // function
  goToNextPage(context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WalletPage()),
    );
  }

  // getBalance() {
  //   web3client.getBalance(address);
  // }

  connectWallet() async {
    state = LoginPageState.loading();
    isConnectWallet = await walletConnectHelper.initSession();
    if (isConnectWallet) {
      // update ui
      // init
      initWeb3Client();
      address = walletConnectHelper
          .getEthereumCredentials()
          .getEthereumAddress()
          .toString();
      print(address);
      var amount =
          await web3client.getBalance(EthereumAddress.fromHex(address));
      print(amount.getValueInUnit(EtherUnit.ether));
      WalletsHelper().addWallet(
        new EthWallet(
          address,
          ImportMethod.metamask,
          ethers: amount.getValueInUnit(EtherUnit.ether),
        ),
      );
      state = LoginPageState(WalletsHelper());
    }
  }

  void initWeb3Client() {
    web3client =
        Web3Client(WalletConnectHelper.ethRinkebyTestnetEndpoints, Client());
    web3client.addedBlocks().listen((event) async {
      // print('newblock: ${transferResultHash.isNotEmpty} $event');
      // if (transferResultHash.isNotEmpty) {
      //   var res = await web3client.getTransactionReceipt(transferResultHash);
      //   print(res);
      // }
    });

    // use contract(StreamChicken2) address
    final EthereumAddress contractAddress =
        EthereumAddress.fromHex('0xa1e767940e8fb953bbd8972149d2185071b86063');
    // use Rinkeby(test-chain), chain id is '4'
    contract = Stream_chicken_2(
        address: contractAddress, client: web3client, chainId: 4);
  }
}
