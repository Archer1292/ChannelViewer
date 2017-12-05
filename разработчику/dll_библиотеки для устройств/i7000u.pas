unit I7000u;

interface

type PSingle=^Single;
type PWord=^Word;


function GetErrorString(wErrCode : Word ): String;

Var
   gcPort       : Char;    //Global Char
   gwBaudRate   : LongInt;    //Global Word
   gwCheckSum   : Word;
   gcDataBit    : Char;
   gcParity     : Char;
   gcStopBit    : Char;

   gszSend      : PChar;  //Global StringZ
   gszReceive   : PChar;

   gfInData     : Array[0..999] of Single; //Global Float
   gw7000       : Array[0..10] of Word;
   gf7000       : Array[0..10] of Single;

implementation


function GetErrorString( wErrCode : Word ):String ;
Var
    ErrString : String ;
    
Begin
    Case wErrcode of
	 0: ErrString := 'No Error' ;
	 1: ErrString := 'Function Error';
	 2: ErrString := 'Port Error';
	 3: ErrString := 'Baud Rate Error';
	 4: ErrString := 'Data Error';
	 5: ErrString := 'Stop Error';
	 6: ErrString := 'Parity Error';
	 7: ErrString := 'CheckSum Error';
	 8: ErrString := 'ComPort Not Open';
	 9: ErrString := 'Send Thread Create Error';
	10: ErrString := 'Send Command Error';
	11: ErrString := 'Read Com Port Status Error';
	12: ErrString := 'Result String Check Error';
	13: ErrString := 'Command Error';
	//14: ErrString := '';
	15: ErrString := 'Time Out';
	//16: ErrString := '';
	17: ErrString := 'Module Id Error';
	18: ErrString := 'AD Channel Error';
	19: ErrString := 'Under Input Range';
	20: ErrString := 'Exceed Input Range';
	21: ErrString := 'Invalidate Counter No';
	22: ErrString := 'Invalidate Counter Value';
	23: ErrString := 'Invalidate Gate Mode';
    Else
	    ErrString := 'Unknown Error';
    end;

    GetErrorString := ErrString ;
end;

end.

