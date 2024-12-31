import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_app/view/home_screen.dart';
import 'package:web_socket_app/view_model/home_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WebSocket App',
      home: BlocProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        child: const HomeScreen(),
      ),
    );
  }
}
