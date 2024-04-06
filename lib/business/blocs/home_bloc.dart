import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viet_wallet/data/provider/category_provider.dart';
import 'package:viet_wallet/data/repository/wallet_repository.dart';
import 'package:viet_wallet/data/response/base_get_response.dart';
import 'package:viet_wallet/data/response/get_list_wallet_response.dart';
import 'package:viet_wallet/data/response/week_report_response.dart';
import 'package:viet_wallet/presentation/screens/home_screen/home_event.dart';
import 'package:viet_wallet/presentation/screens/home_screen/home_state.dart';
import 'package:viet_wallet/utils/enum/api_error_result.dart';
import 'package:viet_wallet/utils/screen_utilities.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final BuildContext context;
  final _walletRepository = WalletRepository();

  HomePageBloc(this.context) : super(HomePageState()) {
    on((event, emit) async {
      if (event is HomeInitial) {
        emit(state.copyWith(isLoading: true));

        final connectivityResult = await Connectivity().checkConnectivity();
        if (connectivityResult == ConnectivityResult.none) {
          emit(state.copyWith(
            isLoading: false,
            apiError: ApiError.noInternetConnection,
          ));
        } else {
          final response = await _walletRepository.getListWallet();

          if (response is GetListWalletResponse) {
            emit(state.copyWith(
              isLoading: false,
              apiError: ApiError.noError,
              moneyTotal: response.moneyTotal,
              listWallet: response.walletList,
            ));
          } else if (response is ExpiredTokenGetResponse && context.mounted) {
            logoutIfNeed(context);
          } else {
            emit(state.copyWith(
              isLoading: false,
              apiError: ApiError.internalServerError,
              listWallet: [],
            ));
          }

          final weekResponse = await CategoryProvider().getWeekReport();

          if (weekResponse is WeekReportResponse) {
            emit(state.copyWith(
              isLoading: false,
              apiError: ApiError.noError,
              weekReport: weekResponse.data,
            ));
          } else if (weekResponse is ExpiredTokenGetResponse && context.mounted) {
            logoutIfNeed(context);
          } else {
            emit(state.copyWith(
              isLoading: false,
              apiError: ApiError.internalServerError,
              weekReport: null,
            ));
          }
        }
      }
    });
  }
}
