unit GraphScreen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Engins;

type TBox = record
   Left, Right, Up, Down: Extended;
end;

type TGraphPad = class
  private
    FBox: TBox;
    PictWidth, PictHeight: Cardinal;
    function GetPosX(X: Extended): Integer;
    function GetPosY(Y: Extended): Integer;
    function GetScaleOX: Extended;
    function GetScaleOY: Extended;
  protected
    Destination:  TCanvas;
  public
    constructor Create(Sheet: TCanvas; PictureWidth, PictureHeight: Cardinal);
    procedure   SetSquare(U, D, L, R: Extended);
    function    PosToX(X: Integer): Extended;
    function    PosToY(Y: Integer): Extended;

    property ScaleOX: Extended read GetScaleOX;
    property ScaleOY: Extended read GetScaleOY;
    property Box: TBox read FBox;
end;

const GraphTypes = 15;
type TGraphType = (gtHorizMMmM, gtHorizMMAng, gtHorigMMUsilije, gtHorizMMCruchenije,
                   gtHorizMMElectro, gtMMAng, gtMMUsilije, gtMMCruchenije, gtMMElectro,
                   gtAngUsilije, gtAngCruchenije, gtAngElectro,
                   gtUsilijeCruchenije, gtUsilijeElectro, gtCruchenijeElectro);
const GraphTypeNames: array[0..GraphTypes-1] of array [0..1] of String =
      (('l,мм','d,мм'),('ф,°','d,мм'),('d,мм','Р,Н'),('d,мм','М,Н·м'),
      ('U,В','d,мм'),('ф,°','l,мм'),('l,мм','Р,Н'),
       ('l,мм','М,Н·м'),('l,мм','U,В'),('ф,°','Р,Н'),
       ('ф,°','М,Н·м'),('ф,°','U,В'),('М,Н·м','Р,Н'),('U,В','Р,Н'),('U,В','М,Н·м'));

type TGraph = class(TGraphPad)
  private
    OldX, OldY: Integer;
    procedure SetMarker(x,y: Integer);
    procedure GetData(n: Cardinal; var x,y: Extended);
  public
    Last, First: Cardinal;
    LineColor: TColor;
    Kind: TGraphType;
    OXname, OYname: String;
    OXaccuracy, OYaccuracy: Cardinal;
    procedure Plot(Start, Stop: Cardinal);
    procedure RecreateGraphic;
    procedure Continue;
end;
//---------------------------------------------------------------------------
//Left, Right, Down, Up
const GraphCoordinates: array [0..GraphTypes-1] of array[0..3] of Extended =
   ((0,1,0,0.5),(0,180,0,0.5),(0,0.5,0,10000),(0,0.5,0,15),(0,1,0,0.5),(0,180,0,1),
    (0,1,0,10000), (0,1,0,15),(0,1,0,1),(0,180,0,10000),(-90,180,-20,15),(0,180,0,1),(0,15,0,10000),
    (0,1,0,10000),(0,1,0,15));
type
  TGraphScreen = class(TImage)
  private
   Fon: TBitmap;
   Graphs: array[0..GraphTypes - 1] of TGraph;

    FFont: TFont;
    FCapFont: TFont;
    FStartColor: TColor;
    FEndColor: TColor;
    FBlackAndWhite: Boolean;
    FLineColor: TColor;
    procedure SetFont(const Value: TFont);
    procedure SetCapFont(const Value: TFont);
    procedure SetBlackAndWhite(const Value: Boolean);
    procedure SetKind(const Value: TGraphType);
    { Private declarations }
  protected
    CurrentKind: TGraphType;
    function GetCoordinateBox: TGraph;
    procedure SetBox(const Value: TBox);
    function GetBox: TBox;
    procedure WriteCoordinats(Dest: TCanvas);
    procedure MakeFon;
    procedure LineAcels(Dest: TCanvas);
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   procedure ResizeBuffers;
   procedure Loaded; override;
   property CoordinateBox: TGraph read GetCoordinateBox;
   property Box: TBox read GetBox write SetBox;

    procedure RecreateGraphic;
    procedure RecreateGraphicToPrinter;
    procedure Continue;
    procedure Clear;
    procedure ClearAll;
    property Kind: TGraphType read CurrentKind write SetKind;
  published
    property StartColor: TColor read FStartColor write FStartColor;
    property EndColor: TColor read FEndColor write FEndColor;
    property Font: TFont read FFont write SetFont;
    property CapFont: TFont read FCapFont write SetCapFont;
    property BlackAndWhite: Boolean read FBlackAndWhite write SetBlackAndWhite;
    property LineColor: TColor read FLineColor write FLineColor;
  end;

procedure Register;

implementation
uses Math, CommonTypes, Printers;

procedure Register;
begin
  RegisterComponents('My', [TGraphScreen]);
