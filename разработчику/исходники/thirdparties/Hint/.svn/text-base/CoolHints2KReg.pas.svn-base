{

  CoolHints2k registration module.

}

{$IFNDEF VER90}
  {$IFNDEF VER100}
    {$IFNDEF VER120}
      {$IFNDEF VER130}
          {$IFDEF VER110}
            {$ObjExportAll On}
            {$Define ver100}
          {$ELSE}
            {$IFDEF VER125}
              {$Define ver120}
            {$ELSE}
              {$Define ver90}
            {$ENDIF}
          {$ENDIF}
      {$ELSE}
        {$IFNDEF BCB}
          {$Define Delphi}
        {$ENDIF}
        {$Define ver120}
      {$ENDIF}
    {$ELSE}
      {$Define Delphi}
    {$ENDIF}
  {$ELSE}
    {$Define Delphi}
  {$ENDIF}
{$ELSE}
  {$Define Delphi}
{$ENDIF}

{$D-,L-,Y-}
unit CoolHints2KReg;

interface

uses
  Windows, Classes, Forms, Controls, DsgnIntf, ExptIntf, TypInfo, ToolIntf,
  EditIntf, VirtIntf, {$IFDEF VER120}{$IFDEF Delphi}ToolsApi, {$ENDIF}{$ENDIF} SysUtils, Dialogs,
  ExtCtrls, StdCtrls, Graphics;

type
  {TCoolHint2KFormExpert}
  TCoolHint2KFormExpert = class(TIExpert)
  private
    procedure RunExpert(ToolServices: TIToolServices);
  public
    function GetName: string; override;
    function GetComment: string; override;
    function GetGlyph: HICON; override;
    function GetStyle: TExpertStyle; override;
    function GetState: TExpertState; override;
    function GetIDString: string; override;
    function GetAuthor: string; override;
    function GetPage: string; override;
    function GetMenuText: string; override;
    procedure Execute; override;
  end;

  {TCoolHint2KFormCreator}
  {$IFDEF VER120}
  TCoolHint2KFormCreator = class(TIModuleCreatorEx)
  {$ELSE}
  TCoolHint2KFormCreator = class(TIModuleCreator)
  {$ENDIF}
  private
    FClass : string;
  public
    function Existing: Boolean; override;
    function GetAncestorName: string; override;
    function GetFileName: string; override;
    function GetFileSystem: string; override;
    function GetFormName: string; override;
    {$IFDEF VER120}
    function GetIntfName: string; override;
    function NewIntfSource(const UnitIdent, FormIdent,
      AncestorIdent: string): string; override;
    function NewModuleSource(const UnitIdent, FormIdent,
      AncestorIdent: string): string; override;
    {$ELSE}
    {$IFDEF Delphi}
    function NewModuleSource(UnitIdent, FormIdent,
      AncestorIdent: string): string; override;
    {$ELSE}
    function NewModuleSource(const UnitIdent, FormIdent,
      AncestorIdent: string): string; override;
    {$ENDIF}
    {$ENDIF}
    procedure FormCreated(Form: TIFormInterface); override;
  end;

  {TCHAboutProperty}
  TCHAboutProperty = class(TClassProperty)
  public
    procedure Edit; override;
    function GetAttributes: TPropertyAttributes; override;
    function GetValue: string; override;
    {$IFDEF VER130}
    procedure PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean); override;
    {$ENDIF}
  end;

procedure Register;

implementation

uses
  CoolHints2K;

{TCoolHint2KFormCreator}
function TCoolHint2KFormCreator.Existing: Boolean;
begin
  Result := False;
end;

function TCoolHint2KFormCreator.GetAncestorName: string;
begin
  Result := 'CoolHint2KForm';
end;

function TCoolHint2KFormCreator.GetFileName: string;
begin
  Result := '';
end;

function TCoolHint2KFormCreator.GetFileSystem: string;
begin
  Result := '';
end;

function TCoolHint2KFormCreator.GetFormName: string;
begin
  Result := FClass;
end;

{$IFDEF VER120}
function TCoolHint2KFormCreator.GetIntfName: string;
begin
  Result := '';
end;

function TCoolHint2KFormCreator.NewIntfSource(const UnitIdent, FormIdent, AncestorIdent: string): string;
const
  CRLF = #13#10;
