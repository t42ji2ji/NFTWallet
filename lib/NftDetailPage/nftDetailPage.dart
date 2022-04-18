import 'package:flutter/material.dart';
import 'package:wallet_demo/LoginPage/LoginButton.dart';
import 'package:wallet_demo/utils/theme.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:supercharged_dart/supercharged_dart.dart';

class NftDetailPage extends StatefulWidget {
  const NftDetailPage({Key? key}) : super(key: key);

  @override
  State<NftDetailPage> createState() => _NftDetailPageState();
}

class _NftDetailPageState extends State<NftDetailPage> {
  double screenOpacity = 0;

  List<Widget> warframeList() {
    return List<Widget>.generate(
      6,
      (index) => Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: LoginButton(
          onPress: () {},
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.all(5),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/chicken/ck-${index + 1}.png',
                  height: 40,
                ),
                SizedBox(width: 5),
                Text('我是賦能', style: CustomTheme.textBlack),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlayAnimation<double>(
      tween: Tween<double>(begin: 0.0, end: 0.3),
      delay: Duration(milliseconds: 100),
      duration: Duration(milliseconds: 300),
      builder: (context, child, snapshot) {
        return Material(
          color: Colors.black.withOpacity(
              screenOpacity + snapshot <= 0 ? 0 : screenOpacity + snapshot),
          child: Listener(
            onPointerMove: (PointerMoveEvent event) {
              if (event.delta.dy > 0) {
                if (screenOpacity <= -0.3) {
                  return;
                }
                screenOpacity -= event.delta.dy * 0.01;
                setState(() {});
              }
            },
            child: Dismissible(
              key: Key('some key here'),
              direction: DismissDirection.down,
              onDismissed: (_) {
                print('ondissmiss');
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 100),
                decoration: BoxDecoration(
                  color: CustomTheme.bgColor,
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: CustomTheme.secondColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                      ),
                      height: 240,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/chicken/ck-1.png',
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  _metaDataBox(),
                                  SizedBox(width: 15),
                                  _metaDataBox(),
                                  SizedBox(width: 15),
                                  _metaDataBox(),
                                ],
                              ),
                              SizedBox(height: 25),
                              Wrap(
                                spacing: 5,
                                runSpacing: 5,
                                children: [
                                  _metaDataTag(),
                                  _metaDataTag(),
                                  _metaDataTag(),
                                  _metaDataTag(),
                                  _metaDataTag(),
                                  _metaDataTag(),
                                ],
                              ),
                              SizedBox(height: 25),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Address',
                                    style: CustomTheme.textSmallPrimary,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '0x899bd466D50e861351fb1fAa303CaB08Bdb03725',
                                    style: CustomTheme.textSmallWhite,
                                  ),
                                ],
                              ),
                              SizedBox(height: 25),
                              LoginButton(
                                onPress: () {},
                                color: CustomTheme.secondColor,
                                child: Container(
                                  width: double.infinity,
                                  child: Container(
                                    padding: EdgeInsets.all(20),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'send',
                                      style: CustomTheme.textWhite,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              LoginButton(
                                onPress: () {},
                                color: Colors.white,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                          'assets/NFTDetailPage/opensea.png',
                                          width: 24),
                                      SizedBox(width: 5),
                                      Text('Sell on Opensea',
                                          style: CustomTheme.textBlack),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                padding: EdgeInsets.all(20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: CustomTheme.bgSecondColor),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Image.asset(
                                            'assets/NFTDetailPage/crown.png',
                                            width: 30),
                                        Text(
                                          '賦能',
                                          style: CustomTheme.textWhite,
                                        ),
                                      ],
                                    ),
                                    ...warframeList()
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _metaDataBox() {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: BoxDecoration(
          color: CustomTheme.bgSecondColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name',
              style: CustomTheme.textPrimary,
            ),
            SizedBox(height: 10),
            Text(
              '123',
              style: CustomTheme.textSmallWhite,
            ),
          ],
        ),
      ),
    );
  }

  Widget _metaDataTag() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: CustomTheme.primaryColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '# body1',
        style: CustomTheme.textBlack,
      ),
    );
  }
}
