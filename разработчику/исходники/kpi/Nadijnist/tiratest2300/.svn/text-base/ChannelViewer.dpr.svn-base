program ChannelViewer;

uses
  Forms,
  Windows,
  SysUtils,
  Main in 'Code\Main.pas' {FormMain},
  Splash in 'Code\Splash.pas' {FormSplash},
  Start in 'Code\Start.pas' {FormStart},
  DataThread in 'Code\DataThread.pas',
  BufferedImageForChannelViewer in 'Code\BufferedImageForChannelViewer.pas',
  ProgressBarForm in 'Code\ProgressBarForm.pas' {FormProgressBar};

{$R *.RES}
var StartTime: TDateTime;
    i: Integer;
const OneSecond = 0.00001;
begin
  FormSplash := TFormSplash.Create(Application);
  FormSplash.WindowState := wsNormal;
  FormSplash.Show;
  FormSplash.Update;
  StartTime := Now;

  Application.Initialize;
  Application.CreateForm(TFormMain, FormMain);
  while Now - StartTime < OneSecond * 2 do Application.ProcessMessages;
  FormSplash.Hide;
  FormSplash.Free;

  FormStart  := TFormStart.Create(Application);
  FormStart.ShowModal;
  FormStart.Free;

  DataThread.DataCollectingThread := TDataCollectingThread.Create;
  DataThread.DataCollectingThread.FreeOnTerminate := True;

  FormMain.CurrentLine := 1;
  FormMain.ClearStringGrid;
  for i := 0 to 15 do
  begin
      DataThread.DataCollectingThread.Active[i]      := Start.Channels[i].Active;
      DataThread.DataCollectingThread.Coefficient[i] := Start.Channels[i].Coefficient;
  end;

  FormMain.Timer.Enabled := True;
  FormMain.Graph.TimerEnabled := True;

  Application.Run;
end.
