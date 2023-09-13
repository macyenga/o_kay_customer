import 'package:flutter/material.dart';
import 'package:o_kay_customer/constants/colors.dart';

class PromoText extends StatelessWidget {
  const PromoText({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 48,
        ),
        width: double.infinity,
        color: Color.fromARGB(255, 16, 2, 214).withOpacity(0.1),
        child: Text(
          title,
          style: textTheme.bodyText1
              ?.copyWith(color: Color.fromARGB(255, 16, 2, 214)),
        ),
      ),
    );
  }
}
