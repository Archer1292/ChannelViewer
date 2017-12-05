(*
   CoolHints2k v 1.0                                Registered!

   First of all, thank you for registering of the CoolHints2k
   package. We hope you will enjoy these components and you
   will find them useful.
   
   YOU MAY use the components and classes from this unit in any your
   (or your company's) FREEWARE/SHAREWARE or COMMERCIAL application.

   YOU MAY derive your own components based on components from
   this unit as you like, but ONLY with UNREGISTERED version
   of CoolHints2k and if someone else will decide to use it they
   will have to register CoolHints2k too.

   YOU MAY NOT DISTRIBUTE REGISTERED VERSION OF CoolHints2k.
   IT WILL BE VIOLATION OF INTERNATIONAL COPYRIGHT LAWS.

   Copyright (c) 2000 by Artem A. Berman (art@cooldev.com)
   Copyright (c) 2000 by CoolDev.Com

   COMPILING THE SHAREWARE vs REGISTERED versions
   ---------------------------------------------------------------------
   This code contains both the shareware and registered, and both
   Borland Delphi and Borland C++ Builder versions of the CoolHints2k.

   To compile the registered version please make sure the following line
   is included below:

    {$define Registered}

   All distributed source code versions should have this line by default.
   You don't have to remove anything manually to decrease application size.

                                                                         *)

{$Define Registered}

{$IFNDEF VER90}
  {$IFNDEF VER100}
    {$IFNDEF VER120}
      {$IFNDEF VER130}
          {$IFDEF VER110}
            {$ObjExportAll On}
            {$Define ver100}
          {$ELSE}
            {$IFDEF VER125}
              {$Define ver120}
            {$ELSE}
              {$Define ver90}
            {$ENDIF}
          {$ENDIF}
      {$ELSE}
        {$IFNDEF BCB}
          {$Define Delphi}
        {$ENDIF}
        {$Define ver120}
      {$ENDIF}
    {$ELSE}
      {$Define Delphi}
    {$ENDIF}
  {$ELSE}
    {$Define Delphi}
  {$ENDIF}
{$ELSE}
  {$Define Delphi}
{$ENDIF}

{$D-,L-,Y-}
unit CoolHints2K;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Graphics, Forms, ExtCtrls,
  Registry, StdCtrls;

type
  {TCHAboutBox}
  TCHAboutBox = class
  end;

  {TCoolHint2KForm}
  TCoolHint2KForm = class(TCustomForm)
  private
    FAbout: TCHAboutBox;
    FDragable: Boolean;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDblclk(var Message: TWMNCLButtonDblclk); message WM_NCLBUTTONDBLCLK;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateBalloonForm; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure Activate; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property About: TCHAboutBox read FAbout write FAbout;
    property Dragable: Boolean read FDragable write FDragable default True;
    property ActiveControl;
    property Font;
    property Color default $00DDFFFF;
    property Cursor;
    property KeyPreview;
    property PixelsPerInch;
    property Position;
    property PrintScale;
    property Scaled;
    property Visible;
    property OnActivate;
    property OnClose;
    property OnCloseQuery;
    {$IFDEF VER120}
    property OnConstrainedResize;
    {$ENDIF}
    {$IFDEF VER130}
    property OnContextPopup;
    {$ENDIF}
    property OnCreate;
    property OnDblClick;
    property OnDestroy;
    property OnDeactivate;
    {$IFDEF VER120}
    property OnDockDrop;
    property OnDockOver;
    {$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VER120}
    property OnEndDock;
    property OnGetSiteInfo;
    {$ENDIF}
    property OnHide;
    property OnHelp;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VER120}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    {$ENDIF}
    property OnPaint;
    property OnResize;
    {$IFDEF VER120}
    property OnShortCut;
    {$ENDIF}
    property OnShow;
    {$IFDEF VER120}
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

  {TCoolHint2KControl}
  TCoolHint2KControl = class(TCustomControl)
  private
    FAbout: TCHAboutBox;
    FDragable: Boolean;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure WMNCLButtonDblclk(var Message: TWMNCLButtonDblclk); message WM_NCLBUTTONDBLCLK;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
  protected
    procedure CreateBalloonForm; virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure CreateWnd; override;
    procedure Loaded; override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property About: TCHAboutBox read FAbout write FAbout;
    property Dragable: Boolean read FDragable write FDragable default True;
    property Font;
    property Color default $00DDFFFF;
    {$IFDEF VER120}
    property OnConstrainedResize;
    {$ENDIF}
    {$IFDEF VER130}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    {$IFDEF VER120}
    property OnDockDrop;
    property OnDockOver;
    {$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VER120}
    property OnEndDock;
    property OnGetSiteInfo;
    {$ENDIF}
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VER120}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

  TFocusState = (fsMouseCaptured, fsKeyboardCaptured, fsPressed);
  TFocusStates = set of TFocusState;

  {TCustom2KControl}
  TCustom2KControl = class(TCustomControl)
  private
    FAbout: TCHAboutBox;
    FFocusStates: TFocusStates;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property TabStop default True;
  published
    property About: TCHAboutBox read FAbout write FAbout;
  end;

  {TCoolHint2KButton}
  TCoolHint2KButton = class(TCustom2KControl)
  private
    FDefault: Boolean;
    FCancel: Boolean;
    FModalResult: TModalResult;
    procedure SetDefault(Value: Boolean);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMDialogKey(var Message: TCMDialogKey); message CM_DIALOGKEY;
  protected
    procedure Paint; override;
    procedure Click; override;
    procedure CreateWnd; override;
    procedure CreateBalloonButton; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Cancel: Boolean read FCancel write FCancel default False;
    property Default: Boolean read FDefault write SetDefault default False;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property Caption;
    property Color default $00DDFFFF;
    property Cursor;
    property Font;
    property ParentColor;
    property ParentFont;
    property TabOrder;
    property TabStop default True;
    property OnClick;
    {$IFDEF VER120}
    property OnConstrainedResize;
    {$ENDIF}
    {$IFDEF VER130}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    {$IFDEF VER120}
    property OnDockDrop;
    property OnDockOver;
    property OnDragDrop;
    {$ENDIF}
    property OnDragOver;
    {$IFDEF VER120}
    property OnEndDock;
    property OnGetSiteInfo;
    {$ENDIF}
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VER120}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

  {TCoolHint2KLink}
  TCoolHint2KLink = class(TCustom2KControl)
  private
    FVisited: Boolean;
    FColorVisited: TColor;

    procedure SetVisited(Value: Boolean);
    procedure SetColorVisited(Value: TColor);
  protected
    procedure Paint; override;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ColorVisited: TColor read FColorVisited write SetColorVisited default clPurple;
    property Visited: Boolean read FVisited write SetVisited default False;
    property Font;
    property Caption;
    property Color default $00DDFFFF;
    property Cursor default crHandPoint;
    property ParentColor;
    property ParentFont;
    property TabOrder;
    property TabStop default True;
    property OnClick;
    {$IFDEF VER120}
    property OnConstrainedResize;
    {$ENDIF}
    {$IFDEF VER130}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    {$IFDEF VER120}
    property OnDockDrop;
    property OnDockOver;
    {$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VER120}
    property OnEndDock;
    property OnGetSiteInfo;
    {$ENDIF}
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VER120}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

  TCommandType = (ctNext, ctPrevious);

  {TCoolHint2KCommandLink}
  TCoolHint2KCommandLink = class(TCustom2KControl)
  private
    FCommandType: TCommandType;
    procedure SetCommandType(Value: TCommandType);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property CommandType: TCommandType read FCommandType write SetCommandType default ctNext;
    property Font;
    property Caption;
    property Color default $00DDFFFF;
    property Cursor default crHandPoint;
    property ParentColor;
    property ParentFont;
    property TabOrder;
    property TabStop default True;
    property OnClick;
    {$IFDEF VER120}
    property OnConstrainedResize;
    {$ENDIF}
    {$IFDEF VER130}
    property OnContextPopup;
    {$ENDIF}
    property OnDblClick;
    {$IFDEF VER120}
    property OnDockDrop;
    property OnDockOver;
    {$ENDIF}
    property OnDragDrop;
    property OnDragOver;
    {$IFDEF VER120}
    property OnEndDock;
    property OnGetSiteInfo;
    {$ENDIF}
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    {$IFDEF VER120}
    property OnMouseWheel;
    property OnMouseWheelDown;
    property OnMouseWheelUp;
    property OnResize;
    property OnStartDock;
    property OnUnDock;
    {$ENDIF}
  end;

