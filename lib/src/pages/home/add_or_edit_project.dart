import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/components/content_title.dart';
import 'package:scp/src/controller/screen_layout_controller.dart';
import 'package:scp/src/pages/template/contents_template.dart';

class AddOrEditProject extends ContentTemplate {
  AddOrEditProject({Key? key}) : super(key: key);
  bool isEdit = false;
  @override
  List<Widget> customDetail() {
    isEdit = Get.parameters['pid'] != null;

    return [
      ContentTitle(
        title: '${isEdit ? 'Edit' : 'Add'} Project',
      ),
      _header('Input title'),
      const SizedBox(
        height: 20,
      ),
      _header('Add Team'),
      const SizedBox(
        height: 20,
      ),
      _header('Add Team Member'),
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
            hintStyle: TextStyle(color: CustomColors.black.withOpacity(0.5)),
            label: null,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _member() {
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
                    color: CustomColors.black.withOpacity(0.2), width: 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: CustomColors.beige,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'name',
                    style: TextStyle(color: CustomColors.beige, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ),
        controller.type.value != ScreenSizeType.MOBILE
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
              height: 50,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
        style: TextStyle(color: CustomColors.beige),
      ),
      icon: Icon(
        Icons.edit,
        color: CustomColors.beige,
      ),
      backgroundColor: CustomColors.black,
    );
  }
}
