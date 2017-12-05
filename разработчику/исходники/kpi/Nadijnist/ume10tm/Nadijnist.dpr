program Nadijnist;

uses
  Forms,
  Main in 'Code\Main.pas' {FormMain},
  Start in 'Code\Start.pas' {HintStart: TCoolHint2KForm},
  FormSave in 'Code\FormSave.pas' {SaveForm},
  CommonTypes in '..\Components\Code\CommonTypes.pas',
  About in 'Code\About.pas' {AboutBox};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormMain,  FormMain);
  Application.CreateForm(THintStart, HintStart);
  Application.CreateForm(TSaveForm, SaveForm);
  Application.Run;
end.
