


import 'package:flutter/material.dart';

Widget gapHeight({double height = 16}) {
  return SizedBox(
    height: height,
  );
}Widget gapWidth({double width = 16}) {
  return SizedBox(
    height: width,
  );
}
class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

