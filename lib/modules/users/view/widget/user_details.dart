
import 'package:flutter/material.dart';

class UserDetails extends StatelessWidget {
  final String fullName;
  final String email;
  final String avatar;

  const UserDetails({
    super.key,
    required this.fullName,
    required this.email,
    required this.avatar,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: NetworkImage(avatar),
          
          ),
           SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(
            fullName,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.email, color: Colors.grey, size: 18),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Text(
                email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Text(textAlign: TextAlign.center,
            "for more information about ${fullName.split(' ').first}, please contact via email.",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}