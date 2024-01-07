import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:closure_task6/models/ad.models.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'ad_state.dart';

class AdCubit extends Cubit<List<Ad>> {
  AdCubit() : super([]);
  void getAds() async {
    print('...getAds being called...');
    int x = 0;
    var adsData = await rootBundle.loadString('assets/data/sample.json');
    var dataDecoded =
        List<Map<String, dynamic>>.from(jsonDecode(adsData)['ads']);
    List<Ad> adsList = [];
    adsList = List<Ad>.from(dataDecoded.map((e) => Ad.fromjson(e)));
    for (var el in (adsList as Iterable)) {
      x++;
      adsList.add(Ad.fromjson(el));
    }
    print('...now states will be emitted ...');
    emit(adsList);
  }
}
