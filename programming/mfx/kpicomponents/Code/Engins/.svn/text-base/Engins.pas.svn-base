unit Engins;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CommonTypes, StepType, comctrls;

const TAB = #9;

type TCommandType = (ctEngineCommand, ctEngineLR, ctEngineUD, ctEngineAngle,
                     ctEngineMM, ctEngineUsilije, ctEngineCruch, ctOther, ctNone);
type TEngineCommand = (ecForward,    ecBackward,   ecStop);
     TEngineLR      = (ecLeft,       ecRight,      ecStopLR);
     TEngineUD      = (ecDown,       ecUp,         ecStopUD);
     TEngineAngle   = (ecDecAngle,   ecIncAngle,   ecStopAngle);
     TEngineMM      = (ecIncMM,      ecDecMM,      ecStopMM);
     TEngineUsilije = (ecIncUsilije, ecDecUsilije, ecStopUsilije);
     TEngineCruch   = (ecDecCruch,   ecIncCruch,   ecStopCruch);

type TState = (stRun, stForward, stBackward, stSU, stOL, stFU, stAvarija);
     TEngineState = set of TState;

const cmdGoForward  = 'FA02';
      cmdGoBackward = 'FA04';
      cmdStop       = 'FA00';
      cmdReadState  = '7A';
      cmdWriteFreq  = 'EE';
      cmdReadFreq   = '6F';
      cmdReadVolt   = '71';
      cmdReset      = 'FD9696';
      cmdReadAmper  = '70';

const STX = #02;  //начало данных
      ETX = #03;  //конец данных
      ENQ = #05;  //запрос на взаимодействие
      ACK = #06;  //ответ: ошибок нет
      LF  = #10;  //перевод строки
      CR  = #13;  //возврат каретки
      NAK = #15;  //ответ: обнаружена ошибка
//------------------------------------------------------------------------------
type TEnginsComPort = class(TThreadHolder)
  private
    FPortNumber: Cardinal;
    FPortOpened: Boolean;
    dcb:     TDCB;
    ct:      TCommTimeouts;
    hCom:    THandle;
    Overlap: TOverlapped;
  protected
  public
    procedure Send(S: String);
    function  Receive: String;
    procedure  Loaded; override;
    destructor Destroy; override;
    property   PortSuccessfullyOpened: Boolean read FPortOpened;
  published
    property Port: Cardinal read FPortNumber write FPortNumber;
end;
//------------------------------------------------------------------------------
type TCommand = record
        Command: String;
        case CommandType: TCommandType of
        ctEngineCommand: (Description1: TEngineCommand);
        ctEngineLR:      (Description2: TEngineLR);
        ctEngineUD:      (Description3: TEngineUD);
        ctEngineAngle:   (Description4: TEngineAngle);
        ctEngineMM:      (Description5: TEngineMM);
        ctEngineUsilije: (Description6: TEngineUsilije);
        ctEngineCruch:   (Description7: TEngineCruch);
        ctOther:         (Description8: Integer);
end;

type TEngineDictionary = class(TEnginsComPort)
  private
   // MyFile: TFileStream;
    Command0, Command1: TCommand;
    FOnLine1: Boolean;
    FOnLine0: Boolean;
  protected
    function OKAnswer(Engine: Cardinal; Answer: String): Boolean;
    procedure Proceed0Command;
    procedure Proceed1Command;

    function SendCommand(Engine: Cardinal; S: String): String;
  public
    function CreateCommand(Data: String): String;
    constructor Create(AOwner: TComponent); override;
    procedure RunForward0;
    procedure RunBackward0;
    procedure StopEngine0;
    procedure Reset0;

    procedure RunForward1;
    procedure RunBackward1;
    procedure StopEngine1;
    procedure Reset1;

    property OnLine0: Boolean read FOnLine0;
    property OnLine1: Boolean read FOnLine1;
end;
//------------------------------------------------------------------------------

type TEngineInfo = class(TEngineDictionary)
  private
    FVolt1: Cardinal;
    FVolt0: Cardinal;
    FAmper1: Cardinal;
    FAmper0: Cardinal;
    FFrequency1: Cardinal;
    FFrequency0: Cardinal;
    FState1: TEngineState;
    FState0: TEngineState;

    SetNewFrequency0, SetNewFrequency1: Boolean;

    procedure SetFrequency0(Value: Cardinal);
    procedure SetFrequency1(Value: Cardinal);

    procedure ReadVolt0;
    procedure ReadAmper0;
    procedure ReadFrequency0;
    procedure ReadState0;

    procedure ReadVolt1;
    procedure ReadAmper1;
    procedure ReadFrequency1;
    procedure ReadState1;

  protected
    FNewFrequency0, FNewFrequency1: Cardinal;
  public
    property Volt0: Cardinal read FVolt0;
    property Volt1: Cardinal read FVolt1;
    property Amper0: Cardinal read FAmper0;
    property Amper1: Cardinal read FAmper1;
    property Frequency0: Cardinal read FFrequency0 write SetFrequency0;
    property Frequency1: Cardinal read FFrequency1 write SetFrequency1;
    property State0: TEngineState read FState0;
    property State1: TEngineState read FState1;
end;
//------------------------------------------------------------------------------

type TEngineCycle = class(TEngineInfo)
  private
    FChoice: Cardinal;
    LastTime: TTime;
    FActPerSecond: Cardinal;
    FLastUDFreqSet, FLastLRFreqSet: Cardinal;
    procedure DoMainCommand;
    procedure CommandTo0(Command: TEngineCommand);
    procedure CommandTo1(Command: TEngineCommand);
    function  GetLRState: TEngineCommand;
    function  GetUDState: TEngineCommand;
  protected
    procedure Proc; override;
    property  StateLR: TEngineCommand read GetLRState;
    property  StateUD: TEngineCommand read GetUDState;
  public
    procedure StopBothEngines;
    procedure CommandToEngine(Command: TEngineLR);       overload;
    procedure CommandToEngine(Command: TEngineUD);       overload;
    procedure CommandToEngine(Command: TEngineAngle);    overload;
    procedure CommandToEngine(Command: TEngineMM);       overload;
    procedure CommandToEngine(Command: TEngineUsilije);  overload;
    procedure CommandToEngine(Command: TEngineCruch);    overload;
    property  ConnectionSpeedActPerSecond: Cardinal read FActPerSecond;
    property  FrequencyUD: Cardinal read FFrequency1 write SetFrequency1;
    property  FrequencyLR: Cardinal read FFrequency0 write SetFrequency0;
    property  LastUDFreqSet: Cardinal read FNewFrequency1;
    property  LastLRFreqSet: Cardinal read FNewFrequency0;

    property  VoltLR: Cardinal read FVolt0;
    property  VoltUD: Cardinal read FVolt1;
    property  AmperLR: Cardinal read FAmper0;
    property  AmperUD: Cardinal read FAmper1;
    property  OnLineUD: Boolean read FOnLine1;
    property  OnLineLR: Boolean read FOnLine0;
    property  StateUpDown: TEngineState read FState1;
    property  StateLeftRight: TEngineState read FState0;
end;
//------------------------------------------------------------------------------
type TExtData = record
  HorizMM:    Extended;
  MM:         Extended;
  Ang:        Extended;
  Usilije:    Extended;    //kg
  Cruchenije: Extended;
  Electro:    Extended; // volt
  Resistance: Extended;
  Time:       TDateTime;
  Cycle:      Cardinal;
end;

function FormDataString(var Data: TExtData): String;

const DataBufferLenght = 24 * 60 * 60 * 20; //24часов * 3600 секунд * 20 записей в секунду
var DataBuffer: array [0..DataBufferLenght] of TExtData;
    Pos: Cardinal;

type TExternalInfo = procedure(var Info: Extended) of object;
type TB2_38 = (tv1mV, tv100mV);
type TEngineExternalInfo = class(TEngineCycle)
  private
    FOnMM: TExternalInfo;
    FOnUsilije: TExternalInfo;
    FOnCruchenije: TExternalInfo;
    FOnAng: TExternalInfo;
    FMM: Extended;
    FAng: Extended;
    FCruchenije: Extended;
    FUsilije: Extended;
    FHorizMM: Extended;
    FElectro: Extended;
    FResistance: Extended;
    FOnHorizMM: TExternalInfo;
    FOnElectro: TExternalInfo;
    FOnResistance: TExternalInfo;
    FTV38: TB2_38;
    FTemperature, FRt: Extended;
    procedure SetTemperature(const Value: Extended);
    function GetR: Extended;
  protected
    FCurCycle: Cardinal;
    procedure Proc; override;
  public
    TimeIntervalMS: Extended;
//-------------------------------------------------
    RAmper: Extended;
