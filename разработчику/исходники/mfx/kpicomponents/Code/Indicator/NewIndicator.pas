unit NewIndicator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;
type TStroka = String[20];
     TEkran  = array[1..4]  of TStroka;

type
  TNewIndicator = class(TComponent)
  private
    FIsWorking: Boolean;
    FCom: Cardinal;
    CommunicationReady: Boolean;
    dcb:     TDCB;
    ct:      TCommTimeouts;
    hCom:    THandle;
    FXY: TEkran;
    FExchGood: Boolean;
    function  CP866(S: String): String;
    procedure SetXY(const Value: TEkran);
    procedure SendText(S: String);
    procedure OnOff(MigCursor, StatCursor, OnOff: Boolean);
    procedure OnOffPodsvet(b: Boolean);
    procedure Clear;
    procedure Send(S: String);
    function  ReceiveAnswer(Len: Cardinal): String;
    procedure Loaded; override;
  public
constructor Create(AOwner: TComponent); override;
destructor Destroy; override;

property IsWorking: Boolean read FIsWorking;
property XY: TEkran read FXY write SetXY;
property ExchGood: Boolean read FExchGood;
   published
property Com: Cardinal read FCom write FCom;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('KPI', [TNewIndicator]);
end;

var    T: array[0..255] of Byte = (0  ,1  ,2  ,3  ,4  ,5  ,6  ,7  ,8  ,9  ,10 ,11 ,12 ,13 ,14 ,15,  //0
                                   16 ,17 ,18 ,19 ,20 ,21 ,22 ,23 ,24 ,25 ,26 ,27 ,28 ,29 ,30 ,31,  //1
                                   32 ,33 ,34 ,35 ,36 ,37 ,38 ,39 ,40 ,41 ,42 ,43 ,44 ,45 ,46 ,47,  //2
                                   48 ,49 ,50 ,51 ,52 ,53 ,54 ,55 ,56 ,57 ,58 ,59 ,60 ,61 ,62 ,63,  //3
                                   64 ,65 ,66 ,67 ,68 ,69 ,70 ,71 ,72 ,73 ,74 ,75 ,76 ,77 ,78 ,79,  //4
                                   80 ,81 ,82 ,83 ,84 ,85 ,86 ,87 ,88 ,89 ,90 ,91 ,92 ,93 ,94 ,95,  //5
                                   96 ,97 ,98 ,99 ,100,101,102,103,104,105,106,107,108,109,110,111, //6
                                   112,113,114,115,116,117,118,119,120,121,122,27 ,28 ,29 ,30 ,31,  //7
                                   32 ,33 ,34 ,35 ,20 ,21 ,22 ,23 ,24 ,25 ,26 ,27 ,28 ,29 ,30 ,31,  //8
                                   32 ,33 ,34 ,35 ,20 ,21 ,22 ,23 ,24 ,25 ,26 ,27 ,28 ,29 ,30 ,31,  //9
                                   32 ,33 ,34 ,35 ,20 ,21 ,22 ,23 ,240 ,25 ,0  ,27 ,28 ,29 ,30 ,2,  //A
                                   32 ,33 ,34 ,35 ,20 ,21 ,22 ,23 ,181 ,25 ,1  ,27 ,28 ,29 ,30 ,3 , //B
                                   128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143, //C
                                   144,145,146,147,148,149,150,151,152,153,154,155,156,157,176,177, //D
                                   160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175, //E
                                   224,225,226,227,228,229,230,192,193,233,194,195,196,197,198,199);//F

//                                 0   1   2   3   4   5   6   7   8   9   A   B   C   D   E   F

{ TNewIndicator }

procedure TNewIndicator.Clear;
begin
SendText('T');
end;

function TNewIndicator.CP866(S: String): String;
var i: Integer;
begin
    SetLength(Result, Length(S));
    for i := 1 to Length(S) do
       Result[i] := Chr(T[Ord(S[i])]);
end;

constructor TNewIndicator.Create(AOwner: TComponent);
begin
  inherited;
  FIsWorking := False;
end;

destructor TNewIndicator.Destroy;
begin
  if FIsWorking then CloseHandle(hCom);
  inherited;
end;

