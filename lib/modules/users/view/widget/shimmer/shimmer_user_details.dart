import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerUserDetails extends StatelessWidget {
  const ShimmerUserDetails({super.key});

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
          Shimmer(
            duration: Duration(seconds: 2),
            child: CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey[300],
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Shimmer(
            duration: Duration(seconds: 2),
            child: Container(
              height: 22,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Shimmer(
                duration: Duration(seconds: 2),
                child: Icon(Icons.email, color: Colors.grey[300], size: 18),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.02),
              Shimmer(
                duration: Duration(seconds: 2),
                child: Container(
                  height: 16,
                  width: MediaQuery.of(context).size.width * 0.4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Shimmer(
            duration: Duration(seconds: 2),
            child: Container(
              height: 16,
              width: MediaQuery.of(context).size.width * 0.8,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          Shimmer(
            duration: Duration(seconds: 2),
            child: Container(
              height: 16,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }
}