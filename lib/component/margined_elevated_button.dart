import 'package:flutter/material.dart';

class MarginedElevatedButton extends StatelessWidget {
  const MarginedElevatedButton(
      {Key? key, required this.onPressed, this.text = '-', this.strong = true})
      : super(key: key);
  final Function() onPressed;
  final String text;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(text),
        style: (() {
          if (!strong) {
            return ElevatedButton.styleFrom(
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
              ),
              primary: Colors.white,
              onPrimary: Theme.of(context).colorScheme.primary,
            );
          }
        }()),
      ),
    );
  }
}
