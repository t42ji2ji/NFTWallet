import 'package:wallet_demo/abi/stream_chicken_2.g.dart';
import 'package:wallet_demo/abi/usdt.g.dart';
import 'package:web3dart/web3dart.dart';

class WalletsHelper {
  static final WalletsHelper _singleton = WalletsHelper._internal();
  factory WalletsHelper() {
    return _singleton;
  }
  WalletsHelper._internal();
  List<EthWallet> wallets = [];

  addWallet(EthWallet wallet) {
    print(wallet.address);
    for (var data in wallets) {
      if (data.address == wallet.address) {
        return;
      }
    }
    wallets.add(wallet);
  }
}

enum ImportMethod { metamask, privateKey, local }

class EthWallet {
  double ethers;
  final String address;
  final ImportMethod importMethod;
  final Stream_chicken_2 ch2Contract;
  final Web3Client web3client;
  EthWallet(this.address,
      {required this.importMethod,
      required this.ch2Contract,
      required this.web3client,
      this.ethers = 0});

  EthereumAddress get eAddress {
    return EthereumAddress.fromHex(address);
  }

  Future<double> balanceOf() async {
    return (await web3client.getBalance(EthereumAddress.fromHex(address)))
        .getValueInUnit(EtherUnit.ether);
  }

  Stream_chicken_2 getChickContract() {
    final EthereumAddress contractAddress =
        EthereumAddress.fromHex('0xa1e767940e8fb953bbd8972149d2185071b86063');
    return Stream_chicken_2(
        address: contractAddress, client: web3client, chainId: 4);
  }

  Stream_chicken_2 createNFTContract(String address) {
    final EthereumAddress contractAddress = EthereumAddress.fromHex(address);
    return Stream_chicken_2(
        address: contractAddress, client: web3client, chainId: 4);
  }

  Usdt getUsdtContract() {
    final EthereumAddress contractAddress =
        EthereumAddress.fromHex('0xd92e713d051c37ebb2561803a3b5fbabc4962431');
    return Usdt(address: contractAddress, client: web3client, chainId: 4);
  }
}
