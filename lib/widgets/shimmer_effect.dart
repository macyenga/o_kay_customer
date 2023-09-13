import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonSkimming extends StatelessWidget {
  final double width;
  final double height;
  const SkeletonSkimming({
    Key? key,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!.withOpacity(0.7),
      highlightColor: Colors.grey.shade100,
      enabled: true,
      direction: ShimmerDirection.ltr,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: width * 0.3,
              height: height * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: width * 0.4,
              height: height * 0.2,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
