unit uGameSelector;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmGameSelector = class(TForm)
    Panel1: TPanel;
    lbGameNames: TListBox;
    Panel2: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    Panel3: TPanel;
    lblDescription: TLabel;
    procedure lbGameNamesClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    DataSelected: Boolean;
    procedure UpdateGameNames;
  end;

var
  frmGameSelector: TfrmGameSelector;

implementation

uses uGameManager;

{$R *.dfm}

{ TfrmGameSelector }

procedure TfrmGameSelector.UpdateGameNames;
var
  i: Integer;
begin
  lbGameNames.Clear;
  for i := 0 to gGameManager.GameCount - 1 do
    lbGameNames.Items.Add(gGameManager.GameName[i])
end;

procedure TfrmGameSelector.lbGameNamesClick(Sender: TObject);
var
  i: Integer;
begin
  i := lbGameNames.ItemIndex;
  if i >= 0 then
    lblDescription.Caption := gGameManager.GameDesc[i];
end;

procedure TfrmGameSelector.btnOKClick(Sender: TObject);
var
  i: Integer;
begin
  i := lbGameNames.ItemIndex;
  if i >= 0 then
  begin
    gGameManager.SwitchToGame(i);
    ModalResult := mrOk;
  end else
  begin
    ShowMessage('Please select game data');
  end;
end;

end.
