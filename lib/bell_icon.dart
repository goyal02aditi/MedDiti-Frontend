import 'package:flutter/material.dart';

class BellIcon extends StatelessWidget {
 final double scale;

 const BellIcon({Key? key, this.scale = 1.0}) : super(key: key);

 @override
 Widget build(BuildContext context) {
   return Transform.scale(
     scale: scale,
     child: Icon(Icons.notifications),
   );
 }
}