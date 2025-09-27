import 'package:tafeel_task/modules/users/model/user_model.dart';



class PaginationResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> data;
  

  PaginationResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  
  });

  factory PaginationResponse.fromJson(Map<String, dynamic> json) {
    return PaginationResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      data: (json['data'] as List)
          .map((user) => UserModel.fromJson(user))
          .toList(),
     
    );
  }

  bool get hasNextPage => page < totalPages;
  bool get hasPreviousPage => page > 1;
}