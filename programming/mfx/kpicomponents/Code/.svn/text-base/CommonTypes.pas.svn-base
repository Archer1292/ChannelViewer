unit CommonTypes;
interface
uses Windows, Sysutils, Classes, Dialogs;

const //OneSecond    = 0.00001;
      OneSecond      = 0.000011568287;
      OneMillisecond = OneSecond / 1000;


type TObjectProcedure = procedure of object;
type TTaskType = (ttPosition, ttCharge, ttWaitPos, ttWaitCharge);
type TNagrugenije = (Slognoje, Ciklicheskoje);
     TRegim = (Mjagkij, Gestkij);
     TTrajectory = (tr1, tr2, tr3, tr4);
     TTaskAccuracy = (taSlow, taMiddle, taFast, taTraversaSlow, taTraversaMiddle, taTraversaFast, taTimeMS);

type TThreadSupport = class(TThread)
private
  FProc: TObjectProcedure;
protected
  procedure Execute; override;
public
  Act: Boolean;
  constructor Create(Proc: TObjectProcedure);
  property Terminated;
end;
//-----------------------------------------------------------------------------
type PMyList = ^AList;
     AList = record
        P: TObjectProcedure;
        C: Pointer;
     end;

type TLinkHolder = class(TComponent)
protected
  Users: TList;
public
  constructor Create(AOwner: TComponent); override;
  destructor  Destroy; override;
  procedure   AddUser(UserProc: TObjectProcedure; var User: TLinkHolder); overload;
  procedure   AddUser(var User: TLinkHolder); overload;
  procedure   DeleteUser(var User: TLinkHolder);
end;
//-----------------------------------------------------------------------------

type TThreadHolder = class(TLinkHolder)
private
  procedure SetAct(const Value: Boolean);
  function  GetPriority: TThreadPriority;
  procedure SetPriority(const Value: TThreadPriority);
protected
  Thread: TThreadSupport;
  procedure Proc; virtual; abstract;
public
  procedure Run;
  procedure Pause;
  constructor Create(AOwner: TComponent); override;
  destructor  Destroy; override;
  property Act: Boolean write SetAct;
  property Priority: TThreadPriority read GetPriority write SetPriority;
end;
//-----------------------------------------------------------------------------

function HexToCardinal(S: String): Cardinal;
function ExtToStr(Number: Extended; Accuracy: Cardinal = 3): String;
procedure Wait(ms: Cardinal);

















implementation

procedure Wait(ms: Cardinal);
var st: TDateTime;
begin
  st := Now;
  while (Now - st < ms * OneMillisecond) do Sleep(0);
end;

function  ExtToStr(Number: Extended; Accuracy: Cardinal = 3): String;
begin
  Result := FloatToStrF(Number, ffFixed, 7, Accuracy);
end;

function HexToCardinal(S: String): Cardinal;
var i, n, m: Cardinal;
begin
    Result := 0; n := 1;
    S := UpperCase(S);
    for i := Length(S) downto 1 do
    begin
        case S[i] of
            'A'..'F': m := 10 + Ord(S[i]) - Ord('A');
            '0'..'9': m := Ord(S[i]) - Ord('0');
        else raise EConvertError.Create('Ошибка преобразования шестнадцатеричного числа в десятичное.');
        end;
        Result := Result + n * m;
        n := n * 16;
    end;
end;

{ TThreadSupport }

constructor TThreadSupport.Create(Proc: TObjectProcedure);
begin
  Act := False;
  FProc := Proc;
  inherited Create(True);
  FreeOnTerminate := True;
end;

procedure TThreadSupport.Execute;
begin
  while not Terminated do
      if Act then if Assigned(FProc) then
      try
        FProc;
      except
      end;
end;

{ TThreadHolder }

constructor TThreadHolder.Create(AOwner: TComponent);
begin
  inherited;
  if csDesigning in ComponentState then Exit;
  Thread := TThreadSupport.Create(Proc);
end;

destructor TThreadHolder.Destroy;
begin
  if not (csDesigning in ComponentState) then
  begin
    Thread.Act := False;
    Thread.Resume;
    Thread.Terminate;
    Thread.WaitFor;
  end;
  inherited;
end;

function TThreadHolder.GetPriority: TThreadPriority;
begin
  Result := Thread.Priority;
end;

procedure TThreadHolder.SetAct(const Value: Boolean);
begin
  if csDesigning in ComponentState then Exit;
  Thread.Act := Value;
end;

procedure TThreadHolder.SetPriority(const Value: TThreadPriority);
begin
  Thread.Priority := Value;
end;

procedure TThreadHolder.Run;
begin
   Thread.Resume;
end;

procedure TThreadHolder.Pause;
begin
   Thread.Suspend;
end;

{ TLinkHolder }

procedure TLinkHolder.AddUser(UserProc: TObjectProcedure;
  var User: TLinkHolder);
var ARecord: PMyList;
begin
    New(ARecord);
    ARecord^.P := UserProc;
    ARecord^.C := @User;
    Users.Add(ARecord);
    User := Self;
end;

procedure TLinkHolder.AddUser(var User: TLinkHolder);
var ARecord: PMyList;
begin
    New(ARecord);
    ARecord^.C := @User;
    Users.Add(ARecord);
    User := Self;
end;

constructor TLinkHolder.Create(AOwner: TComponent);
begin
  inherited;
  Users := TList.Create;
end;

procedure TLinkHolder.DeleteUser(var User: TLinkHolder);
var i: Integer;
begin
  for i := 0 to Users.Count - 1 do
    if PMyList(Users.Items[i])^.C = @User then
            Users.Delete(i);
end;

destructor TLinkHolder.Destroy;
var i: Integer;
begin
  for i := 0 to Users.Count - 1 do
    TLinkHolder(PMyList(Users.Items[i])^.C^) := nil;
  Users.Free;
  inherited;
end;

end.




