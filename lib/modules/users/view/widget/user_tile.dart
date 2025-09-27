
import 'package:flutter/material.dart';
import 'package:tafeel_task/core/theme/app_colors.dart';

class UserTile extends StatelessWidget {
  String id;
  String avatar;
  String email;
  String fullName;
  String firstName;
  VoidCallback? onTap;
  UserTile({
    super.key,
    required this.avatar,
    required this.id,
    required this.email,
    required this.fullName,

    required this.firstName,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.04,
            vertical: MediaQuery.of(context).size.height * 0.02
        ),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(avatar),
              backgroundColor: AppColors.primary,
              child: id.isEmpty? Icon(Icons.person, color: AppColors.secondary): null,
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.04),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    fullName,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                  Text(
                    email,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.secondary.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}