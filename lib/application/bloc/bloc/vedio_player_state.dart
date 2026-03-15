part of 'vedio_player_bloc.dart';

@freezed
class VedioPlayerState with _$VedioPlayerState {
  const factory VedioPlayerState.initial() = _Initial;
  const factory VedioPlayerState.ready(
      {required WebViewController controller}) = _Ready;
}
