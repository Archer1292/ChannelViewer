unit BufferedImageForChannelViewer;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type TPaintRequest = procedure(Sender: TGraphicControl) of object;
type
  TTimerImage = class(TGraphicControl)
  private
    Timer: Integer;
    FTimerEnabled: Boolean;
    FTimerInterval: Cardinal;
    FOnBufferPaint: TPaintRequest;
    procedure SetTimerEnabled(const Value: Boolean);
    procedure SetTimerInterval(const Value: Cardinal);
  protected
    procedure Paint; override;
  public
    Buffer: TBitmap;
    destructor Destroy; override;
    constructor Create(AOwner: TComponent); override;

//  ладЄм наружу
//-------------------------------------
    procedure DoBufferRepaint;
    procedure ResizeGraphBuffer;
  published
    property TimerEnabled: Boolean read FTimerEnabled write SetTimerEnabled;
    property TimerInterval: Cardinal read FTimerInterval write SetTimerInterval;
    property OnBufferPaint: TPaintRequest read FOnBufferPaint write FOnBufferPaint;
  end;

//---------------------------------------------------
type TBox = record
   Left, Right, Up, Down: Extended;
end;

type TGraphPad = class
  private
    FBox: TBox;
    PictWidth : Cardinal;
    PictHeight : Cardinal;
    function GetPosX(X: Extended): Integer;
    function GetPosY(Y: Extended): Integer;
    function GetScaleOX: Extended;
    function GetScaleOY: Extended;
  protected
    Destination : TCanvas;
  public
    constructor Create;
    procedure   SetSquare(U, D, L, R: Extended);
    function    PosToX(X: Integer): Extended;
    function    PosToY(Y: Integer): Extended;

    property ScaleOX: Extended read GetScaleOX;
    property ScaleOY: Extended read GetScaleOY;
    property Box: TBox read FBox;
end;

type TGraph = class(TGraphPad)
  private
    OldX, OldY: Integer;
    procedure SetMarker(x,y: Integer);
  public
    Last, First: Cardinal;
    LineColor: TColor;
    OXname, OYname: String;
    OXaccuracy, OYaccuracy: Cardinal;
    XChannel, YChannel: Cardinal;
    procedure Plot(Start, Stop: Cardinal);
    procedure RecreateGraphic;
    procedure Continue;
end;

//---------------------------------------------------------------------------
type
  TGraphScreen = class(TTimerImage)
  private
    Graph: TGraph;

    FFont: TFont;
    FCapFont: TFont;
    FStartColor: TColor;
    FLineColor: TColor;
    FEndColor: TColor;
    FBlackAndWhite: Boolean;
    FYChannel: Cardinal;
    FXChannel: Cardinal;
    procedure SetFont(const Value: TFont);
    procedure SetCapFont(const Value: TFont);
    procedure SetBlackAndWhite(const Value: Boolean);
    procedure SetXChannel(const Value: Cardinal);
    procedure SetYChannel(const Value: Cardinal);
    procedure SetLineColor(const Value: TColor);
    function GetLineColor: TColor;
    { Private declarations }
  protected
    function  GetCoordinateBox: TGraph;
    procedure SetBox(const Value: TBox);
    function  GetBox: TBox;
    procedure WriteCoordinats(Dest: TCanvas);
    procedure MakeFon(Dest: TCanvas);
    procedure LineAcels(Dest: TCanvas);
  public
   constructor Create(AOwner: TComponent); override;
   destructor Destroy; override;

   procedure ResizeBuffers;
   property CoordinateBox: TGraph read GetCoordinateBox;
   property Box: TBox read GetBox write SetBox;

    procedure RecreateGraphic;
    procedure RecreateGraphicToPrinter;
    procedure Continue;
    procedure Clear;
    procedure ClearAll;
  published
    property StartColor: TColor read FStartColor write FStartColor;
    property EndColor: TColor read FEndColor write FEndColor;
    property Font: TFont read FFont write SetFont;
    property CapFont: TFont read FCapFont write SetCapFont;
    property BlackAndWhite: Boolean read FBlackAndWhite write SetBlackAndWhite;
    property LineColor: TColor read GetLineColor write SetLineColor;
    property OnMouseDown;
    property XChannel: Cardinal read FXChannel write SetXChannel;
    property YChannel: Cardinal read FYChannel write SetYChannel;
  end;

type TBufferedImageForChannelViewer = class(TGraphScreen) end;

