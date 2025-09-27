import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tafeel_task/modules/users/logic/search_cubit.dart';
import 'package:tafeel_task/modules/users/logic/search_state.dart';
import 'package:tafeel_task/modules/users/view/widget/user_details.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userId;
  const UserDetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => SearchCubit()..getUserDetails(userId),
      child: Scaffold(
          appBar: AppBar(
            title: Text('User Details'),
          ),
          body: BlocConsumer<SearchCubit, SearchState>(
            listener: (context, state) {
              if (state is UserDetailsError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.read<SearchCubit>().errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is UserDetailsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is UserDetailsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        context.read<SearchCubit>().errorMessage,
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                      ElevatedButton(
                        onPressed: () {
                          context.read<SearchCubit>().getUserDetails(userId);
                        },
                        child: Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is UserDetailsSuccess) {
                final user = context.read<SearchCubit>().selectedUser!;
                return UserDetails(
                  fullName: user.fullName,
                  email: user.email,
                  avatar: user.avatar,
                );
              }
        
              return Center(
                child: Text('Loading user details...'),
              );
            },
          ),
        ));
      }
    
  }
