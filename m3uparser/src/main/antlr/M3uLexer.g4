lexer grammar M3uLexer;

WS: SPACES+ -> skip;
NEWLINE: ('\r\n' | '\r' | '\n') -> skip;
FILE_START: '#EXTM3U';
CHANNEL_START: '#EXTINF';
NUMBER: '-'? DIGIT+;
SAFE_STRING: SAFE_CHAR+;
QUOTED_STRING: QUOTE (SAFE_CHAR | NUMBER | COLON | EQUALS | SPACES | COMMA)+ QUOTE;
COMMA: ',' -> pushMode(FREE_TEXT);
COLON: ':';
EQUALS: '=';

fragment QUOTE: '"';
fragment SPACES: [ \t];
fragment DIGIT: [0-9];
fragment SAFE_CHAR: ~[":= \t,\r\n];

mode FREE_TEXT;

FREE_TEXT_NEWLINE: ('\r\n' | '\r' | '\n') -> skip;
FREE_TEXT_CHANNEL_START: '#EXTINF' -> popMode;
FREE_TEXT_TEXT: FREE_TEXT_SAFE_CHAR+;

fragment FREE_TEXT_SAFE_CHAR: ~[#\r\n];