
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

import 'firebase_options.dart';
import 'package:ecommerce_app/features/cubit/login/login_cubit.dart';
import 'package:ecommerce_app/features/view/login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setDefaults({
      'welcome_message': 'Welcome back!',
      'login_subtitle': 'Sign in to continue shopping.',
    });

    await remoteConfig.fetchAndActivate();
  } catch (e) {
    debugPrint('Remote Config error: $e');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => AuthCubit(),
        child: const LoginScreen(),
      ),
    );
  }
}
