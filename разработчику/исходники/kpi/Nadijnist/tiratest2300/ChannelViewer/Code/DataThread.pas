unit DataThread;

interface
uses Classes, Forms, windows, SysUtils, Messages,Dialogs, Variants,  Graphics, Controls, StdCtrls;
const BufferSize = 5000;
      BaseAddress = $220;
      NumberOfChannels=3;//���� �� 3 ���������� chanelviewer,datathread,start

type TDataCollectingThread = class(TThread)
private
   Buffer: array [1..BufferSize] of Single;
   FCardFound: Boolean;

   procedure Refresh(Channel: Integer);

   function ConvertStrToRealVolt(s:String):Extended;//�������� �������� �� ��� � �����

   function SearchModuleAdress(portNo:Integer): Word; //����� �������
public
   Active: array [0..NumberOfChannels] of Boolean;
   Volt:   array [0..NumberOfChannels] of Extended;
   Coefficient: array [0..NumberOfChannels] of Extended;
   DataShift: array [0..NumberOfChannels] of Extended;
   function ConnectToModul: Boolean;//���� � ��������� ��� ���� � ������ ������ 7019R
   procedure PrepareModule;   //��������� ��� ����
   procedure Execute; override;
   constructor Create;
   destructor Destroy;
   procedure ClosePort;
  // property IsConnected : Boolean read fIsConnected;
  // property Port: Boolean read gcPort;
   property CardFound: Boolean read FCardFound;
 //  property CardFound: Boolean read FCardFound;
end;

const DataBufferLength = 10 * 60 * 60 * 24;
type TDataPack = array[0..NumberOfChannels] of Extended;

var DataCollectingThread: TDataCollectingThread;
    Pos: Integer;      //? ������� ��������� ������(��� ���� ������)
    IsConnected:Boolean;
(* 10 ������� � ������� �� 60 ������ �� 60 ����� �� 24 ���� *)

    DataBuffer: array[0..DataBufferLength] of TDataPack;

implementation
uses i7000,i7000u,Main;

constructor TDataCollectingThread.Create;   //��������� ���� � �����������
var retval:Word;
begin
  //DataShift[0]:=0;
    FCardFound := True;

    if ConnectToModul then PrepareModule;
    inherited Create(False);
end;

procedure TDataCollectingThread.Refresh(Channel: Integer);
var //	Extended ��� � ��������� ������� ���������� ����� �������
                  // ��������� � ������������
    retval :Word;
    s:String  ;

begin
   // if not FCardFound then Exit;    // ���� �� �������� ����
    gw7000[5] := Channel;   //Which Channel hex?

    retval := AnalogIn(@gw7000[0],@gf7000[0],gszSend,gszReceive);
     if retval=0 then
     begin //����  ������ ������
      s:='$'+gszReceive[1]+gszReceive[2]+gszReceive[3]+gszReceive[4];

      //���������� 4 ����� hex ���������(������ ������ ">")
      Volt[Channel] := ConvertStrToRealVolt(s); //��������� �� ������ � �������� �����
      DataBuffer[Pos][Channel] := (Volt[Channel] + DataShift[Channel]) * Coefficient[Channel];
        // ������� ���������� �������� ����� � ������� ��������� � ������ ����.
        //DataShift - �������� ������ ���������
      end
     else begin
   //  Application.MessageBox(PChar('������ ��� ����������. '+IGetErrorString(retval)), 'Error', 1);
   // if ConnectToModul then PrepareModule;
      FCardFound:=False;
      retval:=MessageBox(Handle,PChar(IGetErrorString(retval)+' ����������� ������������ ��� ���?(��� ���������� ����� ��������)'),PChar('������ ����������� � ������'),MB_ICONINFORMATION+MB_OKCANCEL+MB_DEFBUTTON2+  MB_SYSTEMMODAL);//MB_SYSTEMMODAL
      if ((retval=1) or (retval=IDRETRY) or ( retval=IDYES)) then // ???? ?????? ?????? Yes
      begin
        FCardFound:=False;
        if ConnectToModul then PrepareModule; // ????????? ???? ? ????????? ?????????
      end;
    if ((retval=2)or(retval=IDABORT) or (retval=IDIGNORE)) then // ???? ?????? ?????? No
    begin
      DataThread.DataCollectingThread.Suspend;

    end;
     end;
      
