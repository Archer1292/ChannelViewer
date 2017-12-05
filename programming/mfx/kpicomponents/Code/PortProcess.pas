unit PortProcess;
interface
uses CommonTypes, Windows, Sysutils, Classes, Dialogs;

const BufferSize = 100;
type  TDataCame = procedure(S: String) of object;

type TComPortController = class(TThreadHolder)
private
    FAfterSendData: TDataCame;
    FActive: Boolean;
    FCom:    Cardinal;
    procedure SetCom(const Value: Cardinal);
protected
    CommunicationReady: Boolean;
    dcb:     TDCB;
    ct:      TCommTimeouts;
    hCom:    THandle;
    procedure SetActive(const Value: Boolean); virtual;
    procedure Proc; override;
    procedure PortConfig; virtual;
    procedure TimeoutConfig; virtual;
    procedure Communicate; virtual; abstract;
public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure ClearAllBuffers;
    procedure Send(S: String);
    function  ReceiveAnswer(Len: Cardinal): String; virtual;
published
    property Com: Cardinal read FCom write SetCom;
    property Active: Boolean read FActive write SetActive;
end;
//-----------------------------------------------------------------------------

type TComPort = class(TComPortController)
private
  FDataCame: TDataCame;
protected
  procedure PortConfig; override;
  procedure TimeoutConfig; override;
  procedure Communicate; override;
public
  function  ReceiveAnswer(Len: Cardinal): String; override;
published
  property DataCame: TDataCame read FDataCame write FDataCame;
  property AfterSendData: TDataCame read FAfterSendData write FAfterSendData;
end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('KPI', [TComPort]);
end;


{ ComPortController }

constructor TComPortController.Create(AOwner: TComponent);
begin
  inherited;
  CommunicationReady := True;
  FCom := 1;
end;

destructor TComPortController.Destroy;
begin
  Active := False;
  while not CommunicationReady do Sleep(0);
  inherited;
end;

procedure TComPortController.PortConfig;
begin
   dcb.DCBlength := sizeof(DCB);
   BuildCommDCB('baud=9600 parity=N data=8 stop=1', dcb);
end;

procedure TComPortController.Proc;
begin
  CommunicationReady := True;
  if not FActive then Exit;
  CommunicationReady := False;
  Communicate;
  CommunicationReady := True;
end;

procedure TComPortController.SetActive(const Value: Boolean);
begin
  if FActive = Value then Exit;
  if csDesigning in ComponentState then begin FActive := Value; Exit; end;
  if Value then