end;


{ TGraphSheetPad }

constructor TGraphPad.Create(Sheet: TCanvas; PictureWidth, PictureHeight: Cardinal);
begin
  Destination := Sheet;
  PictWidth := PictureWidth; PictHeight := PictureHeight;
  FBox.Left := -1; FBox.Right := 1; FBox.Up := 1; FBox.Down := -1;
end;

function TGraphPad.GetPosX(X: Extended): Integer;
begin
  Result := Floor((X - FBox.Left) * ScaleOX);
end;

function TGraphPad.GetPosY(Y: Extended): Integer;
begin
  Result := Floor(PictHeight - (Y - FBox.Down) * ScaleOY);
end;

function TGraphPad.GetScaleOX: Extended;
begin
  Result := PictWidth / (FBox.Right - FBox.Left);
end;

function TGraphPad.GetScaleOY: Extended;
begin
  Result := PictHeight / (FBox.Up - FBox.Down);
end;

function TGraphPad.PosToX(X: Integer): Extended;
begin
  Result := FBox.Left + X / ScaleOX;
end;

function TGraphPad.PosToY(Y: Integer): Extended;
begin
  Result := (-Y + PictHeight) / ScaleOY + FBox.Down;
end;

procedure TGraphPad.SetSquare(U, D, L, R: Extended);
begin
  if U <= D then
  begin
    ShowMessage('Вы неверно задали параметры координатного квадрата: верх должен быть больше чем низ.');
    Exit;
  end;

  if R <= L then
  begin
    ShowMessage('Вы неверно задали параметры координатного квадрата: левая сторона должна быть меньше правой.');
    Exit;
  end;

  FBox.Left := L; FBox.Right := R; FBox.Up := U; FBox.Down := D;
end;


{ TGraph }

procedure TGraph.RecreateGraphic;
var x,y: Extended;
begin
  GetData(First, x,y);
  SetMarker(GetPosX(x), GetPosY(y));
  Destination.MoveTo(GetPosX(x), GetPosY(y));
  Plot(First, Pos - 1);
end;

procedure TGraph.GetData(n: Cardinal; var x,y: Extended);
begin
    with DataBuffer[n] do
    case Kind of
      gtHorizMMmM:         begin x := MM;    y := HorizMM; end;
      gtHorizMMAng:        begin x := Ang;    y := HorizMM; end;
      gtHorigMMUsilije:    begin x := HorizMM;    y := Usilije * 9.8; end;
      gtHorizMMCruchenije: begin x := HorizMM;    y := Cruchenije; end;
      gtHorizMMElectro:    begin x := Electro;    y := HorizMM; end;
      gtMMAng:             begin x := Ang;         y := MM;  end;
      gtMMUsilije:         begin x := MM;         y := Usilije * 9.8; end;
      gtMMCruchenije:      begin x := MM;         y := Cruchenije; end;
      gtMMElectro:         begin x := MM;         y := Electro; end;
      gtAngUsilije:        begin x := Ang;        y := Usilije * 9.8; end;
      gtAngCruchenije:     begin x := Ang;        y := Cruchenije; end;
      gtAngElectro:        begin x := Ang;        y := Electro; end;
      gtUsilijeCruchenije: begin x := Cruchenije;    y := Usilije * 9.8;  end;
      gtUsilijeElectro:    begin x := Electro;    y := Usilije * 9.8;  end;
      gtCruchenijeElectro: begin x := Electro; y := Cruchenije;  end;
    end;
end;

procedure TGraph.Plot(Start, Stop: Cardinal);
var i: Cardinal;
    x, y: Extended;
begin

  if (Pos = 0) or (Stop < Start) then Exit;

  i := Start;
  SetMarker(OldX, OldY);
  Destination.Pen.Style := psSolid;
  Destination.Pen.Mode  := pmCopy;
  Destination.Pen.Color := LineColor;
  GetData(i, x, y);
  while (i <> Stop) do
  begin
     GetData(i, x, y);
     Destination.LineTo(GetPosX(x), GetPosY(y));
     i := (i + 1) mod DataBufferLenght;
  end;
  Last := Stop + 1;
  SetMarker(GetPosX(x), GetPosY(y));
end;

procedure TGraph.SetMarker(x,y: Integer);
begin
  with Destination do
  begin
    Pen.Style := psSolid;
    Pen.Mode := pmNotXor;
    Pen.Color := clBlack;

    MoveTo(x - 5, y - 5); LineTo(x + 5, y + 5);
    MoveTo(x - 5, y + 5); LineTo(x + 5, y - 5);
    MoveTo(x, y);
    Pen.Mode := pmCopy;
  end;
  OldX := x; OldY := y;
end;

procedure TGraph.Continue;
begin
  Plot(Last, Pos - 1);
