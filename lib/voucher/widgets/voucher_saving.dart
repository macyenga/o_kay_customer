import 'package:flutter/material.dart';
import 'package:o_kay_customer/constants/colors.dart';
import 'package:o_kay_customer/models/voucher.dart';
import 'package:o_kay_customer/voucher/widgets/search_voucher_modal.dart';

class VoucherSaving extends StatelessWidget {
  final Function(Voucher) addVoucherToList;
  const VoucherSaving({super.key, required this.addVoucherToList});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '\$ 0.00',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Saved this month',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200],
            width: 1,
            height: 50,
          ),
          Expanded(
              child: GestureDetector(
            onTap: () {
              showSearchVoucherModal(
                context: context,
                addVoucherToList: addVoucherToList,
              );
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.local_offer_outlined,
                  color: Color.fromARGB(255, 16, 2, 214),
                ),
                const SizedBox(width: 10),
                Text(
                  'Add a Voucher',
                  style: TextStyle(
                    color: Color.fromARGB(255, 16, 2, 214),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