implementation
uses Math, Printers, CommonTypes, DataThread;


//procedure CopyBitmap(Destination: TCanvas; Source: TBitmap);
//var hdcDest, hdcSrc: HDC;
//    OK: Boolean;
//begin
//  hdcDest := Destination.Handle;
//  hdcSrc  := Source.Handle;
//
//  OK := BitBlt(hdcDest, 0, 0, Source.Width, Source.Height, hdcSrc, 0, 0, SRCCOPY);
//  if not OK then ShowMessage('Error ' + IntToStr(OK));
//end;


{ TGraphSheetPad }

constructor TGraphPad.Create;
begin
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
    ShowMessage('¬ы неверно задали параметры координатного квадрата: верх должен быть больше чем низ.');
    Exit;
  end;

  if R <= L then
  begin
    ShowMessage('¬ы неверно задали параметры координатного квадрата: лева€ сторона должна быть меньше правой.');
    Exit;
  end;

  FBox.Left := L; FBox.Right := R; FBox.Up := U; FBox.Down := D;
end;


{ TGraph }

procedure TGraph.RecreateGraphic;
var x,y: Extended;
begin
  //First := 0;
  x := DataBuffer[First][XChannel];
  y := DataBuffer[First][YChannel];
  SetMarker(GetPosX(x), GetPosY(y));
  Destination.MoveTo(GetPosX(x), GetPosY(y));
  Plot(First, Pos - 1);
end;

procedure TGraph.Plot(Start, Stop: Cardinal);
var i: Cardinal;
    x, y: Extended;
begin
  if (Pos = 0)   then Exit;
  if (Stop = -1) then Exit;
  if (Start = Pos) then Exit;
  i := Start;
  SetMarker(OldX, OldY);
  Destination.Pen.Style := psSolid;
  Destination.Pen.Mode  := pmCopy;
  Destination.Pen.Color := LineColor;
  x := DataBuffer[i][XChannel];
  y := DataBuffer[i][YChannel];
  while (i <> Stop) do
  begin
     x := DataBuffer[i][XChannel];
     y := DataBuffer[i][YChannel];
     Destination.LineTo(GetPosX(x), GetPosY(y));
     i := (i + 1) mod DataBufferLength;
  end;
  Last := Stop;
  SetMarker(GetPosX(x), GetPosY(y));
end;

procedure TGraph.SetMarker(x,y: Integer);
var Color: TColor;
    CrossDimension: Integer;
begin
  with Destination do
  begin
    Color := Pen.Color;
    Pen.Style := psSolid;
    Pen.Mode := pmNotXor;
    Pen.Color := clBlack;
    Pen.Width := 2;
    CrossDimension := TextWidth('o');

    MoveTo(x - CrossDimension, y - CrossDimension); LineTo(x + CrossDimension, y + CrossDimension);
    MoveTo(x - CrossDimension, y + CrossDimension); LineTo(x + CrossDimension, y - CrossDimension);
    MoveTo(x, y);
    Pen.Mode := pmCopy;
    Pen.Color := Color;
    Pen.Width := 1;
  end;
  OldX := x; OldY := y;
end;

procedure TGraph.Continue;
begin
  Plot(Last, Pos);
end;

{ TGraphScreen }

procedure TGraphScreen.Clear;
begin
  MakeFon(Buffer.Canvas);
  LineAcels(Buffer.Canvas); WriteCoordinats(Buffer.Canvas);
  //Pos := 0;
  CoordinateBox.First := Pos;
  //CoordinateBox.Last  := Pos - 1;
  CoordinateBox.SetMarker(CoordinateBox.GetPosX(DataBuffer[CoordinateBox.Last][XChannel]), CoordinateBox.GetPosY(DataBuffer[CoordinateBox.Last][YChannel]));
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

  Pos := 0;
  FXChannel := 0;
  FYChannel := 1;

  Graph := TGraph.Create;
  Graph.LineColor := clRed;
  Graph.Last := 0;
  Graph.First := 0;
  Graph.OXaccuracy := 3;
  Graph.OYaccuracy := 3;
  Graph.OXname := 'X';
  Graph.OYname := 'Y';
  Graph.SetSquare(1, -1, -1, 1);
  Graph.Destination := Buffer.Canvas;
end;

destructor TGraphScreen.Destroy;
var i: Integer;
begin
  FFont.Free;
  FCapFont.Free;
  Graph.Free;
  inherited;
end;