implementation

{$R CoolHints2K.res}

procedure InflateRectEx(var R: TRect; lOffset, tOffset, rOffset, bOffset: Integer);
begin
  with R do
  begin
    Left := Left+lOffset;
    Top := Top+tOffset;
    Right := Right+rOffset;
    Bottom := Bottom+bOffset;
  end;
end;

{TCustom2KControl}
constructor TCustom2KControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csSetCaption];
  Color := $00DDFFFF;
  TabStop := True;
  FFocusStates := [];
end;

destructor TCustom2KControl.Destroy;
begin
  inherited Destroy;
end;

procedure TCustom2KControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    SetFocus;
    Include(FFocusStates, fsPressed);
    Invalidate;
  end;
end;

procedure TCustom2KControl.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  if Button = mbLeft then
  begin
    Exclude(FFocusStates, fsPressed);
    Invalidate;
  end;
end;

procedure TCustom2KControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited KeyDown(Key, Shift);
  if Key in [VK_SPACE, VK_RETURN] then
  begin
    Include(FFocusStates, fsPressed);
    Click;
    Invalidate;
  end;
end;

procedure TCustom2KControl.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited KeyUp(Key, Shift);
  if Key in [VK_SPACE, VK_RETURN] then
  begin
    Exclude(FFocusStates, fsPressed);
    Invalidate;
  end;
