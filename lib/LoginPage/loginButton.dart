import 'package:flutter/material.dart';
import 'package:wallet_demo/utils/theme.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    Key? key,
    required this.onPress,
    this.color = CustomTheme.primaryColor,
    required this.child,
  }) : super(key: key);

  final Color color;
  final Widget child;
  final Function() onPress;

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  BoxDecoration _getDecoration() {
    return BoxDecoration(
      color: widget.color,
      boxShadow: [
        BoxShadow(offset: Offset(0, 4), color: widget.color.withOpacity(0.75))
      ],
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22),
        decoration: _getDecoration(),
        child: widget.child,
      ),
    );
  }
}
