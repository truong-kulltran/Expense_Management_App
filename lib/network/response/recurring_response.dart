import 'package:viet_wallet/network/response/base_get_response.dart';

import '../model/recurring_list_model.dart';

class RecurringResponse extends BaseGetResponse {
  final List<RecurringListModel>? listRecurring;

  RecurringResponse({
    int? pageNumber,
    int? pageSize,
    int? totalRecord,
    int? status,
    String? error,
    this.listRecurring,
  }) : super(
          pageNumber: pageNumber,
          pageSize: pageSize,
          totalRecord: totalRecord,
          status: status,
          error: error,
        );
  factory RecurringResponse.fromJson(Map<String, dynamic> json) {
    return RecurringResponse(
      listRecurring: json['content'] == null
          ? []
          : List.generate(
              json['content'].length,
              (index) => RecurringListModel.fromJson(json['content'][index]),
            ),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalRecord: json['totalRecord'],
      status: json['status'],
      error: json['error'],
    );
  }

  @override
  String toString() {
    return 'RecurringResponse{listRecurring: $listRecurring}';
  }
}
