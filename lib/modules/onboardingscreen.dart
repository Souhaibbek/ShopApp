import 'package:flutter/material.dart';
import 'package:shopapp/models/onboardingmodel.dart';
import 'package:shopapp/modules/loginscreen.dart';
import 'package:shopapp/network/local/cache_helper.dart';
import 'package:shopapp/shared/components/components.dart';
import 'package:shopapp/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();

  bool isLast = false;

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/img/onBoardingLogo.png',
      title: 'title 1',
      body: 'body 1',
    ),
    BoardingModel(
      image: 'assets/img/onBoardingLogo.png',
      title: 'title 2',
      body: 'body 2',
    ),
    BoardingModel(
      image: 'assets/img/onBoardingLogo.png',
      title: 'title 3',
      body: 'body 3',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onBoarding', value: true)
                    .then((value) {
                  if (value!) {
                    navigateAndFinish(context, ShopLoginScreen());
                  }
                });
              },
              child: Text(
                'SKIP',
                style: TextStyle(color: defaultColor),
              ))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardController,
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: boardController,
                  count: boarding.length,
                  effect: ExpandingDotsEffect(
                    dotWidth: 10.0,
                    spacing: 5.0,
                    activeDotColor: defaultColor,
                    dotColor: Colors.blueGrey,
                    dotHeight: 10.0,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(Icons.arrow_forward_ios),
                  onPressed: () {
                    if (isLast) {
                      CacheHelper.saveData(key: 'onBoarding', value: true)
                          .then((value) {
                        if (value!) {
                          navigateAndFinish(context, ShopLoginScreen());
                        }
                      });
                    } else {
                      boardController.nextPage(
                        duration: Duration(milliseconds: 750),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
