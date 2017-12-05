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
  ProgressBarForm in 'Code\ProgressBarForm.pas' {FormProgressBar},
  I7000 in 'Code\I7000.pas',
  I7000u in 'Code\I7000u.pas';

{$R *.RES}
var StartTime: TDateTime;
    i: Integer;
const OneSecond = 0.00001;  NumberOfChannels=3; //одно из 3 объ€влений chanelviewer,datathread,start

begin
 SetThreadLocale(1049);
  FormSplash := TFormSplash.Create(Application);
  FormSplash.WindowState := wsNormal;
  FormSplash.Show;
  FormSplash.Update;
  StartTime := Now;

  Application.Initialize;
  Application.Title := 'ChannelViewer';
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
  for i := 0 to NumberOfChannels do
  begin
      DataThread.DataCollectingThread.Active[i]      := Start.Channels[i].Active;
      DataThread.DataCollectingThread.Coefficient[i] := Start.Channels[i].Coefficient;
  end;

  FormMain.Timer.Enabled := True;
  FormMain.Graph.TimerEnabled := True;

  Application.Run;
end.
