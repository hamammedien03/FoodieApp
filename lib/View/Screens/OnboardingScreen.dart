import 'package:flutter/material.dart';
import 'package:foodie/Model/Colors.dart';
import 'package:foodie/Model/OnboardingData.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
  static int valuePageViewOnChange = 0;
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Future<void> _finishOnBoarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isFirstTime', false);
    Navigator.pushReplacementNamed(context, '/signin-screen');
  }

  @override
  Widget build(BuildContext context) {
    double heightscreen = MediaQuery.of(context).size.height;
    double widthScreen = MediaQuery.of(context).size.width;
    List<Onboardingdata> dataOnBoarding = Onboardingdata.onboardinDataList;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        color: ColorsApp.white,
        child: Column(
          children: [
            SizedBox(
              width: widthScreen,
              height: heightscreen * 0.8,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: ((value) {
                  setState(() {
                    OnBoardingScreens.valuePageViewOnChange = value;
                    print(OnBoardingScreens.valuePageViewOnChange);
                  });
                }),
                itemCount: dataOnBoarding.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage(dataOnBoarding[index].image),
                        fit: BoxFit.fill,
                      ),
                      Text(
                        dataOnBoarding[index].title,
                        style: TextStyle(
                          fontSize: 35,
                          color: ColorsApp.black,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 15, left: 25),
                        child: Text(
                          textAlign: TextAlign.center,
                          dataOnBoarding[index].description,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: ColorsApp.textLight,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(
              width: widthScreen * 0.5,
              height: heightscreen * 0.07,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsApp.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () {
                  if (OnBoardingScreens.valuePageViewOnChange !=
                      dataOnBoarding.length - 1) {
                    _pageController.animateToPage(
                      OnBoardingScreens.valuePageViewOnChange + 1,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    _finishOnBoarding();
                  }
                },
                child:
                    OnBoardingScreens.valuePageViewOnChange !=
                        dataOnBoarding.length - 1
                    ? const Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: ColorsApp.white,
                        ),
                      )
                    : const Text(
                        "Get Started",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: ColorsApp.white,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
