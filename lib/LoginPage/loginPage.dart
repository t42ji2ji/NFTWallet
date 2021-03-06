import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wallet_demo/LoginPage/loginPageState.dart';

import '../utils/theme.dart';
import 'LoginButton.dart';
import 'loginPageViewModal.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  StateNotifierProvider<LoginPageNotifier, LoginPageState> notifier =
      StateNotifierProvider((ref) {
    return LoginPageNotifier(LoginPageState.init());
  });

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      ref.listen<LoginPageState>(notifier, (p, n) {
        // print(p is LoginPageState);
        if (n is Data) {
          ref.read(notifier.notifier).goToNextPage(context);
        }
      });
      return Scaffold(
        backgroundColor: CustomTheme.bgColor,
        body: Padding(
          padding: const EdgeInsets.all(33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: LoginButton(
                    onPress: () =>
                        ref.read(notifier.notifier).goToNextPage(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/Login/chicken-btn.png',
                          width: 51,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '直接開始',
                            style: CustomTheme.textBlack,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: CustomTheme.bgColor,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Text(
                '其他連接方式',
                textAlign: TextAlign.center,
                style: CustomTheme.textSmallGray,
              ),
              SizedBox(height: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  LoginButton(
                    onPress: ref.read(notifier.notifier).connectWallet,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Login/metamask-icon.png',
                            width: 26,
                          ),
                          SizedBox(width: 10),
                          ref.watch(notifier).when(
                                (walletsHelper) => Text(
                                    "${walletsHelper.wallets[0].address.substring(0, 5)}...${walletsHelper.wallets[0].address.substring(walletsHelper.wallets[0].address.length - 3)}"),
                                loading: () => CircularProgressIndicator(),
                                init: () => Text(
                                  'Connect Wallet',
                                  style: CustomTheme.textBlack,
                                ),
                                error: (e) => Text(
                                  'Connect Error',
                                  style: CustomTheme.textBlack,
                                ),
                              ),
                          SizedBox(width: 36),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 18),
                  LoginButton(
                    onPress: () =>
                        ref.read(notifier.notifier).goToNextPage(context),
                    color: CustomTheme.secondColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/Login/key-btn.png',
                            width: 26,
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Import PrivateKey',
                            style: CustomTheme.textWhite,
                          ),
                          SizedBox(width: 36),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
