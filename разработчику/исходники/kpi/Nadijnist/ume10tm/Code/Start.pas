{TCoolHint2KForm is window class for CoolHints2k package...}

unit Start;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  ExtCtrls, CoolHints2K, StdCtrls, Spin, jpeg;
type
  THintStart = class(TCoolHint2KForm)
    Notebook: TNotebook;
    Label39: TLabel;
    CoolHint2KButton1: TCoolHint2KButton;
    Label40: TLabel;
    Label1: TLabel;
    CoolHint2KLink1: TCoolHint2KLink;
    CoolHint2KLink2: TCoolHint2KLink;
    Label2: TLabel;
    CoolHint2KLink3: TCoolHint2KLink;
    CoolHint2KLink4: TCoolHint2KLink;
    Label3: TLabel;
    Label4: TLabel;
    SpinEdit1: TSpinEdit;
    Label5: TLabel;
    SpinEdit2: TSpinEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    SpinEdit3: TSpinEdit;
    Label9: TLabel;
    SpinEdit4: TSpinEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    CoolHint2KCommandLink1: TCoolHint2KCommandLink;
    CoolHint2KCommandLink2: TCoolHint2KCommandLink;
    CoolHint2KCommandLink3: TCoolHint2KCommandLink;
    Label13: TLabel;
    Label14: TLabel;
    SpinEdit5: TSpinEdit;
    Label15: TLabel;
    SpinEdit6: TSpinEdit;
    Label16: TLabel;
    SpinEdit7: TSpinEdit;
    Label19: TLabel;
    SpinEdit8: TSpinEdit;
    Label20: TLabel;
    Label22: TLabel;
    CoolHint2KCommandLink4: TCoolHint2KCommandLink;
    CoolHint2KCommandLink5: TCoolHint2KCommandLink;
    Label17: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    SpinEdit9: TSpinEdit;
    Label25: TLabel;
    SpinEdit10: TSpinEdit;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    SpinEdit11: TSpinEdit;
    Label29: TLabel;
    SpinEdit12: TSpinEdit;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    CoolHint2KCommandLink6: TCoolHint2KCommandLink;
    CoolHint2KCommandLink7: TCoolHint2KCommandLink;
    Label34: TLabel;
    SpinEdit14: TSpinEdit;
    SpinEdit15: TSpinEdit;
    Label38: TLabel;
    Label41: TLabel;
    Label35: TLabel;
    Label37: TLabel;
    Label44: TLabel;
    SpinEdit17: TSpinEdit;
    Label45: TLabel;
    Label47: TLabel;
    SpinEdit18: TSpinEdit;
    Label48: TLabel;
    SpinEdit19: TSpinEdit;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    CoolHint2KCommandLink8: TCoolHint2KCommandLink;
    CoolHint2KCommandLink9: TCoolHint2KCommandLink;
    Label52: TLabel;
    SpinEdit20: TSpinEdit;
    Label53: TLabel;
    SpinEdit21: TSpinEdit;
    SpinEdit22: TSpinEdit;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label36: TLabel;
    Label42: TLabel;
    Label46: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    CoolHint2KCommandLink10: TCoolHint2KCommandLink;
    Panel1: TPanel;
    Image1: TImage;
    Panel2: TPanel;
    Image2: TImage;
    Panel3: TPanel;
    Image3: TImage;
    Panel4: TPanel;
    Image4: TImage;
    Label62: TLabel;
    Label21: TLabel;
    Label63: TLabel;
    Label43: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label69: TLabel;
    SpinEdit13: TSpinEdit;
    Label70: TLabel;
    Label68: TLabel;
    SpinEdit16: TSpinEdit;
    Label71: TLabel;
    Label33: TLabel;
    SpinEdit23: TSpinEdit;
    Label72: TLabel;
    Label67: TLabel;
    SpinEdit24: TSpinEdit;
    Label73: TLabel;
    procedure SwitchPage(Sender: TObject);
    procedure CoolHint2KFormCreate(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Panel1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DataWrite(Sender: TObject);
  end;

var
  HintStart: THintStart;

implementation

uses Main, CommonTypes;


{$R *.DFM}

procedure THintStart.SwitchPage(Sender: TObject);
begin
case TComponent(Sender).Tag of
  0: Notebook.ActivePage := 'Nagruzenije';
  1: Notebook.ActivePage := 'Izdevat';
  2,7,8,9,10: Notebook.ActivePage := 'Slognoje';
  3: if FormMain.Auto.Nagrugenije = Ciklicheskoje then Notebook.ActivePage := 'MjagkijCiklica'
                                         else Notebook.ActivePage := 'MjagkijSlognoje';
  4: if FormMain.Auto.Nagrugenije = Ciklicheskoje then Notebook.ActivePage := 'GestkijCiklica'
                                         else Notebook.ActivePage := 'GestkijSlognoje';
  11,12,13,14: ModalResult := mrOK;
end;
  DataWrite(Sender);
end;

procedure THintStart.CoolHint2KFormCreate(Sender: TObject);
begin
  Notebook.ActivePage := 'Default';
end;

procedure THintStart.Image1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Panel1.BevelInner <> bvRaised then Panel1.BevelInner := bvRaised;
end;

procedure THintStart.Panel1MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Panel1.BevelInner <> bvLowered then Panel1.BevelInner := bvLowered;
  if Panel2.BevelInner <> bvLowered then Panel2.BevelInner := bvLowered;
  if Panel3.BevelInner <> bvLowered then Panel3.BevelInner := bvLowered;
  if Panel4.BevelInner <> bvLowered then Panel4.BevelInner := bvLowered;
end;

procedure THintStart.Image2MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Panel2.BevelInner <> bvRaised then Panel2.BevelInner := bvRaised;
end;

procedure THintStart.Image3MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Panel3.BevelInner <> bvRaised then Panel3.BevelInner := bvRaised;
end;

procedure THintStart.Image4MouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
  if Panel4.BevelInner <> bvRaised then Panel4.BevelInner := bvRaised;
end;

procedure THintStart.DataWrite(Sender: TObject);
begin
   with FormMain.Auto do
   case TComponent(Sender).Tag of
     1: Nagrugenije := Slognoje;      //“ип нагрузки - сложное
     2: Nagrugenije := Ciklicheskoje; //“ип нагрузки - циклическое
     4: Regim := Gestkij;             //–ежим нагружени€ - жЄсткий
     3: Regim := Mjagkij;             //–ежим нагружени€ - м€гкий
     7: Trajectory := tr1;
     8: Trajectory := tr2;
     9: Trajectory := tr3;
    10: Trajectory := tr4;
    11: begin //∆Єсткий, циклика
          Cycles   := SpinEdit5.Value;
          Mm1      := SpinEdit6.Value / 1000;
          Mm2      := SpinEdit7.Value / 1000;
          TimeSec  := SpinEdit8.Value;
          //Accuracy := TTaskAccuracy(ComboBox2.ItemIndex);
          BreakUDKg  := SpinEdit23.Value;
        end;
    12: begin //ћ€гкий, циклика
          Cycles     := SpinEdit1.Value;
          Usilije1kg := SpinEdit2.Value;
          Usilije2kg := SpinEdit3.Value;
          TimeSec    := SpinEdit4.Value;
          //Accuracy := TTaskAccuracy(ComboBox4.ItemIndex);
          BreakUDKg    := SpinEdit13.Value;
        end;
    13: begin //ћ€гкий, сложное
          Cycles        := SpinEdit9.Value;
          Usilije1kg    := SpinEdit10.Value;
          Usilije2kg    := SpinEdit11.Value;
          Cruchenije1nm := SpinEdit14.Value;
          Cruchenije2nm := SpinEdit15.Value;
          TimeSec       := SpinEdit12.Value;
          BreakUDKg       :=  SpinEdit16.Value;
          //Accuracy := TTaskAccuracy(ComboBox3.ItemIndex);
          //if Trajectory = tr3 then Accuracy := TTaskAccuracy(ComboBox3.ItemIndex + 3);
        end;
    14: begin //∆Єсткий, сложное
          Cycles     := SpinEdit20.Value;
          Mm1        := SpinEdit17.Value / 1000;
          Mm2        := SpinEdit18.Value / 1000;
          Angle1grad := SpinEdit21.Value / 100;
          Angle2grad := SpinEdit22.Value / 100;
          TimeSec    := SpinEdit19.Value;
          //if Trajectory = tr3 then Accuracy := TTaskAccuracy(ComboBox1.ItemIndex + 3) else
          BreakUDKg    := SpinEdit24.Value;
          //Accuracy := TTaskAccuracy(ComboBox1.ItemIndex);
       end;
   end;
end;

end.
