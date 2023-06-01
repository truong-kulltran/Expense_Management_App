import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:viet_wallet/utilities/utils.dart';
import 'package:viet_wallet/widgets/animation_loading.dart';

import '../../../../network/model/data_sfcartesian_char_model.dart';
import '../../../../network/model/report_expenditure_revenue_model.dart';
import '../../../../utilities/shared_preferences_storage.dart';
import 'custom_bloc.dart';
import 'custom_event.dart';
import 'custom_state.dart';

class CustomAnalytic extends StatefulWidget {
  final List<int> walletIDs;
  final String fromTime, toTime;
  const CustomAnalytic({
    Key? key,
    required this.walletIDs,
    required this.fromTime,
    required this.toTime,
  }) : super(key: key);

  @override
  State<CustomAnalytic> createState() => _CustomAnalyticState();
}

class _CustomAnalyticState extends State<CustomAnalytic> {
  final currency = SharedPreferencesStorage().getCurrency() ?? '\$/USD';

  @override
  void initState() {
    BlocProvider.of<CustomAnalyticBloc>(context).add(CustomAnalyticEvent(
      walletIDs: widget.walletIDs,
      fromTime: widget.fromTime,
      toTime: widget.toTime,
    ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CustomAnalyticBloc, CustomAnalyticState>(
      builder: (context, state) {
        List<ReportData> data = state.data ?? [];
        log(data.toString());

        List<DataSf> sfListExpense = data.map((reportData) {
          return DataSf(
            title: reportData.name,
            value: reportData.expenseTotal / 1000000,
          );
        }).toList();
        List<DataSf> sfListIncome = data.map((reportData) {
          return DataSf(
            title: reportData.name,
            value: reportData.incomeTotal / 1000000,
          );
        }).toList();
        List<DataSf> sfListRemain = data.map((reportData) {
          return DataSf(
            title: reportData.name,
            value: reportData.remainTotal / 1000000,
          );
        }).toList();

        return state.isLoading
            ? const AnimationLoading()
            : SingleChildScrollView(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _charts(sfListIncome, sfListExpense, sfListRemain),
                    Divider(
                      height: 10,
                      thickness: 10,
                      color: Theme.of(context).backgroundColor,
                    ),
                    SizedBox(
                      height: 100 * (data.length.toDouble()),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) => _itemList(data[index]),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }

  Widget _itemList(ReportData data) {
    return Container(
      decoration: BoxDecoration(
        border: BorderDirectional(
          top: BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.2)),
          bottom: BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.2)),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: SizedBox(
        height: 100,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              isNotNullOrEmpty(data.name) ? data.name : '',
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '${data.incomeTotal} $currency',
                  style: const TextStyle(fontSize: 14, color: Colors.green),
                ),
                Text(
                  '${data.expenseTotal} $currency',
                  style: const TextStyle(fontSize: 14, color: Colors.red),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  decoration: const BoxDecoration(
                    border: BorderDirectional(
                      top: BorderSide(width: 0.5, color: Colors.grey),
                    ),
                  ),
                  child: Text(
                    '${data.remainTotal} $currency',
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _charts(List<DataSf> listIncome, listExpense, listRemain) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, top: 10.0, bottom: 4),
          child: Text(
            '(Đơn vị: triệu VNĐ)',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SfCartesianChart(
          primaryXAxis: CategoryAxis(),
          tooltipBehavior: TooltipBehavior(enable: true),
          series: <ChartSeries>[
            ColumnSeries<DataSf, String>(
              dataSource: listIncome,
              xValueMapper: (DataSf data, _) => data.title,
              yValueMapper: (DataSf data, _) => data.value,
              name: 'Income',
              color: Colors.grey,
              // Enable data label
              // dataLabelSettings: DataLabelSettings(isVisible: true)
            ),
            ColumnSeries<DataSf, String>(
              dataSource: listExpense,
              xValueMapper: (DataSf data, _) => data.title,
              yValueMapper: (DataSf data, _) => data.value,
              name: 'Expense',
              color: Colors.blue,
              // Enable data label
              // dataLabelSettings: DataLabelSettings(isVisible: true)
            ),
            ColumnSeries<DataSf, String>(
              dataSource: listRemain,
              xValueMapper: (DataSf data, _) => data.title,
              yValueMapper: (DataSf data, _) => data.value,
              name: 'Remain',
              color: Colors.red,
              // Enable data label
              // dataLabelSettings: DataLabelSettings(isVisible: true)
            )
          ],
        ),
      ],
    );
  }
}
