unit A812;

interface

type PSingle=^Single;
     PWord=^Word;
     PInteger=^Integer;

Const
//***************** DEFINE A812 RELATIVE ADDRESS *****************/
 A812_TIMER0          =  $00;
 A812_TIMER1          =  $01;
 A812_TIMER2          =  $02;
 A812_TIMER_MODE      =  $03;
 A812_AD_LO           =  $04;    //* Analog to Digital, Low Byte */
 A812_AD_HI           =  $05;    //* Analog to Digital, High Byte */
 A812_DA_CH0_LO       =  $04;    //* Digit to Analog, CH 0 */
 A812_DA_CH0_HI       =  $05;
 A812_DA_CH1_LO       =  $06;    //* Digit to Analog, CH 1 */
 A812_DA_CH1_HI       =  $07;
 A812_DI_LO           =  $06;    //* Digit Input */
 A812_DO_LO           =  $0D;    //* Digit Output */

 A812_CLEAR_IRQ       =  $08;
 A812_SET_GAIN        =  $09;
 A812_SET_CH          =  $0A;
 A812_SET_MODE        =  $0B;
 A812_SOFT_TRIG       =  $0C;

 A812_POLLING_MODE    =  1;
 A812_DMA_MODE        =  2;
 A812_INTERRUPT_MODE  =  6;

//*** define the gain mode ***/
 A812_BI_1			=0;
 A812_BI_2			=1;
 A812_BI_4			=2;
 A812_BI_8			=3;
 A812_BI_16			=4;

 A812_NoError 			=0;
 A812_DriverOpenError	    	=1;
 A812_DriverNoOpen		=2;
 A812_GetDriverVersionError	=3;
 A812_InstallIrqError		=4;
 A812_ClearIntCountError	=5;
 A812_GetIntCountError		=6;
 A812_GetBufferError		=7;
 A812_AdError1			=100;
 A812_AdError2			=-200.0;
 A812_InstallBufError		=10;
 A812_AllocateMemoryError	=11;
 A812_TimeoutError		=$ffff;
 A812_OtherError		=13;

// Function of Test
Function  A812_SHORT_SUB_2(nA, nB : SmallInt):SmallInt; StdCall;
Function  A812_FLOAT_SUB_2(fA, fB : Single):Single; StdCall;
Function  A812_Get_DLL_Version:WORD; StdCall;
Function  A812_GetDriverVersion(var wDriverVersion:WORD):Word; StdCall;

// Function of DI/DO
Procedure A812_DO(wBase, wHexValue:Word); StdCall;
Function  A812_DI(wBase:Word):Word; StdCall;
Function  A812_InputByte(wPortAddr:WORD):WORD; StdCall;
Function  A812_InputWord(wPortAddr:WORD):WORD; StdCall;
Procedure A812_OutputByte(wPortAddr:WORD; bOutputVal:Byte); StdCall;
Procedure A812_OutputWord(wPortAddr:WORD; wOutputVal:WORD); StdCall;

// Function of AD/DA
Function  A812_AD_Hex(wBase,wChannel,wGainCode:WORD):WORD; StdCall;
Function  A812_ADs_Hex(wBase,wChannel,wGainCode:WORD; wBuf:PWord; wCount:WORD):WORD; StdCall;
Function  A812_AD_Float(wBase,wChannel,wGainCode,wJump10v:WORD):Single; StdCall;
Function  A812_ADs_Float(wBase,wChannel,wGainCode,wJump10v:WORD; fBuf:PSingle; wCount:WORD):WORD; StdCall;
Function  A812_AD2F(wHex,wGainCode,wJump10v:WORD):Single; StdCall;
Procedure A812_DA(wBase, wChannel, wHexValue:WORD); StdCall;
Procedure A812_Uni5_DA(wBase,wChannel:Word;fValue:Single); StdCall;
Procedure A812_Uni10_DA(wBase,wChannel:Word;fValue:Single); StdCall;

// Function of Driver	
Function  A812_DELAY(wBase,wDownCount:WORD):WORD; StdCall;
Function  A812_Check_Address(wBase:WORD):WORD; StdCall;
Function  A812_DriverInit:WORD; StdCall;
Procedure A812_DriverClose; StdCall;

// Function of Interrupt
Function  A812_Int_Install(wBase,wIrq:WORD; dwCount:LongInt):WORD; StdCall;
Function  A812_Int_Start(wChannel,wGainCode,wJump10v,wCounter1,wCounter2:WORD):WORD; StdCall;
Function  A812_Int_Remove:WORD; StdCall;
Function  A812_Int_GetCount(var dwVal:LongInt):WORD; StdCall;
Function  A812_Int_GetBuffer(dwNum:LongInt; wBuffer:PWord):WORD; StdCall;
Function  A812_Int_GetFloatBuffer(dwNum:LongInt; fBuffer:PSingle):WORD; StdCall;

implementation

Function  A812_SHORT_SUB_2;          	external 'A812.DLL' name 'A812_SHORT_SUB_2';
Function  A812_FLOAT_SUB_2;          	external 'A812.DLL' name 'A812_FLOAT_SUB_2';
Function  A812_Get_DLL_Version; 	external 'A812.DLL' name 'A812_Get_DLL_Version';
Function  A812_GetDriverVersion;   	external 'A812.DLL' name 'A812_GetDriverVersion';

Procedure A812_DO;          		external 'A812.DLL' name 'A812_DO';
Function  A812_DI;          		external 'A812.DLL' name 'A812_DI';
Procedure A812_OutputByte;   		external 'A812.DLL' name 'A812_OutputByte';
Procedure A812_OutputWord;   		external 'A812.DLL' name 'A812_OutputWord';
Function  A812_InputByte;   		external 'A812.DLL' name 'A812_InputByte';
Function  A812_InputWord;   		external 'A812.DLL' name 'A812_InputWord';

Function  A812_AD_Hex;       		external 'A812.DLL' name 'A812_AD_Hex';
Function  A812_ADs_Hex;         	external 'A812.DLL' name 'A812_ADs_Hex';
Function  A812_AD_Float;       		external 'A812.DLL' name 'A812_AD_Float';
Function  A812_ADs_Float;       	external 'A812.DLL' name 'A812_ADs_Float';
Function  A812_AD2F;       		external 'A812.DLL' name 'A812_AD2F';
Procedure A812_DA;          		external 'A812.DLL' name 'A812_DA';
Procedure A812_Uni5_DA;        		external 'A812.DLL' name 'A812_Uni5_DA';
Procedure A812_Uni10_DA;       		external 'A812.DLL' name 'A812_Uni10_DA';

Function  A812_DriverInit;         	external 'A812.DLL' name 'A812_DriverInit';
Procedure A812_DriverClose;        	external 'A812.DLL' name 'A812_DriverClose';
Function  A812_DELAY;           	external 'A812.DLL' name 'A812_DELAY';
Function  A812_Check_Address;   	external 'A812.DLL' name 'A812_Check_Address';

Function  A812_Int_Install;      	external 'A812.DLL' name 'A812_Int_Install';
Function  A812_Int_Start;    		external 'A812.DLL' name 'A812_Int_Start';
Function  A812_Int_Remove;     		external 'A812.DLL' name 'A812_Int_Remove';
Function  A812_Int_GetCount;     	external 'A812.DLL' name 'A812_Int_GetCount';
Function  A812_Int_GetBuffer;       	external 'A812.DLL' name 'A812_Int_GetBuffer';
Function  A812_Int_GetFloatBuffer;      external 'A812.DLL' name 'A812_Int_GetFloatBuffer';


end.

