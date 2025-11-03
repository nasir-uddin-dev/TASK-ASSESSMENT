import 'package:flutter/material.dart';

class CounterContainer extends StatelessWidget {
  const CounterContainer({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  final int length, currentIndex;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Row(
        children: List.generate(
          length,
              (index) => AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: const EdgeInsets.only(right: 6),
            height: 13,
            width: currentIndex == index ? 30 : 13,
            decoration: BoxDecoration(
              shape: currentIndex == index
                  ? BoxShape.circle
                  : BoxShape.circle,
              color: currentIndex == index ? Colors.lightBlue : Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
