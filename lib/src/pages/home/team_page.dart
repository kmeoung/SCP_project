import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/home/add_or_edit_team.dart';
import 'package:scp/src/pages/template/contents_template.dart';

class TeamPage extends ContentTemplate {
  final String uid;
  TeamPage({required this.uid, Key? key}) : super(uid, key: key);

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
        crossAxisCount: controller.type == ScreenSizeType.MOBILE
            ? 2
            : controller.type == ScreenSizeType.TABLET
                ? 3
                : 5,
        childAspectRatio: 8 / 8,
        crossAxisSpacing: 10,
        mainAxisSpacing: 5,
      ),
      itemBuilder: (context, index) {
        return _teamCard('Team $index');
      },
    );
  }

  Widget _teamCard(String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: CustomColors.deepPurple,
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
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                        color: CustomColors.white,
                        overflow: TextOverflow.ellipsis,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    iconSize: 30,
                    onPressed: () {
                      // todo : tid 추가 필요
                      Get.to(AddOrEditTeam(
                        uid: uid,
                        tid: '',
                      ));
                    },
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.more_horiz,
                      color: CustomColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: CustomColors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: _memberCard(
                        title: 'Team Member', color: CustomColors.deepPurple),
                  ),
                  Expanded(
                    child: _memberCard(
                        title: 'Team Member', color: CustomColors.deepPurple),
                  ),
                  Expanded(
                    child: _memberCard(
                        title: 'Team Member', color: CustomColors.deepPurple),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _memberCard({required String title, required Color color}) {
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
                style: TextStyle(color: CustomColors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            CircleAvatar(
              radius: 20,
              backgroundColor: CustomColors.white,
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
        Get.to(AddOrEditTeam(uid: uid));
      },
      child: const Icon(
        Icons.add,
        color: CustomColors.white,
      ),
      backgroundColor: CustomColors.deepPurple,
    );
  }
}
