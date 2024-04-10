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

const uyirEzhuthukal2 = [
  ["அ", "ஆ", "இ"],
  ["ஈ", "உ", "ஊ"],
  ["எ", "ஏ", "ஐ"],
  [
    "ஒ",
    "ஓ",
    "ஔ",
  ],
];
const tamilSymbols2 = [
  ["ி", "ீ"],
  ["ு", "ூ"],
  ["ெ", "ே"],
  ["ை", "ா"]
];
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
