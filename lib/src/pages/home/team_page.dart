import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/template/contents_template.dart';

class TeamPage extends ContentTemplate {
  TeamPage({Key? key}) : super(key: key);

  @override
  List<Widget> customDetail(BuildContext context) {
    return [
      ContentTitle(title: 'My Team'),
      _homeItemView(tempCount: 1),
      const SizedBox(
        height: 40,
      ),
      ContentTitle(title: 'Shared Team'),
      _homeItemView(tempCount: 2),
    ];
  }

  Widget _homeItemView({int tempCount = 2}) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tempCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: controller.type.value == ScreenSizeType.MOBILE
            ? 2
            : controller.type.value == ScreenSizeType.TABLET
                ? 3
                : 5,
        childAspectRatio: 8 / 8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return _projectCard('Team $index');
      },
    );
  }

  Widget _projectCard(String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: CustomColors.black,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 45,
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9.0),
            alignment: Alignment.centerLeft,
            color: Colors.transparent,
            child: SizedBox(
              height: 30,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.beige,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    iconSize: 30,
                    onPressed: () {
                      Get.toNamed(AllRoutes.TEAM_EDIT
                          .replaceAll(AllRoutes.ARGS_TEAMID, '1'));
                    },
                    padding: EdgeInsets.zero,
                    icon: Icon(
                      Icons.more_horiz,
                      color: CustomColors.beige,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: CustomColors.beige,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _taskCard(
                        title: 'Team Member', color: CustomColors.black),
                  ),
                  Expanded(
                    child: _taskCard(
                        title: 'Team Member', color: CustomColors.black),
                  ),
                  Expanded(
                    child: _taskCard(
                        title: 'Team Member', color: CustomColors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _taskCard({required String title, required Color color}) {
    return Card(
      elevation: 5.0,
      color: color.withOpacity(0.7),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        alignment: Alignment.center,
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(color: CustomColors.beige),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: CustomColors.beige,
            )
          ],
        ),
      ),
    );
  }

  @override
  FloatingActionButton? floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        Get.toNamed(AllRoutes.TEAM_ADD);
      },
      child: Icon(
        Icons.add,
        color: CustomColors.beige,
      ),
      backgroundColor: CustomColors.black,
    );
  }
}
