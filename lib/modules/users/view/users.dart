import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeel_task/modules/users/logic/search_cubit.dart';
import 'package:tafeel_task/modules/users/logic/search_state.dart';
import 'package:tafeel_task/modules/users/view/user_details_screen.dart';
import 'package:tafeel_task/modules/users/view/widget/custom_text_field.dart';
import 'package:tafeel_task/modules/users/view/widget/user_tile.dart';

class AllUsers extends StatelessWidget {
  AllUsers({super.key});

   final TextEditingController _searchController = TextEditingController();
   final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit()..fetchUsers(),
      child: Scaffold(
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
                          content:
                              Text(context.read<SearchCubit>().errorMessage),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is SearchError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              context.read<SearchCubit>().errorMessage,
                              style: TextStyle(color: Colors.red),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                                height: MediaQuery.of(context).size.height * 0.02),
                            ElevatedButton(
                              onPressed: () {context.read<SearchCubit>().fetchUsers();},
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      );
                    } else if (state is SearchSuccess ||state is SearchLoadingMore){ 

                      var cubit = BlocProvider.of<SearchCubit>(context);

                      if (cubit.filteredUsers.isEmpty && state is SearchSuccess) {
                        return Center(
                          child: Text('No users found'),
                        );
                      }
                      return Column(
                        children: [
                          Expanded(
                            child: NotificationListener<ScrollNotification>(
                              onNotification: (ScrollNotification scrollInfo) {
                                if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {_onScroll(context); }
                                return false;
                              },
                              child: ListView.builder(
                                controller: _scrollController,
                                itemCount: cubit.filteredUsers.length + (cubit.hasNextPage ? 1 : 0),
                                itemBuilder: (context, index) {
                                  if (index == cubit.filteredUsers.length) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: MediaQuery.of(context)  .size .width * 0.04,
                                          vertical: MediaQuery.of(context).size.height *0.02),
                                      child: Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                    );
                                  }

                                  return UserTile(
                                    avatar: cubit.filteredUsers[index].avatar,
                                    email: cubit.filteredUsers[index].email,
                                    fullName: cubit.filteredUsers[index].fullName,
                                    firstName: cubit.filteredUsers[index].firstName,
                                    id: cubit.filteredUsers[index].id .toString(),
                                    onTap: () {
                                      Navigator.push( context,
                                       MaterialPageRoute(builder: (context) => UserDetailsScreen(userId: cubit.filteredUsers[index].id),
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                    return Center(
                      child: Text('Welcome! Start searching for users.'),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onScroll(BuildContext context) {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      final cubit = context.read<SearchCubit>();
      if (cubit.hasNextPage && !cubit.isLoadingMore) {
        cubit.loadMoreUsers();
      }
    }
  }
}
