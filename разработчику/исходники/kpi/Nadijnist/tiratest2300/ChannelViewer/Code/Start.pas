unit Start;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;
const  NumberOfChannels=3;
type
  TFormStart = class(TForm)
    GroupBox1: TGroupBox;
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
    CheckBox15: TCheckBox;
    CheckBox16: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit16: TEdit;
    BitBtn1: TBitBtn;
    Edit17: TEdit;
    Edit18: TEdit;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Edit22: TEdit;
    Edit23: TEdit;
    Edit24: TEdit;
    Edit25: TEdit;
    Edit26: TEdit;
    Edit27: TEdit;
    Edit28: TEdit;
    Edit29: TEdit;
    Edit30: TEdit;
    Edit31: TEdit;
    Edit32: TEdit;
    Edit33: TEdit;
    Edit34: TEdit;
    Edit35: TEdit;
    Edit36: TEdit;
    Edit37: TEdit;
    Edit38: TEdit;
    Edit39: TEdit;
    Edit40: TEdit;
    Edit41: TEdit;
    Edit42: TEdit;
    Edit43: TEdit;
    Edit44: TEdit;
    Edit45: TEdit;
    Edit46: TEdit;
    Edit47: TEdit;
    Edit48: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    function CanConnectToModul: Boolean;

  private
  FormChannels: array [0..NumberOfChannels] of
    record CheckBox: TCheckBox; Edit: TEdit; MeasureUnit: TEdit; Coefficient: TEdit; end;

  public
    { Public declarations }
  end;

var
  FormStart: TFormStart;
  Channels: array [0..NumberOfChannels] of
    record Active: Boolean; Name: string; Coefficient: Extended; MeasureUnit: string; end;

implementation
uses i7000,i7000u;
{$R *.DFM}

procedure TFormStart.FormCreate(Sender: TObject);
begin
    FormChannels[0].CheckBox := CheckBox1;
    FormChannels[0].Edit     := Edit1;
    FormChannels[0].MeasureUnit := Edit33;
    FormChannels[0].Coefficient := Edit17;

    FormChannels[1].CheckBox := CheckBox2;
    FormChannels[1].Edit     := Edit2;
    FormChannels[1].MeasureUnit := Edit34;
    FormChannels[1].Coefficient := Edit18;

    FormChannels[2].CheckBox := CheckBox3;
    FormChannels[2].Edit     := Edit3;
    FormChannels[2].MeasureUnit := Edit35;
    FormChannels[2].Coefficient := Edit19;

    FormChannels[3].CheckBox := CheckBox4;
    FormChannels[3].Edit     := Edit4;
    FormChannels[3].MeasureUnit := Edit36;
    FormChannels[3].Coefficient := Edit20;

 {   FormChannels[4].CheckBox := CheckBox5;
    FormChannels[4].Edit     := Edit5;
    FormChannels[4].MeasureUnit := Edit37;
    FormChannels[4].Coefficient := Edit21;

    FormChannels[5].CheckBox := CheckBox6;
    FormChannels[5].Edit     := Edit6;
    FormChannels[5].MeasureUnit := Edit38;
    FormChannels[5].Coefficient := Edit22;

    FormChannels[6].CheckBox := CheckBox7;
    FormChannels[6].Edit     := Edit7;
    FormChannels[6].MeasureUnit := Edit39;
    FormChannels[6].Coefficient := Edit23;

    FormChannels[7].CheckBox := CheckBox8;
    FormChannels[7].Edit     := Edit8;
    FormChannels[7].MeasureUnit := Edit40;
    FormChannels[7].Coefficient := Edit24;

    FormChannels[8].CheckBox := CheckBox9;
    FormChannels[8].Edit     := Edit9;
    FormChannels[8].MeasureUnit := Edit41;
    FormChannels[8].Coefficient := Edit25;

    FormChannels[9].CheckBox := CheckBox10;
    FormChannels[9].Edit     := Edit10;
    FormChannels[9].MeasureUnit := Edit42;
    FormChannels[9].Coefficient := Edit26;

    FormChannels[10].CheckBox := CheckBox11;
    FormChannels[10].Edit     := Edit11;
    FormChannels[10].MeasureUnit := Edit43;
    FormChannels[10].Coefficient := Edit27;

    FormChannels[11].CheckBox := CheckBox12;
    FormChannels[11].Edit     := Edit12;
    FormChannels[11].MeasureUnit := Edit44;
    FormChannels[11].Coefficient := Edit28;

    FormChannels[12].CheckBox := CheckBox13;
    FormChannels[12].Edit     := Edit13;
    FormChannels[12].MeasureUnit := Edit45;
    FormChannels[12].Coefficient := Edit29;

    FormChannels[13].CheckBox := CheckBox14;
    FormChannels[13].Edit     := Edit14;
    FormChannels[13].MeasureUnit := Edit46;
    FormChannels[13].Coefficient := Edit30;

    FormChannels[14].CheckBox := CheckBox15;
    FormChannels[14].Edit     := Edit15;
    FormChannels[14].MeasureUnit := Edit47;
    FormChannels[14].Coefficient := Edit31;

    FormChannels[15].CheckBox := CheckBox16;
    FormChannels[15].Edit     := Edit16;
    FormChannels[15].MeasureUnit := Edit48;
    FormChannels[15].Coefficient := Edit32;
  }
