unit FormSave;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, FileCtrl, ComCtrls, Dialogs, Engins;

type
  TSaveForm = class(TForm)
    Button1: TButton;
    pb: TProgressBar;
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    Edit1: TEdit;
    FileListBox1: TFileListBox;
    rgFormat: TRadioGroup;
    Button2: TButton;
    OpenDialog: TOpenDialog;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure rgFormatClick(Sender: TObject);
  private

    Excel: Variant;
    procedure FillTable;
    procedure SaveTXT;
    procedure SavePAV;
  public
    procedure ReadPAV;
  end;

var
  SaveForm: TSaveForm;

implementation

uses Main, ComObj, Math, CommonTypes;

{$R *.DFM}

procedure TSaveForm.Button2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TSaveForm.Button1Click(Sender: TObject);
var Sheet: Variant;
    Row: Integer;
    a,b,c: Boolean;
begin
    with FormMain do
    begin
      A812Indicator.Pause;
      Angle.Pause;
      Auto.Pause;
      a := Seldom.Enabled;
      b := DataTimer.Enabled;
      c := EngineTimer.Enabled;
      Seldom.Enabled := False;
      DataTimer.Enabled := False;
      EngineTimer.Enabled := False;
    end;

case rgFormat.ItemIndex of
  1: SaveTXT;
  2: SavePAV;
  0: begin
       //if not VarIsEmpty(Excel) then Exit;
       try
         Excel := CreateOleObject('Excel.Application');
       except
         Application.MessageBox('Нет доступа к серверу Excel.', 'Внимание!', MB_OK);
       //ShowMessage('Нет доступа к серверу Excel.');
         Exit;
       end;
       Screen.Cursor := crHourGlass;
       Excel.SheetsInNewWorkbook := 1;
       Excel.Workbooks.Add;

       Sheet := Excel.Workbooks[1].Sheets[1];

         Sheet.Columns.Columns[1].ColumnWidth := 10;
         Sheet.Columns.Columns[2].ColumnWidth := 10;
         Sheet.Columns.Columns[3].ColumnWidth := 15;
         Sheet.Columns.Columns[4].ColumnWidth := 25;
         Sheet.Columns.Columns[5].ColumnWidth := 10;
         Sheet.Columns.Columns[6].ColumnWidth := 30;
         Sheet.Columns.Columns[7].ColumnWidth := 20;
         Sheet.Columns.Columns[8].ColumnWidth := 10;
         Sheet.Columns.Columns[9].ColumnWidth := 20;
         Sheet.Columns.Columns[10].ColumnWidth := 30;
         Sheet.Columns.Columns[11].ColumnWidth := 30;
         Sheet.Columns.Columns.Font.Size := 8;

       Sheet.Cells[1, 4] := 'Отчёт ' + DateToStr(Date) + ' Время: ' + TimeToStr(Time);
       Sheet.Cells[2, 4] := 'Диаметр образца: ' + FormMain.edtDiametr.Text +
                            'мм, рабочая длина: ' +
                            FormMain.edtLength.Text + ' мм.';

         Sheet.Range['a1:j2'].Font.Size := 15;
         Sheet.Range['a1:j2'].Font.Bold := True;
         Sheet.Range['a1:j2'].Font.Italic := True;
         Sheet.Range['a1:j2'].Columns.Interior.ColorIndex := 6;
         Sheet.Range['a1:j2'].HorizontalAlignment := 3;

       Sheet.Range['a2:j4'].Font.Size := 10;
       Sheet.Range['a2:j4'].Font.Bold := True;
       Sheet.Range['a2:j2'].HorizontalAlignment := 3;

       Sheet.Cells[4,1] := 'Время';
       Sheet.Cells[4,2] := 'Усилие (Н)';
       Sheet.Cells[4,3] := 'Удлинение (мм)';
       Sheet.Cells[4,4] := 'Момент (Ньютон*Метр)';
       Sheet.Cells[4,5] := 'Угол (' + '°' + ')';
       Sheet.Cells[4,6] := 'Поперечная деформация (мм)';
       Sheet.Cells[4,7] := 'Электрическое сопротивление (Ом)';
       Sheet.Cells[4,8] := '№ цикла';
       Sheet.Cells[4,9] := '№ шага внутри цикла';


       pb.Show;
       pb.Max := FormMain.GetRowsCount;

       Application.ProcessMessages;
       for Row := 5 to FormMain.GetRowsCount + 4 do
       if FormMain.StringGrid.Cells[0,Row - 4] <> '' then
       begin
         Sheet.Cells[Row,1] := StrToTime(FormMain.StringGrid.Cells[0,Row - 4]);
         Sheet.Cells[Row,2] := StrToFloat(FormMain.StringGrid.Cells[1,Row - 4]);
         Sheet.Cells[Row,3] := StrToFloat(FormMain.StringGrid.Cells[2,Row - 4]);
         Sheet.Cells[Row,4] := StrToFloat(FormMain.StringGrid.Cells[3,Row - 4]);
         Sheet.Cells[Row,5] := StrToFloat(FormMain.StringGrid.Cells[4,Row - 4]);
         Sheet.Cells[Row,6] := FormMain.StringGrid.Cells[5, Row - 4];
         Sheet.Cells[Row,7] := StrToFloat(FormMain.StringGrid.Cells[6,Row - 4]);
         Sheet.Cells[Row,8] := StrToFloat(FormMain.StringGrid.Cells[7,Row - 4]);
         Sheet.Cells[Row,9] := StrToFloat(FormMain.StringGrid.Cells[8,Row - 4]);
         pb.Position := Row - 3;
       end;

       Screen.Cursor := crDefault;
       Excel.Workbooks[1].SaveAs(DirectoryListBox1.Directory + '/' +Edit1.Text);
       Excel.Quit;
       Excel := Unassigned;
       pb.Position := 0;
     end;