//-------------------------------------------------
    Diametr, WorkingLength: Extended;
    property HorizMM: Extended read FHorizMM;
    property MM: Extended read FMM;
    property Ang: Extended read FAng;
    property Usilije: Extended read FUsilije;    //kg
    property Cruchenije: Extended read FCruchenije;
    property Electro: Extended read FElectro; // volt
    property Resistance: Extended read FResistance;

  published
    property OnHorizMM: TExternalInfo read FOnHorizMM write FOnHorizMM;
    property OnMM: TExternalInfo read FOnMM write FOnMM;
    property OnAng: TExternalInfo read FOnAng write FOnAng;
    property OnUsilije: TExternalInfo read FOnUsilije write FOnUsilije;
    property OnCruchenije: TExternalInfo read FOnCruchenije write FOnCruchenije;
    property OnElectro: TExternalInfo read FOnElectro write FOnElectro;
    property OnResistance: TExternalInfo read FOnResistance write FOnResistance;
    property Temperature: Extended read FTemperature write SetTemperature;
    property Rt: Extended read FRt;
    property TV38: TB2_38 read FTV38;
    property Soprotivlenije: Extended read GetR;
end;

//------------------------------------------------------------------------------
type TEngineControlState = (ecsIdle, ecsTask, ecsHandControl, ecsPause);
type TEngineOneStep = class(TEngineExternalInfo)
  private
    FState: TEngineControlState;
    FStartTime, FTermin: TTime;
    LRDone, UDDone: Boolean;
    FReductor: Cardinal;
    OldBreakUDKg, OldBreakLRKg: Extended;
    ObrazecBreak: Boolean;

    procedure ActivateTask;
    procedure ControlTask;

    procedure ControlPosition;
    procedure ControlCharge;    virtual;
    procedure ControlWaitPos;
    procedure ControlWaitCharge;

    procedure ActivatePosition;
    procedure ActivateCharge;   virtual;
    procedure ActivateWaitPos;
    procedure ActivateWaitCharge;

  protected
    FProceedTask: Boolean;
    InFlow: Boolean;
    UDDifference, LRDifference: Extended;
    CurrentStep: TStep;
    FBreakUDKg: Cardinal;
    UpDownEngineCanWork, LeftRightEngineCanWork: Boolean;
    BreakStepIntoNParts: Integer;

    procedure Proc; override;
  public
    UDFreq, LRFreq: Cardinal;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure DoOneStep(Step: TStep);
    procedure PauseTaskAndStopEngines;
    procedure ContinueTask;

    property  State: TEngineControlState read FState;
    property  Reductor: Cardinal read FReductor write FReductor;
end;
//------------------------------------------------------------------------------
type TGoToPhysicalZero = class(TEngineOneStep)///class(TEngineStrictTaskMaker)///
  private
    FOnPhysicalUsilije: TExternalInfo;
    FOnPhysicalCruchenije: TExternalInfo;
    FPhysicalUsilije, FPhysicalCruchenije: Extended;
  protected
    procedure Proc; override;
  public
    procedure GoToPhysicalZero;
  published
    property OnPhysicalUsilije: TExternalInfo read FOnPhysicalUsilije write FOnPhysicalUsilije;
    property OnPhysicalCruchenije: TExternalInfo read FOnPhysicalCruchenije write FOnPhysicalCruchenije;
end;
//------------------------------------------------------------------------------

type TEngineTaskMaker = class(TGoToPhysicalZero)
  private
    LastStepDone: Boolean;
    FProcess: TProcess;
    FCycles: Cardinal;
    FCurStep : Cardinal;
    FOnEndTask: TNotifyEvent;
    procedure SetProceedTask(const Value: Boolean);
    function GetSteps: Cardinal;
  protected
    procedure Proc; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property ProceedTask: Boolean read FProceedTask write SetProceedTask;
  published
    property Cycles: Cardinal read FCycles write FCycles;
    property CurrentCycle: Cardinal read FCurCycle;
    property CurrentStepNumber: Cardinal read FCurStep;
    property StepsInOneCycle: Cardinal read GetSteps;
    property Process: TProcess read FProcess write FProcess;
    property OnEndTask: TNotifyEvent read FOnEndTask write FOnEndTask;
end;
//------------------------------------------------------------------------------
type TEngineStandartTasks = class(TEngineTaskMaker)
  private
    FTimeSec: Cardinal;
    FAngle1grad: Extended;
    FAngle2grad: Extended;
    FMm1: Extended;
    FUsilije2kg: Extended;
    FCruchenije1nm: Extended;
    FUsilije1kg: Extended;
    FMm2: Extended;
    FCruchenije2nm: Extended;
    FTrajectory: TTrajectory;
    FEditor: TRichEdit;
    FRegim: TRegim;
    FNagrugenije: TNagrugenije;
    FAccuracy: TTaskAccuracy;
    procedure InitStep(const StepNumber, TimeMSec:Cardinal; TaskType: TTaskType;
                       IdealCharge: Extended = 0; IdealCruchenie: Extended = 0;
                       Grad: Extended = 0; Peremeshcenije: Extended = 0;
                       CruchenijeCanWork: Bool = True; TraversaCanWork: Bool = True;
                       BreakStepIntoNParts: Integer = 1);
  public
    procedure Init;
    procedure InitMjagkijSlognoje;
    procedure InitGestkijSlognoje;
    procedure InitMjagkijCiklicheskoje;
    procedure InitGestkijCiklicheskoje;
    procedure Start;
    procedure StopAndResetTask;

    property Angle1grad: Extended write FAngle1grad;
    property Angle2grad: Extended write FAngle2grad;
    property Mm1: Extended write FMm1;
    property Mm2: Extended write FMm2;
    property Usilije1kg: Extended write FUsilije1kg;
    property Usilije2kg: Extended write FUsilije2kg;
    property Cruchenije1nm: Extended write FCruchenije1nm;
    property Cruchenije2nm: Extended write FCruchenije2nm;
    property TimeSec: Cardinal write FTimeSec;
    property Trajectory: TTrajectory read FTrajectory write FTrajectory;
    property BreakUDKg: Cardinal read FBreakUDKg write FBreakUDKg;
    //property Accuracy: TTaskAccuracy write FAccuracy;
    property Regim: TRegim read FRegim write FRegim ;
    property Nagrugenije: TNagrugenije read FNagrugenije write FNagrugenije ;
  published
    property Editor: TRichEdit read FEditor write FEditor;
end;
























  type
  TEngins = class(TEngineStandartTasks)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation
uses Math;
procedure Register;
begin
  RegisterComponents('KPI', [TEngins]);
end;

{ TEngineDictionary }

constructor TEngineDictionary.Create(AOwner: TComponent);
begin
  inherited;
  Command0.CommandType := ctNone;
  Command1.CommandType := ctNone;
end;

function TEngineDictionary.CreateCommand(Data: String): String;
var i, Sum: Integer;
begin
  //if Length(Data) < 4 then begin ShowMessage('Ошибка в CreateCommand. Сообщить разработчику.'); Exit; End;
//Любая команда начинается с запроса на взаимодействие
   Result := ENQ;
//Номер станции
   Result := Result + Data[1] + Data[2];
//Команда
   Result := Result + Data[3] + Data[4];
//Время ожидания между пиёмом данных преобразователем и выдачей ответа:
//'1' - 10мСек. Диапазон: 0-150 мСек.
   Result := Result + '1';
//Данные
   Result := Result + Copy(Data, 5, Length(Data) - 2);
//Контрольная сумма
   Sum := 0;
   for i := 2 to Length(Result) do Sum := Sum + Ord(Result[i]);
   Sum := Sum mod 256;
   Result := Result + IntToHex(Sum, 2);
//Завершаем команду
   Result := Result + CR;
end;

function TEngineDictionary.OKAnswer(Engine: Cardinal;
  Answer: String): Boolean;
begin
  Result := True;
  if (Length(Answer) <> 11) and (Length(Answer) <> 9) and (Length(Answer) <> 4)
     then begin Result := False; Exit; end;
  if (Answer[1] <> STX) and (Answer[1] <> ACK) then Result := False;
  if Answer[Length(Answer)] <> CR  then Result := False;
  if IntToHex(Engine, 2) <> Copy(Answer, 2, 2) then Result := False;
end;

procedure TEngineDictionary.Proceed0Command;
//var S: String;
begin
  (*S := 'Шлём команду 0 двигалелю: ';
  MyFile.Write(S[1], Length(S)); *)
  SendCommand(0, Command0.Command);
  case Command0.CommandType of
    ctEngineLR: begin end;
    ctEngineAngle: begin end;
    ctEngineCruch: begin end;
  end;
end;

procedure TEngineDictionary.Proceed1Command;
//var S: String;
begin
  (*S := 'Шлём команду 1 двигалелю: ';
  MyFile.Write(S[1], Length(S)); *)
  SendCommand(1, Command1.Command);
  case Command0.CommandType of
    ctEngineUD: begin end;
    ctEngineMM: begin end;
    ctEngineUsilije: begin end;
  end;
end;

procedure TEngineDictionary.Reset0;
begin
  Command0.CommandType := ctOther;
  Command0.Command := CreateCommand('00' + cmdReset);
  Command0.Description8 := 0;
end;

procedure TEngineDictionary.Reset1;
begin
  Command1.CommandType := ctOther;
  Command1.Command := CreateCommand('01' + cmdReset);
  Command1.Description8 := 1;
end;

procedure TEngineDictionary.RunBackward0;
begin
  Command0.Command := CreateCommand('00' + cmdGoBackward);
end;

procedure TEngineDictionary.RunBackward1;
begin
  Command1.Command := CreateCommand('01' + cmdGoBackward);
