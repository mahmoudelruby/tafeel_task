import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeel_task/modules/users/logic/search_cubit.dart';
import 'package:tafeel_task/modules/users/logic/search_state.dart';
import 'package:tafeel_task/modules/users/model/user_model.dart';
import 'package:tafeel_task/modules/users/view/user_details_screen.dart';
import 'package:tafeel_task/modules/users/view/widget/custom_text_field.dart';
import 'package:tafeel_task/modules/users/view/widget/shimmer/shimmer_user_tile.dart';
import 'package:tafeel_task/modules/users/view/widget/user_tile.dart';
  
class AllUsers extends StatelessWidget {
  AllUsers({super.key});

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
  
    context.read<SearchCubit>().fetchUsers();
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Search Screen'),
      ),
      body: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.04),
        child: Column(
          children: [
            BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
              return CustomTextFiled(
                hintText: 'Search Users',
                controller: _searchController,
                onChanged: (value) {
                  context.read<SearchCubit>().searchUsers(value);
                },
              );
            }),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
                child: BlocConsumer<SearchCubit, SearchState>(
                listener: (context, state) {
                 if (state is SearchError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.read<SearchCubit>().errorMessage),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }, builder: (context, state) {
               if (state is SearchLoading) {
                return ListView.separated(

                  itemCount: 6,
                  separatorBuilder: (context, index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  itemBuilder: (context, index) => const ShimmerUserTile(),
                );
              } else if (state is SearchError) {
                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<SearchCubit>().fetchUsers();
                  },
                  child: Center(
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
                            context.read<SearchCubit>().fetchUsers();
                          },
                          child: Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                );
        } else if (state is SearchSuccess &&
                  context.watch<SearchCubit>().filteredUsers.isEmpty) {
                return Center( child: Text('No users found.'));
              }
              return 
                  RefreshIndicator(
                    onRefresh: () async {
                      context.read<SearchCubit>().fetchUsers();
                    },
                    child: NotificationListener<ScrollNotification>(
                     onNotification: (scrollNotification) {
                    if (scrollNotification is ScrollEndNotification) {
                      _onScroll(context);
                    }return false;},
                    child: ListView.separated(
                    controller: _scrollController,
                    itemCount: context.watch<SearchCubit>().filteredUsers.length + (context.watch<SearchCubit>().isLoadingMore ? 1 : 0),
                    separatorBuilder: (context, index) => SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    itemBuilder: (context, index) {
                      final cubit = context.watch<SearchCubit>();
                      if (index >= cubit.filteredUsers.length) {
                        return const Center(child: CircularProgressIndicator(
                          color: Colors.grey,
                        ));
                      }
                      UserModel user = cubit.filteredUsers[index];
                      return UserTile(
                        id: user.id.toString(),
                        firstName: user.firstName,
                        fullName: user.fullName,
                        email: user.email,
                        avatar: user.avatar,
                            onTap: () {
                               Navigator.push(context, MaterialPageRoute(
                                builder: (context) => UserDetailsScreen(userId: user.id
                                ),
                              ),
                            );
                          },
                      );
                    },
                                    ),
                                  ),
                  );
            })),
          ],
        ),
      ),
    );
  }

  void _onScroll(BuildContext context) {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      SearchCubit cubit = context.read<SearchCubit>();
      if (cubit.hasNextPage && !cubit.isLoadingMore) {
        cubit.loadMoreUsers();
      }
    }
  }
}