end;

procedure TDataCollectingThread.Execute;
var i: Integer;
begin
    while (not Terminated) do
    begin
        for i := 0 to NumberOfChannels do
            if Active[i] then
                Refresh(i);
        Inc(Pos);
    end;
end;

procedure TDataCollectingThread.PrepareModule; // �������� � ��������� ������ + gw7000(������� � ������� �����,
// �������� ������, � �.�.)
// �������� ������ ������ �� hex � �������������� ����,
// type code = 8 (hex) - -10V .. +10V
// �� ������ ����� �������� "%AA080602" ,A - ������ ������ � hex
var
retval :Word;
wt : Word ; //���    Send_Receive_Cmd   //sAddr := IntToHex(StrToInt('$' + Address.Text),2);
                                        //StrCopy( gszSend , PChar('#' +IntToHex(StrToInt('$' + '01'),2)));
begin
if FCardFound then

    gdwBaudRate:=9600;
    retval:=IOpenCom(gcPort,gdwBaudRate);
     //gw7000[1]     ����
     //gw7000[1]   := $01;  //adress $01 ������
     gw7000[0]   := Word(gcPort);
    //  gw7000[1]   := gw7000_[1]; //adress $01 �� ���������, ���� ����� �������� - �������� init ����
     gw7000[2]   := $7019;  //modul  $7019   �� ���������, ���� ����� �������� - �������� init ����
     //gw7000[3] := 0;      // CheckSum disable    - �� ��������� ��� �����
     gw7000[4]   := 200;    // TimeOut Constant   �����������
     gw7000[6]   := 1;      // debug mode {  : ��� ������ debag-mode? }
     //{$Optimization Off}   //{  ������ ��� ������ }
     gszSend    := StrAlloc(128);
     gszReceive := StrAlloc(128);
//    StrCopy( gszSend , PChar('$012')) ; //$AA2[CHKSUM](CR)
                                          //$ Delimiter character
                                          //AA Address of the module to be read (00 to FF)
                                          //2 Command to read the module configuration
//    retval:= Send_Receive_Cmd(gcPort, gszSend, gszReceive, 100, 0, wT);
    StrCopy( gszSend , PChar('%' +IntToHex(gw7000[1],2)+IntToHex(gw7000[1],2)+'080602')); //���������� � gszSend ������� ��������� ������
          //% - ����������� ��� ���������
          // gw7000[1]  - ����� � ����� ������ ������  hex
          // 080602 :
          //08 - type code = 08 -> -10V..+10V
          //06 - baud rate = 06 -> 9600
          //02 - data format = 02 hex ������ � �������� ���������
    if retval=0 then
    retval:= Send_Receive_Cmd(gcPort, gszSend, gszReceive, 100, 0, wT); //���������� ��������� �� ������
    if retval<>0 then
    begin
       FCardFound := False;
       if(retval=15)then
          begin
            Application.MessageBox('������ �� �������� ������� �����, �������� �� ���������� � ������ ���������.', 'Error', 1);
          end else
          begin
            Application.MessageBox(PChar(IGetErrorString(retval)+' PrepareModule'), 'Error', 1);
          end;
      // Application.MessageBox('�������� ������ ��� ��������� ������.', 'Error', 1);
    end; //else Close_Com(gcPort);

end;

function TDataCollectingThread.ConvertStrToRealVolt(s:String ):Extended;
// ������� �� integer � �������� � �������
// �������� value ��� 0..65535 ��� -32768..+23767
var intValue: Integer;
const   maxValue=10.0;
minValue = -10.0;
begin
  intValue:=StrToInt(s);
  if ((intValue>=0) and (intValue<=32767 )) then
           Result:= intValue*maxValue/32767 // + 32768 - ���. ������������� ��������  value
  else  if  ((intValue>0) and (intValue<=65535)) then
    begin
        intValue:=-(intValue-32767);
        Result:= intValue*maxValue/32768;// - 32767 - ����. ������������� �������� value
    end
  else
    Application.MessageBox('������ � ��� �������� ����������� ��������� � �������� ��������, �������� ������� �� �������� [-32768..+32767] ', 'Error', 1);
end;



