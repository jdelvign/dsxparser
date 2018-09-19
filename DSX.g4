// Define DSX grammar
grammar DSX;

// Grammar reminder
// ? zero or once (optional)
// * zero or more 
// + once or more

dsx // match 1/1 header and 1/* objects
  : header (dsjob
  | dsstagetypes
  | dstabledefs
  | dsroutines
  | dssharedcontainer)+ EOF
  ;
 
header // HEADER Description
  : 'BEGIN HEADER' property+ 'END HEADER'
  ;

dsjob // DSJOB Description
  : 'BEGIN DSJOB' identifier (property | dsrecord)+ 'END DSJOB'
  ;

dsstagetypes
  : 'BEGIN DSSTAGETYPES' property+ 'END DSSTAGETYPES'
  ;

dstabledefs
  : 'BEGIN DSTABLEDEFS' dsrecord+ 'END DSTABLEDEFS'
  ;

dsroutines
  : 'BEGIN DSROUTINES' (dsrecord | dsubinary)+ 'END DSROUTINES'
  ;

dssharedcontainer
  : 'BEGIN DSSHAREDCONTAINER' identifier (property | dsrecord)+ 'END DSSHAREDCONTAINER'
  ;

dsubinary
  : 'BEGIN DSUBINARY' identifier property+ 'END DSUBINARY'
  ;

dsrecord
  : 'BEGIN DSRECORD' identifier (property | dssubrecord)+ 'END DSRECORD'
  ;

dssubrecord
  : 'BEGIN DSSUBRECORD' property+ 'END DSSUBRECORD'
  ;

identifier
  : 'Identifier' propvalue
  ;

property 
  : propname propvalue
  ;

propname // match lower-case OR upper-case keys
   : LETTERS (LETTERS | NUMBER | SPECIAL_CHARS)*
   ;

propvalue
  : STRING_LITERAL
  | PLAIN_TEXT
  ;

STRING_LITERAL // VALUE is any char
   : '"' (~[\r\n"] | '\\"')* '"'
   ;

LETTERS
   : ('a' .. 'z' | 'A' .. 'Z')+
   ;

NUMBER
   : ('0' .. '9')+
   ;

SPECIAL_CHARS // Only accepted special chars are listed here
  : [-_]
  ;

PLAIN_TEXT  // .*? matches anything until the first */
  : '=+=+=+=' .*? '=+=+=+=' 
  ;

WS    // skip spaces, tabs, newline
  : [ \t\r\n]+ -> skip    
  ; 