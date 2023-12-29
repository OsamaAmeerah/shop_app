import 'package:flutter/material.dart';
import 'package:shopapp/componants/deafult_components.dart';
import 'package:shopapp/modules/login/login_screen.dart';
import 'package:shopapp/shared/network/local/cahce_helper.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../style/colors.dart';

class  BoardingModel{
  late final String image;
  late final String title;
  late final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
});
}
var boardController = PageController();
// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget
{
   const OnBoardingScreen({super.key});
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onBoard.png',
        title: 'On Board 1 Title',
        body: 'On Board 1 Body',
    ),
    BoardingModel(
      image: 'assets/images/onBoard.png',
        title: 'On Board 2 Title',
        body: 'On Board 2 Body',
    ),
    BoardingModel(
      image: 'assets/images/onBoard.png',
        title: 'On Board 3 Title',
        body: 'On Board 3 Body',
    ),

  ];
bool isLast = false;

  void submit()
  {
     CacheHelper.saveData(
         key: 'onBoarding',
         value: true).then((value) {
       if(value) {
         navigateAndFinish(context, LoginScreen(),);
       }
     });
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
     appBar: AppBar(
       actions: [
         TextButton(onPressed: (){
           submit();
         }, child: const Text(
           'SKIP',
         ),
         ),

       ],

     ),
        body:  Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  onPageChanged: (int index){
                    if(index == boarding.length - 1)
                    {
                      setState(() {
                        isLast = true;
                      });
                    }
                    else
                      {
                        setState(() {
                          isLast= false;
                        });
                      }
                  },
                  itemBuilder: (context,index) => buildBoardingItem(boarding[index]),
                 itemCount: boarding.length,
                  controller: boardController,
                  physics: const BouncingScrollPhysics(),

                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
                Row(
                children: [
                  SmoothPageIndicator(
                      controller: boardController,
                      effect:  const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        activeDotColor: defaultColor,
                        dotHeight: 10.0,
                        expansionFactor: 4.0,
                        dotWidth: 7.0,
                        spacing: 5.0,
                      ),
                      count: boarding.length,
                  ),
                  const Spacer(),
                  FloatingActionButton(
                      onPressed: (){
                        if(isLast)
                          {
                            submit();
                          }
                           else
                             {
                               boardController.nextPage(
                                 duration: const Duration(
                                   milliseconds: 750,
                                 ),
                                 curve: Curves.fastLinearToSlowEaseIn,
                               );
                             }
                      },
                    child: const Icon(
                      Icons.arrow_forward,
                    ) ,

                  ),
                ],
              ),

            ],
          ),
        ),

    );

  }

  Widget buildBoardingItem(BoardingModel model)=>   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(
            image: AssetImage(model.image)),
      ),
      const SizedBox(
        height: 30.0,),
      Text(
        model.title,
        style: const TextStyle(
          fontSize: 24.0,
        ),

      ),
      const SizedBox(
        height: 15.0,),
      Text(
        model.body,
        style: const TextStyle(
          fontSize: 14.0,
        ),

      ),
      const SizedBox(
        height: 30.0,),

    ],

  );
}
