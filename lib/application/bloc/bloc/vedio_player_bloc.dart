import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:webview_flutter/webview_flutter.dart';

part 'vedio_player_event.dart';
part 'vedio_player_state.dart';
part 'vedio_player_bloc.freezed.dart';

class VedioPlayerBloc extends Bloc<VedioPlayerEvent, VedioPlayerState> {
  VedioPlayerBloc() : super(const VedioPlayerState.initial()) {
    on<_InitializePlayer>((event, emit) {
      final controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadHtmlString('''
      <html>
      <head>
        <script src="https://player.vimeo.com/api/player.js"></script>
        <style>
          body { margin: 0; background-color: black; overflow: hidden; }
          iframe { width: 100vw; height: 100vh; border: none; }
        </style>
      </head>
      <body>
      <iframe id="vimeo-player" src="https://player.vimeo.com/video/${event.videoId}?api=1&badge=0&autopause=0&player_id=0&app_id=58479"
      allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" 
      referrerpolicy="strict-origin-when-cross-origin" 
      title="How_to_Embed_a_Vimeo_Video_on_Your_Site">
      </iframe>
      <script>
        var iframe = document.getElementById('vimeo-player');
        var player = new Vimeo.Player(iframe);
      </script>
      </body>
      </html>
      ''');

      emit(VedioPlayerState.ready(controller: controller));
    });
  }
}
