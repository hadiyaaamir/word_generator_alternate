part of 'view.dart';

class WordsList extends StatefulWidget {
  const WordsList({super.key});

  @override
  State<WordsList> createState() => _WordsListState();
}

class _WordsListState extends State<WordsList> {
  final GlobalKey<SliverAnimatedListState> _listKey =
      GlobalKey<SliverAnimatedListState>();

  final List<Word> _words = [];

  late final WordController wordController;

  @override
  void initState() {
    super.initState();
    wordController = context.read<WordController>();
    wordController.addListener(_handleWordControllerChange);
    _words.addAll(wordController.previousWords.reversed);
  }

  void _handleWordControllerChange() {
    List previousWords = wordController.previousWords;

    if (previousWords.isNotEmpty) {
      final Word addedWord = previousWords.first;

      if (_words.isEmpty || addedWord.word != _words.last.word) {
        _addWordToAnimateList(addedWord);
      } else if (addedWord.word == _words.last.word) {
        setState(() {
          _words.clear();
          _words.addAll(wordController.previousWords.reversed);
        });
      }
    }
  }

  void _addWordToAnimateList(Word addedWord) {
    _words.insert(wordController.previousWords.length - 1, addedWord);
    final SliverAnimatedListState? animatedList = _listKey.currentState;

    animatedList?.insertItem(
      _words.length - 1,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    wordController.removeListener(_handleWordControllerChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      sliver: SliverAnimatedList(
        key: _listKey,
        initialItemCount: _words.length,
        itemBuilder: (context, index, animation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return AnimatedBottomToTopSliding(
                animation: animation,
                child: SmallWordTile(
                  word: _words[index],
                  key: Key('${_words[index].word}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