end;

procedure TCustom2KControl.CMEnter(var Message: TCMEnter);
begin
  inherited;
  Include(FFocusStates, fsKeyboardCaptured);
  Invalidate;
end;

procedure TCustom2KControl.CMExit(var Message: TCMExit);
begin
  inherited;
  Exclude(FFocusStates, fsKeyboardCaptured);
  Invalidate;
end;

procedure TCustom2KControl.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Include(FFocusStates, fsMouseCaptured);
  Invalidate;
end;

procedure TCustom2KControl.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  Exclude(FFocusStates, fsMouseCaptured);
  Invalidate;
end;

procedure TCustom2KControl.CMTextChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

{TCoolHint2KButton}
constructor TCoolHint2KButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(Left, Top, 115, 25);
  TabStop := True;
  Color := $00DDFFFF;
  FModalResult := 0;
  FCancel := False;
  FDefault := False;
end;

destructor TCoolHint2KButton.Destroy;
begin
  inherited Destroy;
end;

procedure TCoolHint2KButton.SetDefault(Value: Boolean);
var
  Form: TCustomForm;
begin
  FDefault := Value;

  if FDefault and HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
end;

procedure TCoolHint2KButton.CreateWnd;
begin
  inherited CreateWnd;
  CreateBalloonButton;
end;

procedure TCoolHint2KButton.CreateBalloonButton;
var
  R: TRect;
  Rgn: HRGN;
begin
  R := ClientRect;
  Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 5, 5);
  SetWindowRgn(Handle, Rgn, True);
  DeleteObject(Rgn);
end;

procedure TCoolHint2KButton.Click;
var
  Form: TCustomForm;
begin
  Form := GetParentForm(Self);
  if Form <> nil then Form.ModalResult := ModalResult;
  inherited Click;
end;

procedure TCoolHint2KButton.Paint;
var
  Rgn: HRGN;
  R: TRect;