begin
  {$IFDEF Delphi}
  Result := '';
  {$ELSE}
  Result :=  '//----------------------------------------------------------------------------'+CRLF;
  Result :=  Result + '#ifndef ' + UnitIdent + 'H'+CRLF;
  Result :=  Result + '#define ' + UnitIdent + 'H'+CRLF;
  Result :=  Result + '//----------------------------------------------------------------------------'+CRLF;
  Result :=  Result + '#include <Classes.hpp>'+CRLF;
  Result :=  Result + '#include <Controls.hpp>'+CRLF;
  Result :=  Result + '#include <StdCtrls.hpp>'+CRLF;
  Result :=  Result + '#include <Forms.hpp>'+CRLF;
  Result :=  Result + '#include <CoolHints2k.hpp>'+CRLF;
  Result :=  Result + '//----------------------------------------------------------------------------'+CRLF;
  Result :=  Result + 'class T' + FormIdent + ' : public T' + AncestorIdent +CRLF;
  Result :=  Result + '{'+CRLF;
  Result :=  Result + '__published:'+CRLF;
  Result :=  Result + 'private:'+CRLF;
  Result :=  Result + 'public:'+CRLF;
  Result :=  Result + '   __fastcall T' + FormIdent + '(TComponent* Owner);'+CRLF;
  Result :=  Result + '};'+CRLF;
  Result :=  Result + '//----------------------------------------------------------------------------'+CRLF;
  Result :=  Result + 'extern PACKAGE T' + FormIdent + ' *' + FormIdent + ';'+CRLF;
  Result :=  Result + '//----------------------------------------------------------------------------'+CRLF;
  Result :=  Result + '#endif '+CRLF;
  {$ENDIF}
end;

function TCoolHint2KFormCreator.NewModuleSource(const UnitIdent, FormIdent, AncestorIdent: string): string;
{$ELSE}
{$IFDEF Delphi}
function TCoolHint2KFormCreator.NewModuleSource(UnitIdent, FormIdent, AncestorIdent: string): string;
{$ELSE}
function TCoolHint2KFormCreator.NewModuleSource(const UnitIdent, FormIdent, AncestorIdent: string): string;
{$ENDIF}
{$ENDIF}
const
  CRLF = #13#10;
  CRLF2 = #13#10#13#10;
begin
  FClass := AncestorIdent;

  {$IFDEF Delphi}
  Result := '{TCoolHint2KForm is window class for CoolHints2k package...}'  +CRLF2;
  Result := Result+'unit '+UnitIdent+';'+CRLF2+
    'interface'+CRLF2+
    'uses'+CRLF+
    '  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,'+CRLF+
    '  ExtCtrls, CoolHints2K;'+CRLF2+
    'type'+CRLF;
    Result := Result+'  T'+FormIdent;
    Result := Result+' = class(TCoolHint2KForm)'+CRLF+
      '  private'+CRLF+
      '    { Private declarations }'+CRLF+
      '  public'+CRLF+
      '    { Public declarations }'+CRLF+
      '  end;'+CRLF2;
      Result := Result+'var '+CRLF+ '  ' + FormIdent+': T'+FormIdent+';'+CRLF2;
    Result := Result+
      'implementation'+CRLF2+
      '{$R *.DFM}'+CRLF2;
    Result := Result+
      'end.'+CRLF;
  {$ELSE}
  Result :=  '//TCoolHint2KForm is window class for CoolHints2K package...'  +CRLF;
  Result :=  Result + '//---------------------------------------------------------------------------' +CRLF;
  Result :=  Result + '#include <vcl.h>'+CRLF;
  Result :=  Result + '#pragma hdrstop'+CRLF2;
  Result :=  Result + '#include "' + UnitIdent + '.h"'+CRLF;
  Result :=  Result + '//---------------------------------------------------------------------------'+CRLF;
  Result :=  Result + '#pragma resource "*.dfm"'+CRLF;
  Result :=  Result + 'T' + FormIdent + ' *' + FormIdent + ';'+CRLF;
  Result :=  Result + '//---------------------------------------------------------------------------'+CRLF;
  Result :=  Result + '__fastcall T' + FormIdent + '::T' + FormIdent + '(TComponent* Owner)'+CRLF;
  Result :=  Result + '        : T' + AncestorIdent + '(Owner)'+CRLF;
  Result :=  Result + '{'+CRLF;
  Result :=  Result + '}'+CRLF;
  Result :=  Result + '//---------------------------------------------------------------------------';
  {$ENDIF}
end;

procedure TCoolHint2KFormCreator.FormCreated(Form: TIFormInterface);
begin
end;

procedure HandleException;
begin
  ToolServices.RaiseException(ReleaseException);
end;

{TCoolHint2KFormExpert}
function TCoolHint2KFormExpert.GetName: string;
begin
  try
    Result := 'Form';
  except
    HandleException;
  end;
end;

function TCoolHint2KFormExpert.GetComment: string;
begin
  try
    Result := 'Creates new TCoolHint2KForm Form';
  except
    HandleException;
  end;
end;

function TCoolHint2KFormExpert.GetGlyph: HICON;
begin
  try
    Result := LoadIcon(HInstance, 'ICON_COOLHINTS2K');
  except
    Result := 0;
  end;
end;

function TCoolHint2KFormExpert.GetStyle: TExpertStyle;
begin
  Result := esForm;
end;

function TCoolHint2KFormExpert.GetState: TExpertState;
begin
  try
    Result := [esEnabled];
  except
    HandleException;
  end;
end;

function TCoolHint2KFormExpert.GetIDString: string;
begin
  try
    Result := 'CoolDev.TCoolHint2KFormExpert';
  except
    HandleException;
  end;