end;

procedure TEngineDictionary.RunForward0;
begin
  Command0.Command := CreateCommand('00' + cmdGoForward);
end;

procedure TEngineDictionary.RunForward1;
begin
  Command1.Command := CreateCommand('01' + cmdGoForward);
end;

function TEngineDictionary.SendCommand(Engine: Cardinal; S: String): String;
var i: Integer;
const Attempts = 5;
begin
  if not FPortOpened then Exit;

  //PurgeComm(hCom, PURGE_RXCLEAR or PURGE_RXABORT);
  //PurgeComm(hCom, PURGE_TXCLEAR or PURGE_TXABORT);
  Send(S);
  //FlushFileBuffers(hCom);
(*      S := 'Послана команда: ' + S;
      if MyFile = nil
      then MyFile := TFileStream.Create('Log.txt', fmCreate);
      MyFile.Write(S[1], Length(S));     *)

  i := Attempts;
  Result := '';
  for i := 1 to Attempts do
  begin
      Result := Result + Receive;
    (*  S := 'Получен ответ: ' + Result + CR+LF;
      MyFile.Write(S[1], Length(S));  *)
      if OKAnswer(Engine, Result) then
      begin
         if Length(Result) = 4  then Result := '00';
         if Length(Result) = 9  then Result := Copy(Result, 4, 2);
         if Length(Result) = 11 then Result := Copy(Result, 4, 4);
         if Engine = 0 then FOnLine0 := True;
         if Engine = 1 then FOnLine1 := True;
         Exit;
      end;
      (*S := 'Неверный ответ !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!11111';
      MyFile.Write(S[1], Length(S));     *)
  end;
      Result := '00';
  if Engine = 0 then FOnLine0 := False;
  if Engine = 1 then FOnLine1 := False;
end;

procedure TEngineDictionary.StopEngine0;
begin
  Command0.Command := CreateCommand('00' + cmdStop);
  //SendCommand(0, Command0.Command);
end;

procedure TEngineDictionary.StopEngine1;
begin
  Command1.Command := CreateCommand('01' + cmdStop);
  //SendCommand(1, Command1.Command);
end;

{ TEnginsComPort }

destructor TEnginsComPort.Destroy;
begin
  if not (csDesigning in ComponentState) then
    if FPortOpened then
      begin
        FPortOpened := False;
        Thread.Act := False;
        CloseHandle(hCom);
      end;
  inherited;
end;

procedure TEnginsComPort.Loaded;
begin
  inherited;
  FPortOpened := False;
  if csDesigning in ComponentState then Exit;

  hCom := CreateFile(PChar('COM' + IntToStr(FPortNumber)), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL(*FILE_FLAG_OVERLAPPED*), 0); //Других вариантов подключения к СОМ-порту нет
  if DWORD(hCom) = INVALID_HANDLE_VALUE then    begin ShowMessage('Порт СОМ' + IntToStr(FPortNumber) + ' недоступен. Ошибка произошла при открытии порта.'); Exit; end;//Устанавливаем размеры буферов ввода и выводаif not SetupComm(hCom, 100, 100) then    begin ShowMessage('Произошла ошибка при установке размеров буферов. Открытие порта прошло успешно.'); Exit; end;   dcb.DCBlength := sizeof(DCB);   BuildCommDCB('baud=19200 parity=N data=8 stop=2', dcb);
   dcb.BaudRate := 19200;      //Скорость обмена данными (бод/сек.)  Параметр № 118   dcb.ByteSize := 8;          //Длина слова (бит)                   Параметр № 119   dcb.StopBits := TWOSTOPBITS;//Кол-во стоповых бит                 Параметр № 119   dcb.Parity   := ODDPARITY;  //Контроль чётности                   Параметр № 120if not SetCommState(hCom, dcb) then    begin ShowMessage('Порт СОМ' + IntToStr(FPortNumber) + ' недоступен. Ошибка произошла при записи новых настроек.'); Exit; end;//Параметры временных задержек при приёме-передаче данныхif not Windows.GetCommTimeouts(hCom, ct) then    begin ShowMessage('Порт СОМ' + IntToStr(FPortNumber) + ' недоступен. Ошибка произошла при считывании текущих параметров временных задержек.'); Exit; end;    ct.ReadIntervalTimeout := 10;    ct.ReadTotalTimeoutMultiplier := 2;
    ct.ReadTotalTimeoutConstant := 5;
    ct.WriteTotalTimeoutMultiplier := 1;
    ct.WriteTotalTimeoutConstant := 5;
(*  ct.ReadTotalTimeoutConstant := 5;  ct.ReadIntervalTimeout := 1;   //Таймаут между символами
  ct.ReadTotalTimeoutMultiplier := 1;
  ct.WriteTotalTimeoutMultiplier := 1;
  ct.WriteTotalTimeoutConstant := 5;  *)
if not Windows.SetCommTimeouts(hCom, ct) then
    begin ShowMessage('Порт СОМ' + IntToStr(FPortNumber) + ' недоступен. Ошибка произошла при установке параметров временных задержек.'); Exit; end;

//Устанавливаем маску отсева событий
if not Windows.SetCommMask(hCom, EV_RING + EV_RXCHAR + EV_RXFLAG + EV_TXEMPTY) then
    begin ShowMessage('Порт СОМ' + IntToStr(FPortNumber) + ' недоступен. Ошибка произошла при установке маски.'); Exit; end;

//Очищаем буферы ввода-выводаPurgeComm(hCom, PURGE_RXCLEAR);PurgeComm(hCom, PURGE_TXCLEAR);FPortOpened := True; //Подключение прошло успешно//Thread.Act := True;end;

function TEnginsComPort.Receive: String;
var Buffer: array[1..100] of Char;
    Readed: Longword;
begin
    if not FPortOpened then Exit;
    FillChar(Buffer, 100, 0);
    FillChar(Overlap, SizeOf(Overlap), 0);
    Windows.ReadFile(hCom, Buffer, 12, Readed, @Overlap);
    Result := Buffer; SetLength(Result, Readed);
end;

procedure TEnginsComPort.Send(S: String);
var OKBytesOut: Longword;
    Error: Cardinal;
begin
    if not FPortOpened then Exit;
    FillChar(Overlap, SizeOf(Overlap), 0);
    ClearCommError(hCom, Error, @Overlap);
    Windows.WriteFile(hCom, S[1], Length(S), OKBytesOut, @Overlap);
end;

{ TEngineInfo }

procedure TEngineInfo.ReadAmper0;
begin
  FAmper0 := HexToCardinal(SendCommand(0, CreateCommand('00' + cmdReadAmper))) div 10;
end;

procedure TEngineInfo.ReadAmper1;
begin
  FAmper1 := HexToCardinal(SendCommand(1, CreateCommand('01' + cmdReadAmper))) div 10;
end;

procedure TEngineInfo.ReadFrequency0;
//var S: String;
begin
  FFrequency0 := HexToCardinal(SendCommand(0, CreateCommand('00' + cmdReadFreq))) div 100;
  if not SetNewFrequency0 then Exit;

  (*S := 'Частота 0 двигалелю: ' + IntToStr(FNewFrequency0) + 'Hz: ';
  MyFile.Write(S[1], Length(S));    *)

  SendCommand(0, CreateCommand('00' + cmdWriteFreq + IntToHex(FNewFrequency0 * 100, 4)));
  SetNewFrequency0 := False;
end;

procedure TEngineInfo.ReadFrequency1;
//var S: String;
begin
  FFrequency1 := HexToCardinal(SendCommand(1, CreateCommand('01' + cmdReadFreq))) div 100;
  if not SetNewFrequency1 then Exit;

 (* S := 'Частота 0 двигалелю: ' + IntToStr(FNewFrequency0) + 'Hz: ';
  MyFile.Write(S[1], Length(S));      *)

  SendCommand(1, CreateCommand('01' + cmdWriteFreq + IntToHex(FNewFrequency1 * 100, 4)));
  SetNewFrequency1 := False;
end;

procedure TEngineInfo.ReadState0;
var i: Cardinal;
begin
    i := HexToCardinal(SendCommand(0, CreateCommand('00' + cmdReadState)));
    FState0 := [];
    if (i and 1) <> 0   then FState0 := FState0 + [stRun];
    if (i and 2) <> 0   then FState0 := FState0 + [stForward];
    if (i and 4) <> 0   then FState0 := FState0 + [stBackward];
    if (i and 8) <> 0   then FState0 := FState0 + [stSU];
    if (i and 16) <> 0  then FState0 := FState0 + [stOL];
    if (i and 64) <> 0  then FState0 := FState0 + [stFU];
    if (i and 128) <> 0 then FState0 := FState0 + [stAvarija];
end;

procedure TEngineInfo.ReadState1;
var i: Cardinal;
begin
    i := HexToCardinal(SendCommand(1, CreateCommand('01' + cmdReadState)));
    FState1 := [];
    if (i and 1) <> 0   then FState1 := FState1 + [stRun];
    if (i and 2) <> 0   then FState1 := FState1 + [stForward];
    if (i and 4) <> 0   then FState1 := FState1 + [stBackward];
    if (i and 8) <> 0   then FState1 := FState1 + [stSU];
    if (i and 16) <> 0  then FState1 := FState1 + [stOL];
    if (i and 64) <> 0  then FState1 := FState1 + [stFU];
    if (i and 128) <> 0 then FState1 := FState1 + [stAvarija];
