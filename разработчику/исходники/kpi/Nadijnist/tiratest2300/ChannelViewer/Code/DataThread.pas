unit DataThread;

interface
uses Classes, Forms, windows, SysUtils, Messages,Dialogs, Variants,  Graphics, Controls, StdCtrls;
const BufferSize = 5000;
      BaseAddress = $220;
      NumberOfChannels=3;//одно из 3 объявлений chanelviewer,datathread,start

type TDataCollectingThread = class(TThread)
private
   Buffer: array [1..BufferSize] of Single;
   FCardFound: Boolean;

   procedure Refresh(Channel: Integer);

   function ConvertStrToRealVolt(s:String):Extended;//преводит значение из инт в вольт

   function SearchModuleAdress(portNo:Integer): Word; //поиск адресса
public
   Active: array [0..NumberOfChannels] of Boolean;
   Volt:   array [0..NumberOfChannels] of Extended;
   Coefficient: array [0..NumberOfChannels] of Extended;
   DataShift: array [0..NumberOfChannels] of Extended;
   function ConnectToModul: Boolean;//ищет и открывает ком порт и адресс модуля 7019R
   procedure PrepareModule;   //открывает ком порт
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
    Pos: Integer;      //? счетчик оновлений данных(для всех канлов)
    IsConnected:Boolean;
(* 10 записей в секунду на 60 секунд на 60 минут на 24 часа *)

    DataBuffer: array[0..DataBufferLength] of TDataPack;

implementation
uses i7000,i7000u,Main;

constructor TDataCollectingThread.Create;   //открываем порт с устройством
var retval:Word;
begin
  //DataShift[0]:=0;
    FCardFound := True;

    if ConnectToModul then PrepareModule;
    inherited Create(False);
end;

procedure TDataCollectingThread.Refresh(Channel: Integer);
var //	Extended Тип с плавающей запятой обладающий самой высокой
                  // точностью и вместимостью
    retval :Word;
    s:String  ;

begin
   // if not FCardFound then Exit;    // если не ненайден блок
    gw7000[5] := Channel;   //Which Channel hex?

    retval := AnalogIn(@gw7000[0],@gf7000[0],gszSend,gszReceive);
     if retval=0 then
     begin //если  небыло ошибок
      s:='$'+gszReceive[1]+gszReceive[2]+gszReceive[3]+gszReceive[4];

      //записываем 4 байта hex показания(первый символ ">")
      Volt[Channel] := ConvertStrToRealVolt(s); //переводим из строку в значение вольт
      DataBuffer[Pos][Channel] := (Volt[Channel] + DataShift[Channel]) * Coefficient[Channel];
        // перевод полученого значения вольт в единицы измерения с учетом коэф.
        //DataShift - смещение начала координат
      end
     else begin
   //  Application.MessageBox(PChar('Ошибка при считывании. '+IGetErrorString(retval)), 'Error', 1);
   // if ConnectToModul then PrepareModule;
      FCardFound:=False;
      retval:=MessageBox(Handle,PChar(IGetErrorString(retval)+' Попробовать подключиться еще раз?(или считывание будет окончено)'),PChar('Ошибка подключения к модулю'),MB_ICONINFORMATION+MB_OKCANCEL+MB_DEFBUTTON2+  MB_SYSTEMMODAL);//MB_SYSTEMMODAL
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

procedure TDataCollectingThread.PrepareModule; // открытие и настройка модуля + gw7000(таблица с номером порта,
// адрессом модуля, и т.д.)
// поменять формат ответа на hex в дополнительном коде,
// type code = 8 (hex) - -10V .. +10V
// на модуль нужно передать "%AA080602" ,A - адресс модуля в hex
var
retval :Word;
wt : Word ; //для    Send_Receive_Cmd   //sAddr := IntToHex(StrToInt('$' + Address.Text),2);
                                        //StrCopy( gszSend , PChar('#' +IntToHex(StrToInt('$' + '01'),2)));
begin
if FCardFound then

    gdwBaudRate:=9600;
    retval:=IOpenCom(gcPort,gdwBaudRate);
     //gw7000[1]     порт
     //gw7000[1]   := $01;  //adress $01 ставит
     gw7000[0]   := Word(gcPort);
    //  gw7000[1]   := gw7000_[1]; //adress $01 по умолчанию, если нужно изменить - добавить init файл
     gw7000[2]   := $7019;  //modul  $7019   по умолчанию, если нужно изменить - добавить init файл
     //gw7000[3] := 0;      // CheckSum disable    - по умолчанию уже стоит
     gw7000[4]   := 200;    // TimeOut Constant   поумолчанию
     gw7000[6]   := 1;      // debug mode {  : что делаем debag-mode? }
     //{$Optimization Off}   //{  убрать при релизе }
     gszSend    := StrAlloc(128);
     gszReceive := StrAlloc(128);