begin
  inherited Paint;
  R := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(R);

  Canvas.Font.Assign(Font);

  Rgn := CreateRectRgnIndirect(R);
  GetWindowRgn(Handle, Rgn);
  Canvas.Brush.Color := clBtnFace;
  FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);
  if fsPressed in FFocusStates then
  begin
    Canvas.Brush.Color := clBtnShadow;
    OffsetRgn(Rgn, 1, 1);
    FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);

    Canvas.Brush.Color := clWindow;
    OffsetRgn(Rgn, -2, -2);
    FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);
  end else
  if fsMouseCaptured in FFocusStates then
  begin
    Canvas.Brush.Color := clWindow;
    OffsetRgn(Rgn, 1, 1);
    FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);

    Canvas.Brush.Color := clBtnShadow;
    OffsetRgn(Rgn, -2, -2);
    FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);
  end;
  DeleteObject(Rgn);

  SetBkMode(Canvas.Handle, TRANSPARENT);

  if (fsKeyboardCaptured in FFocusStates) or Focused then
  begin
    R := ClientRect;
    DrawText(Canvas.Handle, PChar(Caption), -1, R,
        DT_CALCRECT or DT_CENTER or DT_VCENTER or DT_MODIFYSTRING or DT_END_ELLIPSIS or DT_SINGLELINE);
    OffsetRect(R, (ClientRect.Right - R.Right) div 2, (ClientRect.Bottom - R.Bottom) div 2);
    Canvas.DrawFocusRect(R);
  end;

  R := ClientRect;
  DrawText(Canvas.Handle, PChar(Caption), -1, R,
        DT_CENTER or DT_VCENTER or DT_MODIFYSTRING or DT_END_ELLIPSIS or DT_SINGLELINE);
end;

procedure TCoolHint2KButton.WMSize(var Message: TWMSize);
begin
  inherited;
  CreateBalloonButton;
end;

