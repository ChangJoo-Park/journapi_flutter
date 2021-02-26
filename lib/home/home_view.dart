import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:journapi/home/home_controller.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: CustomScrollView(
          slivers: [
            // Composer
            SliverToBoxAdapter(
              child: Obx(() => Container(
                    child: Column(
                      children: [
                        Text(controller.newBullet.value ?? ''),
                        Text(controller.newDate.value.toString() ?? ''),
                      ],
                    ),
                  )),
            ),
            // List
            SliverList(delegate: SliverChildListDelegate([]))
          ],
        ));
      },
    );
  }
}
