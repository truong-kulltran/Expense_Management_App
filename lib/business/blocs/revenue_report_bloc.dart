import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viet_wallet/data/provider/category_provider.dart';
import 'package:viet_wallet/data/response/base_response.dart';
import 'package:viet_wallet/data/response/category_report_response.dart';
import 'package:viet_wallet/presentation/screens/report_screen/revenue_report/revenue_report_event.dart';
import 'package:viet_wallet/presentation/screens/report_screen/revenue_report/revenue_report_state.dart';
import 'package:viet_wallet/utils/enum/api_error_result.dart';
import 'package:viet_wallet/utils/enum/enum.dart';
import 'package:viet_wallet/utils/screen_utilities.dart';

class RevenueReportBloc extends Bloc<RevenueReportEvent, RevenueReportState> {
  final BuildContext context;

  RevenueReportBloc(this.context) : super(RevenueReportState()) {
    on<RevenueReportEvent>((event, emit) async {
      final response = await CategoryProvider().getDataReport(type: TransactionType.income);

      if (response is CategoryReportResponse) {
        emit(state.copyWith(
          isLoading: false,
          apiError: ApiError.noError,
          listReport: response.listReport,
        ));
      } else if (response is ExpiredTokenResponse && context.mounted) {
        logoutIfNeed(context);
      } else {
        emit(state.copyWith(
          isLoading: false,
          apiError: ApiError.internalServerError,
          listReport: [],
        ));
      }
    });
  }
}
