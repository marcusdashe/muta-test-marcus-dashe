import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muta_app/ui/welcome/flash_ui.dart';
import 'package:muta_app/ui/welcome/get_started_ui.dart';

import 'common/cache/local_cache.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalCache().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muta Language App',
      themeMode: ThemeMode.system,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        textTheme: GoogleFonts.robotoTextTheme(Theme.of(context).textTheme),
        useMaterial3: true,
      ),
      home: const FlashUI(),
      routes: {
        GetStartedUI.routeName: (context) => const GetStartedUI(),
      },
    );
    // return MultiBlocProvider(
    //     providers: [
    //
    //     ],
    // child:
    //
    // );
  }
}

