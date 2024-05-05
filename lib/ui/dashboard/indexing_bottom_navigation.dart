import 'package:flutter/material.dart';
import 'package:muta_app/common/constants/muta_colors.dart';
import 'package:muta_app/common/constants/muta_image_paths.dart';

import 'home_ui.dart';
import 'learn_ui.dart';
import 'live_session_ui.dart';


// Author: Marcus Dashe <marcusdashe.developer@gmail.com>


class DashboardIndexNavigation extends StatefulWidget {
  static const routeName = '/dashboard-index-navigation';
  const DashboardIndexNavigation({super.key});

  @override
  State<DashboardIndexNavigation> createState() => _DashboardIndexNavigationState();
}

class _DashboardIndexNavigationState extends State<DashboardIndexNavigation> {
  int _selectedItemIndex = 0;
  List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    final Map<String, dynamic>? args =
    ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (args != null && args.containsKey('initialSelectedIndex')) {
      setState(() {
        _selectedItemIndex = args['initialSelectedIndex'];
      });
    }
  }

  void init() async {
    _pages = [
      const HomeUI(),
      const LearnUI(),
      const SessionUI(),
    ];

    setState(() {});
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  void _onTap(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  Widget _bottomTab(){
    return BottomNavigationBar(
        currentIndex: _selectedItemIndex,
        onTap: _onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: MutaColors.whiteColor,
        selectedItemColor: MutaColors.primaryColor,
        unselectedItemColor: Colors.black54,
        elevation: 20,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 14,
        items:   <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Home', MutaImages.homeIcon),
            activeIcon: customBottomNav(context, true, 'Home', MutaImages.homeIcon),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Learn', MutaImages.learnIcon),
            activeIcon: customBottomNav(context, true, 'Learn', MutaImages.learnIcon),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: customBottomNav(context, false, 'Live Session', MutaImages.sessionIcon),
            activeIcon: customBottomNav(context, true, 'Live Session', MutaImages.sessionIcon),
            label: '',
          ),

        ]
    );
  }

  Widget customBottomNav(BuildContext context, bool isActiveIcon, String text, String icon) {
    if (isActiveIcon) {
      return Column(
        children: [
          Image.asset(icon, height: 20, width: 20),
          const SizedBox(height: 5,),
          Text('$text', style: const TextStyle(fontSize: 16, color: MutaColors.primaryColor, fontWeight: FontWeight.w600)),
        ],
      );
    } else {
      return Column(
        children: [
          Image.asset(icon, height: 16, width: 16, color: Colors.black),
          Text('$text', style: TextStyle(fontWeight: FontWeight.w500)),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _bottomTab(),
        body: _pages[_selectedItemIndex],
      ),
    );
  }
}
