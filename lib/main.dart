import 'package:closure_task6/cubit/ad_cubit.dart';
import 'package:closure_task6/models/ad.models.dart';
import 'package:closure_task6/pages/homepage.pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider<AdCubit>(create: (BuildContext context) {
            AdCubit adCubit = AdCubit();
            if (adCubit.state.isEmpty) {
              adCubit.getAds();
            } else {
              print('states are not empty');
            }
            return adCubit;
          }),
          BlocProvider<AdCubit>(create: (BuildContext context) => AdCubit()),
        ],
        child: Scaffold(
          body: BlocBuilder<AdCubit, List<Ad>>(builder: (context, State) {
            if (State.isNotEmpty) {
              print('..Loaded..');
              return const Center(
                child: Text('Loaded..'),
              );
            } else {
              if (State.isEmpty) {
                print('..Loading..');
                return const Center(
                  child: Text('Loading..'),
                );
              }
              print('..UI is being called..');
              return HomePage();
            }
          }),
        ),
      ),
    );
  }
}
