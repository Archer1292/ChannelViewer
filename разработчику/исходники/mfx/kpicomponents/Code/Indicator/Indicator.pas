unit Indicator;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  PortProcess;
type TStroka = String[20];
     TEkran  = array[1..4]  of TStroka;
type
  TIndicator = class(TComPortController)
  private
    FXY: TEkran;
    FExchGood: Boolean;
    procedure SetXY(const Value: TEkran);
  protected
    procedure PortConfig; override;
    procedure Communicate; override;
    function  CP866(S: String): String;
    procedure SendText(S: String);
    procedure SetActive(const Value: Boolean); override;
  public
    procedure Clear;
    procedure OnOff(MigCursor, StatCursor, OnOff: Boolean);
    procedure OnOffPodsvet(b: Boolean);
    procedure Write(S: String);
    procedure WriteXY(i, j: Cardinal; S: String);
    property XY: TEkran read FXY write SetXY;
    property ExchGood: Boolean read FExchGood;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('My', [TIndicator]);
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

{ TIndicator }

procedure TIndicator.Clear;
begin
  SendText('T');
  Sleep(5);
end;

procedure TIndicator.Communicate;
begin
Exit;
end;

function TIndicator.CP866(S: String): String;
var i: Integer;
begin
    SetLength(Result, Length(S));
    for i := 1 to Length(S) do
       Result[i] := Chr(T[Ord(S[i])]);
end;

procedure TIndicator.OnOff(MigCursor, StatCursor, OnOff: Boolean);
var i: Integer;
begin
  i := 0;
  i := i + 1 * Integer(MigCursor);
  i := i + 2 * Integer(StatCursor);
  i := i + 4 * Integer(OnOff);
  SendText('S' + IntToHex(i, 1));
end;

procedure TIndicator.OnOffPodsvet;
begin
  Send('$01'+ CP866('I' + IntToStr(Integer(b))) + #13);
end;

procedure TIndicator.PortConfig;
begin
  inherited;
  dcb.BaudRate := 115200;       //Скорость обмена данными (бод/сек.)  Параметр № 118
  dcb.ByteSize := 8;          //Длина слова (бит)                   Параметр № 119  dcb.StopBits := ONESTOPBIT; //Кол-во стоповых бит                 Параметр № 119  dcb.Parity   := NOPARITY;  //Контроль чётности                   Параметр № 120end;

procedure TIndicator.SendText(S: String);
var Temp: String;
begin
  if not Active then Exit;
  Send('$01' + S + #13);
  Temp := ReceiveAnswer(5);
  FExchGood := (Temp = '!01' + #$D);
end;

procedure TIndicator.SetActive(const Value: Boolean);
begin
  inherited;
  if Value then
  begin
    OnOff(False, False, True);
    OnOffPodsvet(False); //Включить подсвет
    Clear;               //Очистить индикатор
  end;
end;

procedure TIndicator.SetXY(const Value: TEkran);
begin
  FXY := Value;
  SendText('T' + '000' + CP866(Value[1]));
  SendText('T' + '100' + CP866(Value[2]));
  SendText('T' + '200' + CP866(Value[3]));
  SendText('T' + '300' + CP866(Value[4]));
end;

procedure TIndicator.Write(S: String);
begin
  Clear;
  SendText('T000' + CP866(S));
end;

procedure TIndicator.WriteXY(i, j: Cardinal; S: String);
var Temp: String;
begin
  Temp := IntToStr(j - 1);
  Temp := StringOfChar('0', 2 - Length(Temp)) + Temp;
  if (i > 4) or (j > 20) then Exit;
  SendText('T' + IntToStr(i - 1) + Temp + CP866(S));
end;

end.
