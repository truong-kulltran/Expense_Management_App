import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:viet_wallet/utilities/utils.dart';

import '../network/model/frequency_model.dart';
import '../utilities/enum/enum.dart';

class FrequencyPickerScreen extends StatefulWidget {
  const FrequencyPickerScreen({super.key});

  @override
  State<FrequencyPickerScreen> createState() => _FrequencyPickerScreenState();
}

class _FrequencyPickerScreenState extends State<FrequencyPickerScreen> {
  List<DayOfWeek> listDay = [];
  String? sortedTitles;

  Frequency frequencySelected = Frequency(
    title: 'Hàng ngày',
    frequencyType: FrequencyType.daily,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          onPressed: () {
            if (frequencySelected.frequencyType == FrequencyType.weekday) {
              Navigator.of(context).pop(listDay);
            } else {
              Navigator.of(context).pop(frequencySelected);
            }
          },
          icon: const Icon(
            Icons.done,
            size: 24,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Pick Frequency',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: listFrequency.length,
        itemBuilder: (context, index) {
          final frequency = listFrequency[index];
          listDay.sort((a, b) => a.index.compareTo(b.index));
          List<String> titles = listDay.map((day) => day.title).toList();

          if (const ListEquality().equals(listDay, listDayOfWeek)) {
            sortedTitles = 'Tất cả các ngày trong tuần';
          } else {
            sortedTitles = titles.join(', ');
          }

          return Container(
            decoration: BoxDecoration(
              border: BorderDirectional(
                top:
                    BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.2)),
                bottom:
                    BorderSide(width: 0.5, color: Colors.grey.withOpacity(0.2)),
              ),
            ),
            child: ListTile(
              title: Text(frequency.title),
              subtitle: (frequency.frequencyType == FrequencyType.weekday)
                  ? isNotNullOrEmpty(sortedTitles)
                      ? Text(
                          sortedTitles!,
                          textAlign: TextAlign.end,
                        )
                      : null
                  : null,
              trailing:
                  frequencySelected.frequencyType == frequency.frequencyType
                      ? Icon(
                          Icons.check,
                          size: 24,
                          color: Theme.of(context).primaryColor,
                        )
                      : null,
              onTap: () async {
                setState(() {
                  frequencySelected = frequency;
                });

                if (frequency.frequencyType == FrequencyType.weekday) {
                  final List<DayOfWeek>? result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DayOfWeekPickerScreen(listDay: listDay),
                    ),
                  );
                  setState(() {
                    listDay = result ?? [];
                  });
                } else {
                  // Handle other frequency types
                  // ...
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class DayOfWeekPickerScreen extends StatefulWidget {
  final List<DayOfWeek>? listDay;
  const DayOfWeekPickerScreen({super.key, this.listDay});

  @override
  DayOfWeekPickerScreenState createState() => DayOfWeekPickerScreenState();
}

class DayOfWeekPickerScreenState extends State<DayOfWeekPickerScreen> {
  List<DayOfWeek> selectedDays = [];

  bool isDaySelected(DayOfWeek day) {
    return selectedDays.contains(day);
  }

  void toggleDaySelection(DayOfWeek day) {
    setState(() {
      if (isDaySelected(day)) {
        selectedDays.remove(day);
      } else {
        selectedDays.add(day);
      }
    });
  }

  void initListDay() {
    widget.listDay?.forEach((element) {
      selectedDays.add(element);
    });
  }

  @override
  void initState() {
    initListDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop(selectedDays);
            },
            icon: const Icon(
              Icons.done,
              size: 24,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          title: const Text(
            'Pick Day of Week',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
            itemCount: listDayOfWeek.length,
            itemBuilder: (context, index) {
              final day = listDayOfWeek[index];
              return ListTile(
                title: Text(day.title),
                trailing: isDaySelected(day)
                    ? const Icon(Icons.check_box)
                    : const Icon(Icons.check_box_outline_blank),
                onTap: () {
                  toggleDaySelection(day);
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
