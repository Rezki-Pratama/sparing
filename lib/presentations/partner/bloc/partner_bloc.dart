import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'partner_event.dart';
part 'partner_state.dart';

class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  PartnerBloc() : super(PartnerInitial());

  @override
  Stream<PartnerState> mapEventToState(
    PartnerEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
