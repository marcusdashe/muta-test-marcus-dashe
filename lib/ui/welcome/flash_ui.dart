import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:muta_app/common/constants/muta_colors.dart';
import 'package:muta_app/common/constants/muta_image_paths.dart';

import 'get_started_ui.dart';



class FlashUI extends StatefulWidget {
  const FlashUI({super.key});

  @override
  State<FlashUI> createState() => _FlashUIState();
}

class _FlashUIState extends State<FlashUI> with TickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState(){
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _sizeAnimation = Tween<double>(begin: 60.0, end: 200.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // _fontSizeAnimation = Tween<double>(begin: 0.0, end: 28.0).animate(
    //   CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    // );

    _startAnimations();
  }

  Future<void> _startAnimations() async {
    await Future.delayed(const Duration(seconds: 3));

    _animationController.forward();

    await Future.delayed(const Duration(seconds: 3));

    Navigator.of(context).pushReplacementNamed(GetStartedUI.routeName);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: MutaColors.surfaceColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    final h = MediaQuery.of(context).size.height, w = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: MutaColors.surfaceColor,
        body: SizedBox(
          height: h,
          width: w,
          child: Stack(
            alignment: Alignment.center,
            children: [
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return SizedBox(
                    height: _sizeAnimation.value,
                    width: _sizeAnimation.value,
                    child: Opacity(
                      opacity: _opacityAnimation.value,
                      child: Image.asset(
                        MutaImages.logoImage,
                        width: _sizeAnimation.value,
                        height: _sizeAnimation.value,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
