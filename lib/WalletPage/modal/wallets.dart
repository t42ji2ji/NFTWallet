class WalletsHelper {
  static final WalletsHelper _singleton = WalletsHelper._internal();
  factory WalletsHelper() {
    return _singleton;
  }
  WalletsHelper._internal();

  List<EthWallet> wallets = [];

  addWallet(EthWallet wallet) {
    if (wallets.contains(wallet.address)) {
      return;
    }
    wallets.add(wallet);
  }
}

enum ImportMethod { metamask, privateKey, local }

class EthWallet {
  double ethers;
  final String address;
  final ImportMethod importMethod;
  EthWallet(this.address, this.importMethod, {this.ethers = 0});
}