//    StrCopy( gszSend , PChar('$012')) ; //$AA2[CHKSUM](CR)
                                          //$ Delimiter character
                                          //AA Address of the module to be read (00 to FF)
                                          //2 Command to read the module configuration
//    retval:= Send_Receive_Cmd(gcPort, gszSend, gszReceive, 100, 0, wT);
    StrCopy( gszSend , PChar('%' +IntToHex(gw7000[1],2)+IntToHex(gw7000[1],2)+'080602')); //записываем в gszSend команду настройки модуля
          //% - спецсимовол для настройки
          // gw7000[1]  - стрый и новый адресс модуля  hex
          // 080602 :
          //08 - type code = 08 -> -10V..+10V
          //06 - baud rate = 06 -> 9600
          //02 - data format = 02 hex формат в двоичном дополении
    if retval=0 then
    retval:= Send_Receive_Cmd(gcPort, gszSend, gszReceive, 100, 0, wT); //отправляем сообщение на модуль
    if retval<>0 then
    begin
       FCardFound := False;
       if(retval=15)then
          begin
            Application.MessageBox('Модуль не отвечает слишком долго, возможно он находиться в режиме настройки.', 'Error', 1);
          end else
          begin
            Application.MessageBox(PChar(IGetErrorString(retval)+' PrepareModule'), 'Error', 1);
          end;
      // Application.MessageBox('Возникла ошибка при настройке модуля.', 'Error', 1);
    end; //else Close_Com(gcPort);

end;

function TDataCollectingThread.ConvertStrToRealVolt(s:String ):Extended;
// перевод из integer в значение в вольтах
// диапазон value или 0..65535 или -32768..+23767
var intValue: Integer;
const   maxValue=10.0;
minValue = -10.0;
begin
  intValue:=StrToInt(s);
  if ((intValue>=0) and (intValue<=32767 )) then
           Result:= intValue*maxValue/32767 // + 32768 - мин. положительное значение  value
  else  if  ((intValue>0) and (intValue<=65535)) then
    begin
        intValue:=-(intValue-32767);
        Result:= intValue*maxValue/32768;// - 32767 - макс. положительное значение value
    end
  else
    Application.MessageBox('Ошибка в при переводе результатов измерения в реальные значения, параметр выходит за диапазон [-32768..+32767] ', 'Error', 1);
end;



function TDataCollectingThread.ConnectToModul: Boolean;
// поиск порта модуля и вызов функции поиска адресса модуля  SearchModuleAdress
// номер ком порта записывается в gcPort
// адресс записывается в gw7000[1]
const comPortCout = 16;  //количесто портов на пк
var
  retval,errorcod :Word;
  adress: Word;
  PortNo: Integer;
  gcPortNo:Char;
begin
  IsConnected:=False;
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

    //  Application.MessageBox(PChar('Ошибка при подключению модуля.'+IGetErrorString(retval)),
    //                          'Error', 1);
       FCardFound:=False;
       retval:=MessageBox(Handle,PChar(IGetErrorString(retval)+' Попробовать подключиться еще раз?(или считывание будет окончено)'),PChar('Ошибка подключения к модулю'),MB_ICONINFORMATION+MB_OKCANCEL+MB_DEFBUTTON2+  MB_SYSTEMMODAL);
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
//ищет адресс модуля, возвращает результат
//если адрес не найден возвращает 65535
const moduleNumber =  $256;  //количество модулей
var
  gcPortNo:Char;
  retval,wt :Word;
  moduleadress:Word;
begin
  Result := 65535;   //
  gcPortNo := Char(Portno);
//gdwBaudRate := 9600;
 // {$Optimization Off}   //{  : убрать при релизе }
  gszSend    := StrAlloc(128);
  gszReceive := StrAlloc(128);
  for moduleadress:=$1 to moduleNumber do  //adress $01 по умолчанию, если нужно изменить - добавить init файл
     begin
        StrCopy( gszSend , PChar('$' +IntToHex(moduleadress,2)+'M')); //записываем в gszSend команду чтения имени модуля
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
