import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:viet_wallet/data/provider/wallet_provider.dart';
import 'package:viet_wallet/data/response/base_get_response.dart';
import 'package:viet_wallet/data/response/get_list_wallet_response.dart';
import 'package:viet_wallet/presentation/screens/setting_screen/export_file_screen/export_file_event.dart';
import 'package:viet_wallet/presentation/screens/setting_screen/export_file_screen/export_file_state.dart';
import 'package:viet_wallet/utils/screen_utilities.dart';

class ExportBloc extends Bloc<ExportEvent, ExportState> {
  final BuildContext context;

  final _walletProvider = WalletProvider();

  ExportBloc(this.context) : super(LoadingState()) {
    on<ExportEvent>((event, emit) async {
      if (event is Initial) {
        emit(LoadingState());

        final response = await _walletProvider.getListWallet();
        if (response is GetListWalletResponse) {
          emit(ExportInitial(listWallet: response.walletList));
        } else if (response is ExpiredTokenGetResponse && context.mounted) {
          logoutIfNeed(context);
        } else {
          emit(ErrorServerState());
        }
      }
    });
  }
}
