import 'package:flowery_driver/config/di/di.dart';
import 'package:flowery_driver/core/theme/app_theme.dart';
import 'package:flowery_driver/modules/auth/presentation/screens/apply_screen.dart';
import 'package:flowery_driver/modules/auth/presentation/view_model/apply_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: BlocProvider(
            create: (context) => getIt<ApplyCubit>(),
            child: ApplyScreen(),
          ),
        );
      },
    );
  }
}