end;

procedure TFormStart.BitBtn1Click(Sender: TObject);
var i: Integer;
    IsThereAtLeastOneChoice: Boolean;
    IsThereAtLeastTwoChoice: Boolean;
begin

    IsThereAtLeastOneChoice := False;
    IsThereAtLeastTwoChoice := False;
    for i := 0 to NumberOfChannels do
    begin
      IsThereAtLeastOneChoice:=IsThereAtLeastOneChoice;
        Channels[i].Active := FormChannels[i].CheckBox.Checked;
        if Channels[i].Active then
        begin
            Channels[i].Name   := FormChannels[i].Edit.Text;
            Channels[i].MeasureUnit := FormChannels[i].MeasureUnit.Text;
            if Trim(Channels[i].MeasureUnit) = '' then
            begin
                ShowMessage('Введите единицы измерения для всех активизированных каналов.');
                Exit;
            end;

            try

                Channels[i].Coefficient := StrToFloat(StringReplace(FormChannels[i].Coefficient.Text, ',', '.',
                          [rfReplaceAll, rfIgnoreCase]));
            except
                ShowMessage('Вы неправильно ввели один из коэффициентов. Для разделяющей запятой для десятичной записи чисел необходимо использовать либо запятую, либо точку (но только одно из них).');
                Exit;
            end;
        end;

        if Channels[i].Active then
            if IsThereAtLeastOneChoice then
                IsThereAtLeastTwoChoice := True
            else
                IsThereAtLeastOneChoice := True;
    end;

    if not IsThereAtLeastTwoChoice then
    begin
        ShowMessage('Выберите по крайней мере два канала');
        Exit;
    end;

    if not CanConnectToModul then
    begin
        Exit;
    end;

    ModalResult := mrOK;
end;


function TFormStart.CanConnectToModul: Boolean;
// поиск модуля
const comPortCout = 16;  //количесто портов на пк
var
  retval,errorcod :Word;
  adress,wt: Word;
  PortNo: Integer;
  gcPortNo:Char;
begin
  errorcod:=65533; //ошибка не открытого порта
  Result := False;
  Portno:=1;
  gdwBaudRate := 9600;
  try
  for Portno := 1 to comPortCout do
    begin
      gcPortNo := Char(Portno);
      Close_Com(gcPortNo);
      retval:=IOpenCom(gcPortNo,gdwBaudRate);
      if(retval=0) then
      begin
          gszSend    := StrAlloc(128);
          gszReceive := StrAlloc(128);
          for adress:=$1 to 256 do  //adress $01 по умолчанию, если нужно изменить - добавить init файл
          begin
            StrCopy( gszSend , PChar('$' +IntToHex(adress,2)+'M')); //записываем в gszSend команду чтения имени модуля
            retval:= Send_Receive_Cmd(gcPortNo, gszSend, gszReceive, 100, 0, wT);
            if(retval=0)  then
            begin
              if ((gszReceive[0]='!')
              and (gszReceive[3]='7')
              and (gszReceive[4]='0')
              and (gszReceive[5]='1')
              and (gszReceive[6]='9')
              and (gszReceive[7]='R'))then
              begin
                 if adress < 257 then
                 begin
                    Result:=true;
                    errorcod:=0;
                    Break;
                 end;  

              end;
            end;
          end;
          StrDispose( gszSend );
          StrDispose( gszReceive );

          if retval=0 then Break;
      end
      else if retval < 24 then  errorcod:=retval;
      Close_Com(gcPortNo);
    end;
  except
  end;
  if errorcod <> 0 then
  begin
       retval:=Application.MessageBox(PChar('Не удалось подключиться к модулю. '+IGetErrorString(retval)),
                             'Error', 1);
  end;
end;



procedure TFormStart.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if (ModalResult <> mrOK)
        then begin
          ExitProcess(0);
      //  Application.Terminate;
      //  Exit;
        end;
end;






end.