end;
    with FormMain do
    begin
     A812Indicator.Run;
     Angle.Run;
     Auto.Run;
     Seldom.Enabled := a;
     DataTimer.Enabled := b;
     EngineTimer.Enabled := c;
    end;
end;

procedure TSaveForm.SaveTXT;
var
  S: TStringList;
  T: String;
  i, j: Integer;
const TAB = #9;
begin
  S := TStringList.Create;
  S.Add('Время   ' + TAB +'Усилие (Н)'  + TAB  + 'Удлинение (мм)' + TAB + 'Момент (Ньютон*Метр)' + TAB + 'Угол (' + '°' + ')' + TAB + 'Поперечная деформация (мм)' + TAB + 'Электрическое сопротивление (Ом)' + TAB + '№ цикла' + TAB + TAB + 'Ток (Вольт)');
  S.Add('');
  for i := 1 to FormMain.GetRowsCount - 1 do
  with FormMain.StringGrid do
  begin
    T :=     Cells[0, i] + TAB;
    T := T + Cells[1, i] + TAB + TAB;
    T := T + Cells[2, i] + TAB + TAB;
    T := T + Cells[3, i] + TAB + TAB + TAB;
    T := T + Cells[4, i] + TAB + TAB;
    T := T + Cells[5, i] + TAB + TAB + TAB + TAB;
    T := T + Cells[6, i] + TAB + TAB + TAB;
    T := T + Cells[7, i] + TAB + TAB;
    T := T + Cells[8, i];
    S.Add(T);
  end;
  S.SaveToFile(DirectoryListBox1.Directory + '/' + Edit1.Text);
  S.Free;
end;

procedure TSaveForm.SavePAV;
var FileStream: TFileStream;
    Len: Cardinal;