end;

{ TGraphScreen }

procedure TGraphScreen.Clear;
var x,y: Extended;
begin
  Picture.Bitmap.Assign(Fon);
  LineAcels(Canvas); WriteCoordinats(Canvas);
  //Pos := 0;
  CoordinateBox.First := Pos - 1;
  CoordinateBox.GetData(CoordinateBox.Last, x, y);
  CoordinateBox.SetMarker(CoordinateBox.GetPosX(x), CoordinateBox.GetPosY(y));
end;

procedure TGraphScreen.Continue;
begin
  CoordinateBox.Continue;
end;

constructor TGraphScreen.Create(AOwner: TComponent);
begin
  inherited;
  FFont := TFont.Create;
  FCapFont := TFont.Create;
  if (csDesigning in ComponentState) then Exit;
  Picture.Graphic := TBitmap.Create;
  Fon := TBitmap.Create;
end;

destructor TGraphScreen.Destroy;
var i: Integer;
begin
  FFont.Free;
  FCapFont.Free;
  if csDesigning in ComponentState then begin inherited; Exit; end;
  Fon.Free;
  for i := 0 to GraphTypes - 1 do Graphs[i].Free;
  inherited;
end;

procedure TGraphScreen.Loaded;
var i: Integer;
begin
  inherited;
  if (csDesigning in ComponentState) then Exit;
  for i := 0 to GraphTypes - 1 do
  begin
    Graphs[i] := TGraph.Create(Canvas, Width, Height);
    Graphs[i].Kind := TGraphType(i);
    Graphs[i].LineColor := clRed;
    Graphs[i].Last := 0;
    Graphs[i].First := 0;
    Graphs[i].OXaccuracy := 3;
    Graphs[i].OYaccuracy := 3;
    Graphs[i].OXname := GraphTypeNames[i][0];
    Graphs[i].OYname := GraphTypeNames[i][1];
    Graphs[i].SetSquare(GraphCoordinates[i][3], GraphCoordinates[i][2],
              GraphCoordinates[i][0], GraphCoordinates[i][1]);
  end;
  ResizeBuffers;
end;

procedure TGraphScreen.RecreateGraphic;
begin
  if csLoading in ComponentState then Exit;
  if csDesigning in ComponentState then Exit;
  Picture.Bitmap.Assign(Fon);
  LineAcels(Canvas); WriteCoordinats(Canvas);
  CoordinateBox.RecreateGraphic;
end;

procedure TGraphScreen.SetBlackAndWhite(const Value: Boolean);
begin
  if (csDesigning in ComponentState) or (csLoading in ComponentState) then begin FBlackAndWhite := Value; Exit; end;
  if Value then CoordinateBox.LineColor := clBlack else CoordinateBox.LineColor := FLineColor;
  FBlackAndWhite := Value;
  MakeFon;
  Picture.Bitmap.Assign(Fon);
  LineAcels(Canvas); WriteCoordinats(Canvas);
  CoordinateBox.RecreateGraphic;
end;

procedure TGraphScreen.SetCapFont(const Value: TFont);
begin
   FCapFont.Assign(Value);
end;

procedure TGraphScreen.SetFont(const Value: TFont);
begin
   FFont.Assign(Value);
end;

procedure TGraphScreen.SetKind(const Value: TGraphType);
begin
   if CurrentKind = Value then Exit;
   CurrentKind := Value;
   if FBlackAndWhite then CoordinateBox.LineColor := clBlack else CoordinateBox.LineColor := FLineColor;
   RecreateGraphic;
end;

procedure TGraphScreen.RecreateGraphicToPrinter;
begin
try
       Printer.Orientation := poLandscape;
       Printer.BeginDoc;
         LineAcels(Printer.Canvas);
         WriteCoordinats(Printer.Canvas);
         CoordinateBox.Destination := Printer.Canvas;
         CoordinateBox.PictWidth := Printer.PageWidth;
         CoordinateBox.PictHeight := Printer.PageHeight;
         CoordinateBox.RecreateGraphic;
         CoordinateBox.PictWidth := Width;
         CoordinateBox.PictHeight := Height;
         CoordinateBox.Destination := Self.Canvas;
       Printer.EndDoc;
except end;
end;

procedure TGraphScreen.ClearAll;
var i: Integer;
begin
  Clear;
  for i := 0 to GraphTypes - 1 do Graphs[i].First := Pos - 1;
end;

{ TGraphScreen }
function TGraphScreen.GetBox: TBox;
begin
  Result := CoordinateBox.Box;
end;

function TGraphScreen.GetCoordinateBox: TGraph;
begin
  Result := Graphs[Integer(CurrentKind)];
end;

procedure TGraphScreen.LineAcels;
var StartX, StartY, StepX, StepY, BreitX, BreitY: Extended;
    i: Integer;