end;

procedure TEngineInfo.ReadVolt0;
begin
  FVolt0 := HexToCardinal(SendCommand(0, CreateCommand('00' + cmdReadVolt))) div 10;
end;

procedure TEngineInfo.ReadVolt1;
begin
  FVolt1 := HexToCardinal(SendCommand(1, CreateCommand('01' + cmdReadVolt))) div 10;
end;

procedure TEngineInfo.SetFrequency0(Value: Cardinal);
begin
  if Value = FFrequency0 then Exit;
  if Value > 100 then Value := 80; //Нельзя поставить частоту выше 100 герц
  FNewFrequency0 := Value;
  SetNewFrequency0 := True;
end;

procedure TEngineInfo.SetFrequency1(Value: Cardinal);
begin
  if Value = FFrequency1 then Exit;
  if Value > 100 then Value := 80; //Нельзя поставить частоту выше 100 герц
  FNewFrequency1 := Value;
  SetNewFrequency1 := True;
end;

{ TEngineCycle }

procedure TEngineCycle.CommandTo0(Command: TEngineCommand);
begin
  if Command0.CommandType <> ctNone then DoMainCommand;
  case Command of
    ecForward:  RunForward0;
    ecBackward: RunBackward0;
    ecStop:     StopEngine0;
  end;
end;

procedure TEngineCycle.CommandTo1(Command: TEngineCommand);
begin
  if Command1.CommandType <> ctNone then DoMainCommand;
  case Command of
    ecForward:  RunForward1;
    ecBackward: RunBackward1;
    ecStop:     StopEngine1;
  end;
end;

procedure TEngineCycle.CommandToEngine(Command: TEngineUD);
begin
  CommandTo1(TEngineCommand(Command));
  Command1.Description3 := Command;
  Command1.CommandType := ctEngineUD;
end;

procedure TEngineCycle.CommandToEngine(Command: TEngineLR);
begin
  CommandTo0(TEngineCommand(Command));
  Command0.Description2 := Command;
  Command0.CommandType := ctEngineLR;
end;

procedure TEngineCycle.CommandToEngine(Command: TEngineUsilije);
begin
  CommandTo1(TEngineCommand(Command));
  Command1.Description6 := Command;
  Command1.CommandType := ctEngineUsilije;
end;

procedure TEngineCycle.CommandToEngine(Command: TEngineCruch);
begin
  CommandTo0(TEngineCommand(Command));
  Command0.Description7 := Command;
  Command0.CommandType := ctEngineCruch;
end;

procedure TEngineCycle.CommandToEngine(Command: TEngineAngle);
begin
  CommandTo0(TEngineCommand(Command));
  Command0.Description4 := Command;
  Command0.CommandType := ctEngineAngle;
end;

procedure TEngineCycle.CommandToEngine(Command: TEngineMM);
begin
  CommandTo1(TEngineCommand(Command));
  Command1.Description5 := Command;
  Command1.CommandType := ctEngineMM;
end;

procedure TEngineCycle.DoMainCommand;
begin
   if Command0.CommandType <> ctNone then Proceed0Command;
   if Command1.CommandType <> ctNone then Proceed1Command;
   Command0.CommandType := ctNone;
   Command1.CommandType := ctNone;
end;

function TEngineCycle.GetLRState: TEngineCommand;
begin
  Result := TEngineCommand(5);
  if stForward in State0 then Result := ecForward;
  if stBackward in State0 then Result := ecBackward;
  if (*not (stRun in State0)*) State0 = [] then Result := ecStop;
end;

function TEngineCycle.GetUDState: TEngineCommand;
begin
  Result := TEngineCommand(5);
  if stForward in State1 then Result := ecForward;
  if stBackward in State1 then Result := ecBackward;
  if (*not (stRun in State1)*) State1 = [] then Result := ecStop;
end;

procedure TEngineCycle.Proc;
//var i: Integer;
    //S: String;
begin
    FChoice := (FChoice + 1) mod 4;
    DoMainCommand;
    ReadFrequency0;
    DoMainCommand;
    ReadFrequency1;
    DoMainCommand;
    ReadState0;
    DoMainCommand;
    ReadState1;
    DoMainCommand;
    //S :=  '-----------------------------------' + CR;
    //S := S + LF;
    case FChoice of
      0: ReadVolt0;
      1: ReadAmper0;
      2: ReadVolt1;
      3: ReadAmper1;
      //4: MyFile.Write(S[1], Length(S));
      //4: FActPerSecond := Floor((Time - LastTime) / (9 * OneSecond));
    end;
    DoMainCommand;
end;

procedure TEngineCycle.StopBothEngines;
begin
    CommandToEngine(ecStopUsilije);
    CommandToEngine(ecStopCruch);
end;

{ TEngineExternalInfo }

function TEngineExternalInfo.GetR: Extended;
begin
    Result := 0; //Rt * Electro / Tok;
//    Result := Electro / RAmper;
end;


procedure TEngineExternalInfo.Proc;
begin
  inherited;
//  while (Time - LastTime) / OneMillisecond < 10 do Sleep(0);
//  LastTime := Time;

  if Assigned(FOnResistance) then FOnResistance(FResistance);
  if Assigned(FOnElectro) then FOnElectro(FElectro);
  if Assigned(FOnMM)  then FOnMM(FMM);
  if Assigned(FOnAng) then FOnAng(FAng);
  if Assigned(FOnUsilije) then FOnUsilije(FUsilije);
  if Assigned(FOnCruchenije) then FOnCruchenije(FCruchenije);
  if Assigned(FOnHorizMM) then FOnHorizMM(FHorizMM);

  DataBuffer[Pos].HorizMM := FHorizMM;
  DataBuffer[Pos].MM      := FMM;
  DataBuffer[Pos].Ang     := FAng;
  DataBuffer[Pos].Usilije := FUsilije;
  DataBuffer[Pos].Cruchenije := FCruchenije;
  DataBuffer[Pos].Electro := FElectro;
  DataBuffer[Pos].Time    := Now;
  DataBuffer[Pos].Cycle   := FCurCycle;
  DataBuffer[Pos].Resistance := FResistance;

  Pos := (Pos + 1) mod DataBufferLenght;
end;

procedure TEngineExternalInfo.SetTemperature(const Value: Extended);
begin
  FTemperature := Value;
  FRt := 0.00999950 + 0.0001 * (2.1 * (Value - 20) * 0.0001 - 0.40 * (Value - 20) * (Value - 20) * 0.0001);   
end;

{ TEngineOnestep }

procedure TEngineOneStep.ActivateTask;
begin
  UDDone := True; LRDone := True;
  case CurrentStep.TaskType of
    ttPosition:   ActivatePosition;
    ttCharge:     ActivateCharge;
    ttWaitPos:    ActivateWaitPos;
    ttWaitCharge: ActivateWaitCharge;
  end;
end;

procedure TEngineOneStep.ControlTask;
begin
  InFlow := True;

  if Abs(OldBreakUDKg - Usilije) > FBreakUDKg then
  begin
    UDDone := True; LRDone := True;
    StopBothEngines;
    DoMainCommand;
    FState := ecsIdle;
    ObrazecBreak := True;
    Exit;
  end;
    OldBreakUDKg := Usilije;
  case CurrentStep.TaskType of
    ttPosition:   ControlPosition;
    ttCharge:     ControlCharge;
    ttWaitPos:    ControlWaitPos;
    ttWaitCharge: ControlWaitCharge;
  end;

    InFlow := False;
end;

procedure TEngineOnestep.ContinueTask;
begin
  //if (FState = ecsHandControl) or (FState = ecsPause) then
  //DoOneStep(CurrentStep);
  ActivateTask;
end;

constructor TEngineOnestep.Create(AOwner: TComponent);
begin
  LastTime := Time;
  inherited;
  FState := ecsIdle;
  FReductor := 2;
  CurrentStep := TStep.Create;
end;

destructor TEngineOnestep.Destroy;
begin
  inherited;
  CurrentStep.Free;
end;

procedure TEngineOnestep.DoOneStep(Step: TStep);
begin
  if (BreakStepIntoNParts = 1) then
  begin
    BreakStepIntoNParts    := Step.BreakStepIntoNParts;

    CurrentStep.TaskType  := Step.TaskType;
    CurrentStep.TimeMS := Step.TimeMS;
  //CurrentStep.Accuracy := Step.Accuracy;
    CurrentStep.Active := Step.Active;
    CurrentStep.TraversaCanWork := Step.TraversaCanWork;
    CurrentStep.CruchenijeCanWork := Step.CruchenijeCanWork;

    UpDownEngineCanWork    := Step.TraversaCanWork;
    LeftRightEngineCanWork := Step.CruchenijeCanWork;
  end else
  begin
    Dec(BreakStepIntoNParts);
  end;

    CurrentStep.IdealCharge    := Usilije    + (Step.IdealCharge - Usilije)       / BreakStepIntoNParts;
    CurrentStep.IdealCruchenie := Cruchenije + (Step.IdealCruchenie - Cruchenije) / BreakStepIntoNParts;
    CurrentStep.Peremeshcenije := MM         + (Step.Peremeshcenije - MM)         / BreakStepIntoNParts;
    CurrentStep.Grad           := Ang        + (Step.Grad - Ang)                  / BreakStepIntoNParts;

  ActivateTask;
