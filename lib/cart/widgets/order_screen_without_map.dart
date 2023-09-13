import 'package:flutter/material.dart';
import 'package:o_kay_customer/cart/screens/help_screen.dart';
import 'package:o_kay_customer/cart/widgets/order_screen_info.dart';
import 'package:o_kay_customer/constants/colors.dart';
import 'package:o_kay_customer/models/order.dart';

class OrderScreenWithoutMap extends StatelessWidget {
  static const String routeName = '/order-without-map-screen';

  final Order order;

  const OrderScreenWithoutMap({
    super.key,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Color.fromARGB(255, 16, 2, 214),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your order',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              order.shop.shopName,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    HelpScreen.routeName,
                    arguments: HelpScreen(
                      voucherId: order.voucherId,
                    ),
                  );
                },
                child: Text(
                  'Help',
                  style: TextStyle(
                    color: Color.fromARGB(255, 16, 2, 214),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: OrderScreenInfo(order: order),
      ),
    );
  }
}
