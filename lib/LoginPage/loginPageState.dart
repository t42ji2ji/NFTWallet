import 'package:freezed_annotation/freezed_annotation.dart';

import '../WalletPage/modal/wallets.dart';

part 'loginPageState.freezed.dart';

@freezed
class LoginPageState with _$LoginPageState {
  const factory LoginPageState(WalletsHelper walletsHelper) = Data;
  const factory LoginPageState.loading() = Loading;
  const factory LoginPageState.init() = Init;
  const factory LoginPageState.error([String? message]) = ErrorDetails;
}