procedure TCoolHint2KButton.CMDialogKey(var Message: TCMDialogKey);
begin
  with Message do
  begin
    if ((CharCode = VK_RETURN) and FDefault) and (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
      Exit;
    end;
    if ((CharCode = VK_ESCAPE) and FCancel) and (KeyDataToShiftState(Message.KeyData) = []) and CanFocus then
    begin
      Click;
      Result := 1;
      Exit;
    end;
  end;
  inherited;
end;

{TCoolHint2KLink}
constructor TCoolHint2KLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(Left, Top, 200, 50);
  FColorVisited := clPurple;
  FVisited := False;
  Cursor := crHandPoint;
  TabStop := True;
  Color := $00DDFFFF;
end;

destructor TCoolHint2KLink.Destroy;
begin
  inherited Destroy;
end;

procedure TCoolHint2KLink.SetVisited(Value: Boolean);
begin
  if FVisited <> Value then
  begin
    FVisited := Value;
    Invalidate;
  end;
end;

procedure TCoolHint2KLink.SetColorVisited(Value: TColor);
begin
  if FColorVisited <> Value then
  begin
    FColorVisited := Value;
    Invalidate;
  end;
end;

procedure TCoolHint2KLink.Paint;
var
  R: TRect;
  BitmapLight: TBitmap;
begin
  inherited Paint;
  R := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(R);

  Canvas.Font.Assign(Font);
  if FVisited then
    Canvas.Font.Color := FColorVisited;

  BitmapLight := TBitmap.Create;
  try
    if fsPressed in FFocusStates then
    begin
      BitmapLight.Handle := LoadBitmap(HInstance, 'LIGHT_ON');
    end else
    if fsMouseCaptured in FFocusStates then
    begin
      BitmapLight.Handle := LoadBitmap(HInstance, 'LIGHT_ON');
    end else
    begin
      BitmapLight.Handle := LoadBitmap(HInstance, 'LIGHT_OFF');
    end;

    BitmapLight.Transparent := True;
    Canvas.Draw(0, 0, BitmapLight);

    OffsetRect(R, BitmapLight.Width + 5, 0);
    SetBkMode(Canvas.Handle, TRANSPARENT);

    if (fsPressed in FFocusStates) or (fsKeyboardCaptured in FFocusStates)then
    begin
      DrawText(Canvas.Handle, PChar(Caption), -1, R,
          DT_CALCRECT or DT_LEFT or DT_MODIFYSTRING or DT_END_ELLIPSIS or DT_WORDBREAK);
      InflateRectEx(R, -4, 0, 0, 0);
      Canvas.Pen.Style := psDot;
      Canvas.PolyLine([Point(R.Left, R.Top), Point(R.Right, R.Top), Point(R.Right, R.Bottom), Point(R.Left, R.Bottom), Point(R.Left, R.Top)]);
      InflateRectEx(R, 4, 0, 0, 0);
    end;
    DrawText(Canvas.Handle, PChar(Caption), -1, R,
        DT_LEFT or DT_MODIFYSTRING or DT_END_ELLIPSIS or DT_WORDBREAK);
  finally
    BitmapLight.Free;
  end;

  if csDesigning in ComponentState then
    with Canvas do
    begin
      R := ClientRect;
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    end;
end;

procedure TCoolHint2KLink.Click;
begin
  inherited Click;
  FVisited := True;
end;

{TCoolHint2KCommandLink}
constructor TCoolHint2KCommandLink.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(Left, Top, 100, 17);
  Cursor := crHandPoint;
  CommandType := ctNext;
  TabStop := True;
  Color := $00DDFFFF;
end;

destructor TCoolHint2KCommandLink.Destroy;
begin
  inherited Destroy;
end;

procedure TCoolHint2KCommandLink.SetCommandType(Value: TCommandType);
begin
  FCommandType := Value;
  case FCommandType of
    ctNext: Caption := 'See more...';
    ctPrevious: Caption := 'See previous';
  end;
  Invalidate;
end;

procedure TCoolHint2KCommandLink.Paint;
var
  R: TRect;
  BitmapCommand: TBitmap;
begin
  inherited Paint;

  R := ClientRect;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(R);
  Canvas.Font.Assign(Font);

  BitmapCommand := TBitmap.Create;
  try
    if fsPressed in FFocusStates then
    begin
      if FCommandType = ctNext then
        BitmapCommand.Handle := LoadBitmap(HInstance, 'NEXT_ON') else
        BitmapCommand.Handle := LoadBitmap(HInstance, 'PRED_ON');
    end else
    if fsMouseCaptured in FFocusStates then
    begin
      if FCommandType = ctNext then
        BitmapCommand.Handle := LoadBitmap(HInstance, 'NEXT_ON') else
        BitmapCommand.Handle := LoadBitmap(HInstance, 'PRED_ON');
    end else
    begin
      if FCommandType = ctNext then
        BitmapCommand.Handle := LoadBitmap(HInstance, 'NEXT_OFF') else
        BitmapCommand.Handle := LoadBitmap(HInstance, 'PRED_OFF');
    end;

    BitmapCommand.Transparent := True;
    Canvas.Draw(0, 4, BitmapCommand);

    OffsetRect(R, BitmapCommand.Width + 5, 0);
    SetBkMode(Canvas.Handle, TRANSPARENT);

    if (fsPressed in FFocusStates) or (fsKeyboardCaptured in FFocusStates)then
    begin
      DrawText(Canvas.Handle, PChar(Caption), -1, R,
          DT_CALCRECT or DT_LEFT or DT_MODIFYSTRING or DT_END_ELLIPSIS or DT_SINGLELINE);
      InflateRectEx(R, -4, 0, 0, 0);
      Canvas.Pen.Style := psDot;
      Canvas.PolyLine([Point(R.Left, R.Top), Point(R.Right, R.Top), Point(R.Right, R.Bottom), Point(R.Left, R.Bottom), Point(R.Left, R.Top)]);
      InflateRectEx(R, 4, 0, 0, 0);
    end;
    DrawText(Canvas.Handle, PChar(Caption), -1, R,
        DT_LEFT or DT_MODIFYSTRING or DT_END_ELLIPSIS or DT_SINGLELINE);
  finally
    BitmapCommand.Free;
  end;

  if csDesigning in ComponentState then
    with Canvas do
    begin
      R := ClientRect;
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(R.Left, R.Top, R.Right, R.Bottom);
    end;
end;

{TCoolHint2KForm}
constructor TCoolHint2KForm.Create(AOwner: TComponent);
begin
  {$IFDEF VER120}
  GlobalNameSpace.BeginWrite;
  {$ENDIF}
  try
    inherited CreateNew(AOwner);
    if (ClassType <> TCoolHint2KForm) and not (csDesigning in ComponentState) then
    begin
      if not InitInheritedComponent(Self, TCoolHint2KForm) then
        raise EResNotFound.CreateFmt('Resource %s not found', [ClassName]);

      {$IFDEF VER130}
      if OldCreateOrder then DoCreate;
      {$ENDIF}
    end;
  finally
    {$IFDEF VER120}
    GlobalNameSpace.EndWrite;
    {$ENDIF}
  end;
  Color := $00DDFFFF;
  FDragable := True;
end;

procedure TCoolHint2KForm.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TCoolHint2KForm.CreateWnd;
begin
  inherited CreateWnd;
  if not (csDesigning in ComponentState) then
  begin
    SetWindowLong(Handle, GWL_STYLE, GetWindowLong(Handle, GWL_STYLE) and not WS_CAPTION);
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE or SWP_FRAMECHANGED);
    CreateBalloonForm;
  end;
