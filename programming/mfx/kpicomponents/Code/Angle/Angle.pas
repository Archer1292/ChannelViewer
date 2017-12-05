unit Angle;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, PortProcess;

type
  TAngle = class(TComPortController)
  private
    FExchGood: Boolean;
    FOldCiclePos, AOldSum: Integer;
    FPosition, FGrad, FMin, FSec: Integer;
    FAbsoluteGrad: Extended;
    FZero: Cardinal;
    FOldAbsAngle: Integer;
    FCycle: Integer;
    FPurePosition: Cardinal;
    function GetGMS: String;
  protected
    procedure Communicate; override;
    procedure PortConfig; override;
    procedure TimeoutConfig; override;
    procedure Loaded; override;
  public
    property  ExchGood: Boolean read FExchGood;
    procedure SetOrigin;
  published
    property Position: Integer read FPosition;
    property Grad: Integer read FGrad;
    property Min: Integer read FMin;
    property Sec: Integer read FSec;
    property AbsoluteGrad: Extended read FAbsoluteGrad;
    property GradMinSec: String read GetGMS;
  end;

procedure Register;

implementation
uses Math, CommonTypes;

procedure Register;
begin
  RegisterComponents('KPI', [TAngle]);
end;

{ TAngle }

procedure TAngle.Communicate;
var Buffer: array[1..3] of Char;
    Overlap: TOverlapped;
    OKBytesOut, Readed, t, d: Cardinal;
    S: Char;
    InSec, p: Extended;
const MaxCome = 65536;
begin
    FillChar(Overlap, SizeOf(Overlap), 0);
    S := #31;  //команда запроса данных
    WriteFile(hCom, S, 1, OKBytesOut, @Overlap); Sleep(3);
    ReadFile(hCom, Buffer[1], 3, Readed, @Overlap); //получили данные
    FExchGood := (Readed > 2) and (Buffer[1] = #31); //если всё нормально, присываются 3 байта
    if not FExchGood then Exit; //если обрыв связи, то выйти
    FPurePosition := Ord(Buffer[2]) * 256 + Ord(Buffer[3]);  //вычислили результат

    //вычислили результат с учётом смещённого начала координат
    FPosition := (FPurePosition - FZero - MaxCome div 2) mod MaxCome;
    if FPosition < 0 then FPosition := MaxCome + FPosition;
    FPosition := FPosition - MaxCome div 2;

    //намотали круги (поворот > 360 гр.)
    if (FPosition < (- MaxCome div 2) + (MaxCome div 8)) and (FOldAbsAngle > (MaxCome div 2) - (MaxCome div 8)) then Inc(FCycle);
    if (FOldAbsAngle < (- MaxCome div 2) + (MaxCome div 8)) and (FPosition > (MaxCome div 2) - (MaxCome div 8)) then Dec(FCycle);
    FOldAbsAngle := FPosition;
    FPosition := -(FPosition + FCycle * MaxCome);

    //убрать помехи: угол не может слишком быстро менятся
    if Abs(FOldCiclePos - FPosition) > 100 then begin FOldCiclePos := FPosition; Exit; end;
    FOldCiclePos := FPosition;

    //посчитать результаты
    FAbsoluteGrad := -FPosition * 360 / MaxCome;
    //перевод в градусы, минуты, секунды
    d := Abs(FPosition);
    InSec := d * (360 * 60 * 60 / 65536);
    t := Floor(InSec);
    FSec  := t mod 60;
    FMin  := (t div 60) mod 60;
    FGrad := (t div 3600);// mod 360;
end;

function TAngle.GetGMS: String;
begin
  Result := IntToStr(FGrad) + '°'+
            IntToStr(FMin) + '''' +
            InttoStr(FSec) + '''''';
  if FAbsoluteGrad < 0 then Result := '-' + Result;
end;

procedure TAngle.Loaded;
begin
  inherited;
  Communicate;
  SetOrigin;
end;

procedure TAngle.PortConfig;
begin
  inherited;
  dcb.BaudRate := 9600;      //Скорость обмена данными (бод/сек.)
  dcb.ByteSize := 8;         //Длина слова (бит)  dcb.StopBits := ONESTOPBIT;//Кол-во стоповых бит  dcb.Parity   := NOPARITY;  //Контроль чётностиend;

procedure TAngle.SetOrigin;
begin
    FZero  := FPurePosition;
    FCycle := 0;
end;

procedure TAngle.TimeoutConfig;
begin
  inherited;
  ct.ReadIntervalTimeout := 10;   //Таймаут между символами
  ct.ReadTotalTimeoutConstant := 5;
  ct.ReadTotalTimeoutMultiplier := 5;
  ct.WriteTotalTimeoutMultiplier := 1;
  ct.WriteTotalTimeoutConstant := 5;
end;

end.
 