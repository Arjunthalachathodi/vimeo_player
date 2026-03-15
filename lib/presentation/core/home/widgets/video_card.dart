import 'package:flutter/material.dart';
import '../../../../application/core/theme/colors.dart';
import '../../../../application/core/theme/text_styles.dart';
import '../../../../application/core/theme/diamentions.dart';
import '../screens/vimeo_player_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';

class VideoCard extends StatefulWidget {
  const VideoCard({super.key});

  @override
  State<VideoCard> createState() => _VideoCardState();
}

class _VideoCardState extends State<VideoCard> {
  late final WebViewController controller;
  String _videoTitle = 'Loading...';
  String _videoDuration = '0:00';
  double _playbackProgress = 0.0;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'VimeoStatus',
        onMessageReceived: (JavaScriptMessage message) {
          if (!mounted) return;
          final parts = message.message.split(',');
          if (parts.length >= 3) {
            final double currentTime = double.tryParse(parts[0]) ?? 0;
            final double duration = double.tryParse(parts[1]) ?? 1; // avoid / 0
            final bool isPaused = parts[2] == 'true';

            setState(() {
              _playbackProgress = (currentTime / duration).clamp(0.0, 1.0);
              _isPlaying = !isPaused;
            });
          }
        },
      )
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
      <iframe id="vimeo-player" src="https://player.vimeo.com/video/1173688059?api=1&badge=0&autopause=0&player_id=0&app_id=58479"
      allow="autoplay; fullscreen; picture-in-picture; clipboard-write; encrypted-media; web-share" 
      referrerpolicy="strict-origin-when-cross-origin" 
      title="How_to_Embed_a_Vimeo_Video_on_Your_Site_-_Tech_Tip_2025_Full_Guide_720P">
      </iframe>
      <script>
        var iframe = document.getElementById('vimeo-player');
        var player = new Vimeo.Player(iframe);

        setInterval(function() {
          Promise.all([player.getCurrentTime(), player.getDuration(), player.getPaused()]).then(function(values) {
             VimeoStatus.postMessage(values[0] + ',' + values[1] + ',' + values[2]);
          });
        }, 500);

        window.flutterPlay = function() { player.play(); };
        window.flutterPause = function() { player.pause(); };
        window.flutterSkipForward = function() { 
            player.getCurrentTime().then(function(seconds) {
                player.setCurrentTime(seconds + 10);
            });
        };
        window.flutterSkipBackward = function() { 
            player.getCurrentTime().then(function(seconds) {
                player.setCurrentTime(seconds - 10);
            });
        };
      </script>
      </body>
      </html>
      ''');

    _fetchVideoDetails();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      controller.runJavaScript("window.flutterPause();");
    } else {
      controller.runJavaScript("window.flutterPlay();");
    }
  }

  void _skipForward() {
    controller.runJavaScript("window.flutterSkipForward();");
  }

  void _skipBackward() {
    controller.runJavaScript("window.flutterSkipBackward();");
  }

  Future<void> _fetchVideoDetails() async {
    try {
      final response = await Dio().get(
          'https://vimeo.com/api/oembed.json?url=https://vimeo.com/1173688059');
      if (response.statusCode == 200 && response.data != null) {
        final title = response.data['title'] ?? 'Unknown Video';
        final durationSeconds = response.data['duration'] as int? ?? 0;
        final minutes = durationSeconds ~/ 60;
        final seconds = durationSeconds % 60;

        // Ensure widget is still mounted before calling setState in async gaps
        if (mounted) {
          setState(() {
            _videoTitle = title.toString().replaceAll('_', ' ');
            _videoDuration =
                '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _videoTitle = 'Video Unavailable';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220, // Adjusted height to accommodate the inline player and text
      decoration: BoxDecoration(
        color: ColorResources.darkBlue,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: ColorResources.black.withOpacity(0.10),
            blurRadius: 16,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: Stack(
          children: [
            // The Embedded Native Vimeo Player
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 180,
              child: WebViewWidget(controller: controller),
            ),

            // Full Screen Button Floating overlay
            Positioned(
              top: 10,
              right: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const VimeoPlayerScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.fullscreen,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),

            // Bottom info bar overlay matching original design
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      ColorResources.transparent,
                      ColorResources.black.withOpacity(0.95),
                    ],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: _skipBackward,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: ColorResources.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.replay_10_rounded,
                              color: ColorResources.white,
                              size: 16,
                            ),
                          ),
                        ),
                        gap8,
                        GestureDetector(
                          onTap: _togglePlayPause,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: ColorResources.oceanBlue,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              _isPlaying
                                  ? Icons.pause_rounded
                                  : Icons.play_arrow_rounded,
                              color: ColorResources.white,
                              size: 20,
                            ),
                          ),
                        ),
                        gap8,
                        GestureDetector(
                          onTap: _skipForward,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: ColorResources.white.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.forward_10_rounded,
                              color: ColorResources.white,
                              size: 16,
                            ),
                          ),
                        ),
                        gap8,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _videoTitle,
                                style:
                                    ThemeTextStyles.getPrimaryTextStyle(context)
                                        .s14
                                        .w700
                                        .copyWith(color: ColorResources.white),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Mathematics • $_videoDuration',
                                style:
                                    ThemeTextStyles.getPrimaryTextStyle(context)
                                        .s11
                                        .copyWith(
                                            color: ColorResources.silverGray),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    gap8,
                    // Progress bar
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: LinearProgressIndicator(
                        value: _playbackProgress,
                        minHeight: 4,
                        backgroundColor: ColorResources.white.withOpacity(0.2),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            ColorResources.oceanBlue),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