end;

procedure TCoolHint2KForm.Loaded;
begin
  inherited Loaded;
end;

procedure TCoolHint2KForm.Activate;
begin
  inherited Activate;
end;

procedure TCoolHint2KForm.CreateBalloonForm;
var
  R: TRect;
  Rgn: HRGN;
  BeakRgn: HRGN;
  BeakTops: array[0..2] of TPoint;
begin
  R := ClientRect;
  InflateRectEx(R, 5, 5, -5, -15);

  Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
  BeakTops[0] := Point(R.Right - 40, R.Bottom-1);
  BeakTops[1] := Point(R.Right - 50, R.Bottom-1);
  BeakTops[2] := Point(R.Right - 40, R.Bottom + 15);
  BeakRgn := CreatePolygonRgn(BeakTops, 3, WINDING);

  CombineRgn(Rgn, Rgn, BeakRgn, RGN_OR );

  SetWindowRgn(Handle, Rgn, True);

  DeleteObject(Rgn);
  DeleteObject(BeakRgn);
end;

procedure TCoolHint2KForm.Paint;
var
  Rgn: HRGN;
begin
  inherited Paint;

  with Canvas.Brush do
  begin
    Color := clBlack;
    Style := bsSolid;
  end;

  if not (csDesigning in ComponentState) then
  begin
    Rgn := CreateRectRgnIndirect(Rect(0, 0, 0, 0));
    GetWindowRgn(Handle, Rgn);
    OffsetRgn(Rgn, -3, -3);
    FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);
    DeleteObject(Rgn);
  end;
end;

procedure TCoolHint2KForm.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if not (csDesigning in ComponentState) and FDragable then
    Message.Result := htCaption;
end;

procedure TCoolHint2KForm.WMNCLButtonDblclk(var Message: TWMNCLButtonDblclk);
begin
end;

procedure TCoolHint2KForm.WMSize(var Message: TWMSize);
begin
  inherited;
  if not (csDesigning in ComponentState) then
    CreateBalloonForm;
end;

{TCoolHint2KControl}
constructor TCoolHint2KControl.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  SetBounds(Left, Top, 250, 250);
  Color := $00DDFFFF;
  FDragable := True;
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
    csSetCaption, csOpaque, csDoubleClicks, csReplicatable];
end;

procedure TCoolHint2KControl.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    if (Parent = nil) and (ParentWindow = 0) then
    begin
      WndParent := Application.Handle;
      Style := Style or WS_CLIPCHILDREN or WS_POPUP and not (WS_CHILD or WS_GROUP or WS_TABSTOP);
      ExStyle := WS_EX_TOOLWINDOW;
      WindowClass.Style := WindowClass.Style or CS_SAVEBITS;
    end;
  end;
end;

