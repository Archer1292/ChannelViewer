unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, ComCtrls, StdCtrls, Buttons, Encoder300, 
  Gauges, Spin, Math,
  PortProcess, Angle, ImgList, ToolWin,  CoolHints2K, TeEngine,
  Series, TeeProcs, Chart, AxCtrls, OleCtrls, vcf1, Grids,
  CommonTypes, Tabs, Engins, A812PG, NewIndicator, 
  BufferedImage, MiddleAverage, HiokiComPort, AppEvnts;

type
  TFormMain = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    Enc300: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    UpDowning: TUpDown;
    A812Newton: TLabel;
    A812Kg: TLabel;
    BitBtn2: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    GroupBox4: TGroupBox;
    UpDownAngle: TUpDown;
    A812Angle: TLabel;
    BitBtn3: TBitBtn;
    Label3: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    BitBtn4: TBitBtn;
    UpDown2: TUpDown;
    GroupBox5: TGroupBox;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    EngineTimer: TTimer;
    Label12: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Bevel3: TBevel;
    Label14: TLabel;
    Label15: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    CruchSpeed: TTrackBar;
    Travers: TTrackBar;
    GroupBox6: TGroupBox;
    Label27: TLabel;
    Bevel4: TBevel;
    Label28: TLabel;
    Label29: TLabel;
    Bevel5: TBevel;
    Bevel6: TBevel;
    Label34: TLabel;
    SpinEdit1: TSpinEdit;
    SpinEdit2: TSpinEdit;
    SpinEdit3: TSpinEdit;
    SpinEdit4: TSpinEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    GroupBox7: TGroupBox;
    Bevel8: TBevel;
    Bevel9: TBevel;
    Label35: TLabel;
    Label36: TLabel;
    Bevel10: TBevel;
    Label38: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    CheckBox13: TCheckBox;
    CheckBox14: TCheckBox;
    Bevel11: TBevel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    ToolbarImages: TImageList;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    PrintDialog: TPrintDialog;
    FontDialog: TFontDialog;
    Panel1: TPanel;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    labCaption: TLabel;
    Image: TImage;
    TabSheet5: TTabSheet;
    GroupBox9: TGroupBox;
    StringGrid: TStringGrid;
    ToolBar2: TToolBar;
    ToolButton17: TToolButton;
    ToolButton19: TToolButton;
    Panel2: TPanel;
    BitBtn9: TBitBtn;
    ToolButton18: TToolButton;
    Encoder300: TEncoder300;
    Angle: TAngle;
    SpeedButton9: TSpeedButton;
    GroupBox11: TGroupBox;
    Bevel7: TBevel;
    Bevel12: TBevel;
    Label40: TLabel;
    Label47: TLabel;
    Bevel13: TBevel;
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    CheckBox21: TCheckBox;
    CheckBox22: TCheckBox;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    CheckBox23: TCheckBox;
    CheckBox24: TCheckBox;
    CheckBox17: TCheckBox;
    CheckBox19: TCheckBox;
    CheckBox18: TCheckBox;
    Label53: TLabel;
    CheckBox20: TCheckBox;
    Reductor: TRadioGroup;
    DataTimer: TTimer;
    Seldom: TTimer;
    SpeedButton7: TSpeedButton;
    stCoord: TStaticText;
    CheckBox25: TCheckBox;
    GroupBox14: TGroupBox;
    BitBtn10: TBitBtn;
    BitBtn12: TBitBtn;
    ToolButton9: TToolButton;
    ToolButton10: TToolButton;
    pbCycle: TProgressBar;
    lbCycle: TLabel;
    pbCurrentCycle: TProgressBar;
    A812Indicator: TA812PG;
    Label6: TLabel;
    Label54: TLabel;
    Image1: TImage;
    Indicator: TNewIndicator;
    SpeedButton8: TSpeedButton;
    SpeedButton13: TSpeedButton;
    GroupBox15: TGroupBox;
    Label1: TLabel;
    GraphType: TComboBox;
    Auto: TEngins;
    GroupBox12: TGroupBox;
    edUp: TEdit;
    edLeft: TEdit;
    edDown: TEdit;
    edRight: TEdit;
    Button1: TButton;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    GroupBox10: TGroupBox;
    Label37: TLabel;
    Label39: TLabel;
    SpinEdit5: TSpinEdit;
    BitBtn14: TBitBtn;
    Label2: TLabel;
    Label4: TLabel;
    Button2: TButton;
    GroupBox8: TGroupBox;
    Label55: TLabel;
    edtDiametr: TEdit;
    Label57: TLabel;
    Label59: TLabel;
    edtLength: TEdit;
    Label60: TLabel;
    GraphScreen: TBufferedImage;
    Label56: TLabel;
    seCycleToSave: TSpinEdit;
    Label58: TLabel;
    MiddleAverage1: TMiddleAverage;
    HiokiComPort: THiokiComPort;
    ApplicationEvents: TApplicationEvents;
    procedure FormCreate(Sender: TObject);
    procedure ZeroSet(Sender: TObject);
    procedure ButtonClick(Sender: TObject);
    procedure EngineTimerTimer(Sender: TObject);
    procedure CruchSpeedChange(Sender: TObject);
    procedure TraversChange(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure Buttons(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure DataTimerTimer(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure ReductorClick(Sender: TObject);
    procedure AutopilotTaskCompleted(Sender: TObject);
    procedure AutopilotUserTerminate(Sender: TObject);
    procedure AutopilotTaskStart(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SeldomTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SheetMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure AutoAng(var Info: Extended);
    procedure AutoCruchenije(var Info: Extended);
    procedure AutoMM(var Info: Extended);
    procedure AutoPhysicalCruchenije(var Info: Extended);
    procedure AutoPhysicalUsilije(var Info: Extended);
    procedure AutoUsilije(var Info: Extended);
    procedure btnProcess(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure SheetMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SheetMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AutoEndTask(Sender: TObject);
    procedure AutoHorizMM(var Info: Extended);
    procedure SpeedButton8Click(Sender: TObject);
    procedure AutoElectro(var Info: Extended);
    procedure GraphTypeChange(Sender: TObject);
    procedure edUpKeyPress(Sender: TObject; var Key: Char);
    procedure Button2Click(Sender: TObject);
    procedure edtDiametrChange(Sender: TObject);
    procedure edtTemperatureChange(Sender: TObject);
    procedure edtLengthChange(Sender: TObject);
    procedure GraphScreenBufferPaint(Sender: TGraphicControl);
    procedure GraphScreenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RadioGroup1Click(Sender: TObject);
    procedure edtAmperChange(Sender: TObject);
    procedure AutoResistance(var Info: Extended);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ApplicationEventsMessage(var Msg: tagMSG;
      var Handled: Boolean);
   
  private
    MinTraversa, MaxTraversa: Cardinal;
    MinAngle, MaxAngle: Integer;
    Start: Boolean;
    //Excel: Variant;
    MouseDown: Boolean;
    MouseRect: TRect;
  public
    CurrentLine: Cardinal;
    function GetRowsCount: Cardinal;
  end;

var
  FormMain: TFormMain;

implementation

uses FormSave, Clipbrd, Start, About, Printers;


{$R *.DFM}

procedure TFormMain.FormCreate(Sender: TObject);
var a: Boolean;
begin
    MinTraversa := 10;
    MaxTraversa := 50;
    MinAngle    := 10;
    MaxAngle    := 50;

    Auto.Diametr := 7;
    Auto.Temperature := 22;
    Auto.RAmper := 1;

    Start := True;

    ToolButton17Click(nil);

    Brush.Bitmap := Image.Picture.Bitmap;

    A812Indicator.Run;
    Angle.Run;
    Auto.Run;
    GraphType.ItemIndex := 0;
end;

procedure TFormMain.ZeroSet(Sender: TObject);
begin
    case TComponent(Sender).Tag of
    0: Encoder300.Reset;
    1: A812Indicator.SetNagrOrigin;
    2: A812Indicator.SetCruchOrigin;
    3: if MessageDlg('Сброс настроек преобразователей необходим только в случае аварии.' +
                     'Вы уверены, что хотите сбросить траверс?', mtConfirmation,
                      [mbYes, mbNo], 0) = mrYes
       then Auto.Reset1;

    4: if MessageDlg('Сброс настроек преобразователей необходим только в случае аварии.' +
                     'Вы уверены, что хотите сбросить кручение?', mtConfirmation,
                      [mbYes, mbNo], 0) = mrYes
       then Auto.Reset0;
    5: Angle.SetOrigin;
    7: A812Indicator.SetElectroOrigin;
    8: A812Indicator.SetTokOrigin;
    end;
end;

procedure TFormMain.ButtonClick(Sender: TObject);
begin
with Auto do
case TComponent(Sender).Tag of
    0: CommandToEngine(ecRight);
    1: CommandToEngine(ecStopLR);
    2: CommandToEngine(ecLeft);
    3: CommandToEngine(ecDown);
    4: CommandToEngine(ecStopUD);
    5: CommandToEngine(ecUp);
end;
    CruchSpeedChange(Self);
    TraversChange(Self);
end;
//-----------------------------------------------------------------------------------------------------------
procedure TFormMain.EngineTimerTimer(Sender: TObject);
begin
    Label2.Caption     := 'Сейчас: ' + TimeToStr(Now);
    Enc300.Caption     := ExtToStr(Auto.MM, UpDowning.Position);
    Label6.Caption     := ExtToStr(Auto.HorizMM, UpDowning.Position + 1);
    A812Newton.Caption := ExtToStr(Auto.Usilije * 9.8, 0);
    A812Kg.Caption     := ExtToStr(Auto.Usilije, 0);
    A812Angle.Caption  := ExtToStr(Auto.Cruchenije, UpDownAngle.Position);
    Label9.Caption     := ExtToStr(Angle.AbsoluteGrad, UpDown2.Position);
    Label3.Caption     := Angle.GradMinSec;
    //Label1.Caption     := ExtToStr(Auto.Electro, VoltUpDown.Position);
    Label1.Caption     := HiokiComPort.Resistance;

//    Label11.Caption    := ExtToStr(Auto.Tok, TokUpDown.Position);
//try
//    Label11.Caption    := ExtToStr(Auto.Electro / (1000 * StrToFloat(Edit1.Text)), TokUpDown.Position);
//    except
//    end;
end;
//-----------------------------------------------------------------------------------------------------------

procedure TFormMain.CruchSpeedChange(Sender: TObject);
var i: Cardinal;
begin
    i := MinAngle + CruchSpeed.Position * (MaxAngle - MinAngle) div 20;
    Auto.FrequencyLR := i;
    Auto.LRFreq := i;
end;

procedure TFormMain.TraversChange(Sender: TObject);
var i: Cardinal;
begin
    i := MinTraversa + (20 - Travers.Position) * (MaxTraversa - MinTraversa) div 20;
    Auto.FrequencyUD := i;
    Auto.UDFreq := i;
end;

procedure TFormMain.SpinEdit1Change(Sender: TObject);
begin
    if Spinedit1.Value >= Spinedit2.Value then  Spinedit1.Value := MinTraversa
    else MinTraversa := Spinedit1.Value;

    if Spinedit3.Value >= Spinedit4.Value then  Spinedit3.Value := MinAngle
    else MinAngle := Spinedit3.Value;
end;

procedure TFormMain.SpinEdit2Change(Sender: TObject);
begin
    if Spinedit1.Value >= Spinedit2.Value then Spinedit2.Value := MaxTraversa
    else MaxTraversa := Spinedit2.Value;

    if Spinedit3.Value >= Spinedit4.Value then Spinedit4.Value := MaxAngle
    else MaxAngle := Spinedit4.Value;
end;

procedure TFormMain.Buttons(Sender: TObject);
begin
case TComponent(Sender).Tag of
  0: Close;
  1: begin
      try
       Printer.Orientation := poLandscape;
       Printer.BeginDoc;
       Printer.Canvas.StretchDraw(Rect(0,0,Printer.PageWidth,Printer.PageHeight),
                                  GraphScreen.Buffer);
       Printer.EndDoc;
      except end;
     end;
  17: Application.Minimize;
  18: begin Start := True; FormActivate(nil); end;
  19: GraphScreen.Clear;
  20: Clipboard.Assign(GraphScreen.Buffer);
  21: SaveForm.ReadPAV;
  22: GraphScreen.BlackAndWhite := CheckBox25.Checked;
  23: SaveForm.ShowModal;
  24: Auto.GoToPhysicalZero;
  25: begin
        AboutBox := TAboutBox.Create(Self);
        AboutBox.ShowModal;
        AboutBox.Free;
      end;
  26: GraphScreen.ClearAll;
end;
end;

procedure TFormMain.FormActivate(Sender: TObject);
begin
  if not Start then Exit;
  PageControl.ActivePage := PageControl.Pages[0];

  edUp.Text    := ExtToStr(GraphScreen.Box.Up);
  edDown.Text  := ExtToStr(GraphScreen.Box.Down);
  edLeft.Text  := ExtToStr(GraphScreen.Box.Left);
  edRight.Text := ExtToStr(GraphScreen.Box.Right);

  Auto.Priority := tpLower;
  A812Indicator.Priority := tpLowest;
  Angle.Priority := tpLowest;


   HintStart.ShowModal;
   HintStart.Hide;
   Auto.Init;
   GraphScreen.SetBounds(0, Panel2.Top + Panel2.Height,
            Panel2.Width, Panel1.Height - (Panel2.Top + Panel2.Height));
   GraphScreen.ResizeBuffers;
   Auto.Act := True;
   A812Indicator.Act := True;
   Angle.Act := True;

   Seldom.Enabled := True;
   EngineTimer.Enabled := True;
   Panel1.Visible := True;
   SpeedButton7.Visible := True;
   Start := False;

  GraphScreen.Repaint;
  Application.ProcessMessages;
  Auto.Priority := tpNormal;
  A812Indicator.Priority := tpNormal;
  Angle.Priority := tpNormal;
end;

procedure TFormMain.BitBtn7Click(Sender: TObject);
begin
  if BitBtn7.Kind = bkAll then
  begin
    BitBtn10.Enabled := True;
    CurrentLine := GetRowsCount;
    Auto.Start;
    BitBtn7.Kind := bkNo;
    BitBtn7.Caption := 'Стоп';
    //DataTimer.Enabled := True;
  end else
  begin
       BitBtn10.Enabled := False;
       BitBtn12.Enabled := False;
    Auto.StopAndResetTask;
    //DataTimer.Enabled := False;
    BitBtn7.Kind := bkAll;
    BitBtn7.Caption := 'Старт';
  end;
end;

procedure TFormMain.SpinEdit5Change(Sender: TObject);
begin
  DataTimer.Interval := 100 * SpinEdit5.Value;
end;

procedure TFormMain.DataTimerTimer(Sender: TObject);
var myRect: TGridRect;
begin
    ToolButton10.Down := True;

    if (Auto.CurrentCycle mod seCycleToSave.Value <> 0)
        then Exit;

    if (CurrentLine > StringGrid.VisibleRowCount) then
        StringGrid.TopRow := CurrentLine - StringGrid.VisibleRowCount + 1;

    StringGrid.Cells[0,CurrentLine] := TimeToStr(Time);
    StringGrid.Cells[1,CurrentLine] := A812Newton.Caption;//ExtToStr(Auto.Usilije * 9.8, SpinEdit6.Value);
    StringGrid.Cells[2,CurrentLine] := Enc300.Caption;//ExtToStr(Auto.MM);
    StringGrid.Cells[3,CurrentLine] := A812Angle.Caption;//ExtToStr(Auto.Cruchenije, SpinEdit6.Value);
    StringGrid.Cells[4,CurrentLine] := Label9.Caption;//ExtToStr(Auto.Ang, SpinEdit6.Value);
    StringGrid.Cells[5,CurrentLine] := Label6.Caption;//ExtToStr(Auto.HorizMM);
    StringGrid.Cells[6,CurrentLine] := HiokiComPort.Resistance;//ExtToStr(Auto.Electro);
    StringGrid.Cells[7,CurrentLine] := IntToStr(Auto.CurrentCycle);
    StringGrid.Cells[8,CurrentLine] := IntToStr(Auto.CurrentStepNumber);
    //StringGrid.Cells[8,CurrentLine] := '0';//Label11.Caption;
    //StringGrid.Cells[9,CurrentLine] := ExtToStr(Auto.Soprotivlenije, 10);

    myRect.Left   := 0;
    myRect.Top    := CurrentLine;
    myRect.Right  := StringGrid.ColCount - 1;
    myRect.Bottom := CurrentLine;
    StringGrid.Selection := myRect;

    Inc(CurrentLine);
    if CurrentLine > StringGrid.RowCount then StringGrid.RowCount := StringGrid.RowCount + 100;
end;

procedure TFormMain.ToolButton17Click(Sender: TObject);
var i: Integer;
    myRect: TGridRect;
begin
   // number of columns
   StringGrid.ColCount := 9;

   // clear rows
   for i := 1 to CurrentLine - 1
       do StringGrid.Rows[i].Clear;
   StringGrid.RowCount := 1;
   StringGrid.RowCount := 10 * 60 * 60 * 24;
   StringGrid.FixedRows := 1;

   // column names
   StringGrid.Cells[0,0] := 'Время';
   StringGrid.Cells[1,0] := 'Усилие (Н)';
   StringGrid.Cells[2,0] := 'Удлинение (mm)';
   StringGrid.Cells[3,0] := 'Момент (N*m)';
   StringGrid.Cells[4,0] := 'Угол (' + '°' + ')';
   StringGrid.Cells[5,0] := 'Поперечная деформация (мм)';
   StringGrid.Cells[6,0] := 'Электрическое сопротивление (Ом)';
   StringGrid.Cells[7,0] := '№ цикла';
   StringGrid.Cells[8,0] := '№ шага в цикле';
   //StringGrid.Cells[8,0] := 'Напряжение В2-38 (Вольт)';
   //StringGrid.Cells[9,0] := 'Cопротивление Rt (Ом)';

   // set current line
   CurrentLine := 1;

   // set cursor
   myRect.Left   := 0;
   myRect.Top    := 1;
   myRect.Right  := StringGrid.ColCount - 1;
   myRect.Bottom := 1;
   StringGrid.Selection := myRect;
end;

procedure TFormMain.ReductorClick(Sender: TObject);
begin
  Auto.Reductor := Reductor.ItemIndex;
end;

procedure TFormMain.AutopilotTaskCompleted(Sender: TObject);
begin
  DataTimer.Enabled := False;
  BitBtn7.Kind := bkAll;
  BitBtn7.Caption := 'Старт';
end;

procedure TFormMain.AutopilotUserTerminate(Sender: TObject);
begin
  DataTimer.Enabled := False;
  BitBtn7.Kind := bkAll;
  BitBtn7.Caption := 'Старт';
end;

procedure TFormMain.AutopilotTaskStart(Sender: TObject);
begin
  DataTimer.Enabled := True;
end;

procedure TFormMain.Button1Click(Sender: TObject);
var Box: TBox;
begin
  try
     Box.Left := StrToFloat(edLeft.Text);
     Box.Right := StrToFloat(edRight.Text);
     Box.Up := StrToFloat(edUp.Text);
     Box.Down := StrToFloat(edDown.Text);
  except
    Application.MessageBox('Вы неверно ввели одно из чисел.', 'Внимание!', MB_OK);
    //ShowMessage('Вы неверно ввели одно из чисел.');
    Exit;
  end;
  GraphScreen.Box := Box;
end;               

procedure TFormMain.SeldomTimer(Sender: TObject);
var Ekran: TEkran;
    S1, S2, S3, S4: String;
begin
    S1 := 'Усилие F: ' + A812Newton.Caption;
    S2 := 'Удлин. L: ' + ExtToStr((Encoder300.X + Encoder300.Y) / 2, UpDowning.Position);
    S3 := 'Крут.м.M: ' + A812Angle.Caption;
    S4 := 'Уг.зак.ф:'  + Label3.Caption;
    Ekran[1] := S1 + StringOfChar(' ', 20 - Length(S1) - 1) + 'H';
    Ekran[2] := S2 + StringOfChar(' ', 20 - Length(S2) - 2) + 'мм';
    Ekran[3] := S3 + StringOfChar(' ', 20 - Length(S3) - 3) + 'H/м';
    Ekran[4] := S4 + StringOfChar(' ', 20 - Length(S4) - 0);
    Indicator.XY := Ekran;
    GroupBox10.Hint := ExtToStr(Auto.TimeIntervalMS);

if PageControl.ActivePageIndex = 0 then
begin
    pbCycle.Max := Auto.Cycles;
    pbCycle.Position := Auto.CurrentCycle - 1;
    pbCurrentCycle.Max := Auto.StepsInOneCycle;
    pbCurrentCycle.Position := Auto.CurrentStepNumber;
    //pbCycle.Position := Floor(100 * (Auto.CurrentCycle - 1) / Auto.Cycles + 100 * Auto.CurrentStepNumber / (Auto.StepsInOneCycle + 1) / Auto.Cycles);
    lbCycle.Caption := 'цикл ' + IntToStr(Auto.CurrentCycle);
    //pbCurrentCycle.Position := Floor(100 * Auto.CurrentStepNumber / (1 + Auto.StepsInOneCycle));

    //A812Kg.Hint := ExtToStr(A812Indicator.NagrAbsoluteKg, 0) + ' кг';
    //A812Angle.Hint := ExtToStr(A812Indicator.KruchAbsoluteKg,0) + ' тарировочных кг';
    //Label1.Hint := ExtToStr(A812Indicator.ElectroAbsoluteVolt, 8) + ' Вольт';

    Travers.SelStart   := Floor(20 *(1 - (Auto.FrequencyUD -  MinTraversa)/(MaxTraversa - MinTraversa)));
    CruchSpeed.SelEnd  := Floor(20 * (Auto.FrequencyLR -  MinAngle)/(MaxAngle - MinAngle));

    Label15.Caption := IntToStr(Auto.FrequencyLR);
    Label14.Caption := IntToStr(Auto.FrequencyUD);
    Label24.Caption := IntToStr(Auto.VoltLR);
    Label23.Caption := IntToStr(Auto.VoltUD);
    Label26.Caption := IntToStr(Auto.AmperLR);
    Label25.Caption := IntToStr(Auto.AmperUD);
end;

if PageControl.ActivePageIndex = 1 then
begin
    Label40.Hint := 'Скорость обмена: ' + IntToStr(Auto.ConnectionSpeedActPerSecond) + ' актов обмена/сек';
    CheckBox1.Checked := stRun      in Auto.StateUpDown;
    CheckBox2.Checked := stForward  in Auto.StateUpDown;
    CheckBox3.Checked := stBackward in Auto.StateUpDown;
    CheckBox4.Checked := stSU       in Auto.StateUpDown;
    CheckBox5.Checked := stOL       in Auto.StateUpDown;
    CheckBox6.Checked := stFU       in Auto.StateUpDown;
    CheckBox7.Checked := stAvarija  in Auto.StateUpDown;

    CheckBox8.Checked  := stRun      in Auto.StateLeftRight;
    CheckBox9.Checked  := stForward  in Auto.StateLeftRight;
    CheckBox10.Checked := stBackward in Auto.StateLeftRight;
    CheckBox11.Checked := stSU       in Auto.StateLeftRight;
    CheckBox12.Checked := stOL       in Auto.StateLeftRight;
    CheckBox13.Checked := stFU       in Auto.StateLeftRight;
    CheckBox14.Checked := stAvarija  in Auto.StateLeftRight;

    CheckBox15.Checked := Auto.PortSuccessfullyOpened;
    CheckBox16.Checked := Auto.PortSuccessfullyOpened;
    CheckBox22.Checked := Auto.OnLineUD;
    CheckBox21.Checked := Auto.OnLineLR;
    CheckBox17.Checked := Encoder300.IsWorking;
    CheckBox19.Checked := A812Indicator.IsWorking;
    CheckBox23.Checked := Angle.Active;
    CheckBox24.Checked := Angle.ExchGood;
    CheckBox18.Checked := Indicator.IsWorking;
    CheckBox20.Checked := Indicator.ExchGood;
end;
end;

procedure TFormMain.FormShow(Sender: TObject);
begin
if not Start then Exit;
  SetBounds(0, 0, Screen.Width, Screen.Height);
  labCaption.Width := Width - PageControl.Width - 90;
  Panel1.SetBounds(0, 30, Width - PageControl.Width, Height - 30);
  //Auto.UDFreq := MinTraversa + (20 - Travers.Position) * (MaxTraversa - MinTraversa) div 20;
  //Auto.LRFreq := MinAngle + CruchSpeed.Position * (MaxAngle - MinAngle) div 20;
  //GraphScreen.ReFresh;
end;

procedure TFormMain.SheetMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  stCoord.Caption := '(' + ExtToStr(GraphScreen.CoordinateBox.PosToX(X)) + ' ; ' + ExtToStr(GraphScreen.CoordinateBox.PosToY(Y)) + ')';

  if MouseDown then
    with GraphScreen.Buffer.Canvas do
    begin
      Pen.Mode := pmNotXOR;
      Pen.Style := psDash;
      Pen.Color := clBlack;
      Brush.Style := bsClear;

      Rectangle(MouseRect);
      MouseRect.Right  := X;
      MouseRect.Bottom := Y;
      Rectangle(MouseRect);
    end;
end;

procedure TFormMain.AutoAng(var Info: Extended);
begin
  Info := Angle.AbsoluteGrad;
end;

procedure TFormMain.AutoCruchenije(var Info: Extended);
begin
  Info := A812Indicator.KruchNewtonMetr;
end;

procedure TFormMain.AutoMM(var Info: Extended);
begin
  Info := (Encoder300.X + Encoder300.Y) / 2;
end;

procedure TFormMain.AutoPhysicalCruchenije(var Info: Extended);
begin
  Info := A812Indicator.KruchAbsoluteNewM;
end;

procedure TFormMain.AutoPhysicalUsilije(var Info: Extended);
begin
  Info := A812Indicator.NagrAbsoluteKg;
end;

procedure TFormMain.AutoUsilije(var Info: Extended);
begin
  Info := A812Indicator.NagrKg;
end;

procedure TFormMain.btnProcess(Sender: TObject);
begin
  case TComponent(Sender).Tag of
  0: begin
       Auto.PauseTaskAndStopEngines;
       BitBtn10.Enabled := False;
       BitBtn12.Enabled := True;
     end;
  2: begin
       Auto.ContinueTask;
       BitBtn10.Enabled := True;
       BitBtn12.Enabled := False;
     end;
  end;
end;

procedure TFormMain.ToolButton10Click(Sender: TObject);
begin
  DataTimer.Enabled := ToolButton10.Down;
  SpeedButton8.Down := ToolButton10.Down;
  SpeedButton8Click(nil);
end;

procedure TFormMain.SheetMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Box: TBox;
    h,w: Extended;
begin
  if Button = mbLeft then
  begin
    MouseDown := True;
    MouseRect.Left   := X;
    MouseRect.Top    := Y;
    MouseRect.Right  := X;
    MouseRect.Bottom := Y;
  end;

  if Button = mbRight then
  begin
    Box := GraphScreen.Box;
    h := Box.Up - Box.Down;
    w := Box.Right - Box.Left;
    Box.Up := Box.Up + h / 4;
    Box.Down := Box.Down - h / 4;
    Box.Left := Box.Left - w / 4;
    Box.Right := Box.Right + w / 4;
    GraphScreen.Box := Box;

    edUp.Text    := ExtToStr(GraphScreen.Box.Up);
    edDown.Text  := ExtToStr(GraphScreen.Box.Down);
    edLeft.Text  := ExtToStr(GraphScreen.Box.Left);
    edRight.Text := ExtToStr(GraphScreen.Box.Right);
  end;
end;

procedure TFormMain.SheetMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Box: TBox;
procedure Swap(var A,B: Integer);
var Temp: Integer;
begin
  Temp := A; A := B; B := Temp;
end;
begin
  if MouseDown then
  begin
    with GraphScreen.Buffer.Canvas do
    begin
      Pen.Mode := pmNotXOR;
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(MouseRect);
      Pen.Mode := pmCopy;
      Pen.Style := psSolid;
    end;
    with GraphScreen.Buffer.Canvas do
    begin
      Pen.Mode := pmNotXOR;
      Pen.Style := psDash;
      Brush.Style := bsClear;
      Rectangle(MouseRect);
      Pen.Mode := pmCopy;
      Pen.Style := psSolid;
    end;
      MouseDown := False;
      MouseRect.Right  := X;
      MouseRect.Bottom := Y;


      if (MouseRect.Right = MouseRect.Left) or (MouseRect.Top = MouseRect.Bottom) then Exit;
      if MouseRect.Right < MouseRect.Left then Swap(MouseRect.Right, MouseRect.Left);
      if MouseRect.Top > MouseRect.Bottom then Swap(MouseRect.Top, MouseRect.Bottom);

    Box.Up    := GraphScreen.CoordinateBox.PosToY(MouseRect.Top);
    Box.Down  := GraphScreen.CoordinateBox.PosToY(MouseRect.Bottom);
    Box.Left  := GraphScreen.CoordinateBox.PosToX(MouseRect.Left);
    Box.Right := GraphScreen.CoordinateBox.PosToX(MouseRect.Right);

    GraphScreen.Box := Box;
    edUp.Text    := ExtToStr(GraphScreen.CoordinateBox.Box.Up);
    edDown.Text  := ExtToStr(GraphScreen.CoordinateBox.Box.Down);
    edLeft.Text  := ExtToStr(GraphScreen.CoordinateBox.Box.Left);
    edRight.Text := ExtToStr(GraphScreen.CoordinateBox.Box.Right);
    end;

end;

procedure TFormMain.AutoEndTask(Sender: TObject);
begin
  DataTimer.Enabled := False;
  BitBtn7.Kind := bkAll;
end;

procedure TFormMain.AutoHorizMM(var Info: Extended);
begin
  Info := Encoder300.Z * 0.47;
end;

procedure TFormMain.SpeedButton8Click(Sender: TObject);
begin
  DataTimer.Enabled := SpeedButton8.Down;
  ToolButton10.Down := SpeedButton8.Down;
  SpeedButton8.Glyph := nil;
  if SpeedButton8.Down then ToolbarImages.GetBitmap(17,SpeedButton8.Glyph)
                       else ToolbarImages.GetBitmap(18,SpeedButton8.Glyph);
end;

procedure TFormMain.AutoElectro(var Info: Extended);
begin
  Info := A812Indicator.Electro;// * 0.00025384879;// / 5000;
end;

procedure TFormMain.GraphTypeChange(Sender: TObject);
begin
  Auto.Priority := tpLower;
  A812Indicator.Priority := tpLowest;
  Angle.Priority := tpLowest;
  //GraphScreen.Repaint;
  Application.ProcessMessages;
  GraphScreen.Kind := TGraphType(GraphType.ItemIndex);
  //SendMessage(GraphScreen.Picture.Bitmap.Handle, WM_PAINT, 0, 0);//
  //GraphScreen.Repaint;
  Application.ProcessMessages;
  Auto.Priority := tpNormal;
  A812Indicator.Priority := tpLower;
  Angle.Priority := tpNormal;
  CheckBox25.Checked := GraphScreen.BlackAndWhite;
  edUp.Text    := ExtToStr(GraphScreen.Box.Up, 5);
  edDown.Text  := ExtToStr(GraphScreen.Box.Down, 5);
  edLeft.Text  := ExtToStr(GraphScreen.Box.Left, 5);
  edRight.Text := ExtToStr(GraphScreen.Box.Right, 5);
end;

function TFormMain.GetRowsCount: Cardinal;
begin
  Result := 1;
  while StringGrid.Cells[1, Result] <> '' do Inc(Result);
end;

procedure TFormMain.edUpKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then Button1Click(nil);
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
   Label4.Caption := TimeToStr(Now);
end;

procedure TFormMain.edtDiametrChange(Sender: TObject);
begin
   try
     Auto.Diametr := StrToFloat((Sender as TEdit).Text);
   except
     Application.MessageBox('Число введено неверно.', 'Внимание!', MB_OK);
     // ShowMessage('Число введено неверно');
   end;
end;

procedure TFormMain.edtTemperatureChange(Sender: TObject);
begin
   try
     Auto.Temperature := StrToFloat((Sender as TEdit).Text);
   except
     Application.MessageBox('Число введено неверно.', 'Внимание!', MB_OK);
     //ShowMessage('Число введено неверно');
   end;
end;

procedure TFormMain.edtLengthChange(Sender: TObject);
begin
   try
     Auto.WorkingLength := StrToFloat((Sender as TEdit).Text);
   except
     Application.MessageBox('Число введено неверно.', 'Внимание!', MB_OK);
     //ShowMessage('Число введено неверно');
   end;
end;

procedure TFormMain.GraphScreenBufferPaint(Sender: TGraphicControl);
begin
        GraphScreen.Continue;
end;

procedure TFormMain.GraphScreenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
       stCoord.Caption := '(' + ExtToStr(GraphScreen.CoordinateBox.PosToX(X)) + ' ; ' + ExtToStr(GraphScreen.CoordinateBox.PosToY(Y)) + ')';
end;

procedure TFormMain.RadioGroup1Click(Sender: TObject);
begin
 //   Application.MessageBox('procedure TFormMain.RadioGroup1Click(Sender: TObject);', 'Внимание!', MB_OK);
end;

procedure TFormMain.edtAmperChange(Sender: TObject);
begin
   try
     Auto.RAmper := StrToFloat((Sender as TEdit).Text);
   except
     Application.MessageBox('Число введено неверно.', 'Внимание!', MB_OK);
     //ShowMessage('Число введено неверно');
   end;
end;


procedure TFormMain.AutoResistance(var Info: Extended);
begin
    Info := HiokiComPort.ResistanceExt;
end;

procedure TFormMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        ShowMessage('Enter');

    if Key = VK_LEFT then
        ShowMessage('Left');

    if Key = VK_RIGHT then
        ShowMessage('Right');

    if Key = VK_UP then
        ShowMessage('Up');

    if Key = VK_DOWN then
        ShowMessage('Down');

    if Key = VK_SPACE then
        ShowMessage('Space');


end;

procedure TFormMain.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
var ShiftPressed: Boolean;
    CtrlPressed:  Boolean;
begin
    // filter keystrokes
    if Msg.message <> WM_KEYUP then Exit;

    // check whether shift is pressed
    //ShiftPressed :=

end;

end.