procedure TGraphScreen.RecreateGraphic;
begin
  MakeFon(Buffer.Canvas);
  LineAcels(Buffer.Canvas); WriteCoordinats(Buffer.Canvas);
  CoordinateBox.RecreateGraphic;
end;

procedure TGraphScreen.SetBlackAndWhite(const Value: Boolean);
begin
  if Value then CoordinateBox.LineColor := clBlack else CoordinateBox.LineColor := FLineColor;
  FBlackAndWhite := Value;
  MakeFon(Buffer.Canvas);
  LineAcels(Buffer.Canvas); WriteCoordinats(Buffer.Canvas);
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

procedure TGraphScreen.RecreateGraphicToPrinter;
//var OldCursorPosition: TPoint;
begin
try
       Printer.Orientation := poLandscape;
       Printer.BeginDoc;
         //OldCursorPosition := CoordinateBox.Destination.PenPos;
         CoordinateBox.Destination := Printer.Canvas;
         CoordinateBox.PictWidth   := Printer.PageWidth;
         CoordinateBox.PictHeight  := Printer.PageHeight;
         LineAcels(Printer.Canvas);
         WriteCoordinats(Printer.Canvas);
         Printer.Canvas.Pen.Width  := 3;
         CoordinateBox.RecreateGraphic;
         Printer.Canvas.Pen.Width  := 1;
         CoordinateBox.PictWidth   := Width;
         CoordinateBox.PictHeight  := Height;
         CoordinateBox.Destination := Buffer.Canvas;
         //CoordinateBox.Destination.PenPos := OldCursorPosition;
       Printer.EndDoc;
except end;
end;

procedure TGraphScreen.ClearAll;
var i: Integer;
begin
  Clear;
  Graph.First := Pos - 1;
end;

procedure TGraphScreen.SetXChannel(const Value: Cardinal);
begin
  FXChannel := Value;
  if Graph <> nil then
     Graph.XChannel := Value;
end;

procedure TGraphScreen.SetYChannel(const Value: Cardinal);
begin
  FYChannel := Value;
  if Graph <> nil then
     Graph.YChannel := Value;
end;

procedure TGraphScreen.SetLineColor(const Value: TColor);
begin
  Graph.LineColor := Value;
  FLineColor      := Value;
end;

function TGraphScreen.GetLineColor: TColor;
begin
    Result := Graph.LineColor;
end;

{ TGraphScreen }
function TGraphScreen.GetBox: TBox;
begin
  Result := CoordinateBox.Box;
end;

function TGraphScreen.GetCoordinateBox: TGraph;
begin
  Result := Graph;
end;

procedure TGraphScreen.LineAcels(Dest: TCanvas);
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
      MoveTo(CoordinateBox.GetPosX(StartX + i * StepX), 0);  LineTo(CoordinateBox.GetPosX(StartX + i * StepX),  (*Buffer.Height*)CoordinateBox.PictHeight);
      Pen.Color := clBlack;
      TextOut(CoordinateBox.GetPosX(StartX + i * StepX), (*Buffer.Height*)CoordinateBox.PictHeight - TextHeight('T') - 1, ExtToStr(StartX + i * StepX, CoordinateBox.OXaccuracy));
      end;
    for i := 1 to Ceil(BreitY / StepY) do
      begin
      Pen.Color := clGray;
      MoveTo(0, CoordinateBox.GetPosY(StartY + i * StepY)); LineTo((*Buffer.Width*)CoordinateBox.PictWidth, CoordinateBox.GetPosY(StartY + i * StepY));
      Pen.Color := clBlack;
      TextOut(3, CoordinateBox.GetPosY(StartY + i * StepY), ExtToStr(StartY + i * StepY, CoordinateBox.OYaccuracy));
      end;

//Ќарисовать координатные оси
    Pen.Color := clBlack;
    Pen.Style := psSolid;
    MoveTo(0, CoordinateBox.GetPosY(0)); LineTo((*Buffer.Width*)CoordinateBox.PictWidth, CoordinateBox.GetPosY(0));
    MoveTo(CoordinateBox.GetPosX(0), 0); LineTo(CoordinateBox.GetPosX(0), (*Buffer.Height*)CoordinateBox.PictHeight);
  end;
end;