end;

procedure TEngineOnestep.PauseTaskAndStopEngines;
begin
 FState := ecsPause;
 while (InFlow) do Sleep(0);
 StopBothEngines;
end;

procedure TEngineOneStep.Proc;
begin
  inherited;
  case FState of
    ecsIdle:        Exit;
    ecsHandControl: Exit;
    ecsPause:       Exit;
    ecsTask:        ControlTask;
  end;
end;

procedure TEngineOneStep.ActivatePosition;
begin
  if FProceedTask then
  if UpDownEngineCanWork then
  begin
    FrequencyUD := UDFreq;
    if MM  > CurrentStep.Peremeshcenije then
      begin CommandToEngine(ecDecMM); UDDone := False; FState := ecsTask; end;
    if MM  < CurrentStep.Peremeshcenije then
      begin CommandToEngine(ecIncMM); UDDone := False; FState := ecsTask; end;
  end;

  if FProceedTask then
  if LeftRightEngineCanWork then
  begin
  FrequencyLR := LRFreq;
    if Ang > CurrentStep.Grad + 0.05  then
      begin CommandToEngine(ecDecAngle); LRDone := False; FState := ecsTask; end;
    if Ang < CurrentStep.Grad - 0.05  then
      begin CommandToEngine(ecIncAngle); LRDone := False; FState := ecsTask; end;
  end;
end;

procedure TEngineOneStep.ActivateCharge;
begin
  if FProceedTask then
  if UpDownEngineCanWork then
  begin
     FrequencyUD := UDFreq;
     if Usilije > CurrentStep.IdealCharge + 1 then begin CommandToEngine(ecDecUsilije); UDDone := False; FState := ecsTask; end;
     if Usilije < CurrentStep.IdealCharge - 1 then begin CommandToEngine(ecIncUsilije); UDDone := False; FState := ecsTask; end;
  end;

  if FProceedTask then
  if LeftRightEngineCanWork then
  begin
    FrequencyLR := LRFreq;
    if Cruchenije > CurrentStep.IdealCruchenie + 0.5 then begin CommandToEngine(ecDecCruch); LRDone := False; FState := ecsTask; end;
    if Cruchenije < CurrentStep.IdealCruchenie - 0.5 then begin CommandToEngine(ecIncCruch); LRDone := False; FState := ecsTask; end;
  end;

end;

procedure TEngineOneStep.ActivateWaitCharge;
begin
  if CurrentStep.TimeMS < 2000 then Exit;
  FrequencyLR := 5;
  FrequencyUD := 5;

  FStartTime := Time;
  FTermin    := CurrentStep.TimeMS * OneMillisecond;
  FState     := ecsTask;
end;

procedure TEngineOneStep.ActivateWaitPos;
begin
  if CurrentStep.TimeMS < 2000 then Exit;
  FrequencyLR := 5;
  FrequencyUD := 5;

  FStartTime := Time;
  FTermin    := CurrentStep.TimeMS * OneMillisecond;
  FState     := ecsTask;
end;

procedure TEngineOneStep.ControlCharge;
procedure StopUsilije;
begin
  CommandToEngine(ecStopUsilije); UDDone := True;
end;
procedure StopCruch;
begin
  CommandToEngine(ecStopCruch); LRDone := True;
end;

procedure ShouldIStartUDEngine;
begin
  if not FProceedTask then Exit;
  if not UpDownEngineCanWork then Exit;
  if (StateUD <> TEngineCommand(ecDecUsilije)) and (Usilije > CurrentStep.IdealCharge + 10) then
     begin
        CommandToEngine(ecDecUsilije); UDDone := False;
     end;
  if (StateUD <> TEngineCommand(ecIncUsilije)) and (Usilije < CurrentStep.IdealCharge - 10) then
     begin
        CommandToEngine(ecIncUsilije); UDDone := False;
     end;
end;                                                                          
procedure WhatUDSpeedShouldISet;
begin
  if not FProceedTask then Exit;
  if not UpDownEngineCanWork then Exit;
  case FReductor of
    0: begin
       if Abs(Usilije - CurrentStep.IdealCharge) < 50 then StopUsilije else
       if Abs(Usilije - CurrentStep.IdealCharge) < 80 then FrequencyUD := 5 else
       if Abs(Usilije - CurrentStep.IdealCharge) < 200 then FrequencyUD := 10;
       end;
    1: begin
       if Abs(Usilije - CurrentStep.IdealCharge) < 5 then StopUsilije else
       if Abs(Usilije - CurrentStep.IdealCharge) < 80 then FrequencyUD := 7 else
       if Abs(Usilije - CurrentStep.IdealCharge) < 150 then FrequencyUD := 15;
       end;
    2: begin
       if Abs(Usilije - CurrentStep.IdealCharge) < 3 then StopUsilije else
       if Abs(Usilije - CurrentStep.IdealCharge) > UDDifference
            then  FrequencyUD := LastUDFreqSet + 1
       else
       begin
         if Abs(Usilije - CurrentStep.IdealCharge) < 20 then FrequencyUD := 7 else
         if Abs(Usilije - CurrentStep.IdealCharge) < 50 then FrequencyUD := 15;
       end;
       end;
    3: if Abs(Usilije - CurrentStep.IdealCharge) < 1 then StopUsilije;
    4: if Abs(Usilije - CurrentStep.IdealCharge) < 1 then StopUsilije;
  end;

  UDDifference := Abs(Usilije - CurrentStep.IdealCharge);

  if (Usilije  > CurrentStep.IdealCharge - 1) and
     (TEngineUsilije(StateUD) = ecIncUsilije) then StopUsilije;
  if (Usilije  < CurrentStep.IdealCharge + 1) and
     (TEngineUsilije(StateUD) = ecDecUsilije) then StopUsilije;
end;

//---------------------------------
begin
  if not FProceedTask then Exit;

  ShouldIStartUDEngine;
  WhatUDSpeedShouldISet;





//  if LeftRightEngineCanWork then
//  begin
//    if Cruchenije > CurrentStep.IdealCruchenie + 2 then begin CommandToEngine(ecDecCruch); LRDone := False; FState := ecsTask; end;
//    if Cruchenije < CurrentStep.IdealCruchenie - 2 then begin CommandToEngine(ecIncCruch); LRDone := False; FState := ecsTask; end;
//  end;


  if LeftRightEngineCanWork then
  begin
        if Abs(Cruchenije - CurrentStep.IdealCruchenie) < 0.5 then StopCruch else
        if Abs(Cruchenije - CurrentStep.IdealCruchenie) < 2 then FrequencyLR := min(FrequencyLR, 5) else
        if Abs(Cruchenije - CurrentStep.IdealCruchenie) < 5 then FrequencyLR := min(FrequencyLR, 10);

        if (Cruchenije  > CurrentStep.IdealCruchenie - 0.5) and
           (TEngineCruch(StateLR) = ecIncCruch) then StopCruch;
        if (Cruchenije  < CurrentStep.IdealCruchenie + 0.5) and
           (TEngineCruch(StateLR) = ecDecCruch) then StopCruch;
  end;

  if LRDone and UDDone then FState := ecsIdle;
end;

procedure TEngineOneStep.ControlPosition;
procedure StopUD;
begin
  CommandToEngine(ecStopMM); UDDone := True;
end;
procedure StopLR;
begin
  CommandToEngine(ecStopAngle); LRDone := True;
end;
begin
  if UpDownEngineCanWork then
  begin
        case FReductor of
          0: begin
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.05  then StopUD else
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.1 then FrequencyUD := 5 else
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.2 then FrequencyUD := 10;
             end;
          1: begin
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.001 then StopUD else
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.01 then FrequencyUD := 5 else
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.02 then FrequencyUD := 10;
             end;
          2: begin
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.001 then StopUD else
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.002 then FrequencyUD := 5 else
              if Abs(MM - CurrentStep.Peremeshcenije) < 0.004 then FrequencyUD := 10;
             end;
          3: if Abs(MM - CurrentStep.Peremeshcenije) < 0.001 then StopUD;
          4: if Abs(MM - CurrentStep.Peremeshcenije) < 0.001 then StopUD;
        end;

        if (MM  > CurrentStep.Peremeshcenije) and
           (TEngineMM(StateUD) = ecIncMM) then StopUD;
        if (MM  < CurrentStep.Peremeshcenije) and
           (TEngineMM(StateUD) = ecDecMM) then StopUD;
  end;

  if LeftRightEngineCanWork then
  begin
        if Abs(Ang - CurrentStep.Grad) < 0.1 then StopLR else
        if Abs(Ang - CurrentStep.Grad) < 1 then FrequencyLR := min(5, FrequencyLR);
        if (Ang  > CurrentStep.Grad) and
           (TEngineAngle(StateLR) = ecIncAngle) then StopLR;
        if (Ang  < CurrentStep.Grad) and
           (TEngineAngle(StateLR) = ecDecAngle) then StopLR;
  end;

  if LRDone and UDDone then FState := ecsIdle;
