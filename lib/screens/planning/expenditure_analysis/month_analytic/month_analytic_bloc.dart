import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viet_wallet/network/model/analytic_model.dart';
import 'package:viet_wallet/network/response/base_response.dart';
import 'package:viet_wallet/screens/planning/expenditure_analysis/month_analytic/month_analytic_event.dart';
import 'package:viet_wallet/screens/planning/expenditure_analysis/month_analytic/month_analytic_state.dart';

import '../../../../network/provider/analytic_provider.dart';
import '../../../../utilities/enum/api_error_result.dart';
import '../../../../utilities/screen_utilities.dart';

class MonthAnalyticBloc extends Bloc<MonthAnalyticEvent, MonthAnalyticState> {
  final BuildContext context;
  MonthAnalyticBloc(this.context) : super(MonthAnalyticState()) {
    on((event, emit) async {
      if (event is MonthAnalyticEvent) {
        // emit(state.copyWith(isLoading: true));

        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            isLoading: false,
            apiError: ApiError.noInternetConnection,
          ));
        } else {
          final Map<String, dynamic> query = {
            'fromTime': event.fromMonth,
            'timeType': 'MONTH',
            'toTime': event.toMonth,
            'type': event.type.name.toUpperCase()
          };

          final Map<String, dynamic> data = {
            if (event.walletIDs.isNotEmpty) 'walletIds': event.walletIDs,
            if (event.categoryIDs.isNotEmpty) 'categoryIds': event.categoryIDs,
          };

          final response = await AnalyticProvider().getDayEXAnalytic(
            query: query,
            data: data,
          );

          if (response is AnalyticModel) {
            emit(state.copyWith(
              isLoading: false,
              apiError: ApiError.noError,
              data: response,
            ));
          } else if (response is ExpiredTokenResponse) {
            logoutIfNeed(this.context);
          } else {
            emit(state.copyWith(
              isLoading: false,
              apiError: ApiError.internalServerError,
            ));
          }
        }
      }
    });
  }
}
