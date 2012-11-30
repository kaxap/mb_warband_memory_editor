program incval;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uPickItem in 'uPickItem.pas' {frmPickItem},
  uConst in 'uConst.pas',
  uTypes in 'uTypes.pas',
  uCharacterOpts in 'uCharacterOpts.pas' {frmCharOpts},
  uPartyOpts in 'uPartyOpts.pas' {frmPartyOpts},
  uEditUnit in 'uEditUnit.pas' {frmEditUnit},
  uPickTroop in 'uPickTroop.pas' {frmPickUnit},
  uOffsets in 'uOffsets.pas',
  uFileManager in 'uFileManager.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmPickItem, frmPickItem);
  Application.CreateForm(TfrmCharOpts, frmCharOpts);
  Application.CreateForm(TfrmPartyOpts, frmPartyOpts);
  Application.CreateForm(TfrmEditUnit, frmEditUnit);
  Application.CreateForm(TfrmPickUnit, frmPickUnit);
  Application.Run;
end.
