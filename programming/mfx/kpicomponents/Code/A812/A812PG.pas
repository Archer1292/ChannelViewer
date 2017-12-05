unit A812PG;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CommonTypes;

type TGainCode = (Gain5vOr10v, Gain2_5vOr5v, Gain1_25vOr2_5v, Gain0_625vOr1_25v, Gain0_3125vOr0_625v);
     TJump10v  = (Jump5volt, Jump10volt);
const BufferSize1 = 3000;//1500;//5000;
      BufferSize2 = 2000;//5000;
      BufferSize3 = 2000;//2000;
      BufferSize4 = 2000;//2000;

      BaseAddress = $220;
      // VoltageFor0Kg: Extended = 1.74211425781250016;
      VoltageFor0Kg: Extended = 1.8137625931595869399507402687562; // 17 Nov 2006
      VoltageFor1000Kg: Extended = 2.631953125;
      // VoltageFor0Nm: Extended = 0.71635253906249996;
      VoltageFor0Nm: Extended = 0.73487366899480616238651564101877; // 17 Nov 2006
type
  TA812PG = class(TThreadHolder)
  private
    FIsWorking: Boolean;
    FGainCode: TGainCode;
    FJump10v: TJump10v;
    NagrOrigin: Single;
    CruchOrigin: Single;
    ElectroOrigin: Single;
    TokOrigin: Single;
    FPhysCruchOrigin: Single;
    FPhysNagrOrigin:  Single;


    Buf1: array[1..BufferSize1] of Single;
    Buf2: array[1..BufferSize2] of Single;
    Buf3: array[1..BufferSize3] of Single;
    Buf4: array[1..BufferSize4] of Single;
    FChannel0: Extended;
    FChannel1: Extended;
    FChannel2, FOldChannel2, AddChannel2: Extended;
    FChannel4: Extended;
    ElectroCycle: Integer;
    OldElectro: Extended;
    { Private declarations }
  protected
    procedure Proc; override;
    property NagrVolt: Extended read FChannel0;
    property KruchVolt: Extended read FChannel1;
    property ElectroVolt: Extended read FChannel2;
    property TokVolt: Extended read FChannel4;
    procedure Loaded; override;
  public
    property IsWorking: Boolean read FIsWorking;
    destructor Destroy; override;

  function NagrAbsoluteKg: Extended;
  function KruchAbsoluteKg: Extended;
  function KruchAbsoluteNewM: Extended;
  function ElectroAbsoluteVolt: Extended;

  procedure SetNagrOrigin;
  procedure SetCruchOrigin;
  //procedure SetPhysicalOrigin;
  procedure SetElectroOrigin;
  procedure SetTokOrigin;

  function NagrKg: Extended;
  function NagrNewton: Extended;
  function KruchKg: Extended;
  function KruchNewtonMetr: Extended;
  function Electro: Extended;
  function Tok: Extended;

  published
    property GainCode: TGainCode read FGainCode write FGainCode;
    property Jump10v: TJump10v read FJump10v write FJump10v;
  end;

procedure Register;

implementation
uses A812, registry;


procedure Register;
begin
  RegisterComponents('KPI', [TA812PG]);
end;

{ TA812PG }

destructor TA812PG.Destroy;
begin
  A812_DriverClose;
  inherited;
end;

function TA812PG.Electro: Extended;
var NewElectro: Extended;
begin
//   NewElectro := ElectroVolt;// - ElectroOrigin;

//   if ((10 - OldElectro < 0.1) and (NewElectro - 0 < 0.1))
//     then ElectroCycle := ElectroCycle + 1;
//   if ((OldElectro - 0 < 0.1) and (10 - NewElectro < 0.1))
//     then ElectroCycle := ElectroCycle - 1;

//   OldElectro := NewElectro;
//   Result := ElectroCycle * 10 + NewElectro;

   Result := ElectroVolt - ElectroOrigin;
end;

function TA812PG.ElectroAbsoluteVolt: Extended;
begin
    Result := ElectroVolt;
end;

function TA812PG.KruchAbsoluteKg: Extended;
begin
//  if FJump10v = Jump5volt
//  then  // y = -9.524484384665480x + 6.999292785042860
//    Result := -53.804 * (KruchVolt - FPhysCruchOrigin)
//  else
//    Result := (-53.804 / 2) * (KruchVolt - FPhysCruchOrigin);
  if FJump10v = Jump5volt
  then  // y = -9.524484384665480x + 6.999292785042860
    Result := -9.524484384665480 * KruchVolt * 2 + 6.999292785042860
  else
    Result := -9.524484384665480 * KruchVolt + 6.999292785042860;
end;

function TA812PG.KruchAbsoluteNewM: Extended;
begin
    //Result := KruchAbsoluteKg * 9.81 * 0.231;
    Result := KruchAbsoluteKg * 9.81;
end;

