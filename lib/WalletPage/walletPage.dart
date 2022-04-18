import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:matrix4_transform/matrix4_transform.dart';
import 'package:wallet_demo/LoginPage/LoginButton.dart';
import 'package:wallet_demo/WalletPage/modal/wallets.dart';
import 'package:wallet_demo/WalletPage/tokenTab.dart';
import 'package:wallet_demo/utils/theme.dart';
import 'package:wallet_demo/utils/web3Helper.dart';

import 'nftTab.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> walletBgs = [
    'assets/WalletPage/wallet-bg-01.png',
    'assets/WalletPage/wallet-bg-02.png',
    'assets/WalletPage/wallet-bg-03.png',
  ];

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {});
      print(_tabController.index);
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CustomTheme.bgColor,
      child: SafeArea(
        bottom: false,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Wallet',
                          style: CustomTheme.textBoldWhite,
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Icons.add_circle_outlined,
                          color: CustomTheme.primaryColor,
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        'logOut',
                        style: CustomTheme.textPrimary,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 15),
              Container(
                height: 210,
                child: Swiper(
                  controller: SwiperController(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(walletBgs[index % 3]),
                          fit: BoxFit.cover,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${WalletsHelper().wallets[index].address.substring(0, 5)}...${WalletsHelper().wallets[index].address.substring(WalletsHelper().wallets[index].address.length - 3)}',
                              style: CustomTheme.textBlack,
                            ),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Image.asset('assets/WalletPage/eth-token.png',
                                  width: 20),
                              SizedBox(width: 10),
                              Text(
                                "${WalletsHelper().wallets[index].ethers.toStringAsFixed(5)} eth",
                                style: CustomTheme.textBlack,
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          LoginButton(
                            onPress: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              child: Text(
                                '轉帳',
                                style: CustomTheme.textBlack,
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: WalletsHelper().wallets.length,
                  viewportFraction: 0.8,
                  scale: 0.9,
                ),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomTheme.bgSecondColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _tabController.animateTo(0);
                              },
                              child: Text(
                                'Token',
                                style: CustomTheme.textWhite,
                              ),
                            ),
                            SizedBox(width: 30),
                            GestureDetector(
                              onTap: () {
                                _tabController.animateTo(1);
                              },
                              child: Text(
                                'NFT',
                                style: CustomTheme.textWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 100),
                        transform: Matrix4Transform()
                            .translate(x: _tabController.index == 0 ? -30 : 38)
                            .matrix4,
                        width: 46,
                        height: 4,
                        decoration: BoxDecoration(
                          color: CustomTheme.primaryColor,
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            TokenTab(),
                            NFTTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
