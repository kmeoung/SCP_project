import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/common/routes.dart';
import 'package:scp/src/components/add_team_dialog.dart';
import 'package:scp/src/components/add_team_member_dialog.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/template/contents_template.dart';

class AddOrEditTeam extends ContentTemplate {
  final String uid;
  final String? tid;

  AddOrEditTeam({required this.uid, this.tid, Key? key}) : super(uid, key: key);
  bool isEdit = false;
  @override
  List<Widget> customDetail(BuildContext context) {
    isEdit = tid != null;

    return [
      ContentTitle(
        title: '${isEdit ? 'Edit' : 'Add'} Team',
      ),
      _header('Input Team Title'),
      const SizedBox(
        height: 20,
      ),
      _addTeam(context, 'Add Team'),
      const SizedBox(
        height: 20,
      ),
      _addTeamMember(context, 'Add Team Member'),
      const SizedBox(
        height: 40,
      ),
      _member(),
      const SizedBox(
        height: 10,
      ),
      _member(),
      const SizedBox(
        height: 10,
      ),
      _member(),
    ];
  }

  Widget _header(String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: TextField(
          textInputAction: TextInputAction.next,
          maxLines: null,
          decoration: InputDecoration(
            hintText: title,
            hintStyle:
                TextStyle(color: CustomColors.deepPurple.withOpacity(0.5)),
            label: null,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _addTeam(BuildContext context, String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTeamDialog(
                width: Get.width * 0.7,
                height: Get.height * 0.5,
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 17),
          child: Text(
            title,
            style: TextStyle(
              color: CustomColors.deepPurple.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addTeamMember(BuildContext context, String title) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5.0,
      color: Colors.white,
      child: InkWell(
        borderRadius: BorderRadius.circular(10.0),
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddTeamMemberDialog(
                width: Get.width * 0.7,
                height: Get.height * 0.5,
              );
            },
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 17),
          child: Text(
            title,
            style: TextStyle(
              color: CustomColors.deepPurple.withOpacity(0.5),
            ),
          ),
        ),
      ),
    );
  }

  Widget _member() {
    List<String> _permissions = ['?????????', '??????/??????', '?????????'];

    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                    color: CustomColors.deepPurple.withOpacity(0.2), width: 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomColors.white,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      'name',
                      style: TextStyle(color: CustomColors.white, fontSize: 12),
                    ),
                  ),
                  IconButton(
                    splashRadius: 20,
                    onPressed: () {},
                    icon: Icon(
                      Icons.close,
                      color: CustomColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        controller.type != ScreenSizeType.MOBILE
            ? Flexible(flex: 2, child: Container())
            : Container(),
        Flexible(
          flex: 1,
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            elevation: 5.0,
            color: Colors.white,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: DropdownButton(
                dropdownColor: CustomColors.white,
                borderRadius: BorderRadius.circular(10.0),
                isExpanded: true,
                value: _permissions[0],
                elevation: 0,
                style: TextStyle(color: CustomColors.deepPurple, fontSize: 12),
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: CustomColors.deepPurple,
                ),
                underline: Container(),
                onChanged: (String? value) {},
                alignment: Alignment.centerRight,
                items: _permissions
                    .map<DropdownMenuItem<String>>((String value) =>
                        DropdownMenuItem<String>(
                            value: value, child: SizedBox(child: Text(value))))
                    .toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  FloatingActionButton? floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        Get.back();
      },
      label: Text(
        isEdit ? 'Edit' : 'Create',
        style: TextStyle(color: CustomColors.white),
      ),
      icon: Icon(
        Icons.edit,
        color: CustomColors.white,
      ),
      backgroundColor: CustomColors.deepPurple,
    );
  }
}