end;

function TCoolHint2KFormExpert.GetAuthor: string;
begin
  try
    Result := 'Artem A. Berman';
  except
    HandleException;
  end;
end;

function TCoolHint2KFormExpert.GetMenuText: string; 
begin
  try
    Result := '';
  except
    HandleException;
  end; 
end;

function TCoolHint2KFormExpert.GetPage: string;
begin
  try
    Result := 'CoolHints2K';
  except
    HandleException;
  end;
end;

procedure TCoolHint2KFormExpert.Execute;
begin
  try
    RunExpert(ToolServices);
  except
    HandleException;
  end;
end;

procedure TCoolHint2KFormExpert.RunExpert(ToolServices: TIToolServices);
var
  IModule: TIModuleInterface;
  IModuleCreator: TCoolHint2KFormCreator;
begin
  if ToolServices <> nil then
  begin
    IModuleCreator := TCoolHint2KFormCreator.Create;
    try
      {$IFDEF VER120}
      IModule := ToolServices.ModuleCreateEx(IModuleCreator, [cmShowSource, cmShowForm, cmMarkModified, cmUnNamed, cmAddToProject]);
      {$ELSE}
      IModule := ToolServices.ModuleCreate(IModuleCreator, [cmShowSource, cmShowForm, cmMarkModified, cmUnNamed, cmAddToProject]);
      {$ENDIF}
      IModule.Free;
    finally
      IModuleCreator.Free;
    end;
  end;
end;

{TCHAboutProperty}
function TCHAboutProperty.GetAttributes: TPropertyAttributes;
begin
  Result := [paDialog, paReadOnly {$IFDEF VER130}, paFullWidthName {$ENDIF}]
end {GetAttributes};

procedure TCHAboutProperty.Edit;
var
  Hint2KForm: TCoolHint2KForm;
  lbTitle: TLabel;
  lbText: TLabel;
  lbCopyright: TLabel;
  imgIcon: TImage;
  btnOk: TCoolHint2kbutton;
begin
  Hint2KForm := TCoolHint2KForm.Create(Application);
  with Hint2KForm do
  try
    Position := poScreenCenter;
    Font.Name := 'Tahoma';
    Height := 220;

    imgIcon := TImage.Create(Hint2KForm);
    imgIcon.Left := 20;
    imgIcon.Top := 20;
    imgIcon.AutoSize := True;
    imgIcon.Picture.Icon.Handle := LoadIcon(0, IDI_ASTERISK);
    imgIcon.Parent := Hint2KForm;

    lbTitle := TLabel.Create(Hint2KForm);
    lbTitle.Left := 80;
    lbTitle.Top := 20;
    lbTitle.Caption := 'CoolHints2k Package v. 1.0';
    lbTitle.Font.Style := [fsBold];
    lbTitle.Parent := Hint2KForm;

    lbText := TLabel.Create(Hint2KForm);
    lbText.Left := 80;
    lbText.Top := 50;
    lbText.Width := 180;
    lbText.Height := 100;
    lbText.AutoSize := False;
    lbText.WordWrap := True;
    lbText.Caption := 'Package comes with the look and feel of the Office2k hints windows. Complete toolkit to buiild similar system.';
    lbText.Parent := Hint2KForm;

    lbCopyright := TLabel.Create(Hint2KForm);
    lbCopyright.Left := 80;
    lbCopyright.Top := 110;
    lbCopyright.Caption := 'Copyright (c) 2000 by Artem A. Berman' + #13 + 'Copyright (c) 2000 by CoolDev.Com';
    lbCopyright.Parent := Hint2KForm;

    btnOk := TCoolHint2kbutton.Create(Hint2KForm);
    btnOk.Caption := 'O&K';
    btnOk.ModalResult := mrOk;
    btnOk.Width := 75;
    btnOk.Left := 200;
    btnOk.Top := 150;
    btnOk.Default := True;
    btnOk.Cancel := True;
    btnOk.Parent := Hint2KForm;

    ShowModal;
  finally
    Free;
  end;
end;

function TCHAboutProperty.GetValue: string;
begin
  Result := '(About)';
end;

{$IFDEF VER130}
procedure TCHAboutProperty.PropDrawName(ACanvas: TCanvas; const ARect: TRect;
      ASelected: Boolean);
begin
  ACanvas.Font.Style := [fsBold];
  inherited PropDrawName(ACanvas, ARect, ASelected);
end;
{$ENDIF}

procedure Register;
begin
  RegisterCustomModule(TCoolHint2KForm, TCustomModule);
  RegisterLibraryExpert(TCoolHint2KFormExpert.Create);
  RegisterComponents('CoolHints2K', [TCoolHint2KControl, TCoolHint2KButton, TCoolHint2KLink, TCoolHint2KCommandLink]);
  RegisterPropertyEditor(TypeInfo(TCHAboutBox), nil, '', TCHAboutProperty);
end;

end.