procedure TGraphScreen.MakeFon(Dest: TCanvas);
var i, R0, G0, B0, R1, G1, B1, R, G, B, w: Integer;
begin
        //Windows.GradientFill(Buffer.Canvas.Handle, );

  B0 := ($00FF0000 and FStartColor) Shr 16;
  G0 := ($0000FF00 and FStartColor) Shr 8;
  R0 := ($000000FF and FStartColor) Shr 0;
  B1 := ($00FF0000 and FEndColor)   Shr 16;
  G1 := ($0000FF00 and FEndColor)   Shr 8;
  R1 := ($000000FF and FEndColor)   Shr 0;
  w  := Buffer.Height + 1;

  with Dest do
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
      LineTo(Buffer.Width, i);
    end;
  end;
end;

procedure TGraphScreen.ResizeBuffers;
var i: Integer;
begin
  Buffer.Width := Width;
  Buffer.Height := Height;

  Graph.PictWidth := Width;
  Graph.PictHeight := Height;

  MakeFon(Buffer.Canvas);
  LineAcels(Buffer.Canvas); WriteCoordinats(Buffer.Canvas);
  CoordinateBox.RecreateGraphic;
end;

procedure TGraphScreen.SetBox(const Value: TBox);
begin
  if (CoordinateBox.FBox.Left = Value.Left) and
     (CoordinateBox.FBox.Right = Value.Right) and
     (CoordinateBox.FBox.Up = Value.Up) and
     (CoordinateBox.FBox.Down = Value.Down) then Exit;
  CoordinateBox.SetSquare(Value.Up, Value.Down, Value.Left, Value.Right);
  MakeFon(Buffer.Canvas);
  LineAcels(Buffer.Canvas); WriteCoordinats(Buffer.Canvas);
  CoordinateBox.RecreateGraphic;
end;

procedure TGraphScreen.WriteCoordinats(Dest: TCanvas);
begin
  with Dest do
  begin
    Brush.Style := bsClear;
    Pen.Color := clBlack;
    Dest.Font.Assign(FCapFont);

    TextOut(TextWidth('00000'), 5, CoordinateBox.OYname);
    TextOut(CoordinateBox.PictWidth (*Buffer.Width*) - TextWidth(CoordinateBox.OXname)- 15,
            CoordinateBox.PictHeight(*Buffer.Height*) - 20 - TextHeight(CoordinateBox.OXname),
            CoordinateBox.OXname);
  end;
end;


//---------------------------------------------------




//----------------------------------------------------------------------

procedure TimerProc(hwnd: HWND;	uMsg: Cardinal; idEvent: Cardinal; dwTime: Cardinal); stdcall;
begin
  try
    TTimerImage(idEvent).DoBufferRepaint;
    TTimerImage(idEvent).Paint;
    //SendMessage(hwnd, WM_PAINT, 0, 0);
  except end;
end;

constructor TTimerImage.Create(AOwner: TComponent);
begin
  inherited;
  FTimerInterval := 330;
  Buffer := TBitmap.Create;
end;

destructor TTimerImage.Destroy;
begin
  Buffer.Free;
  inherited;
end;

procedure TTimerImage.DoBufferRepaint;
begin
  if Assigned(FOnBufferPaint) then
  try
    FOnBufferPaint(Self);
  except end;
end;

procedure TTimerImage.Paint;
begin
  //if Canvas.LockCount = 0 then
  begin
        Canvas.Lock;

        ResizeGraphBuffer;

        Canvas.Draw(0, 0, Buffer);
        Canvas.Unlock;
  end;
end;

procedure TTimerImage.ResizeGraphBuffer;
begin
   if (Width <> Buffer.Width) or (Height <> Buffer.Height) then
   begin
      Buffer.Width := Width;
      Buffer.Height := Height;
      DoBufferRepaint;
   end;
end;

procedure TTimerImage.SetTimerEnabled(const Value: Boolean);
begin
  FTimerEnabled := Value;
  if (Parent = nil) then Exit;
  if (Value) then
  begin
     Timer := SetTimer(Parent.Handle, Cardinal(Self), FTimerInterval, @TimerProc);
     FTimerEnabled := not (Timer = 0);
  end else
     KillTimer(Parent.Handle, Timer);
end;

procedure TTimerImage.SetTimerInterval(const Value: Cardinal);
begin
  if FTimerInterval = Value then Exit;
  FTimerInterval := Value;
  if (csDesigning in ComponentState) then Exit;
  if (not FTimerEnabled) then Exit;
  if (Parent = nil) then Exit;
  KillTimer(Parent.Handle, Timer);
  SetTimerEnabled(True);
end;

end.
