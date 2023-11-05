import 'package:flutter/material.dart';

class IconNameButton extends StatelessWidget {
  IconNameButton({
    super.key,
    required this.iconData,
    required this.name,
  });

  IconData iconData;
  String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: Colors.white,
              ),
              const SizedBox(width: 11),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              )
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}
