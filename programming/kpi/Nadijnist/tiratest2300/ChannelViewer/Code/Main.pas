unit Main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Buttons, ExtCtrls, StdCtrls, Spin, Grids, DataThread, BufferedImageForChannelViewer;

(*
  Посмотри Hint у кнопки "Сохранить в TxT"!!!!!!!!!!!!!!!!!


*)
type
  TFormMain = class(TForm)
    pnlCaption: TPanel;
    btnClose: TSpeedButton;
    btnMinimize: TSpeedButton;
    Label1: TLabel;
    spnFirstChannel: TSpinEdit;
    spnSecondChannel: TSpinEdit;
    Label2: TLabel;
    Label3: TLabel;
    lblFirstChannel: TLabel;
    Label4: TLabel;
    lblSecondChannel: TLabel;
    Splitter1: TSplitter;
    pnlPicture: TPanel;
    Timer: TTimer;
    lblDataEntities: TLabel;
    Label6: TLabel;
    Panel1: TPanel;
    StringGrid: TStringGrid;
    GroupBox12: TGroupBox;
    edUp: TEdit;
    edLeft: TEdit;
    edDown: TEdit;
    edRight: TEdit;
    Button1: TButton;
    GroupBox10: TGroupBox;
    Label37: TLabel;
    Label39: TLabel;
    SpinEdit5: TSpinEdit;
    DataTimer: TTimer;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    SaveDialog: TSaveDialog;
    Button5: TButton;
    spAccuracy: TSpinEdit;
    Label5: TLabel;
    dlgExcel: TSaveDialog;
    Button6: TButton;
    Button7: TButton;
    GroupBox1: TGroupBox;
    Button8: TButton;
    cbBlackNWhite: TCheckBox;
    procedure ButtonClicks(Sender: TObject);
    procedure pnlPictureResize(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure ChangeGraphChannels(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpinEdit5Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DataTimerTimer(Sender: TObject);
    procedure SaveToTxt(Sender: TObject);
    procedure SaveToExcel(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure cbBlackNWhiteClick(Sender: TObject);
  private
    procedure Continue(Sender: TGraphicControl);
  public
    CurrentLine: Integer;
    Graph: TBufferedImageForChannelViewer;
    constructor Create(AOwner: TComponent); override;
    procedure ClearStringGrid;
  end;

var
  FormMain: TFormMain;

implementation

uses Start, ProgressBarForm, ComObj;

{$R *.DFM}

{ TFormMain }


function  ExtToStr(Number: Extended; Accuracy: Cardinal = 3): String;
begin
  Result := FloatToStrF(Number, ffFixed, 7, Accuracy);
end;

procedure TFormMain.Continue(Sender: TGraphicControl);
begin
    Graph.Continue;
end;

constructor TFormMain.Create(AOwner: TComponent);
begin
  inherited;
  SetBounds(0, 0, Screen.Width, Screen.Height);
  pnlPicture.Width := Screen.Width - 290;
  btnClose.SetBounds(Screen.Width - btnClose.Width, 0, btnClose.Width, btnClose.Height);
  btnMinimize.SetBounds(Screen.Width - btnClose.Width - btnMinimize.Width, 0, btnClose.Width, btnClose.Height);
  Graph := TBufferedImageForChannelViewer.Create(pnlPicture);
  Graph.OnBufferPaint := Continue;
  Graph.LineColor     := clRed;
  Graph.XChannel := 0;
  Graph.YChannel := 1;
  Graph.Parent   := pnlPicture;
  Graph.StartColor := clTeal;
  Graph.EndColor := clWhite;
  //  property Font: TFont read FFont write SetFont;
  //  property CapFont: TFont read FCapFont write SetCapFont;
  Graph.BlackAndWhite := False;
  //  property OnMouseDown;
  //  property XChannel: Cardinal read FXChannel write SetXChannel;
  //  property YChannel: Cardinal read FYChannel write SetYChannel;

  edUp.Text    := ExtToStr(Graph.Box.Up);
  edDown.Text  := ExtToStr(Graph.Box.Down);
  edLeft.Text  := ExtToStr(Graph.Box.Left);
  edRight.Text := ExtToStr(Graph.Box.Right);


end;

procedure TFormMain.ButtonClicks(Sender: TObject);
begin
    case (Sender as TComponent).Tag of
        0: Close;
        1: Application.Minimize;
    end;
end;

procedure TFormMain.pnlPictureResize(Sender: TObject);
begin
   Graph.SetBounds(0, 0, pnlPicture.Width, pnlPicture.Height);
   Graph.ResizeBuffers;
end;

procedure TFormMain.FormDestroy(Sender: TObject);
begin
    DataCollectingThread.Terminate;
    DataCollectingThread.WaitFor;
    Graph.Free;
end;

procedure TFormMain.TimerTimer(Sender: TObject);
begin
    lblFirstChannel.Caption  := ExtToStr(DataCollectingThread.Volt[spnFirstChannel.Value],  5);
    lblSecondChannel.Caption := ExtToStr(DataCollectingThread.Volt[spnSecondChannel.Value], 5);
    lblDataEntities.Caption  := IntToStr(Pos) + ' * ' + IntToStr(BufferSize);
    //Graph.Continue;
end;

procedure TFormMain.ChangeGraphChannels(Sender: TObject);
begin
    Graph.XChannel := spnFirstChannel.Value;
    Graph.YChannel := spnSecondChannel.Value;

    //Graph.Clear;
    Graph.RecreateGraphic;
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
  Graph.Box := Box;

end;

procedure TFormMain.ClearStringGrid;
var i: Integer;
    myRect: TGridRect;
begin
   StringGrid.ColCount := 1;
   StringGrid.RowCount := 1;
   StringGrid.RowCount := 10 * 60 * 60 * 24;
   StringGrid.FixedRows := 1;
   for i := 1 to CurrentLine - 1
       do StringGrid.Rows[i].Clear;

   StringGrid.Cells[0,0] := 'Время';
   for i := 0 to 15 do
       if Start.Channels[i].Active then
       begin
           StringGrid.ColCount := StringGrid.ColCount + 1;
           StringGrid.Cells[StringGrid.ColCount - 1, 0] := Start.Channels[i].Name + ' (' + Start.Channels[i].MeasureUnit + ')';
           StringGrid.Cols[StringGrid.ColCount - 1].Objects[0] := TObject(Pointer(i));
       end;

   CurrentLine := 1;

  myRect.Left   := 0;
  myRect.Top    := 1;
  myRect.Right  := StringGrid.ColCount - 1;
  myRect.Bottom := 1;
  StringGrid.Selection := myRect;
end;

procedure TFormMain.SpinEdit5Change(Sender: TObject);
begin
    DataTimer.Interval := 100 * SpinEdit5.Value;
end;

procedure TFormMain.Button3Click(Sender: TObject);
begin
    ClearStringGrid;
end;

procedure TFormMain.Button2Click(Sender: TObject);
begin
    DataTimer.Enabled := not DataTimer.Enabled;
    if (DataTimer.Enabled) then
        Button2.Caption := 'Остановить запись'
    else
        Button2.Caption := 'Писать в таблицу';
end;

procedure TFormMain.DataTimerTimer(Sender: TObject);
var i: Integer;
  myRect: TGridRect;
begin
  if (CurrentLine > StringGrid.VisibleRowCount) then
      StringGrid.TopRow := CurrentLine - StringGrid.VisibleRowCount + 1;
  for i := 1 to StringGrid.ColCount - 1 do
      StringGrid.Cells[i , CurrentLine] :=
          ExtToStr(DataBuffer[Pos - 1][Integer(StringGrid.Cols[i].Objects[0])], spAccuracy.Value);
  StringGrid.Cells[0,CurrentLine] := TimeToStr(Time);

  Inc(CurrentLine);

  myRect.Left   := 0;
  myRect.Top    := CurrentLine - 1;
  myRect.Right  := StringGrid.ColCount - 1;
  myRect.Bottom := CurrentLine - 1;
  StringGrid.Selection := myRect;
end;

procedure TFormMain.SaveToTxt(Sender: TObject);
var
  S: TStringList;
  T: String;
  i, j: Integer;
const TAB = #9;
begin
    if not SaveDialog.Execute then Exit;

    S := TStringList.Create;
    for i := 0 to CurrentLine - 1 do
        with StringGrid do
        begin
            T := '';
            for j := 0 to StringGrid.ColCount - 1 do
                T := T + Cells[j, i] + TAB;
            S.Add(T);
        end;

    S.SaveToFile(SaveDialog.FileName);
    S.Free;
end;


procedure TFormMain.SaveToExcel(Sender: TObject);
var GridTimer: Boolean;
    Sheet: Variant;
    Excel: Variant;
    i, Row, Column: Integer;
begin
// Останавливаем фоновые процессы
    DataThread.DataCollectingThread.Suspend;
    GridTimer := DataTimer.Enabled;
    DataTimer.Enabled := False;

// Проверяем, что на машине установлен Excel
    try
        Excel := CreateOleObject('Excel.Application');
    except
        Application.MessageBox('Нет доступа к серверу Excel.', 'Внимание!', MB_OK);
        DataTimer.Enabled := GridTimer;
        DataThread.DataCollectingThread.Resume;
        Exit;
    end;

// Спрашиваем у пользователя имя файла
    if not dlgExcel.Execute then Exit;

    Update;

// Показываем пользователю процесс
    Screen.Cursor := crHourGlass;
    FormProgressBar := TFormProgressBar.Create(Application);
    FormProgressBar.ProgressBar.Min := 0;
    FormProgressBar.ProgressBar.Max := CurrentLine - 1;
    FormProgressBar.ProgressBar.Position := 0;
    FormProgressBar.Animate.Active := True;
    FormProgressBar.Show;
    FormProgressBar.Update;

// Создаём оформление документа
    Excel.SheetsInNewWorkbook := 1;
    Excel.Workbooks.Add;

    Sheet := Excel.Workbooks[1].Sheets[1];
    Sheet.Columns.Columns.Font.Size := 8;

    for i := 0 to StringGrid.ColCount - 1 do
    begin
         Sheet.Cells[4,i + 1] := StringGrid.Cells[i, 0];
         Sheet.Columns.Columns[i + 1].ColumnWidth := 40
             //Canvas.TextExtent(StringGrid.Cells[i, 0]).cx;
             //(2 + spAccuracy.Value) * Canvas.TextExtent('0').cx;
    end;
    Sheet.Columns.Columns[1].ColumnWidth := 10;

    Sheet.Cells[1, 4] := 'Отчёт ' + DateToStr(Date) + ' Время: ' + TimeToStr(Time);
//    Sheet.Cells[2, 4] := 'Диаметр образца: ' + FormMain.edtDiametr.Text +
//                            'мм, рабочая длина: ' +
//                            FormMain.edtLength.Text + ' мм.';

    Sheet.Range['a1:j2'].Font.Size := 15;
    Sheet.Range['a1:j2'].Font.Bold := True;
    Sheet.Range['a1:j2'].Font.Italic := True;
    Sheet.Range['a1:j2'].Columns.Interior.ColorIndex := 6;
    Sheet.Range['a1:j2'].HorizontalAlignment := 3;

    Sheet.Range['a2:j4'].Font.Size := 10;
    Sheet.Range['a2:j4'].Font.Bold := True;
    Sheet.Range['a2:j2'].HorizontalAlignment := 3;

// Списываем числовые данные
    if CurrentLine > 0 then
        for Row := 1 to CurrentLine - 1 do
        begin
            Sheet.Cells[Row + 4,1] := StrToTime(StringGrid.Cells[0, Row]);
            for Column := 1 to StringGrid.ColCount - 1 do
                Sheet.Cells[Row + 4, Column + 1] := StrToFloat(StringGrid.Cells[Column, Row]);
            FormProgressBar.ProgressBar.Position := Row;
            FormProgressBar.Update;
        end;

// Уничтожаем демонстрационную форму
    Excel.Workbooks[1].SaveAs(dlgExcel.FileName);
    Excel.Quit;
  //  Excel := Unassigned;
    Screen.Cursor := crDefault;
    FormProgressBar.Hide;
    FormProgressBar.Free;
    Update;

// Запускаем всё по новой
    DataTimer.Enabled := GridTimer;
    DataThread.DataCollectingThread.Resume;
end;

procedure TFormMain.Button6Click(Sender: TObject);
begin
    Graph.Clear;
end;

procedure TFormMain.Button7Click(Sender: TObject);
begin
    DataCollectingThread.DataShift[spnFirstChannel.Value]  := -DataCollectingThread.Volt[spnFirstChannel.Value];
    DataCollectingThread.DataShift[spnSecondChannel.Value] := -DataCollectingThread.Volt[spnSecondChannel.Value];
end;

procedure TFormMain.Button8Click(Sender: TObject);
begin
    Graph.TimerEnabled := False;
    Graph.RecreateGraphicToPrinter;
    Graph.TimerEnabled := True;
    Graph.CoordinateBox.RecreateGraphic;
end;

procedure TFormMain.cbBlackNWhiteClick(Sender: TObject);
begin
    Graph.BlackAndWhite := cbBlackNWhite.Checked;
end;

end.