function TDataCollectingThread.ConnectToModul: Boolean;
// ����� ����� ������ � ����� ������� ������ ������� ������  SearchModuleAdress
// ����� ��� ����� ������������ � gcPort
// ������ ������������ � gw7000[1]
const comPortCout = 16;  //��������� ������ �� ��
var
  retval,errorcod :Word;
  adress: Word;
  PortNo: Integer;
  gcPortNo:Char;
begin
  IsConnected:=False;
  errorcod:=65533; //������ �� ��������� �����
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
        adress:= SearchModuleAdress(PortNo);
        if adress < 257 then
          begin
            gcPort:=gcPortNo;
            gw7000[0]:=Word(gcPortNo);
            gw7000[1] := adress;
            IsConnected:=true;
            Close_Com(gcPortNo);
            Result:= True;
            errorcod:=0;
            FCardFound:=True;
            Break;
          end;
      end
      else if retval < 24 then  errorcod:=retval;
      Close_Com(gcPortNo);
    end;
  except
    Application.MessageBox(PChar('ConnectToModul unknown'+IGetErrorString(retval)), 'Error', 1);
    FCardFound:=False;
  end;
  if errorcod <> 0 then
  begin

    //  Application.MessageBox(PChar('������ ��� ����������� ������.'+IGetErrorString(retval)),
    //                          'Error', 1);
       FCardFound:=False;
       retval:=MessageBox(Handle,PChar(IGetErrorString(retval)+' ����������� ������������ ��� ���?(��� ���������� ����� ��������)'),PChar('������ ����������� � ������'),MB_ICONINFORMATION+MB_OKCANCEL+MB_DEFBUTTON2+  MB_SYSTEMMODAL);
       if retval=1 then // ???? ?????? ?????? Yes
       begin
        FCardFound:=False;
        if ConnectToModul then PrepareModule; // ????????? ???? ? ????????? ?????????
        end;
        if retval=2 then // ???? ?????? ?????? No
      begin
        DataThread.DataCollectingThread.Suspend;  
      end;

  end;
end;

function TDataCollectingThread.SearchModuleAdress(portNo:Integer): Word;
//���� ������ ������, ���������� ���������
//���� ����� �� ������ ���������� 65535
const moduleNumber =  $256;  //���������� �������
var
  gcPortNo:Char;
  retval,wt :Word;
  moduleadress:Word;
begin
  Result := 65535;   //
  gcPortNo := Char(Portno);
//gdwBaudRate := 9600;
 // {$Optimization Off}   //{  : ������ ��� ������ }
  gszSend    := StrAlloc(128);
  gszReceive := StrAlloc(128);
  for moduleadress:=$1 to moduleNumber do  //adress $01 �� ���������, ���� ����� �������� - �������� init ����
     begin
        StrCopy( gszSend , PChar('$' +IntToHex(moduleadress,2)+'M')); //���������� � gszSend ������� ������ ����� ������
          //$AAM[CHKSUM](CR)
          //$ Delimiter character
          //AA Address of the module to be read (00 to FF)
          //M Command to read the module name
        retval:= Send_Receive_Cmd(gcPortNo, gszSend, gszReceive, 100, 0, wT);
        if(retval=0)  then
        begin
         // Response:
                  //Valid Response: !AA(Name)[CHKSUM](CR)  name=7019
                  //Invalid Response: ?AA[CHKSUM](CR)
                  //! Delimiter character for a valid response
                  //? Delimiter character for an invalid response
                  //AA Address of the responding module (00 to FF)
                  //(Name) A string showing the name of the module
                  //There will be no response if the command syntax is
                  //incorrect, there is a communication error, or there is no
                  //module with the specified address.
          if ((gszReceive[0]='!')
          and (gszReceive[3]='7')
          and (gszReceive[4]='0')
          and (gszReceive[5]='1')
          and (gszReceive[6]='9')
          and (gszReceive[7]='R'))then
            begin
                 Result:=moduleadress;
                 Break;
            end;
      end;
    end;
    StrDispose( gszSend );
    StrDispose( gszReceive );
end;

procedure TDataCollectingThread.ClosePort;
var i: Integer;
begin
  Close_Com(gcPort);
 // gcPort:=nil;
 // gw7000[0]:=0;
end;



destructor TDataCollectingThread.Destroy;
begin
  StrDispose( gszSend );
  StrDispose( gszReceive );
  Close_Com(gcPort);
end;

end.
