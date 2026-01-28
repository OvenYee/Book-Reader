import 'package:flutter_epub_viewer/flutter_epub_viewer.dart';
import 'package:flutter/material.dart';

class MyEpubViewer extends StatefulWidget {
  const MyEpubViewer({super.key});

  @override
  State<MyEpubViewer> createState() => _MyEpubViewerState();
}

class _MyEpubViewerState extends State<MyEpubViewer> {
  final epubController = EpubController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: EpubViewer(
          epubSource: EpubSource.fromUrl(
              'https://github.com/IDPF/epub3-samples/releases/download/20230704/accessible_epub_3.epub'),
          epubController: epubController,
          displaySettings:
              EpubDisplaySettings(flow: EpubFlow.paginated, snap: true),
          onChaptersLoaded: (chapters) {
            // Handle chapters loaded
          },
          onEpubLoaded: () async {
            // Handle epub loaded
          },
          onRelocated: (value) {
            // Handle page change
          },
          onTextSelected: (epubTextSelection) {
            // Handle text selection
          },
        ),
      ),
    );
  }
}