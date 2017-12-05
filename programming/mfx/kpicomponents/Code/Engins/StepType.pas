unit StepType;

interface
uses Classes, CommonTypes;

type TTaskType = (ttPosition, ttCharge, ttWaitPos, ttWaitCharge);
const FastAccuracyHz   = 70;
      MiddleAccuracyHz = 50;
      SlowAccuracyHz   = 10;

      TraversaMmMin: array[0..4] of Extended = (50, 5, 0.5, 0.05, 0.005);
      StepsNumber = 25;

type TStep = class(TPersistent)
  private
    FIdealCruchenie: Extended;
    FIdealCharge: Extended;
    FActive: Boolean;
    FTimeMS: Cardinal;
    FPeremeshcenije: Extended;
    FGrad: Extended;
    FTaskType: TTaskType;
    FAccuracy: TTaskAccuracy;
    FCruchenijeCanWork: Boolean;
    FTraversaCanWork: Boolean;
    FBreakStepIntoNParts: Integer;
public
    Done: Boolean;
published
    property TaskType: TTaskType read FTaskType write FTaskType;
    property IdealCharge: Extended read FIdealCharge write FIdealCharge;
    property IdealCruchenie: Extended read FIdealCruchenie write FIdealCruchenie;

    property Grad: Extended read FGrad write FGrad;
    property Peremeshcenije: Extended read FPeremeshcenije write FPeremeshcenije;
    property TimeMS: Cardinal read FTimeMS write FTimeMS;
    property Active: Boolean read FActive write FActive;

    property Accuracy: TTaskAccuracy read FAccuracy write FAccuracy;
    property TraversaCanWork: Boolean read FTraversaCanWork write FTraversaCanWork;
    property CruchenijeCanWork: Boolean read FCruchenijeCanWork write FCruchenijeCanWork;
    property BreakStepIntoNParts: Integer read FBreakStepIntoNParts write FBreakStepIntoNParts;
end;

type TProcess = class(TPersistent)
private
    FStep7: TStep;
    FStep6: TStep;
    FStep5: TStep;
    FStep4: TStep;
    FStep1: TStep;
    FStep9: TStep;
    FStep8: TStep;
    FStep3: TStep;
    FStep2: TStep;
    FFirstStep: TStep;
    FLastStep: TStep;
    FStep11: TStep;
    FStep14: TStep;
    FStep15: TStep;
    FStep12: TStep;
    FStep13: TStep;
    FStep10: TStep;
    FStep16: TStep;
    FStep17: TStep;
    FStep20: TStep;
    FStep18: TStep;
    FStep19: TStep;
    FStep24: TStep;
    FStep25: TStep;
    FStep21: TStep;
    FStep22: TStep;
    FStep23: TStep;
    function GetSteps: Cardinal;
public
    Steps: array[1..StepsNumber] of TStep;
    property ActiveSteps: Cardinal read GetSteps;
published
    constructor Create;
    destructor  Destroy; override;
    property Step1: TStep read FStep1 write FStep1;
    property Step2: TStep read FStep2 write FStep2;
    property Step3: TStep read FStep3 write FStep3;
    property Step4: TStep read FStep4 write FStep4;
    property Step5: TStep read FStep5 write FStep5;
    property Step6: TStep read FStep6 write FStep6;
    property Step7: TStep read FStep7 write FStep7;
    property Step8: TStep read FStep8 write FStep8;
    property Step9: TStep read FStep9 write FStep9;
    property Step10: TStep read FStep10 write FStep10;
    property Step11: TStep read FStep11 write FStep11;
    property Step12: TStep read FStep12 write FStep12;
    property Step13: TStep read FStep13 write FStep13;
    property Step14: TStep read FStep14 write FStep14;
    property Step15: TStep read FStep15 write FStep15;
    property Step16: TStep read FStep16 write FStep16;
    property Step17: TStep read FStep17 write FStep17;
    property Step18: TStep read FStep18 write FStep18;
    property Step19: TStep read FStep19 write FStep19;
    property Step20: TStep read FStep20 write FStep20;
    property Step21: TStep read FStep21 write FStep21;
    property Step22: TStep read FStep22 write FStep22;
    property Step23: TStep read FStep23 write FStep23;
    property Step24: TStep read FStep24 write FStep24;
    property Step25: TStep read FStep25 write FStep25;
    property FirstStep: TStep read FFirstStep write FFirstStep;
    property LastStep: TStep  read FLastStep write FLastStep;
end;


implementation

{ TProcess }

constructor TProcess.Create;
begin
  inherited;
    FStep1 := TStep.Create; Steps[1] := FStep1;
    FStep2 := TStep.Create; Steps[2] := FStep2;
    FStep3 := TStep.Create; Steps[3] := FStep3;
    FStep4 := TStep.Create; Steps[4] := FStep4;
    FStep5 := TStep.Create; Steps[5] := FStep5;
    FStep6 := TStep.Create; Steps[6] := FStep6;
    FStep7 := TStep.Create; Steps[7] := FStep7;
    FStep8 := TStep.Create; Steps[8] := FStep8;
    FStep9 := TStep.Create; Steps[9] := FStep9;
    FStep10 := TStep.Create; Steps[10] := FStep10;
    FStep11 := TStep.Create; Steps[11] := FStep11;
    FStep12 := TStep.Create; Steps[12] := FStep12;
    FStep13 := TStep.Create; Steps[13] := FStep13;
    FStep14 := TStep.Create; Steps[14] := FStep14;
    FStep15 := TStep.Create; Steps[15] := FStep15;
    FStep16 := TStep.Create; Steps[16] := FStep16;
    FStep17 := TStep.Create; Steps[17] := FStep17;
    FStep18 := TStep.Create; Steps[18] := FStep18;
    FStep19 := TStep.Create; Steps[19] := FStep19;
    FStep20 := TStep.Create; Steps[20] := FStep20;
    FStep21 := TStep.Create; Steps[21] := FStep21;
    FStep22 := TStep.Create; Steps[22] := FStep22;
    FStep23 := TStep.Create; Steps[23] := FStep23;
    FStep24 := TStep.Create; Steps[24] := FStep24;
    FStep25 := TStep.Create; Steps[25] := FStep25;
    FFirstStep := TStep.Create;
    FLastStep := TStep.Create;
end;

destructor TProcess.Destroy;
begin
    FStep1.Free;
    FStep2.Free;
    FStep3.Free;
    FStep4.Free;
    FStep5.Free;
    FStep6.Free;
    FStep7.Free;
    FStep8.Free;
    FStep9.Free;
    FStep10.Free;
    FStep11.Free;
    FStep12.Free;
    FStep13.Free;
    FStep14.Free;
    FStep15.Free;
    FStep16.Free;
    FStep17.Free;
    FStep18.Free;
    FStep19.Free;
    FStep20.Free;
    FStep21.Free;
    FStep22.Free;
    FStep23.Free;
    FStep24.Free;
    FStep25.Free;
    FFirstStep.Free;
    FLastStep.Free;
  inherited;
end;

function TProcess.GetSteps: Cardinal;
begin
  for Result := 0 to StepsNumber - 1 do if not Steps[Result + 1].Active then Exit;
end;

end.
