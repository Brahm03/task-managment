import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_managment/consts/app_colors.dart';
import 'package:task_managment/main.dart';
import 'package:task_managment/providers/project_provider.dart';

class AddNewMemberWidget extends StatefulWidget {
  const AddNewMemberWidget({super.key});

  @override
  State<AddNewMemberWidget> createState() => _AddNewMemberWidgetState();
}

class _AddNewMemberWidgetState extends State<AddNewMemberWidget> {
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final userImages = context.watch<ProjectProvider>().userImages;
    final tanlanganRasm = context.watch<ProjectProvider>().tanlanganRasm;
    return Container(
      height: 500,
      width: double.infinity,
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Theme.of(context).brightness == Brightness.dark ? AppColors.dark: AppColors.white, borderRadius: BorderRadius.circular(40)),
      padding: EdgeInsets.symmetric(horizontal: 22, vertical: 10),
      child: Column(
        children: [
          Container(
            height: 8,
            width: 35,
            decoration: BoxDecoration(
                color: AppColors.grey, borderRadius: BorderRadius.circular(40)),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
                hintText: 'Enter usename',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40))),
          ),
          SizedBox(height: 30),
          Text('Pick user image'),
          SizedBox(height: 30),
          SizedBox(
            height: 100,
            child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        context.read<ProjectProvider>().rasmTanlash(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: tanlanganRasm == index
                                ? Border.all(color: AppColors.primary, width: 5)
                                : null),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.network(
                            userImages[index],
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => SizedBox(width: 20),
                itemCount: userImages.length),
          ),
          Spacer(),
          FilledButton(
              onPressed: _nameController.text.isEmpty && tanlanganRasm == -1 ? null : () {
                  context.read<ProjectProvider>().addMember(
                      _nameController.text, userImages[tanlanganRasm]);
                  Navigator.pop(context);
              },
              child: Text('Save'))
        ],
      ),
    );
  }
}
