import 'package:demoshopapp/data/cache_helper.dart';
import 'package:flutter/material.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'login_screen.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  const OnBoardingModel({
    required this.body,
    required this.image,
    required this.title,
  });
}
void submit(context)async{

  CacheHelper.saveData(key: 'onBoarding', value: true).then((value)async {
    if(value??false){
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) =>  LoginScreen()));
      dynamic onboarding = await CacheHelper.getData(key: 'onBoarding');
      print(onboarding);
    }else{
      print('error in submit');
    }
  });


}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> boarding = const [
    OnBoardingModel(
        body: 'Screen body 1',
        image: 'assets/onboarding_images/first_image.jpeg',
        title: 'Screen title 1'),
    OnBoardingModel(
        body: 'Screen body 2',
        image: 'assets/onboarding_images/first_image.jpeg',
        title: 'Screen title 2'),
    OnBoardingModel(
        body: 'Screen body 3',
        image: 'assets/onboarding_images/first_image.jpeg',
        title: 'Screen title 3'),
  ];
  bool isLast = false;
  var boardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: (){submit(context);},
              child: const Text('SKIP'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == 2) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                controller: boardingController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
                physics: const BouncingScrollPhysics(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardingController,
                  count: boarding.length,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10,
                    dotWidth: 10,
                    expansionFactor: 4,
                    activeDotColor: Colors.purple,
                    spacing: 5,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit(context);
                    }
                    boardingController.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn);
                  },
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(OnBoardingModel boarding) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.asset(
              boarding.image,
            ),
          ),
          Text(
            boarding.title,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            boarding.body,
            style: const TextStyle(fontSize: 14, color: Colors.black38),
          ),
          const SizedBox(
            height: 60,
          ),
        ],
      );
}
