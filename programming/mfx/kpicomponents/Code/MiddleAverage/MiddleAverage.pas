unit MiddleAverage;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TMiddleAverage = class(TComponent)
  private

    Sum:      array [0..15] of Extended;
    Summands: array [0..15] of array of Extended;
    Filled:   array [0..15] of Integer;

    function GetChannel0: Extended;
    function GetChannel1: Extended;
    function GetChannel10: Extended;
    function GetChannel11: Extended;
    function GetChannel12: Extended;
    function GetChannel13: Extended;
    function GetChannel14: Extended;
    function GetChannel15: Extended;
    function GetChannel2: Extended;
    function GetChannel3: Extended;
    function GetChannel4: Extended;
    function GetChannel5: Extended;
    function GetChannel6: Extended;
    function GetChannel7: Extended;
    function GetChannel8: Extended;
    function GetChannel9: Extended;
    function GetMaxN0: Integer;
    procedure SetMaxN0(const Value: Integer);
    function GetMaxN1: Integer;
    function GetMaxN10: Integer;
    function GetMaxN11: Integer;
    function GetMaxN12: Integer;
    function GetMaxN13: Integer;
    function GetMaxN14: Integer;
    function GetMaxN15: Integer;
    function GetMaxN2: Integer;
    function GetMaxN3: Integer;
    function GetMaxN4: Integer;
    function GetMaxN5: Integer;
    function GetMaxN6: Integer;
    function GetMaxN7: Integer;
    function GetMaxN8: Integer;
    function GetMaxN9: Integer;
    procedure SetMaxN1(const Value: Integer);
    procedure SetMaxN10(const Value: Integer);
    procedure SetMaxN11(const Value: Integer);
    procedure SetMaxN12(const Value: Integer);
    procedure SetMaxN13(const Value: Integer);
    procedure SetMaxN14(const Value: Integer);
    procedure SetMaxN15(const Value: Integer);
    procedure SetMaxN2(const Value: Integer);
    procedure SetMaxN3(const Value: Integer);
    procedure SetMaxN4(const Value: Integer);
    procedure SetMaxN5(const Value: Integer);
    procedure SetMaxN6(const Value: Integer);
    procedure SetMaxN7(const Value: Integer);
    procedure SetMaxN8(const Value: Integer);
    procedure SetMaxN9(const Value: Integer);
    { Private declarations }
  protected
    procedure Loaded; override;
  public
    property Channel0:  Extended read GetChannel0;
    property Channel1:  Extended read GetChannel1;
    property Channel2:  Extended read GetChannel2;
    property Channel3:  Extended read GetChannel3;
    property Channel4:  Extended read GetChannel4;
    property Channel5:  Extended read GetChannel5;
    property Channel6:  Extended read GetChannel6;
    property Channel7:  Extended read GetChannel7;
    property Channel8:  Extended read GetChannel8;
    property Channel9:  Extended read GetChannel9;
    property Channel10: Extended read GetChannel10;
    property Channel11: Extended read GetChannel11;
    property Channel12: Extended read GetChannel12;
    property Channel13: Extended read GetChannel13;
    property Channel14: Extended read GetChannel14;
    property Channel15: Extended read GetChannel15;

    procedure AddData(const Channel: Integer; const Value: Extended);
  published
    property MaxN0:  Integer read GetMaxN0  write SetMaxN0;
    property MaxN1:  Integer read GetMaxN1  write SetMaxN1;
    property MaxN2:  Integer read GetMaxN2  write SetMaxN2;
    property MaxN3:  Integer read GetMaxN3  write SetMaxN3;
    property MaxN4:  Integer read GetMaxN4  write SetMaxN4;
    property MaxN5:  Integer read GetMaxN5  write SetMaxN5;
    property MaxN6:  Integer read GetMaxN6  write SetMaxN6;
    property MaxN7:  Integer read GetMaxN7  write SetMaxN7;
    property MaxN8:  Integer read GetMaxN8  write SetMaxN8;
    property MaxN9:  Integer read GetMaxN9  write SetMaxN9;
    property MaxN10: Integer read GetMaxN10 write SetMaxN10;
    property MaxN11: Integer read GetMaxN11 write SetMaxN11;
    property MaxN12: Integer read GetMaxN12 write SetMaxN12;
    property MaxN13: Integer read GetMaxN13 write SetMaxN13;
    property MaxN14: Integer read GetMaxN14 write SetMaxN14;
    property MaxN15: Integer read GetMaxN15 write SetMaxN15;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('KPI', [TMiddleAverage]);
end;

{ TMiddleAverage }

procedure TMiddleAverage.AddData(const Channel: Integer;
  const Value: Extended);
begin

end;

function TMiddleAverage.GetChannel0: Extended;
begin

end;

function TMiddleAverage.GetChannel1: Extended;
begin

end;

function TMiddleAverage.GetChannel10: Extended;
begin

end;

function TMiddleAverage.GetChannel11: Extended;
begin

end;

function TMiddleAverage.GetChannel12: Extended;
begin

end;

function TMiddleAverage.GetChannel13: Extended;
begin

end;

function TMiddleAverage.GetChannel14: Extended;
begin

end;

function TMiddleAverage.GetChannel15: Extended;
begin

end;

function TMiddleAverage.GetChannel2: Extended;
begin

end;

function TMiddleAverage.GetChannel3: Extended;
begin

end;

function TMiddleAverage.GetChannel4: Extended;
begin

end;

function TMiddleAverage.GetChannel5: Extended;
begin

end;

function TMiddleAverage.GetChannel6: Extended;
begin

end;

function TMiddleAverage.GetChannel7: Extended;
begin

end;

function TMiddleAverage.GetChannel8: Extended;
begin

end;

function TMiddleAverage.GetChannel9: Extended;
begin

end;

function TMiddleAverage.GetMaxN0: Integer;
begin

end;

function TMiddleAverage.GetMaxN1: Integer;
begin

end;

function TMiddleAverage.GetMaxN10: Integer;
begin

end;

function TMiddleAverage.GetMaxN11: Integer;
begin

end;

function TMiddleAverage.GetMaxN12: Integer;
begin

end;

function TMiddleAverage.GetMaxN13: Integer;
begin

end;

function TMiddleAverage.GetMaxN14: Integer;
begin

end;

function TMiddleAverage.GetMaxN15: Integer;
begin

end;

function TMiddleAverage.GetMaxN2: Integer;
begin

end;

function TMiddleAverage.GetMaxN3: Integer;
begin

end;

function TMiddleAverage.GetMaxN4: Integer;
begin

end;

function TMiddleAverage.GetMaxN5: Integer;
begin

end;

function TMiddleAverage.GetMaxN6: Integer;
begin

end;

function TMiddleAverage.GetMaxN7: Integer;
begin

end;

function TMiddleAverage.GetMaxN8: Integer;
begin

end;

function TMiddleAverage.GetMaxN9: Integer;
begin

end;

procedure TMiddleAverage.Loaded;
var i: Integer;
begin
  inherited;

  for i := 0 to 15 do Filled[i] := 0;

end;

procedure TMiddleAverage.SetMaxN0(const Value: Integer);
begin
   if Value > 1000000 then Exit;
   if Value < 0       then Exit;

   SetLength(Summands[0], Value);
end;

procedure TMiddleAverage.SetMaxN1(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN10(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN11(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN12(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN13(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN14(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN15(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN2(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN3(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN4(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN5(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN6(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN7(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN8(const Value: Integer);
begin

end;

procedure TMiddleAverage.SetMaxN9(const Value: Integer);
begin

end;

end.
