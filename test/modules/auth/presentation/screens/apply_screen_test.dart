import 'package:bloc_test/bloc_test.dart';
import 'package:flowery_driver/config/base_state/base_state.dart';
import 'package:flowery_driver/core/app_strings/apply_strings.dart';
import 'package:flowery_driver/modules/auth/presentation/screens/apply_screen.dart';
import 'package:flowery_driver/modules/auth/presentation/view_model/apply_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockApplyCubit extends MockCubit<BaseState> implements ApplyCubit {}

void main() {
  late MockApplyCubit mockApplyCubit;

  setUp(() {
    mockApplyCubit = MockApplyCubit();
    when(() => mockApplyCubit.state).thenReturn(const BaseState.initial());
    when(() => mockApplyCubit.getCountries()).thenAnswer((_) async {});
  });

  Widget buildTestWidget() {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) => MaterialApp(
        home: BlocProvider<ApplyCubit>.value(
          value: mockApplyCubit,
          child: const ApplyScreen(),
        ),
      ),
    );
  }

  group('ApplyScreen Widget Test', () {
    testWidgets('renders ApplyScreen elements correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      expect(find.text(ApplyStrings.title), findsOneWidget);
      expect(find.text(ApplyStrings.welcomeMessage), findsOneWidget);
      expect(find.text(ApplyStrings.firstLegalName), findsOneWidget);
    });

    testWidgets('shows validation errors when form is empty and submit is pressed', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();

      final applyButton = find.text(ApplyStrings.continueButtonText);
      
      await tester.dragUntilVisible(
        applyButton,
        find.byType(SingleChildScrollView),
        const Offset(0, -500),
      );
      
      await tester.tap(applyButton);
      await tester.pumpAndSettle();

      expect(find.text(ApplyStrings.validationFirstNameRequired), findsWidgets);
    });
  });
}
