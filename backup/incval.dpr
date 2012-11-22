program incval;

uses
  Forms,
  uMain in 'uMain.pas' {Form1},
  uPickItem in 'uPickItem.pas' {frmPickItem},
  uConst in 'uConst.pas',
  uTypes in 'uTypes.pas',
  uCharacterOpts in 'uCharacterOpts.pas' {frmCharOpts};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TfrmPickItem, frmPickItem);
  Application.CreateForm(TfrmCharOpts, frmCharOpts);
  Application.Run;
end.
