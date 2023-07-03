part of 'view.dart';

class WordViewAlternate extends StatefulWidget {
  const WordViewAlternate({super.key});

  @override
  State<WordViewAlternate> createState() => _WordViewAlternateState();
}

class _WordViewAlternateState extends State<WordViewAlternate> {
  final ScrollController _scrollController = ScrollController();

  void _goToBottomPage() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _goToBottomPage();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double sizedBoxHeight = context
        .read<ScrollingNotifierController>()
        .getSizedBoxHeight(context: context);

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        context
            .read<ScrollingNotifierController>()
            .handleScrollNotification(notification, _scrollController, context);

        return false;
      },
      child: Stack(
        children: [
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: SizedBox(
                  height: sizedBoxHeight > 0 ? sizedBoxHeight : 0,
                ),
              ),
              const WordsList(),
              WordGeneratorAlternate(scrollController: _scrollController),
            ],
          ),
          WordGeneratorBottomAlternate(scrollController: _scrollController),
        ],
      ),
    );
  }
}