end;

procedure TEngineOneStep.ControlWaitCharge;
begin
  if Time - FStartTime > FTermin then
  begin
    StopBothEngines;
    FState := ecsIdle;
    Exit;
  end;

    FrequencyLR := 5;
    FrequencyUD := 5;

    if Usilije > CurrentStep.IdealCharge + 2 then CommandToEngine(ecDecUsilije);
    if Usilije < CurrentStep.IdealCharge - 2 then CommandToEngine(ecIncUsilije);
    if Cruchenije > CurrentStep.IdealCruchenie + 0.2 then CommandToEngine(ecDecCruch);
    if Cruchenije < CurrentStep.IdealCruchenie - 0.2 then CommandToEngine(ecIncCruch);

    if StateUD <> ecStop then
      begin
        if Abs(Usilije - CurrentStep.IdealCharge) < 1 then CommandToEngine(ecStopUsilije);
        if (Usilije  > CurrentStep.IdealCharge) and
           (TEngineUsilije(StateUD) = ecIncUsilije) then CommandToEngine(ecStopUsilije);
        if (Usilije  < CurrentStep.IdealCharge) and
           (TEngineUsilije(StateUD) = ecDecUsilije) then CommandToEngine(ecStopUsilije);
      end;

    if StateLR <> ecStop then
      begin
        if Abs(Cruchenije - CurrentStep.IdealCruchenie) < 0.1 then CommandToEngine(ecStopCruch);
        if (Cruchenije  > CurrentStep.IdealCruchenie) and
           (TEngineCruch(StateLR) = ecIncCruch) then CommandToEngine(ecStopCruch);
        if (Cruchenije  < CurrentStep.IdealCruchenie) and
           (TEngineCruch(StateLR) = ecDecCruch) then CommandToEngine(ecStopCruch);
      end;
end;

procedure TEngineOneStep.ControlWaitPos;
begin
  if Time - FStartTime > FTermin then
  begin
    StopBothEngines;
    FState := ecsIdle;
    Exit;
  end;

    if MM  > CurrentStep.Peremeshcenije + 0.005 then CommandToEngine(ecDecMM);
    if MM  < CurrentStep.Peremeshcenije - 0.005 then CommandToEngine(ecIncMM);
    if Ang > CurrentStep.Grad           + 0.05  then CommandToEngine(ecDecAngle);
    if Ang < CurrentStep.Grad           - 0.05  then CommandToEngine(ecIncAngle);

    if StateUD <> ecStop then
      begin
        if Abs(MM - CurrentStep.Peremeshcenije) < 0.001 then CommandToEngine(ecStopMM);
        if (MM  > CurrentStep.Peremeshcenije + 0.005) and
           (TEngineMM(StateUD) = ecIncMM) then CommandToEngine(ecStopMM);
        if (MM  < CurrentStep.Peremeshcenije - 0.005) and
           (TEngineMM(StateUD) = ecDecMM) then CommandToEngine(ecStopMM);
      end;

    if StateLR <> ecStop then
      begin
        if Abs(Ang - CurrentStep.Grad) < 0.01 then CommandToEngine(ecStopAngle);
        if (Ang  > CurrentStep.Grad + 0.05) and
           (TEngineAngle(StateLR) = ecIncAngle) then CommandToEngine(ecStopAngle);
        if (Ang  < CurrentStep.Grad - 0.05) and
           (TEngineAngle(StateLR) = ecDecAngle) then CommandToEngine(ecStopAngle);
      end;
end;

{ TGoToPhysicalZero }

procedure TGoToPhysicalZero.GoToPhysicalZero;
begin
  if FState = ecsTask then Exit;
  if FState = ecsPause then Exit;
  CurrentStep.TaskType := ttCharge;
  CurrentStep.IdealCharge := Usilije - FPhysicalUsilije;
  CurrentStep.IdealCruchenie := Cruchenije - FPhysicalCruchenije;
  CurrentStep.Accuracy := taSlow;
  ActivateTask;
end;

procedure TGoToPhysicalZero.Proc;
begin
  inherited;
  if Assigned(FOnPhysicalUsilije) then FOnPhysicalUsilije(FPhysicalUsilije);
  if Assigned(FOnPhysicalCruchenije) then FOnPhysicalCruchenije(FPhysicalCruchenije);
end;

{ TEngineTaskMaker }

constructor TEngineTaskMaker.Create(AOwner: TComponent);
begin
  inherited;
  FCurStep := 0;
  FCurCycle := 1;
  FProcess := TProcess.Create;
  FCycles := 1;
end;

destructor TEngineTaskMaker.Destroy;
begin
  FProcess.Free;
  inherited;
end;

function TEngineTaskMaker.GetSteps: Cardinal;
begin
  Result := FProcess.ActiveSteps;
end;

procedure TEngineTaskMaker.Proc;
begin
  inherited;
  if not FProceedTask  then Exit;
  if FState  <> ecsIdle then Exit;
  if StateLR <> ecStop then Exit;
  if StateUD <> ecStop then Exit;

  if ObrazecBreak then
  begin
    FProceedTask := False;
    Application.MessageBox('Образец разрушен. Задание полностью отменено. Сохраните результаты.', 'Внимание!', MB_OK);
    //MessageDlg('Образец разрушен. Задание полностью отменено. Сохраните результаты.', mtWarning, [mbOK], 0);
    //ShowMessage('Образец разрушен. Задание полностью отменено. Сохраните результаты.');
    Exit;
  end;

  if (FCurCycle = 1) and (FCurStep = 0) then
  begin
    if FProcess.FirstStep.Active then DoOneStep(FProcess.FirstStep);
    if (BreakStepIntoNParts <= 1) then FCurStep := 1;
    Exit;
  end;

  if(BreakStepIntoNParts > 1) then
  begin
    DoOneStep(FProcess.Steps[FCurStep - 1]);
    Exit;
  end;

  if (FCurStep = StepsNumber + 1) and (FCurCycle >= FCycles) then
  begin
    if not LastStepDone then
        if FProcess.LastStep.Active then
        begin
          DoOneStep(FProcess.LastStep);
          LastStepDone := True;
          Exit;
        end;

    if Assigned(FOnEndTask) then FOnEndTask(Self);
    FCurCycle := 1;
    FCurStep := 0;
    FProceedTask := False;
    Exit;
  end;

  if FCurStep = StepsNumber + 1 then
  begin
    Inc(FCurCycle);
    FCurStep := 1;
  end;

  if FProcess.Steps[FCurStep].Active then DoOneStep(FProcess.Steps[FCurStep])
  else FCurStep := StepsNumber;
  Inc(FCurStep);
end;

procedure TEngineTaskMaker.SetProceedTask(const Value: Boolean);
begin
  if Value then
    begin
      FCurStep := 0;
      FCurCycle := 1;
      CurrentStep.IdealCharge := 0;
      CurrentStep.IdealCruchenie := 0;
      CurrentStep.Peremeshcenije := 0;
      CurrentStep.Grad := 0;
      UDFreq := 15;
      LRFreq := 15;
      FState := ecsIdle;
      UDDifference := 0;
      LRDifference := 0;
      BreakStepIntoNParts := 1;
    end;

  OldBreakUDKg := Usilije;
  ObrazecBreak := False;
  FProceedTask := Value;
end;

{ TEngineStandartTasks }

procedure TEngineStandartTasks.InitStep;
var Step: TStep;
begin
  if StepNumber =  0           then Step := FProcess.FirstStep else
  if StepNumber <= StepsNumber then Step := FProcess.Steps[StepNumber];
  if StepNumber >  StepsNumber then Step := FProcess.LastStep;

  Step.TaskType := TaskType;
  Step.IdealCharge := IdealCharge;
  Step.IdealCruchenie := IdealCruchenie;
  Step.Grad := Grad;
  Step.Peremeshcenije := Peremeshcenije;
  Step.TimeMS := TimeMSec;
  Step.Active := True;
  Step.Accuracy := FAccuracy;
  Step.CruchenijeCanWork := CruchenijeCanWork;
  Step.TraversaCanWork := TraversaCanWork;
  Step.BreakStepIntoNParts := BreakStepIntoNParts;
end;

procedure TEngineStandartTasks.Start;
begin
  LastStepDone := False;
  ProceedTask := True;
end;

procedure TEngineStandartTasks.StopAndResetTask;
begin
  ProceedTask := False;
  FState := ecsIdle;
  StopBothEngines;
end;

procedure TEngineStandartTasks.InitGestkijCiklicheskoje;
begin
//    if Assigned(FEditor) then
//    with FEditor do
//    begin
//      SelAttributes.Style := [fsBold];
//      Lines.Add('Жёсткий режим, циклическое нагружение');
//
//      SelAttributes.Style := [];
//      Lines.Add('Количество циклов: ' + IntToStr(FCycles));
//      Lines.Add('Деформация L0: ' + FloatToStr(FMm1) + ' мм.');
//      Lines.Add('Деформация L1: ' + FloatToStr(FMm2) + ' мм.');
//      Lines.Add('Время выдержки при максимальной нагрузке: ' + IntToStr(FTimeSec) + ' сек.');
//    end;

