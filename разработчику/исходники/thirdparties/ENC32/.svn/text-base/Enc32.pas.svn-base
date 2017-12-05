unit Enc32;

interface

type PSingle=^Single;
     PWord=^Word;
     PInteger=^Integer;

Const
//-------------- define parameter ----------------------------------
 X_axis          =   1;
 Y_axis          =   2;
 Z_axis          =   3;

 ENC_X1          = $00;
 ENC_X2          = $08;
 ENC_QUADRANT    = $00;
 ENC_CW_CCW      = $10;
 ENC_PULSE_DIR   = $20;

// Error Codes
 ENC3_NoError 	        = 0;
 ENC3_DriverOpenError	= 1;
 ENC3_ExceedMaxBoard    = 2;
 ENC3_FailToStart32bit  = 3;

procedure ENC3_INITIAL                                         ; StdCall;
procedure ENC3_END                                             ; StdCall;
procedure ENC3_SELECT(address:LongInt)                         ; StdCall;
procedure ENC3_INIT_CARD(x_mode:Byte; y_mode:Byte; z_mode:Byte); StdCall;

function  ENC3_GET_ENCODER(axis:Byte)                  :LongInt; StdCall;
procedure ENC3_RESET_ENCODER(axis:Byte)                        ; StdCall;
function  ENC3_GET_INDEX                                  :Byte; StdCall;

// Enc 32bit functions
function  ENC3_INITIAL32				:WORD	; StdCall;
procedure ENC3_END32						; StdCall;
function  ENC3_RESET_ENCODER32(axis:Byte)		:LongInt; StdCall;
function  ENC3_GET_ENCODER32(axis:Byte)			:LongInt; StdCall;
procedure ENC3_SET_DELAY32(wDelayMS:WORD)			; StdCall;

implementation

Procedure ENC3_INITIAL;          	external 'Enc32.DLL' name 'ENC3_INITIAL';
Procedure ENC3_END;                     external 'Enc32.DLL' name 'ENC3_END';
Procedure ENC3_SELECT;          	external 'Enc32.DLL' name 'ENC3_SELECT';
Procedure ENC3_INIT_CARD;          	external 'Enc32.DLL' name 'ENC3_INIT_CARD';

Function  ENC3_GET_ENCODER;          	external 'Enc32.DLL' name 'ENC3_GET_ENCODER';
Procedure ENC3_RESET_ENCODER;          	external 'Enc32.DLL' name 'ENC3_RESET_ENCODER';
Function  ENC3_GET_INDEX;          	external 'Enc32.DLL' name 'ENC3_GET_INDEX';

// Enc 32bit functions
function  ENC3_INITIAL32;          	external 'Enc32.DLL' name 'ENC3_INITIAL32';
procedure ENC3_END32;           	external 'Enc32.DLL' name 'ENC3_END32';
function  ENC3_RESET_ENCODER32;         external 'Enc32.DLL' name 'ENC3_RESET_ENCODER32';
function  ENC3_GET_ENCODER32;          	external 'Enc32.DLL' name 'ENC3_GET_ENCODER32';
procedure ENC3_SET_DELAY32;          	external 'Enc32.DLL' name 'ENC3_SET_DELAY32';

end.