procedure TNewIndicator.Loaded;
begin
  inherited;
  if csDesigning in ComponentState then Exit;

  hCom := CreateFile(PChar('COM' + IntToStr(fCom)), GENERIC_READ or GENERIC_WRITE,
    0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL(*FILE_FLAG_OVERLAPPED*), 0);//Других вариантов подключения к СОМ-порту нетif DWORD(hCom) = INVALID_HANDLE_VALUE then    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при открытии порта.'); Exit; end;//Устанавливаем размеры буферов ввода и выводаif not SetupComm(hCom, 50, 50) then    begin ShowMessage('Произошла ошибка при установке размеров буферов. Открытие порта прошло успешно.'); Exit; end;  dcb.DCBlength := sizeof(DCB);  BuildCommDCB('baud=9600 parity=N data=8 stop=1', dcb);
  dcb.BaudRate := 115200;       //Скорость обмена данными (бод/сек.)  Параметр № 118  dcb.ByteSize := 8;          //Длина слова (бит)                   Параметр № 119  dcb.StopBits := ONESTOPBIT; //Кол-во стоповых бит                 Параметр № 119  dcb.Parity   := NOPARITY;  //Контроль чётности                   Параметр № 120if not SetCommState(hCom, dcb) then    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при записи новых настроек.'); Exit; end;//Параметры временных задержек при приёме-передаче данныхif not Windows.GetCommTimeouts(hCom, ct) then    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при считывании текущих параметров временных задержек.'); Exit; end;    ct.ReadIntervalTimeout := 10;    ct.ReadTotalTimeoutMultiplier := 2;
    ct.ReadTotalTimeoutConstant := 5;
    ct.WriteTotalTimeoutMultiplier := 1;
    ct.WriteTotalTimeoutConstant := 2;
(*  ct.ReadTotalTimeoutConstant := 1;  ct.ReadIntervalTimeout := 1;   //Таймаут между символами
  ct.ReadTotalTimeoutMultiplier := 1;
  ct.WriteTotalTimeoutMultiplier := 1;
  ct.WriteTotalTimeoutConstant := 1; *)
if not Windows.SetCommTimeouts(hCom, ct) then    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при установке параметров временных задержек.'); Exit; end;

//Устанавливаем маску отсева событий
if not Windows.SetCommMask(hCom, EV_RING + EV_RXCHAR + EV_RXFLAG + EV_TXEMPTY) then
    begin ShowMessage('Порт СОМ' + IntToStr(FCom) + ' недоступен. Ошибка произошла при установке маски.'); Exit; end;

//Очищаем буферы ввода-выводаPurgeComm(hCom, PURGE_RXCLEAR);PurgeComm(hCom, PURGE_TXCLEAR);FIsWorking := True; //Подключение прошло успешно    OnOff(False, False, True);    OnOffPodsvet(False); //Включить подсвет
    Clear;               //Очистить индикатор
end;

procedure TNewIndicator.OnOff(MigCursor, StatCursor, OnOff: Boolean);
var i: Integer;
begin
  i := 0;
  i := i + 1 * Integer(MigCursor);
  i := i + 2 * Integer(StatCursor);
  i := i + 4 * Integer(OnOff);
  SendText('S' + IntToHex(i, 1));
end;

procedure TNewIndicator.OnOffPodsvet(b: Boolean);
begin
  Send('$01'+ CP866('I' + IntToStr(Integer(b))) + #13);
end;

function TNewIndicator.ReceiveAnswer(Len: Cardinal): String;
var Buffer: array[1..50] of Char;
    Readed: Longword;
    Overlap: TOverlapped;
begin
    if not FIsWorking then Exit;
    FillChar(Buffer, 50, 0);
    FillChar(Overlap, SizeOf(Overlap), 0);
    Windows.ReadFile(hCom, Buffer, Len, Readed, @Overlap);
    Result := Buffer; SetLength(Result, Readed);
end;

procedure TNewIndicator.Send(S: String);
var OKBytesOut: Longword;
    Overlap: TOverlapped;
    Error: Cardinal;
begin
    if not FIsWorking then Exit;
    FillChar(Overlap, SizeOf(Overlap), 0);
    ClearCommError(hCom, Error, @Overlap);
    Windows.WriteFile(hCom, S[1], Length(S), OKBytesOut, @Overlap);
    SetLength(S, OKBytesOut);
end;

procedure TNewIndicator.SendText(S: String);
var Temp: String;
begin
  if not FIsWorking then Exit;
  Send('$01' + S + #13); //Sleep(5);
  Temp := ReceiveAnswer(5);
  FExchGood := (Temp = '!01' + #$D);
end;

procedure TNewIndicator.SetXY(const Value: TEkran);
begin
  FXY := Value;
  SendText('T' + '000' + CP866(Value[1]));
  SendText('T' + '100' + CP866(Value[2]));
  SendText('T' + '200' + CP866(Value[3]));
  SendText('T' + '300' + CP866(Value[4]));
end;

end.
 