begin
    Len := Engins.Pos;
   try
    FileStream := TFileStream.Create(DirectoryListBox1.Directory + '\' + Edit1.Text, fmCreate);
    FileStream.Write(DataBuffer[0], Len * SizeOf(TExtData));
  finally
    FileStream.Free;
  end;
end;

procedure TSaveForm.ReadPAV;
var FileStream: TFileStream;
    a,b,c: Boolean;
    i: Integer;
begin
    with FormMain do
    begin
      A812Indicator.Pause;
      Angle.Pause;
      Auto.Pause;
      a := Seldom.Enabled;
      b := DataTimer.Enabled;
      c := EngineTimer.Enabled;
      Seldom.Enabled := False;
      DataTimer.Enabled := False;
      EngineTimer.Enabled := False;
    end;


  if OpenDialog.Execute then
  begin
    if FileExists(OpenDialog.FileName) then
    begin
      try
  //  with FormMain do
  //  begin
   FormMain.ToolButton17Click(nil);
   //for i := 1 to StringGrid.RowCount - 1 do StringGrid.Rows[i].Clear;
   // StringGrid.Cells[0,0] := 'Время';
  //  StringGrid.Cells[1,0] := 'Усилие (Н)';
  //  StringGrid.Cells[2,0] := 'Удлинение (mm)';
  //  StringGrid.Cells[3,0] := 'Момент (N*m)';
  //  StringGrid.Cells[4,0] := 'Угол (' + '°' + ')';
  //  StringGrid.Cells[5,0] := 'Поперечная деформация (мм)';
  //  StringGrid.Cells[6,0] := 'Напряжение (Вольт)';
  // StringGrid.RowCount := 300;
  // CurrentLine := 1;
   //end;

        FormMain.GraphScreen.Repaint;
        FileStream := TFileStream.Create(OpenDialog.FileName, fmOpenRead);
        FileStream.Read(DataBuffer[0], FileStream.Size);
        Pos := FileStream.Size div SizeOf(TExtData);
        FormMain.GraphScreen.RecreateGraphic;
        FillTable;
      finally
        FileStream.Free;
      end;
    end else Application.MessageBox('Такого файла нет.', 'Внимание!', MB_OK);//ShowMessage('Такого файла нет.');
  end;

  with FormMain do
    begin
     A812Indicator.Run;
     Angle.Run;
     Auto.Run;
     Seldom.Enabled := a;
     DataTimer.Enabled := b;
     EngineTimer.Enabled := c;
    end;
end;

procedure TSaveForm.rgFormatClick(Sender: TObject);
const Mask: array [0..2] of string = ('*.xls', '*.txt', '*.tav');
begin
  FileListBox1.Mask := Mask[rgFormat.ItemIndex];
  FileListBox1.Refresh;
end;

procedure TSaveForm.FillTable;
  var i, Num: Cardinal;
      StartTime, ToTime, StepTime: TDateTime;
procedure AddData(Data: TExtData);
begin
  with FormMain do
  begin
    StringGrid.Cells[0,CurrentLine] := TimeToStr(Data.Time);
    StringGrid.Cells[1,CurrentLine] := ExtToStr(Data.Usilije * 9.8, 0);
    StringGrid.Cells[2,CurrentLine] := ExtToStr(Data.MM);
    StringGrid.Cells[3,CurrentLine] := ExtToStr(Data.Cruchenije, UpDownAngle.Position);
    StringGrid.Cells[4,CurrentLine] := ExtToStr(Data.Ang, UpDown2.Position);
    StringGrid.Cells[5,CurrentLine] := ExtToStr(Data.HorizMM);
    StringGrid.Cells[6,CurrentLine] := ExtToStr(Data.Resistance);//ExtToStr(Data.Electro, VoltUpDown.Position);
    StringGrid.Cells[7,CurrentLine] := IntToStr(Data.Cycle);
  Inc(CurrentLine);
  if CurrentLine > StringGrid.RowCount then StringGrid.RowCount := StringGrid.RowCount + 100;
  end;
end;
begin
  FormMain.CurrentLine := 1;
  FormMain.StringGrid.RowCount := 2;
  StartTime := DataBuffer[0].Time;
  StepTime := OneSecond * FormMain.SpinEdit5.Value;
  ToTime := StartTime + StepTime;
  AddData(DataBuffer[0]);

  for i := 1 to Pos do
    if DataBuffer[i].Time > ToTime then
    begin
      ToTime := ToTime + StepTime;
      AddData(DataBuffer[i]);
    end;
end;

end.
