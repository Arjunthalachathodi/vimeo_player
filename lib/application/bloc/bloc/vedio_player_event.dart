part of 'vedio_player_bloc.dart';

@freezed
class VedioPlayerEvent with _$VedioPlayerEvent {
  const factory VedioPlayerEvent.initializePlayer({required String videoId}) =
      _InitializePlayer;
}