//        InitStep(1,               0, ttPosition, 0, 0, 0, FMm1, False);
//        InitStep(2, FTimeSec * 1000, ttWaitPos,  1, 0, 0, FMm1, False);
//        InitStep(3,               0, ttPosition, 0, 0, 0, 0,    False);
//        InitStep(4,               0, ttPosition, 0, 0, 0, FMm2, False);
//        InitStep(5, FTimeSec * 1000, ttWaitPos,  1, 0, 0, FMm2, False);
//        InitStep(6,               0, ttPosition, 0, 0, 0, 0,    False);
//        FProcess.Steps[7].Active  := False;
    FProcess.FirstStep.Active := False;
    InitStep(1,               0, ttPosition, 0, 0, 0, FMm1, False);
    InitStep(2, FTimeSec * 1000, ttWaitPos,  0, 0, 0, FMm1, False);
    InitStep(3,               0, ttPosition, 0, 0, 0, FMm2, False);
    InitStep(4, FTimeSec * 1000, ttWaitPos,  0, 0, 0, FMm2, False);
    FProcess.Steps[5].Active  := False;

    FProcess.LastStep.Active  := True;
    InitStep(StepsNumber + 1, 0, ttCharge,   0, 0, 0, 0,    False);
end;

procedure TEngineStandartTasks.InitMjagkijCiklicheskoje;
begin
//    if Assigned(FEditor) then
//    with FEditor do
//    begin
//      SelAttributes.Style := [fsBold];
//      Lines.Add('Мягкий режим, циклическое нагружение');
//
//      SelAttributes.Style := [];
//      Lines.Add('Количество циклов: ' + IntToStr(FCycles));
//      Lines.Add('Нагрузка P0: ' + IntToStr(Floor(FUsilije1kg)) + ' кг ('+ IntToStr(Floor(FUsilije1kg * 9.8)) + ' Н)');
//      Lines.Add('Нагрузка P1: ' + IntToStr(Floor(FUsilije2kg)) + ' кг ('+ IntToStr(Floor(FUsilije2kg * 9.8)) + ' Н)');
//      Lines.Add('Время выдержки при максимальной нагрузке: ' + IntToStr(FTimeSec) + ' сек.');
//    end;

//        InitStep(1,               0, ttCharge,     FUsilije1kg, 0, 0, 0, False);
//        InitStep(2, FTimeSec * 1000, ttWaitCharge, FUsilije1kg, 0, 0, 0, False);
//        InitStep(3,               0, ttCharge,     0,           0, 0, 0, False);
//        InitStep(4,               0, ttCharge,     FUsilije2kg, 0, 0, 0, False);
//        InitStep(5, FTimeSec * 1000, ttWaitCharge, FUsilije2kg, 0, 0, 0, False);
//        InitStep(6,               0, ttCharge,     0,           0, 0, 0, False);
//    FProcess.Steps[7].Active  := False;

        FProcess.FirstStep.Active := False;
        InitStep(1,               0, ttCharge,     FUsilije1kg, 0, 0, 0, False);
        InitStep(2, FTimeSec * 1000, ttWaitCharge, FUsilije1kg, 0, 0, 0, False);
        InitStep(3,               0, ttCharge,     FUsilije2kg, 0, 0, 0, False);
        InitStep(4, FTimeSec * 1000, ttWaitCharge, FUsilije2kg, 0, 0, 0, False);
        FProcess.Steps[5].Active  := False;

        FProcess.LastStep.Active  := True;
        InitStep(StepsNumber + 1, 0, ttCharge,     0,           0, 0, 0, False);
end;

procedure TEngineStandartTasks.Init;
begin
  if (FRegim = Mjagkij) and (FNagrugenije = Slognoje)      then InitMjagkijSlognoje;
  if (FRegim = Gestkij) and (FNagrugenije = Ciklicheskoje) then InitGestkijCiklicheskoje;
  if (FRegim = Gestkij) and (FNagrugenije = Slognoje)      then InitGestkijSlognoje;
  if (FRegim = Mjagkij) and (FNagrugenije = Ciklicheskoje) then InitMjagkijCiklicheskoje;
end;

procedure TEngineStandartTasks.InitMjagkijSlognoje;
begin
    if Assigned(FEditor) then
    with FEditor do
    begin
      SelAttributes.Style := [fsBold];
      Lines.Add('Мягкий режим, сложное нагружение');

      SelAttributes.Style := [];
      Lines.Add('Количество циклов: ' + IntToStr(FCycles));
      Lines.Add('Нагрузка P0: ' + IntToStr(Floor(FUsilije1kg)) + ' кг ('+ IntToStr(Floor(FUsilije1kg * 9.8)) + ' Н)');
      Lines.Add('Нагрузка P1: ' + IntToStr(Floor(FUsilije2kg)) + ' кг ('+ IntToStr(Floor(FUsilije2kg * 9.8)) + ' Н)');
      Lines.Add('Момент М0: ' + ExtToStr(FCruchenije1nm) + ' Н*м');
      Lines.Add('Момент М1: ' + ExtToStr(FCruchenije2nm) + ' Н*м');
      Lines.Add('Тип траектории: №' + IntToStr(Integer(FTrajectory) + 1));
      Lines.Add('Время выдержки при максимальной нагрузке: ' + IntToStr(FTimeSec) + 'сек.');
    end;

    FProcess.FirstStep.Active := False;
    FProcess.LastStep.Active  := False;
    case FTrajectory of
      tr1:  // _|-
        begin
        InitStep(1,               0, ttCharge,     0,           FCruchenije1nm);
        InitStep(2,               0, ttCharge,     FUsilije1kg, FCruchenije1nm);
        InitStep(3, FTimeSec * 1000, ttWaitCharge, FUsilije1kg, FCruchenije1nm);
        InitStep(4,               0, ttCharge,     0,           FCruchenije1nm);
        InitStep(5,               0, ttCharge,     0,           FCruchenije2nm);
        InitStep(6,               0, ttCharge,     FUsilije2kg, FCruchenije2nm);
        InitStep(7, FTimeSec * 1000, ttWaitCharge, FUsilije2kg, FCruchenije2nm);
        InitStep(8,               0, ttCharge,     0,           FCruchenije2nm);
        InitStep(9,               0, ttCharge,     0,           0);
        end;

      tr2:
        begin
        InitStep(1,               0, ttCharge,     FUsilije1kg, 0);
        InitStep(2,               0, ttCharge,     FUsilije1kg, FCruchenije1nm);
        InitStep(3, FTimeSec * 1000, ttWaitCharge, FUsilije1kg, FCruchenije1nm);
        InitStep(4,               0, ttCharge,     FUsilije1kg, 0);
        InitStep(5,               0, ttCharge,     FUsilije2kg, 0);
        InitStep(6,               0, ttCharge,     FUsilije2kg, FCruchenije2nm);
        InitStep(7, FTimeSec * 1000, ttWaitCharge, FUsilije2kg, FCruchenije2nm);
        InitStep(8,               0, ttCharge,     FUsilije2kg, 0);
        InitStep(9,               0, ttCharge,     0,           0);
        end;

      tr3:
        begin

        FProcess.FirstStep.Active := True;
        InitStep(0,                0, ttCharge,      FUsilije1kg, FCruchenije1nm, 0, 0, True, True, 5);

        InitStep(1,  FTimeSec * 1000, ttWaitCharge,  FUsilije1kg, FCruchenije1nm, 0, 0, True, True);
        InitStep(2,                0, ttCharge,      FUsilije2kg, FCruchenije2nm, 0, 0, True, True, 10);
        InitStep(3,  FTimeSec * 1000, ttWaitCharge,  FUsilije2kg, FCruchenije2nm, 0, 0, True, True);
        InitStep(4,                0, ttCharge,      FUsilije1kg, FCruchenije1nm, 0, 0, True, True, 10);
        FProcess.Steps[5].Active  := False;

        FProcess.LastStep.Active  := True;
        InitStep(StepsNumber + 1,  0, ttCharge,      0, 0, 0, 0, True, True, 1);

//        InitStep(1,                0, ttCharge,     20 * FUsilije1kg / 100, 20 * FCruchenije1nm / 100);
//        InitStep(2,                0, ttCharge,     40 * FUsilije1kg / 100, 40 * FCruchenije1nm / 100);
//        InitStep(3,                0, ttCharge,     65 * FUsilije1kg / 100, 65 * FCruchenije1nm / 100);
//        InitStep(4,                0, ttCharge,     85 * FUsilije1kg / 100, 85 * FCruchenije1nm / 100);
//        InitStep(5,                0, ttCharge,    100 * FUsilije1kg / 100,100 * FCruchenije1nm / 100);
//        InitStep(6, FTimeSec * 1000, ttWaitCharge, 100 * FUsilije1kg / 100,100 * FCruchenije1nm / 100);
//        InitStep(7,                0, ttCharge,     85 * FUsilije1kg / 100, 85 * FCruchenije1nm / 100);
//        InitStep(8,                0, ttCharge,     65 * FUsilije1kg / 100, 65 * FCruchenije1nm / 100);
//        InitStep(9,                0, ttCharge,     40 * FUsilije1kg / 100, 40 * FCruchenije1nm / 100);
//       InitStep(10,               0, ttCharge,     20 * FUsilije1kg / 100, 20 * FCruchenije1nm / 100);
//        InitStep(11,               0, ttCharge,      0 * FUsilije1kg / 100,  0 * FCruchenije1nm / 100);

