import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:journapi/home/home_controller.dart';
import 'package:journapi/widgets/bullet.dart';
import 'package:journapi/widgets/collapsable.dart';

const months = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) {
        return Scaffold(
            body: CustomScrollView(
          slivers: [
            // Appbar
            SliverAppBar(
              backgroundColor: Color(0xfff7fafc),
              title: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/logo.svg',
                    semanticsLabel: 'Journapi Logo',
                    width: 30,
                    height: 30,
                  ),
                  Text(
                    'Journapi',
                    style: TextStyle(
                      fontFamily: 'JetBrainsMono',
                      color: Colors.grey.shade800,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  )
                ],
              ),
            ),
            // Composer
            SliverToBoxAdapter(
              child: Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Collapsible(
                      key: ValueKey('COMPOSER'),
                      openInitialized: true,
                      hasChildBorder: true,
                      title: 'Write in my journal',
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Form(
                          child: Container(
                            child: Column(
                              children: [
                                TextFormField(
                                  style: TextStyle(fontFamily: 'JetBrainsMono'),
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                  minLines: 2,
                                  maxLines: 10,
                                  controller: controller.newBulletController,
                                ),
                                SizedBox(height: 8),
                                DateTimeField(
                                  dateTextStyle:
                                      TextStyle(fontFamily: 'JetBrainsMono'),
                                  initialDatePickerMode: DatePickerMode.day,
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.blueAccent),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    suffixIcon: Icon(Icons.calendar_today),
                                  ),
                                  selectedDate: controller.newDate.value,
                                  onDateSelected: (DateTime value) {
                                    controller.newDate.value = value;
                                  },
                                ),
                                SizedBox(height: 16),
                                Container(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        primary: Color(0xff63b3ed),
                                        elevation: 0),
                                    child: Text(
                                      'Add to my journal',
                                      style: TextStyle(
                                        fontFamily: 'JetBrainsMono',
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    onPressed: () {
                                      print(
                                          controller.newBulletController.text);
                                      print(controller.newDate.value);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )),
            ),
            // List
            Obx(
              () => SliverList(
                delegate: SliverChildListDelegate(
                  controller.bullets.entries.map((MapEntry e) {
                    List list = List.from(e.value);
                    List<String> elements = '${e.key}'.split('-');
                    final yearIndex = 2;
                    final dayIndex = 0;
                    final monthIndex = 1;
                    String year = elements[yearIndex];
                    String month = months[int.parse(elements[monthIndex]) - 1];
                    String day = elements[dayIndex];
                    String title = '$day $month $year';
                    DateTime now = DateTime.now();
                    bool isToday = '${now.year}'.substring(2, 4) == year &&
                        now.month == int.parse(elements[monthIndex]) &&
                        '${now.day}' == day;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Collapsible(
                          title: title,
                          openInitialized: isToday,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: list.map((item) {
                              Map bullet = Map.from(item);
                              String id = "${bullet['id']}";
                              return Bullet(
                                key: ValueKey('bullet_$id'),
                                bullet: bullet,
                              );
                            }).toList(),
                          )),
                    );
                  }).toList(),
                ),
              ),
            )
          ],
        ));
      },
    );
  }
}
