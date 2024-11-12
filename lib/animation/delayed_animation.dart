import 'package:flutter/material.dart';
import 'dart:async';

class DelayedAnimation extends StatefulWidget {

final Widget child;
final int delay;
const DelayedAnimation(this.delay,this.child, {super.key});


  @override
  State<DelayedAnimation> createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;
  
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500)
      );

       final curve = CurvedAnimation(
        parent: _controller, 
        curve: Curves.decelerate
      );
    }
 
  
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  
}