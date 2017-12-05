unit I7000;

interface

type PSingle=^Single;
type PWord=^Word;

//Declare interface of UART.DLL
function Open_Com(cPort:Char; dwBaudRate:LongInt; cData:Char; cParity:Char; cStop:Char): Word;	StdCall;
function Close_Com(cPort:Char): Word;	StdCall;
function Read_Com_Status(cPort:Char; szRec:PChar; var wT:Word): Word; StdCall;
function Send_Cmd(cPort:Char; szCmd:PChar; wTimeOut:Word; wCheckSum:Word): Word;	StdCall;
function Send_Str(cPort:Char; szSend:PChar; wTimeOut:Word; wLenT,wLenR:Word): Word; StdCall;
function Send_Receive_Cmd(cPort:Char; szCmd,szResult:PChar; wTimeOut,wChkSum:Word; var wT:Word): Word; StdCall;

//Declare interface of I7000.DLL
function Short_Sub_2(nA: smallint; nB: smallint): smallint;  StdCall;
function Float_Sub_2(fA: single;   fB: single):   single;    StdCall;
function Get_Dll_Version: Word; StdCall;
function Test(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadConfigStatus(w7000:PWord; f7000:PSingle; szSend,szReceive:PChar): Word; StdCall;
function AnalogIn(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function AnalogInFsr(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function AnalogInHex(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function AnalogIn8(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function In8_7017(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function AnalogOut(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function AnalogOutReadBack(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function DigitalOut(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function DigitalOutReadBack(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function DigitalIn(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ThermocoupleOpen_7011(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function EnableAlarm(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function DisableAlarm(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ClearLatchAlarm(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetAlarmLimitValue(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadAlarmLimitValue(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadOutputAlarmState(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadEventCounter(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ClearEventCounter(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function CounterIn_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadCounterMaxValue_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetCounterMaxValue_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar; MaxValue:Double): Word; StdCall;
function ReadAlarmLimitValue_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetAlarmLimitValue_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar; MaxValue:Double): Word; StdCall;
function EnableCounterAlarm_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function DisableCounterAlarm_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function EnableCounterAlarm_7080D(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function DisableCounterAlarm_7080D(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadCounterStatus_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ClearCounter_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadOutputAlarmState_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetInputSignalMode_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadInputSignalMode_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function PresetCounterValue_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar; PresetValue:Double): Word; StdCall;
function ReadPresetCounterValue_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function StartCounting_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetModuleMode_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadModuleMode_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetLevelVolt_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadLevelVolt_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetMinSignalWidth_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar; MinWidth:LongInt): Word; StdCall;
function ReadMinSignalWidth_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetGateMode_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function ReadGateMode_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function DataToLED_7080(w7000:PWord; f7000:PSingle; szSend:PChar; szReceive:PChar): Word; StdCall;
function SetConfiguration_7080(w7000:PWord; f7000:PSingle; szSendTo7000:PChar; szReceiveFrom7000:PChar):Word; StdCall;


implementation

//Declare implementation of UART.DLL
function Open_Com;                    external 'UART.DLL'  name 'Open_Com';
function Close_Com;                   external 'UART.DLL'  name 'Close_Com';
function Read_Com_Status;             external 'UART.DLL'  name 'Read_Com_Status';
function Send_Cmd;                    external 'UART.DLL'  name 'Send_Cmd';
function Send_Str;                    external 'UART.DLL'  name 'Send_Str';
function Send_Receive_Cmd;            external 'UART.DLL'  name 'Send_Receive_Cmd';

//Declare implementation of I7000.DLL
function Short_Sub_2;                 external 'I7000.DLL' name 'Short_Sub_2';
function Float_Sub_2;                 external 'I7000.DLL' name 'Float_Sub_2';
function Get_Dll_Version;             external 'I7000.DLL' name 'Get_Dll_Version';
function Test;                        external 'I7000.DLL' name 'Test';
function ReadConfigStatus;            external 'I7000.DLL' name 'ReadConfigStatus';
function AnalogIn;                    external 'I7000.DLL' name 'AnalogIn';
function AnalogInFsr;                 external 'I7000.DLL' name 'AnalogInFsr';
function AnalogInHex;                 external 'I7000.DLL' name 'AnalogInHex';
function AnalogIn8;                   external 'I7000.DLL' name 'AnalogIn8';
function In8_7017;                    external 'I7000.DLL' name 'In8_7017';
function AnalogOut;                   external 'I7000.DLL' name 'AnalogOut';
function AnalogOutReadBack;           external 'I7000.DLL' name 'AnalogOutReadBack';
function DigitalOut;                  external 'I7000.DLL' name 'DigitalOut';
function DigitalOutReadBack;          external 'I7000.DLL' name 'DigitalOutReadBack';
function DigitalIn;                   external 'I7000.DLL' name 'DigitalIn';
function ThermocoupleOpen_7011;       external 'I7000.DLL' name 'ThermocoupleOpen_7011';
function EnableAlarm;                 external 'I7000.DLL' name 'EnableAlarm';
function DisableAlarm;                external 'I7000.DLL' name 'EnableAlarm';
function ClearLatchAlarm;             external 'I7000.DLL' name 'ClearLatchAlarm';
function SetAlarmLimitValue;          external 'I7000.DLL' name 'SetAlarmLimitValue';
function ReadAlarmLimitValue;         external 'I7000.DLL' name 'ReadAlarmLimitValue';
function ReadOutputAlarmState;        external 'I7000.DLL' name 'ReadOutputAlarmState';
function ReadEventCounter;            external 'I7000.DLL' name 'ReadEventCounter';
function ClearEventCounter;           external 'I7000.DLL' name 'ClearEventCounter';
function CounterIn_7080;              external 'I7000.DLL' name 'CounterIn_7080';
function ReadCounterMaxValue_7080;    external 'I7000.DLL' name 'ReadCounterMaxValue_7080';
function SetCounterMaxValue_7080;     external 'I7000.DLL' name 'SetCounterMaxValue_7080';
function ReadAlarmLimitValue_7080;    external 'I7000.DLL' name 'ReadAlarmLimitValue_7080';
function SetAlarmLimitValue_7080;     external 'I7000.DLL' name 'SetAlarmLimitValue_7080';
function EnableCounterAlarm_7080;     external 'I7000.DLL' name 'EnableCounterAlarm_7080';
function DisableCounterAlarm_7080;    external 'I7000.DLL' name 'DisableCounterAlarm_7080';
function EnableCounterAlarm_7080D;    external 'I7000.DLL' name 'EnableCounterAlarm_7080D';
function DisableCounterAlarm_7080D;   external 'I7000.DLL' name 'DisableCounterAlarm_7080D';
function ReadCounterStatus_7080;      external 'I7000.DLL' name 'ReadCounterStatus_7080';
function ClearCounter_7080;           external 'I7000.DLL' name 'ClearCounter_7080';
function ReadOutputAlarmState_7080;   external 'I7000.DLL' name 'ReadOutputAlarmState_7080';
function SetInputSignalMode_7080;     external 'I7000.DLL' name 'SetInputSignalMode_7080';
function ReadInputSignalMode_7080;    external 'I7000.DLL' name 'ReadInputSignalMode_7080';
function PresetCounterValue_7080;     external 'I7000.DLL' name 'PresetCounterValue_7080';
function ReadPresetCounterValue_7080; external 'I7000.DLL' name 'ReadPresetCounterValue_7080';
function StartCounting_7080;          external 'I7000.DLL' name 'StartCounting_7080';
function SetModuleMode_7080;          external 'I7000.DLL' name 'SetModuleMode_7080';
function ReadModuleMode_7080;         external 'I7000.DLL' name 'ReadModuleMode_7080';
function SetLevelVolt_7080;           external 'I7000.DLL' name 'SetLevelVolt_7080';
function ReadLevelVolt_7080;          external 'I7000.DLL' name 'ReadLevelVolt_7080';
function SetMinSignalWidth_7080;      external 'I7000.DLL' name 'SetMinSignalWidth_7080';
function ReadMinSignalWidth_7080;     external 'I7000.DLL' name 'ReadMinSignalWidth_7080';
function SetGateMode_7080;            external 'I7000.DLL' name 'SetGateMode_7080';
function ReadGateMode_7080;           external 'I7000.DLL' name 'ReadGateMode_7080';
function DataToLED_7080;              external 'I7000.DLL' name 'DataToLED_7080';
function SetConfiguration_7080;       external 'I7000.DLL' name 'SetConfiguration_7080';

end.