//        InitStep(12,               0, ttCharge,     20 * FUsilije2kg / 100, 20 * FCruchenije2nm / 100);
//        InitStep(13,               0, ttCharge,     40 * FUsilije2kg / 100, 40 * FCruchenije2nm / 100);
//        InitStep(14,               0, ttCharge,     65 * FUsilije2kg / 100, 65 * FCruchenije2nm / 100);
//        InitStep(15,               0, ttCharge,     85 * FUsilije2kg / 100, 85 * FCruchenije2nm / 100);
//        InitStep(16,               0, ttCharge,    100 * FUsilije2kg / 100,100 * FCruchenije2nm / 100);
//        InitStep(17, FTimeSec * 1000, ttWaitCharge,100 * FUsilije2kg / 100,100 * FCruchenije2nm / 100);
//        InitStep(18,               0, ttCharge,     85 * FUsilije2kg / 100, 85 * FCruchenije2nm / 100);
//        InitStep(19,               0, ttCharge,     65 * FUsilije2kg / 100, 65 * FCruchenije2nm / 100);
//        InitStep(20,               0, ttCharge,     40 * FUsilije2kg / 100, 40 * FCruchenije2nm / 100);
//        InitStep(21,               0, ttCharge,     20 * FUsilije2kg / 100, 20 * FCruchenije2nm / 100);
//        InitStep(22,               0, ttCharge,      0 * FUsilije2kg / 100,  0 * FCruchenije2nm / 100);
//        FProcess.Steps[23].Active  := False;
        end;

      tr4:
        begin
        InitStep(1, 0, ttCharge, FUsilije1kg, 0);
        InitStep(2, 0, ttCharge, FUsilije1kg, FCruchenije1nm);
        InitStep(3, 0, ttCharge, FUsilije2kg, FCruchenije1nm);
        InitStep(4, 0, ttCharge, FUsilije2kg, FCruchenije2nm);
        InitStep(5, 0, ttCharge, FUsilije1kg, FCruchenije2nm);
        InitStep(6, 0, ttCharge, FUsilije1kg, 0);
        FProcess.Steps[7].Active  := False;
        end;
    end;
end;

procedure TEngineStandartTasks.InitGestkijSlognoje;
begin
    if Assigned(FEditor) then
    with FEditor do
    begin
    SelAttributes.Style := [fsBold];
    Lines.Add('Жёсткий режим, сложное нагружение');
    SelAttributes.Style := SelAttributes.Style - [fsBold];

    Lines.Add('Количество циклов: ' + IntToStr(FCycles));
    Lines.Add('Абсолютное удлинение L0: ' + FloatToStr(FMm1) + 'мм');
    Lines.Add('Абсолютное удлинение L1: ' + FloatToStr(FMm2) + 'мм');
    Lines.Add('Угол закручивания Ф0: ' + FloatToStr(FAngle1grad) + '°');
    Lines.Add('Угол закручивания Ф1: ' + FloatToStr(FAngle2grad) + '°');
    Lines.Add('Время выдержки при максимальной деформации: ' + IntToStr(FTimeSec) + 'сек');
    Lines.Add('Тип траектории: №' + IntToStr(Integer(FTrajectory) + 1));
    end;

    FProcess.FirstStep.Active := False;
    FProcess.LastStep.Active  := False;
    case FTrajectory of
      tr1:  // _|-
        begin
        InitStep(1,               0, ttPosition, 0, 0, FAngle1grad, 0);
        InitStep(2,               0, ttPosition, 0, 0, FAngle1grad, FMm1);
        InitStep(3, FTimeSec * 1000, ttWaitPos,  0, 0, FAngle1grad, FMm1);
        InitStep(4,               0, ttPosition, 0, 0, FAngle1grad, 0);
        InitStep(5,               0, ttPosition, 0, 0, FAngle2grad, 0);
        InitStep(6,               0, ttPosition, 0, 0, FAngle2grad, FMm2);
        InitStep(7, FTimeSec * 1000, ttWaitPos,  0, 0, FAngle2grad, FMm2);
        InitStep(8,               0, ttPosition, 0, 0, FAngle2grad, 0);
        InitStep(9,               0, ttPosition, 0, 0, 0, 0);
        end;

      tr2:
        begin
        InitStep(1,               0, ttPosition, 0, 0, 0, FMm1);
        InitStep(2,               0, ttPosition, 0, 0, FAngle1grad, FMm1);
        InitStep(3, FTimeSec * 1000, ttWaitPos,  0, 0, FAngle1grad, FMm1);
        InitStep(4,               0, ttPosition, 0, 0, 0, FMm1);
        InitStep(5,               0, ttPosition, 0, 0, 0, FMm2);
        InitStep(6,               0, ttPosition, 0, 0, FAngle2grad, FMm2);
        InitStep(7, FTimeSec * 1000, ttWaitPos,  0, 0, FAngle2grad, FMm2);
        InitStep(8,               0, ttPosition, 0, 0, 0, FMm2);
        InitStep(9,               0, ttPosition, 0, 0, 0, 0);
        end;

      tr3:   //      /
        begin
          InitStep(1,               0, ttPosition, 0, 0, FAngle1grad, FMm1, True, True, 4);
          InitStep(2, FTimeSec * 1000, ttWaitPos,  0, 0, FAngle1grad, FMm1);
          if ((FAngle2grad = 0) and (FMm2 = 0)) then
          begin
            InitStep(3,               0, ttCharge, 0, 0, 0,           0,    True, True, 4);
            FProcess.Steps[4].Active  := False;
          end  else
          begin
            InitStep(3,               0, ttPosition, 0, 0, FAngle2grad, FMm2, True, True, 4);
            InitStep(4,               0, ttPosition, 0, 0, 0,           0,    True, True, 4);
            FProcess.Steps[5].Active  := False;
            //InitStep(5,               0, ttPosition, 0, 0, 2 * FAngle1grad / 3, 2 * FMm1 / 3);
            //InitStep(6,               0, ttPosition, 0, 0, FAngle1grad / 3, FMm1 / 3);
            //InitStep(7,               0, ttPosition, 0, 0, 0, 0);
            //InitStep(8,               0, ttPosition, 0, 0, FAngle2grad / 3, FMm2 / 3);
            //InitStep(9,               0, ttPosition, 0, 0, 2 * FAngle2grad / 3, 2 * FMm2 / 3);
            //InitStep(10,              0, ttPosition, 0, 0, FAngle2grad, FMm2);
            //InitStep(11, FTimeSec * 1000, ttWaitPos, 0, 0, FAngle2grad, FMm2);
            //InitStep(12,               0, ttPosition, 0, 0, 2 * FAngle2grad / 3, 2 * FMm2 / 3);
            //InitStep(13,               0, ttPosition, 0, 0, FAngle2grad / 3, FMm2 / 3);
            //InitStep(14,               0, ttPosition, 0, 0, 0, 0);
            //FProcess.Steps[15].Active  := False;
          end;
        end;

      tr4:
        begin
        InitStep(0, 0, ttPosition, 0, 0, 0,           FMm1);
        InitStep(1, 0, ttPosition, 0, 0, FAngle1grad, FMm1);
        InitStep(2, 0, ttPosition, 0, 0, FAngle1grad, 0);
        InitStep(3, 0, ttPosition, 0, 0, FAngle1grad, FMm2);
        InitStep(4, 0, ttPosition, 0, 0, 0,           FMm2);
        InitStep(5, 0, ttPosition, 0, 0, FAngle2grad, FMm2);
        InitStep(6, 0, ttPosition, 0, 0, FAngle2grad, 0);
        InitStep(7, 0, ttPosition, 0, 0, FAngle2grad, FMm1);
        InitStep(8, 0, ttPosition, 0, 0, 0,           FMm1);
        FProcess.Steps[9].Active  := False;
        InitStep(100, 0, ttPosition, 0, 0, 0, 0);
        end;

    end;
  end;


function FormDataString(var Data: TExtData): String;
begin
    Result := '';
    Result := Result + TimeToStr(Data.Time) + TAB;
    Result := Result + ExtToStr(Data.Usilije * 9.8, 0) + TAB + TAB;
    Result := Result + ExtToStr(Data.MM) + TAB + TAB;
    Result := Result + ExtToStr(Data.Cruchenije, 2) + TAB + TAB + TAB;
    Result := Result + ExtToStr(Data.Ang, 3) + TAB + TAB;
    Result := Result + ExtToStr(Data.HorizMM, 4) + TAB + TAB + TAB + TAB;
    Result := Result + ExtToStr(Data.Electro) + TAB + TAB + TAB;
    Result := Result + IntToStr(Data.Cycle) + TAB + TAB;
end;


end.
