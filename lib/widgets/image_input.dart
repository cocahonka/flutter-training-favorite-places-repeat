import 'package:flutter/material.dart';

class ImageInput extends StatelessWidget {
  const ImageInput({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.2),
        ),
      ),
      child: TextButton.icon(
        label: const Text('Take Picture'),
        icon: const Icon(Icons.camera),
        onPressed: () {},
      ),
    );
  }
}
