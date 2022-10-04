enum LangType { EN, VI }

extension LangData on LangType {
  String get lang {
    switch (this) {
      case LangType.EN:
        return 'en_lang';
      case LangType.VI:
        return 'vi_lang';

      default:
        break;
    }
    return 'en_lang';
  }
}
