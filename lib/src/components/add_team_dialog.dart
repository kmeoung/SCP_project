import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scp/src/common/colors.dart';
import 'package:scp/src/components/content_title.dart';

class AddTeamDialog extends StatelessWidget {
  double width;
  double height;
  AddTeamDialog({Key? key, required this.width, required this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _customDialog(context);
  }

  Widget _customDialogContents(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ContentTitle(title: 'Team Select'),
          Expanded(
            child: ListView(
              children: List.generate(
                20,
                (index) => ListTile(
                  onTap: () {
                    Get.back();
                  },
                  leading: CircleAvatar(
                    backgroundColor: CustomColors.black,
                    foregroundColor: Colors.transparent,
                  ),
                  title: Text(
                    'Team Name $index',
                    style: TextStyle(color: CustomColors.black),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _customDialog(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: CustomColors.beige,
          borderRadius: BorderRadius.circular(10.0),
        ),
        width: width,
        height: height,
        child: _customDialogContents(context),
      ),
    );
  }
}