function TA812PG.KruchKg: Extended;
begin
//  if FJump10v = Jump5volt
//  then
//      Result := (5 / (0.704 - 0.607)) * (CruchOrigin - KruchVolt)
//  else
//      Result := (5 / (0.704 - 0.607)) * (CruchOrigin - KruchVolt) / 2;
  if FJump10v = Jump5volt
  then  //  y = -9.524484384665480x + 6.999292785042860
      Result := -9.524484384665480 * (Extended(KruchVolt) - CruchOrigin + VoltageFor0Nm) * 2 + 6.999292785042860
  else
      Result := -9.524484384665480 * (Extended(KruchVolt) - CruchOrigin + VoltageFor0Nm) + 6.999292785042860;
//  if FJump10v = Jump5volt
//  then     // y = 1109.18147700387x - 2011.79187201512
//    Result := -(1109.18147700387 * (Extended(NagrVolt) - NagrOrigin + VoltageFor0Kg) * 2 - 2011.79187201512)
//  else
//    Result := -(1109.18147700387 * (Extended(NagrVolt) - NagrOrigin + VoltageFor0Kg) - 2011.79187201512);
end;

function TA812PG.KruchNewtonMetr: Extended;
begin
   //Result := KruchKg * 9.81 * 0.231;
   Result := KruchKg * 9.81;
end;

procedure TA812PG.Loaded;
var Reg: TRegistry;
    A,B: Boolean;
