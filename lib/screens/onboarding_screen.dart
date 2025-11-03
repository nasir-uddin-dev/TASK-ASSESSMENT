import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:interview_task_assesment/controllers/on_boarding_controller.dart';
import 'package:interview_task_assesment/screens/home_screen.dart';
import '../common_widgets/page_indicator.dart';
import '../constants/text_strings.dart';
import '../widget_theme/filled_button_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  //dependency injection
  final controller = Get.put(OnBoardingController());

  //page controller
  late PageController _pageViewController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xFF0A2D73)),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: PageView.builder(
            onPageChanged: (int index) {
              setState(() {
                _currentPageIndex = index;
              });
            },
            controller: _pageViewController,
            itemCount: controller.pages.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ///Foreground Image pages
                  Flexible(
                    child: Image.asset(
                      controller.pages[index].img,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  // const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),

                        ///Title text pages
                        Text(
                          controller.pages[index].title,
                          style: Theme.of(context).textTheme.titleLarge!
                              .copyWith(color: Colors.white, fontSize: 34),
                        ),
                        const SizedBox(height: 8),

                        /// subTitle text pages
                        Text(
                          controller.pages[index].subTile,
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 20),

                        ///Page Indicator
                        Center(
                          child: CounterContainer(
                            currentIndex: _currentPageIndex,
                            length: controller.pages.length,
                          ),
                        ),
                        SizedBox(height: 20),
                        const SizedBox(height: 10),

                        /// Next Button
                        SizedBox(
                          height: 60,
                          child: WidgetFilledButton(
                            text: Text(nNext, style: TextStyle(fontSize: 20)),
                            onPressed: () {
                              _updateCurrentPageIndex(index);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  /// Update Current page
  void _updateCurrentPageIndex(int index) {
    if (index == 2) {
      Get.to(() => HomeScreen());
    } else {
      _pageViewController.animateToPage(
        index + 1,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }
}
