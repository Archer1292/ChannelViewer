unit Splash;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  jpeg, ExtCtrls, StdCtrls;

type
  TFormSplash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSplash: TFormSplash;

implementation

{$R *.DFM}

end.
