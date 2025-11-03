import 'package:get/get.dart';
import 'package:interview_task_assesment/constants/image_strings.dart';
import 'package:interview_task_assesment/constants/text_strings.dart';
import 'package:interview_task_assesment/models/on_boarding_model.dart';

class OnBoardingController extends GetxController {
  OnBoardingController get instance => Get.find();
  RxInt currentPage = 0.obs;

  final pages = [
    OnBoardingModel(img: img1, title: nTitle, subTile: nSubTitle),

    OnBoardingModel(img: img2, title: nTitle2, subTile: nSubTitle2),

    OnBoardingModel(img: img3, title: nTitle3, subTile: nSubTitle3),
  ];


  void onPageChangeCallBack(int activePageIndex) {
    currentPage.value = activePageIndex;
  }
}