begin
  BreitX := Box.Right - Box.Left;
  BreitY := Box.Up    - Box.Down;

    i := Round(Log10((Box.Right - Box.Left) / 10));
    StepX := IntPower(10, i);
    CoordinateBox.OXaccuracy := max(0, -i);

    i := Round(Log10((Box.Up - Box.Down) / 10));
    StepY := IntPower(10, i) / 2;
    CoordinateBox.OYaccuracy := max(0, -i) + 1;

  StartX := Round(Box.Left / StepX); StartX := StartX * StepX;
  StartY := Round(Box.Down / StepY);   StartY := StartY * StepY;

  with Dest do
  begin
    Pen.Color := clBlack;
    Pen.Style := psDashDot;
    Pen.Mode  := pmCopy;
    Dest.Font.Assign(FFont);
    Brush.Style := bsClear;
    for i := 1 to Ceil(BreitX / StepX) do
      begin
      Pen.Color := clGray;
      MoveTo(CoordinateBox.GetPosX(StartX + i * StepX), 0);  LineTo(CoordinateBox.GetPosX(StartX + i * StepX),  Fon.Height);
      Pen.Color := clBlack;
      TextOut(CoordinateBox.GetPosX(StartX + i * StepX), Fon.Height - 17, ExtToStr(StartX + i * StepX, CoordinateBox.OXaccuracy));
      end;
    for i := 1 to Ceil(BreitY / StepY) do
      begin
      Pen.Color := clGray;
      MoveTo(0, CoordinateBox.GetPosY(StartY + i * StepY)); LineTo(Fon.Width, CoordinateBox.GetPosY(StartY + i * StepY));
      Pen.Color := clBlack;
      TextOut(3, CoordinateBox.GetPosY(StartY + i * StepY), ExtToStr(StartY + i * StepY, CoordinateBox.OYaccuracy));
      end;

//Нарисовать координатные оси
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    MoveTo(0, CoordinateBox.GetPosY(0)); LineTo(Fon.Width, CoordinateBox.GetPosY(0));
    MoveTo(CoordinateBox.GetPosX(0), 0); LineTo(CoordinateBox.GetPosX(0), Fon.Height);
  end;
end;

procedure TGraphScreen.MakeFon;
var i, R0, G0, B0, R1, G1, B1, R, G, B, w: Integer;
begin
  B0 := ($00FF0000 and FStartColor) Shr 16;
  G0 := ($0000FF00 and FStartColor) Shr 8;
  R0 := ($000000FF and FStartColor) Shr 0;
  B1 := ($00FF0000 and FEndColor)   Shr 16;
  G1 := ($0000FF00 and FEndColor)   Shr 8;
  R1 := ($000000FF and FEndColor)   Shr 0;
  w  := Fon.Height + 1;

  with Fon.Canvas do
  begin
    Pen.Style := psSolid;
    Pen.Mode := pmCopy;
    for i := 0 to w - 2 do
    begin
      R := Floor(R0 + (R1 - R0) * ( i / w));
      G := Floor(G0 + (G1 - G0) * ( i / w));
      B := Floor(B0 + (B1 - B0) * ( i / w));
      if FBlackAndWhite then Pen.Color := clWhite else Pen.Color := TColor(RGB(R, G, B));
      MoveTo(0, i);
      LineTo(Fon.Width, i);
    end;
  end;
end;

procedure TGraphScreen.ResizeBuffers;
begin
  Fon.Width := Width;
  Fon.Height := Height;

  MakeFon;
  Picture.Bitmap.Assign(Fon);
  LineAcels(Canvas); WriteCoordinats(Canvas);
  CoordinateBox.RecreateGraphic;
end;

procedure TGraphScreen.SetBox(const Value: TBox);
begin
  if (CoordinateBox.FBox.Left = Value.Left) and
     (CoordinateBox.FBox.Right = Value.Right) and
     (CoordinateBox.FBox.Up = Value.Up) and
     (CoordinateBox.FBox.Down = Value.Down) then Exit;
  CoordinateBox.SetSquare(Value.Up, Value.Down, Value.Left, Value.Right);
  Picture.Bitmap.Assign(Fon);
  LineAcels(Canvas); WriteCoordinats(Canvas);
  CoordinateBox.RecreateGraphic;
end;

procedure TGraphScreen.WriteCoordinats(Dest: TCanvas);
begin
  with Dest do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBlack;
    Canvas.Font.Assign(FCapFont);

    TextOut(50, 5, CoordinateBox.OYname);
    TextOut(Fon.Width - TextWidth(CoordinateBox.OXname)- 15,
            Fon.Height - 20 - TextHeight(CoordinateBox.OXname),
            CoordinateBox.OXname);
  end;
end;

end.
