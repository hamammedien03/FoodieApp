class Onboardingdata {
  String image;
  String title;
  String description;

  Onboardingdata({
    required this.image,
    required this.title,
    required this.description,
  });

  static List<Onboardingdata> onboardinDataList = [
    Onboardingdata(
      image: 'assets/images/OnBoardingIm1.png',
      title: "Track your  Comfort \nFood here",
      description:
          "Here You Can find a chef or dish for every taste and color. Enjoy!",
    ),
    Onboardingdata(
      image: "assets/images/OnBoardingIm2.png",
      title: "Foodie is Where Your \nComfort Food Resides",
      description: "Enjoy a fast and smooth food delivery at your doorstep",
    ),
  ];
}
