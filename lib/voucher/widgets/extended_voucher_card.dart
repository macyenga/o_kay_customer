import 'package:flutter/material.dart';
import 'package:o_kay_customer/constants/colors.dart';
import 'package:intl/intl.dart';

class ExtendedVoucherCard extends StatelessWidget {
  final double minPrice;
  final double currentPrice;
  bool isCartMode;
  ExtendedVoucherCard({
    super.key,
    required this.minPrice,
    required this.currentPrice,
    this.isCartMode = false,
  });

  @override
  Widget build(BuildContext context) {
    double remainingPrice = minPrice - currentPrice;
    return remainingPrice > 0
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Card(
                  margin: const EdgeInsets.all(0),
                  color: isCartMode
                      ? Colors.white
                      : Color.fromARGB(255, 16, 2, 214).withOpacity(0.05),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    side: BorderSide(
                      color: Colors.grey[300]!,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Text(
                      'Add \$ ${NumberFormat("###.##", "en_US").format(remainingPrice)} more to use this voucher',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width:
                    currentPrice / minPrice * MediaQuery.of(context).size.width,
                height: 2,
                color: Color.fromARGB(255, 16, 2, 214),
              ),
            ],
          )
        : const SizedBox();
  }
}
