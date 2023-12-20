
const List<String> tensNames = ["", " ده و", " بیست و", " سی و", " چهل و", " پنجاه و", " شصت و", " هفتاد و", " هشتاد و", " نود و"];

const List<String> numNames = [
      "",
      " یک",
      " دو",
      " سه",
      " چهار",
      " پنج",
      " شش",
      " هفت",
      " هشت",
      " نه",
      " ده",
      " یازده",
      " دوازده",
      " سیزده",
      " چهارده",
      " پانزده",
      " شانزده",
      " هفده",
      " هجده",
      " نوزده"
];

const List<String> thousandsNames = [
      "",
      " صد و",
      " دویست و",
      " سیصد و",
      " چهارصد و",
      " پانصد و",
      " ششصد و",
      " هفتصد و",
      " هشتصد و",
      " نهصد و"
];

const Map<String, int> tensMap = {
      "": 0,
      "ده": 10,
      "بیست": 20,
      "سی": 30,
      "چهل": 40,
      "پنجاه": 50,
      "شصت": 60,
      "هفتاد": 70,
      "هشتاد": 80,
      "نود": 90,
};

const Map<String, int> numsMap = {
      "": 0,
      "یک": 1,
      "دو": 2,
      "سه": 3,
      "چهار": 4,
      "پنج": 5,
      "شش": 6,
      "هفت": 7,
      "هشت": 8,
      "نه": 9,
      "ده": 10,
      "یازده": 11,
      "دوازده": 12,
      "سیزده": 13,
      "چهارده": 14,
      "پانزده": 15,
      "شانزده": 16,
      "هفده": 17,
      "هجده": 18,
      "نوزده": 19,
};

const Map<String, int> thousandsMap = {
      "": 0,
      "صد": 100,
      "دویست": 200,
      "سیصد": 300,
      "چهارصد": 400,
      "پانصد": 500,
      "ششصد": 600,
      "هفتصد": 700,
      "هشتصد": 800,
      "نهصد": 900,
};

const Map<String, int> millionsMap = {
      "هزار": 1000,
      "میلیون": 1000000,
      "میلیارد": 1000000000,
      "تریلیون": 1000000000000,
};

/////////////////////////////////////////////////////////////////////////////////////////////////////////////

final rsAstralRange = '\\ud800-\\udfff',
    rsComboMarksRange = '\\u0300-\\u036f',
    reComboHalfMarksRange = '\\ufe20-\\ufe2f',
    rsComboSymbolsRange = '\\u20d0-\\u20ff',
    rsComboRange = rsComboMarksRange + reComboHalfMarksRange + rsComboSymbolsRange,
    rsDingbatRange = '\\u2700-\\u27bf',
    rsLowerRange = 'a-z\\xdf-\\xf6\\xf8-\\xff',
    rsMathOpRange = '\\xac\\xb1\\xd7\\xf7',
    rsNonCharRange = '\\x00-\\x2f\\x3a-\\x40\\x5b-\\x60\\x7b-\\xbf',
    rsPunctuationRange = '\\u2000-\\u206f',
    rsSpaceRange =
        ' \\t\\x0b\\f\\xa0\\ufeff\\n\\r\\u2028\\u2029\\u1680\\u180e\\u2000\\u2001\\u2002\\u2003\\u2004\\u2005\\u2006\\u2007\\u2008\\u2009\\u200a\\u202f\\u205f\\u3000',
    rsUpperRange = 'A-Z\\xc0-\\xd6\\xd8-\\xde',
    rsVarRange = '\\ufe0e\\ufe0f',
    rsBreakRange = rsMathOpRange + rsNonCharRange + rsPunctuationRange + rsSpaceRange;

final rsMiscLower = '(?:$rsLower|$rsMisc)',
    rsMiscUpper = '(?:$rsUpper|$rsMisc)',
    rsOptContrLower = '(?:$rsApos(?:d|ll|m|re|s|t|ve))?',
    rsOptContrUpper = '(?:$rsApos(?:D|LL|M|RE|S|T|VE))?',
    reOptMod = '$rsModifier?',
    rsOptVar = '[$rsVarRange]?',
    rsOptJoin = '(?:$rsZWJ(?:${[rsNonAstral, rsRegional, rsSurrPair].join('|')})$rsOptVar$reOptMod)*',
    rsOrdLower = '\\d*(?:1st|2nd|3rd|(?![123])\\dth)(?=\\b|[A-Z_])',
    rsOrdUpper = '\\d*(?:1ST|2ND|3RD|(?![123])\\dTH)(?=\\b|[a-z_])',
    rsSeq = rsOptVar + reOptMod + rsOptJoin,
    rsEmoji = '(?:${[rsDingbat, rsRegional, rsSurrPair].join('|')})$rsSeq',
    rsSymbol = '(?:${['$rsNonAstral$rsCombo?', rsCombo, rsRegional, rsSurrPair, rsAstral].join('|')})';


final reUnicodeWord = RegExp(
    [
          '$rsUpper?$rsLower+$rsOptContrLower(?=${[rsBreak, rsUpper, r'$'].join('|')})',
          '$rsMiscUpper+$rsOptContrUpper(?=${[rsBreak, rsUpper + rsMiscLower, r'$'].join('|')})',
          '$rsUpper?$rsMiscLower+$rsOptContrLower',
          '$rsUpper+$rsOptContrUpper',
          rsOrdUpper,
          rsOrdLower,
          rsDigits,
          rsEmoji
    ].join('|'),
    multiLine: true,
    unicode: true);

final rsApos = "['\u2019]",
    rsAstral = '[$rsAstralRange]',
    rsBreak = '[$rsBreakRange]',
    rsCombo = '[$rsComboRange]',
    rsDigits = '\\d+',
    rsDingbat = '[$rsDingbatRange]',
    rsLower = '[$rsLowerRange]',
    rsMisc = '[^$rsAstralRange$rsBreakRange$rsDigits$rsDingbatRange$rsLowerRange$rsUpperRange]',
    rsFitz = '\\ud83c[\\udffb-\\udfff]',
    rsModifier = '(?:$rsCombo|$rsFitz)',
    rsNonAstral = '[^$rsAstralRange]',
    rsRegional = '(?:\\ud83c[\\udde6-\\uddff]){2}',
    rsSurrPair = '[\\ud800-\\udbff][\\udc00-\\udfff]',
    rsUpper = '[$rsUpperRange]',
    rsZWJ = '\\u200d';