procedure TCoolHint2KControl.CreateWnd;
begin
  inherited CreateWnd;
  CreateBalloonForm;
end;

procedure TCoolHint2KControl.Loaded;
begin
  inherited Loaded;
end;

procedure TCoolHint2KControl.CreateBalloonForm;
var
  R: TRect;
  Rgn: HRGN;
  BeakRgn: HRGN;
  BeakTops: array[0..2] of TPoint;
begin
  R := ClientRect;
  InflateRectEx(R, 5, 5, -5, -15);

  Rgn := CreateRoundRectRgn(R.Left, R.Top, R.Right, R.Bottom, 20, 20);
  BeakTops[0] := Point(R.Right - 40, R.Bottom-1);
  BeakTops[1] := Point(R.Right - 50, R.Bottom-1);
  BeakTops[2] := Point(R.Right - 40, R.Bottom + 15);
  BeakRgn := CreatePolygonRgn(BeakTops, 3, WINDING);

  CombineRgn(Rgn, Rgn, BeakRgn, RGN_OR );

  SetWindowRgn(Handle, Rgn, True);

  DeleteObject(Rgn);
  DeleteObject(BeakRgn);
end;

procedure TCoolHint2KControl.Paint;
var
  Rgn: HRGN;
begin
  with Canvas.Brush do
  begin
    Color := clBlack;
    Style := bsSolid;
  end;

  Rgn := CreateRectRgnIndirect(Rect(0, 0, 0, 0));
  GetWindowRgn(Handle, Rgn);
  FrameRgn(Canvas.Handle, Rgn, Canvas.Brush.Handle, 1, 1);
  DeleteObject(Rgn);
  inherited Paint;
end;

procedure TCoolHint2KControl.WMNCHitTest(var Message: TWMNCHitTest);
begin
  inherited;
  if not (csDesigning in ComponentState) and FDragable then
    Message.Result := htCaption;
end;

procedure TCoolHint2KControl.WMNCLButtonDblclk(var Message: TWMNCLButtonDblclk);
begin
end;

procedure TCoolHint2KControl.WMSize(var Message: TWMSize);
begin
  inherited;
  CreateBalloonForm;
end;

{$IFNDEF Registered}

{Function been taken from SWAG}
function DelphiRunning: Boolean;
var
  H1, H2, H3, H4: Hwnd;
const
  {$IFDEF Delphi}
    {$IFDEF VER90}
      A0: array[0..10] of Char = 'Delphi 2.0'#0;
    {$ELSE}
      {$IFDEF VER100}
        A0: array[0..8] of Char = 'Delphi 3'#0;
      {$ELSE}
        {$IFDEF VER130}
          A0: array[0..8] of Char = 'Delphi 5'#0;
        {$ELSE}
          A0: array[0..8] of Char = 'Delphi 4'#0; 
        {$ENDIF}
      {$ENDIF}
    {$ENDIF}      
  {$ELSE}
    {$IFDEF VER125}
      A0: array[0..12] of Char = 'C++Builder 4'#0;
    {$ELSE}
      A0: array[0..10] of Char = 'C++Builder'#0;
    {$ENDIF}
  {$ENDIF}
  A1: array[0..12] of Char = 'TApplication'#0;
  A2: array[0..15] of Char = 'TAlignPalette'#0;
  A3: array[0..18] of Char = 'TPropertyInspector'#0;
  A4: array[0..11] of Char = 'TAppBuilder'#0;
begin
  H1 := FindWindow(A1, A0);
  H2 := FindWindow(A2, nil);
  H3 := FindWindow(A3, nil);
  H4 := FindWindow(A4, nil);
  Result := (H1 <> 0) and (H2 <> 0) and (H3 <> 0) and (H4 <> 0);
end;

