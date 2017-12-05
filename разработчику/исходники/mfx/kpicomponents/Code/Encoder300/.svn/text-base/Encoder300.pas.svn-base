unit Encoder300;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, CommonTypes;
const Enc300Address = $240;

type
  TEncoder300 = class(TLinkHolder)
  private
    FIsWorking: Boolean;
    function GetX: Extended;
    function GetY: Extended;
    function GetZ: Extended;
  public
constructor Create(AOwner: TComponent); override;
destructor Destroy; override;

procedure Reset;

property X: Extended read GetX;
property Y: Extended read GetY;
property Z: Extended read GetZ;
property IsWorking: Boolean read FIsWorking;
end;

procedure Register;

implementation
uses Enc32;


procedure Register;
begin
  RegisterComponents('KPI', [TEncoder300]);
end;

{ TEncoder300 }

constructor TEncoder300.Create;
begin
  inherited;
  FIsWorking := False;
  if csDesigning in ComponentState then Exit;

    ENC3_INITIAL;
    ENC3_SELECT(Enc300Address);
    ENC3_INIT_CARD(ENC_X2 or ENC_QUADRANT, ENC_X2 or ENC_QUADRANT, ENC_X2 or ENC_QUADRANT);
    Reset;
  FIsWorking := True;
end;

destructor TEncoder300.Destroy;
begin
  ENC3_END;
  inherited;
end;

function TEncoder300.GetX: Extended;
begin
  if FIsWorking then Result := SmallInt(-ENC3_GET_ENCODER(X_axis))
  else Result := 0;
  Result := Result * 0.001;
end;

function TEncoder300.GetY: Extended;
begin
  if FIsWorking then Result := SmallInt(-ENC3_GET_ENCODER(Y_axis))
  else Result := 0;
  Result := Result * 0.001;
end;

function TEncoder300.GetZ: Extended;
begin
  if FIsWorking then Result := SmallInt(-ENC3_GET_ENCODER(Z_axis))
  else Result := 0;
  Result := Result * 0.001;
end;

procedure TEncoder300.Reset;
begin
   ENC3_RESET_ENCODER(X_axis);
   ENC3_RESET_ENCODER(Y_axis);
   ENC3_RESET_ENCODER(Z_axis);
end;

end.