begin
  hCom := CreateFile(PChar('COM' + IntToStr(fCom)), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
//Других вариантов подключения к СОМ-порту нет  if DWORD(hCom) = INVALID_HANDLE_VALUE then    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при открытии порта.'); Exit; end;//Устанавливаем размеры буферов ввода и выводаif not SetupComm(hCom, BufferSize, BufferSize) then    begin ShowMessage('Произошла ошибка при установке размеров буферов. Открытие порта прошло успешно.'); Exit; end;PortConfig;if not SetCommState(hCom, dcb) then    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при записи новых настроек.'); Exit; end;//Параметры временных задержек при приёме-передаче данныхif not Windows.GetCommTimeouts(hCom, ct) then  begin  ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при считывании текущих параметров временных задержек.'); Exit; end;TimeoutConfig;if not Windows.SetCommTimeouts(hCom, ct) then
    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при установке параметров временных задержек.'); Exit; end;

//Устанавливаем маску отсева событий
if not Windows.SetCommMask(hCom, EV_RING + EV_RXCHAR + EV_RXFLAG + EV_TXEMPTY) then
    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при установке маски.'); Exit; end;

//Очищаем буферы ввода-выводаPurgeComm(hCom, PURGE_RXCLEAR);PurgeComm(hCom, PURGE_TXCLEAR);FActive := True; //Подключение прошло успешно//Thread.Act := True;end else
begin
    Thread.Act := False;
    FActive := False;
    while not CommunicationReady do Sleep(0);
    if not CloseHandle(hCom) then
        begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при закрытии порта.'); Exit; end;    hCom := 0;end;
end;

procedure TComPortController.SetCom(const Value: Cardinal);
begin
  if FActive and (not (csDesigning in ComponentState)) and (Value <> FCom)
    then ShowMessage('Для того, чтобы изменить номер порта, нужно установить Active = False.');
  if (Value > 0) and (Value < 33) then FCom := Value
  else ShowMessage('Номер порта должен быть натуральным числом.');
end;

procedure TComPortController.TimeoutConfig;
begin
    ct.ReadIntervalTimeout := 10;
    ct.ReadTotalTimeoutMultiplier := 2;
    ct.ReadTotalTimeoutConstant := 5;
    ct.WriteTotalTimeoutMultiplier := 1;
    ct.WriteTotalTimeoutConstant := 5;

(*  ct.ReadTotalTimeoutConstant := 10;
  ct.ReadIntervalTimeout := 1;   //Таймаут между символами
  ct.ReadTotalTimeoutMultiplier := 1;
  ct.WriteTotalTimeoutMultiplier := 1;
  ct.WriteTotalTimeoutConstant := 10;*)
end;

{ TComPort }

procedure TComPortController.ClearAllBuffers;
begin
  if not FActive then Exit;
  PurgeComm(hCom, PURGE_RXCLEAR);
  PurgeComm(hCom, PURGE_TXCLEAR);end;

procedure TComPort.PortConfig;
begin
  inherited;
  dcb.BaudRate := 19200;      //Скорость обмена данными (бод/сек.)  Параметр № 118
  dcb.ByteSize := 8;          //Длина слова (бит)                   Параметр № 119  dcb.StopBits := TWOSTOPBITS;//Кол-во стоповых бит                 Параметр № 119  dcb.Parity   := ODDPARITY;  //Контроль чётности                   Параметр № 120end;

procedure TComPortController.Send(S: String);
var OKBytesOut: Longword;
    Overlap: TOverlapped;
    Error: Cardinal;
begin
    if not FActive then Exit;
    FillChar(Overlap, SizeOf(Overlap), 0);
    ClearCommError(hCom, Error, @Overlap);
    Windows.WriteFile(hCom, S[1], Length(S), OKBytesOut, @Overlap);
    SetLength(S, OKBytesOut);
    if Assigned(FAfterSendData) then FAfterSendData(S);
end;

procedure TComPort.TimeoutConfig;
begin
(*  ct.ReadTotalTimeoutConstant := 30;
  ct.ReadIntervalTimeout := 3;   //Таймаут между символами
  ct.ReadTotalTimeoutMultiplier := 2;
  ct.WriteTotalTimeoutMultiplier := 2;
  ct.WriteTotalTimeoutConstant := 20;*)
    ct.ReadIntervalTimeout := 10;
    ct.ReadTotalTimeoutMultiplier := 2;
    ct.ReadTotalTimeoutConstant := 5;
    ct.WriteTotalTimeoutMultiplier := 1;
    ct.WriteTotalTimeoutConstant := 5;

end;

procedure TComPort.Communicate;
var i: Integer;
    p: PMyList;
begin
    for i := 0 to Users.Count - 1 do
    try
        if (Users.Count > i) then p := Users.Items[i] else Exit;
        if Assigned(p^.p) then p^.P;
    except end;
end;

function TComPortController.ReceiveAnswer(Len: Cardinal): String;
var Buffer: array[1..BufferSize] of Char;
    Readed: Longword;
    Overlap: TOverlapped;
begin
    if not FActive then Exit;
    FillChar(Buffer, BufferSize, 0);
    FillChar(Overlap, SizeOf(Overlap), 0);
    Windows.ReadFile(hCom, Buffer, Len, Readed, @Overlap);
    Result := Buffer; SetLength(Result, Readed);
end;

function TComPort.ReceiveAnswer(Len: Cardinal): String;
begin
    Result := inherited ReceiveAnswer(Len);
    if Assigned(FDataCame) then FDataCame(Result);
end;

end.