function DelphiRunningByExeName(AFileName: TFileName): Boolean;
begin
  with TRegIniFile.Create('') do
  try
    RootKey := HKEY_LOCAL_MACHINE;
    Result := (CompareText(AFileName, ReadString('Software\Borland\Delphi\2.0', 'Delphi 2.0', '')) = 0) or
              (CompareText(AFileName, ReadString('Software\Borland\Delphi\3.0', 'Delphi 3', '')) = 0) or
              (CompareText(AFileName, ReadString('Software\Borland\Delphi\4.0', 'Delphi 4', '')) = 0) or
              (CompareText(AFileName, ReadString('Software\Borland\Delphi\5.0', 'App', '')) = 0) or
              (CompareText(AFileName, ReadString('Software\Borland\C++Builder\1.0', 'App', '')) = 0) or
              (CompareText(AFileName, ReadString('Software\Borland\C++Builder\3.0', 'App', '')) = 0) or
              (CompareText(AFileName, ReadString('Software\Borland\C++Builder\4.0', 'App', '')) = 0) or
              (CompareText(AFileName, ReadString('Software\Borland\C++Builder\5.0', 'App', '')) = 0);
  finally
    Free;
  end;
end;

procedure FormClose(Data: Pointer; Sender: TObject; var Action: TCloseAction);
begin
  TCustomForm(Sender).ModalResult := mrOk;
end;

procedure ShowWarningMessage(PrePosition: Boolean);
var
  Hint2KForm: TCoolHint2KForm;
  lbTitle: TLabel;
  lbText: TLabel;
  lbCopyright: TLabel;
  imgIcon: TImage;
  btnOk: TCoolHint2kbutton;
  Evnt: TCloseEvent;
begin
  Hint2KForm := TCoolHint2KForm.Create(Application);
  with Hint2KForm do
  try
    Position := poScreenCenter;
    Font.Name := 'Tahoma';
    Height := 220;

    imgIcon := TImage.Create(Hint2KForm);
    imgIcon.Left := 20;
    imgIcon.Top := 20;
    imgIcon.AutoSize := True;
    imgIcon.Picture.Icon.Handle := LoadIcon(0, IDI_EXCLAMATION);
    imgIcon.Parent := Hint2KForm;

    lbTitle := TLabel.Create(Hint2KForm);
    lbTitle.Left := 80;
    lbTitle.Top := 20;
    lbTitle.Caption := 'CoolHints2k Package v. 1.0';
    lbTitle.Font.Style := [fsBold];
    lbTitle.Parent := Hint2KForm;

    lbText := TLabel.Create(Hint2KForm);
    lbText.Left := 80;
    lbText.Top := 50;
    lbText.Width := 180;
    lbText.Height := 100;
    lbText.AutoSize := False;
    lbText.WordWrap := True;
    lbText.Caption := 'CoolHints2k is shareware product. If you like it and would like to use the package, please register your copy at http://www.cooldev.com./';
    lbText.Parent := Hint2KForm;

    lbCopyright := TLabel.Create(Hint2KForm);
    lbCopyright.Left := 80;
    lbCopyright.Top := 110;
    lbCopyright.Caption := 'Copyright (c) 2000 by Artem A. Berman' + #13 + 'Copyright (c) 2000 by CoolDev.Com';
    lbCopyright.Parent := Hint2KForm;

    btnOk := TCoolHint2kbutton.Create(Hint2KForm);
    btnOk.Caption := 'O&K';
    btnOk.ModalResult := mrOk;
    btnOk.Width := 75;
    btnOk.Left := 200;
    btnOk.Top := 150;
    btnOk.Default := True;
    btnOk.Cancel := True;
    btnOk.Parent := Hint2KForm;

    TMethod(Evnt).Code := @FormClose;
    TMethod(Evnt).Data := Hint2KForm;
    OnClose := Evnt;

    if PrePosition then
      ShowModal
    else
      begin
        Show;
        repeat
          Application.HandleMessage;
        until ModalResult <> 0;
        Hide;
      end;
  finally
    Free;
  end;
end;

initialization
  if not DelphiRunning and not DelphiRunningByExeName(Application.ExeName) then
  begin
    ShowWarningMessage(True);
  end;
finalization
  if not DelphiRunningByExeName(Application.ExeName) then
  begin
    ShowWarningMessage(False);
  end;
{$ENDIF}
end.