begin
  inherited;
  FIsWorking := False;
  ElectroCycle := 0;
  OldElectro := 0;


  if csDesigning in ComponentState then Exit;

  if A812_DriverInit = A812_DriverOpenError then begin ShowMessage('В системе не найден блок A812PG. Либо плата не установлена вообще, либо не совпадает адрес области памяти: 0х220.'); Exit; end;
  if A812_Check_Address(BaseAddress) = A812_AdError1 then begin ShowMessage('Блок A812PG не отзывается на обращения по адресу 0х220'); Exit; end;

  FIsWorking := True;
  Proc; Proc; Proc; Proc;
  ElectroOrigin := 0;//   SetElectroOrigin;
  TokOrigin := 0;

  (*Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    A := Reg.KeyExists('\Software\Nadijnist');
    B := Reg.KeyExists('\Software\Nadijnist');

    Reg.OpenKey('\Software\Nadijnist\', True);

    if not A then Reg.WriteFloat('FPhysCruchOrigin', KruchVolt);
    FPhysCruchOrigin := Reg.ReadFloat('FPhysCruchOrigin');

    if not B then Reg.WriteFloat('FPhysNagrOrigin', NagrVolt);
    FPhysNagrOrigin := Reg.ReadFloat('FPhysNagrOrigin');
  finally
    Reg.CloseKey;
    Reg.Free;
  end;*)
  NagrOrigin  := VoltageFor0Kg;
  CruchOrigin := VoltageFor0Nm;
end;

function TA812PG.NagrAbsoluteKg: Extended;
begin
//  if FJump10v = Jump5volt
//  then
//    Result := -1096.9 * (NagrVolt - FPhysNagrOrigin)
//  else
//    Result := (-1096.9  / 2) * (NagrVolt - FPhysNagrOrigin);
  if FJump10v = Jump5volt
  then     // y = 1109.18147700387x - 2011.79187201512
    Result := -(1109.18147700387 * NagrVolt * 2 - 2011.79187201512)
  else
    Result := -(1109.18147700387 * NagrVolt - 2011.79187201512);
end;

function TA812PG.NagrKg: Extended;
var Coef, Kg0: Extended;
begin
//  Coef := -1001 / (VoltageFor1000Kg - NagrOrigin);
  //Kg0  := (-1000 * NagrOrigin) / (NagrOrigin - VoltageFor1000Kg);
//  Kg0 := -Coef * NagrOrigin;

(*  if FJump10v = Jump5volt
  then
      Result := 1096.9 * (-NagrVolt + NagrOrigin)
  else
      Result := 1096.9 * (-NagrVolt + NagrOrigin);*)
//  Result := Coef * NagrVolt  + Kg0;

  if FJump10v = Jump5volt
  then     // y = 1109.18147700387x - 2011.79187201512
    Result := -(1109.18147700387 * (Extended(NagrVolt) - NagrOrigin + VoltageFor0Kg) * 2 - 2011.79187201512)
  else
    Result := -(1109.18147700387 * (Extended(NagrVolt) - NagrOrigin + VoltageFor0Kg) - 2011.79187201512);
end;

function TA812PG.NagrNewton: Extended;
begin
  Result := NagrKg * 9.8;
end;

procedure TA812PG.Proc;
var i: LongInt;
    Sum: Extended;
function ChooseGainCode(Volt: Extended): WORD;
begin
Volt := abs(Volt);
case FJump10v of
  Jump5volt:  begin
if Volt > 0.3122 then Result := 3;
if Volt > 0.623  then Result := 2;
if Volt > 1.24   then Result := 1;
if Volt > 2.4    then Result := 0;
if Volt < 2.4    then Result := 1;
if Volt < 1.24   then Result := 2;
if Volt < 0.623  then Result := 3;
if Volt < 0.3122 then Result := 4;
           end;
  Jump10volt: begin
if Volt > 0.622 then Result := 3;
if Volt > 1.23  then Result := 2;
if Volt > 2.4   then Result := 1;
if Volt > 4     then Result := 0;
if Volt < 4     then Result := 1;
if Volt < 2.4   then Result := 2;
if Volt < 1.23  then Result := 3;
if Volt < 0.622 then Result := 4;
           end;
end;
  A812_Delay(BaseAddress, 8);
end;
var Ch0: Extended;
begin
  if not FIsWorking then Exit;

  //A812_ADs_Float(BaseAddress, 0, WORD(FGainCode), WORD(FJump10v), @Buf[1], BufferSize);
  //A812_ADs_Float(BaseAddress, 0, ChooseGainCode(FChannel0), WORD(FJump10v), @Buf[1], BufferSize);
  if (A812_ADs_Float(BaseAddress, 0, ChooseGainCode(FChannel0), WORD(FJump10v), @Buf1[1], BufferSize1) = A812_NoError) then
  begin
  Sum := 0;
  for i := 1 to BufferSize1
    do Sum := Sum + Buf1[i];
  FChannel0 := Sum / BufferSize1;
  end;

  //A812_ADs_Float(BaseAddress, 1, WORD(FGainCode), WORD(FJump10v), @Buf[1], BufferSize);
  if (A812_ADs_Float(BaseAddress, 1, ChooseGainCode(FChannel1), WORD(FJump10v), @Buf2[1], BufferSize2) = A812_NoError) then
  begin
  Sum := 0;
  for i := 1 to BufferSize2 do Sum := Sum + Buf2[i];
  FChannel1 := Sum / BufferSize2;
  end;

//  A812_ADs_Float(BaseAddress, 2, WORD(FGainCode), WORD(FJump10v), @Buf[1], BufferSize);
//  if (A812_ADs_Float(BaseAddress, 2, ChooseGainCode(FChannel2), WORD(FJump10v), @Buf3[1], BufferSize3) = A812_NoError) then
//  begin
//  Sum := 0;
//  for i := 1 to BufferSize3 do Sum := Sum + Buf3[i];
//  FChannel2 := Sum / BufferSize3;
//  end;

//  if FJump10v = Jump10v then
//  begin
//    // регистрируем перескок в следующий диапазон
//    if (abs(10 - FOldChannel2) < 0.5)
//        if (abs(0 - FChannel2) < 0.5)
//            AddChannel2 = AddChannel2 + 10;

    // регистрируем скачок в предідущий диапазон
//    if (abs(FOldChannel2 - 0) < 0.5)
//        if (abs(10 - FChannel2) < 0.5)
//            AddChannel2 = AddChannel2 - 10;

//    FOldChannel2 = FChannel2;
//  end;

  //A812_ADs_Float(BaseAddress, 3, WORD(FGainCode), WORD(FJump10v), @Buf[1], BufferSize);
  //if (A812_ADs_Float(BaseAddress, 4, ChooseGainCode(FChannel4), WORD(FJump10v), @Buf4[1], BufferSize4) = A812_NoError) then
  //begin
  //Sum := 0;
  //for i := 1 to BufferSize4 do Sum := Sum + Buf4[i];
  //FChannel4 := Sum / BufferSize4;
  //end;
end;

procedure TA812PG.SetCruchOrigin;
begin
  CruchOrigin := KruchVolt;
end;

procedure TA812PG.SetElectroOrigin;
begin
  ElectroOrigin := ElectroVolt;
end;

procedure TA812PG.SetNagrOrigin;
begin
   NagrOrigin := NagrVolt;
end;

(*procedure TA812PG.SetPhysicalOrigin;
var Reg: TRegistry;
begin
   FPhysCruchOrigin := KruchVolt;
   FPhysNagrOrigin  := NagrVolt;

  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_LOCAL_MACHINE;
    if Reg.OpenKey('\Software\Nadijnist\', True)
      then Reg.WriteFloat('FPhysCruchOrigin',FPhysCruchOrigin);
    if Reg.OpenKey('\Software\Nadijnist\', True)
      then Reg.WriteFloat('FPhysNagrOrigin',FPhysNagrOrigin);
  finally
    Reg.CloseKey;
    Reg.Free;
  end;
end;
  *)
procedure TA812PG.SetTokOrigin;
begin
   TokOrigin := TokVolt;
end;

function TA812PG.Tok: Extended;
begin
   Result := TokVolt - TokOrigin;
end;

end.














