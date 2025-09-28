import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tafeel_task/core/helper/constant.dart';
import 'package:tafeel_task/modules/users/logic/search_state.dart';
import 'package:tafeel_task/modules/users/model/pagination.dart';
import 'package:tafeel_task/modules/users/model/user_model.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  PaginationResponse? paginationResponse;
  List<UserModel> allUsers = [];
  List<UserModel> filteredUsers = [];
  String errorMessage = '';
  bool isLoadingMore = false;

  Future<void> fetchUsers({int page = 1}) async {
    try {
      if (page == 1) {
        emit(SearchLoading());
      } else {
        isLoadingMore = true;
        emit(SearchLoadingMore());
      }

      ApiResponse response = await ApiHelper.makeGetRequest(
        ApiConstants.usersEndpoint,
        queryParams: {'page': page},
      );

      if (response.isSuccess && response.data != null) {

        paginationResponse = PaginationResponse.fromJson(response.data);
    
        if (page == 1) {
          allUsers = paginationResponse!.data;
        } else {
          allUsers.addAll(paginationResponse!.data);
        }

        filteredUsers = List.from(allUsers);
        isLoadingMore = false;
        emit(SearchSuccess());
      } else {
        errorMessage = response.errorMessage ?? ResponseMessages.serverError;
        isLoadingMore = false;
        emit(SearchError());
      }
    } catch (e) {
      errorMessage = '${ResponseMessages.networkError}: ${e.toString()}';
      isLoadingMore = false;
      emit(SearchError());
    }
  }

  Future<void> loadMoreUsers() async {
    if (paginationResponse?.hasNextPage == true && !isLoadingMore) {
      await fetchUsers(page: currentPage + 1);
    }
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers = List.from(allUsers);
    } else {
      filteredUsers = allUsers.where((user) {
        return user.fullName.toLowerCase().contains(query.toLowerCase()) ||
            user.email.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
    emit(SearchSuccess());
  }

  UserModel? selectedUser;
   final Map<int, UserModel> userDetailsCache = {};
  
  
    Future<void> getUserDetails(int userId) async {
      try {
  
        if (userDetailsCache.containsKey(userId)) {
          selectedUser = userDetailsCache[userId];
          emit(UserDetailsSuccess());
          return;
        }
        emit(UserDetailsLoading());
  
        ApiResponse response = await ApiHelper.makeGetRequest(
          '${ApiConstants.usersEndpoint}/$userId',
        );
  
        if (response.isSuccess && response.data != null) {
  
          selectedUser = UserModel.fromJson(response.data['data']);
           userDetailsCache[userId] = selectedUser!;
  
    
          emit(UserDetailsSuccess());
        } else {
          errorMessage = response.errorMessage ?? ResponseMessages.serverError;
          emit(UserDetailsError());
        }
      } catch (e) {
        errorMessage = '${ResponseMessages.networkError}: ${e.toString()}';
        emit(UserDetailsError());
      }
    }
  

  bool get hasNextPage => paginationResponse?.hasNextPage ?? false;
  bool get hasPreviousPage => paginationResponse?.hasPreviousPage ?? false;
  int get currentPage => paginationResponse?.page ?? 1;
  int get totalPages => paginationResponse?.totalPages ?? 1;
}
