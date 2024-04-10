import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const uyirEzhuthukal = [
  ["அ", "ஆ", "இ"],
  ["ஈ", "உ", "ஊ"],
  ["எ", "ஏ", "ஐ"],
  [
    "ஒ",
    "ஓ",
    "ஔ",
  ],
];
const tamilSymbols = [
  ["ி", "ீ"],
  ["ு", "ூ"],
  ["ெ", "ே"],
  ["ை", "ா"]
];
const meiEzhuthukal = [
  [
    "க",
    "ங",
    "ச",
    "ஞ",
    "ட",
    "ண",
  ],
  ["த", "ந", "ப", "ம", "ய", "ர"],
  ["ல", "வ", "ழ", "ள", "ற", "ன"],
  ["ஜ", "ஷ", "ஸ", "ஹ", "ஸ்ரீ", "க்ஷ"]
];

const keys4 = [
  '?123',
  'ஃ',
  '',
  "்",
  '',
  '.',
  "⏎",
  Icon(Icons.keyboard_backspace)
];

final symbolsNameProvider = StateProvider<String?>((ref) {
  return '';
});

const meiEzhuthukal2 = [
  [
    "க",
    "ங",
    "ச",
    "ஞ",
    "ட",
    "ண",
  ],
  ["த", "ந", "ப", "ம", "ய", "ர"],
  ["ல", "வ", "ழ", "ள", "ற", "ன"],
  ["்", "ஜ", "ஷ", "ஸ", "ஹ", "ஸ்ரீ"]
];

const keys2 = [
  '?123',
  'ஃ',
  '',
  'க்ஷ',
  '',
  '.',
  "⏎",
  Icon(Icons.keyboard_backspace)
];

const column1 = [
  ["அ", "ஆ", "இ"],
  ["ஈ", "உ", "ஊ"],
  ["எ", "ஏ", "ஐ"],
  ["ஒ", "ஓ", "ஔ"],
  ["ஃ", "ஜ", "ஸ"],
];
const column2 = [
  ["ி", "ீ"],
  ["ு", "ூ"],
  ["ெ", "ே"],
  ["ை", "ா"],
  ["ஹ", "ஸ்ரீ"]
];
const column3 = [
  ["க", "ங", "ச", "ஞ"],
  ["ட", "ண", "த", "ந"],
  ["ப", "ம", "ய", "ர"],
  ["ல", "வ", "ழ", "ள"],
  ["ஷ", "்", "ற", "ன"]
];
// "க்ஷ"
const keys3 = [
  '?123',
  '',
  '',
  "",
  '',
  '.',
  "⏎",
  Icon(Icons.keyboard_backspace)
];
