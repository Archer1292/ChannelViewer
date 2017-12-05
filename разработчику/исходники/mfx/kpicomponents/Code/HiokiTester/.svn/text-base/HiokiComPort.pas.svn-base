unit HiokiComPort;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  CommonTypes, PortProcess;

type
  THiokiComPort = class(TComPortController)
  private
    FResistance: String;
    FExtResistance: Extended;
    function ReadOneAnswer : String;

  protected
      procedure PortConfig; override;
      procedure TimeoutConfig; override;
      procedure Communicate; override;
      procedure Loaded; override;
  public
      procedure HIOKI_Reset;
  published
    property Resistance: String read FResistance;
    property ResistanceExt: Extended read FExtResistance;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('KPI', [THiokiComPort]);
end;

{ THiokiComPort }

procedure THiokiComPort.Communicate;
var NewValue: String;
    NewRes: Extended;
    DotPos: Integer;
begin
    //Send(':MEAS:RESI?'#13);
    Send(':FETCH?'#13);
    //Send(':READ?');
    NewValue := ReadOneAnswer;
    if NewValue = '' then Exit;
    try
       DotPos := Pos('.', NewValue);
       if DotPos = 0 then Exit else NewValue[DotPos] := ',';
       NewRes := StrToFloat(NewValue);
    except
       try
          NewValue[DotPos] := '.';
          NewRes := StrToFloat(NewValue);
       except
          Exit;
       end;
    end;

    FResistance    := NewValue;
    FExtResistance := NewRes;
end;

procedure THiokiComPort.HIOKI_Reset;
begin
  Thread.Act := False;
  //Send(#13#13#13);
  //ClearAllBuffers;
  //Send(#13#13#13);
  //Send(':SYST:RES'#13);
  //Send('*RST'#13);
  //Sleep(5000);
  Send(':TRIG:SOUR IMM'#13);
  Send(':INIT:CONT ON'#13);
  Send(':SENS:FUNC RES'#13);
  //Send(':SENSE:LPR:RANGE:AUTO ON'#13);
  //Send(':SENSE:RES:RANGE:AUTO ON'#13);
  //Send(':SYST:LFR 50'#13);
  //Sleep(500);
  //Answer := ReceiveAnswer(90);
  Thread.Act := True;
end;                                     

procedure THiokiComPort.Loaded;
begin
    FResistance := '0';
    inherited;
    if csDesigning in ComponentState then Exit;
    if not Active then Exit;

    FResistance    := '0';
    FExtResistance := 0;

    // perform initialization
    HIOKI_Reset;

    Run;
end;

procedure THiokiComPort.PortConfig;
begin
    inherited;
    dcb.BaudRate := 9600;       //Скорость обмена данными (бод/сек.)
    dcb.ByteSize := 8;          //Длина слова (бит)    dcb.StopBits := ONESTOPBIT; //Кол-во стоповых бит    dcb.Parity   := NOPARITY;   //Контроль чётностиend;

function THiokiComPort.ReadOneAnswer: String;
var Overlap: TOverlapped;
    Buf, Prev: Char;
    Readed: Cardinal;
    Success: Boolean;
    FailCounter: Cardinal;
begin
    FillChar(Overlap, SizeOf(Overlap), 0);

    Result := '';
    Prev   := #0;
    repeat
        Buf := #0;
        Success := ReadFile(hCom, Buf, 1, Readed, @Overlap);
        if not Success then
        begin
            Result := '';
            Exit;
        end;

        if (Buf <> #13) and (Buf <> #32) and
           (Buf <> #0)  and (Buf <> #10) 
        then Result := Result + Buf;

        if Buf = #0 then Inc(FailCounter) else FailCounter := 0;
        if FailCounter > 100 then
        begin
            Result := '';
            Exit;
        end;

        Prev := Buf;
    until Buf = #13;

    // read the last #10
    repeat
        Success := ReadFile(hCom, Buf, 1, Readed, @Overlap);
        if not Success then
        begin
            Result := '';
            Exit;
        end;
    until Buf = #10;
end;

procedure THiokiComPort.TimeoutConfig;
begin
    ct.ReadIntervalTimeout         := 30;
    ct.ReadTotalTimeoutMultiplier  := 6;
    ct.ReadTotalTimeoutConstant    := 5;
    ct.WriteTotalTimeoutMultiplier := 2;
    ct.WriteTotalTimeoutConstant   := 5;
end;

end.
