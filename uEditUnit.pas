unit uEditUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uTypes;

type
  TfrmEditUnit = class(TForm)
    Label1: TLabel;
    txtUnit: TEdit;
    btnPickUnit: TButton;
    txtAmmount: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    txtWounded: TEdit;
    cbPrisoner: TCheckBox;
    btnOk: TButton;
    btnCancel: TButton;
    Label4: TLabel;
    txtUpgrade: TEdit;
    procedure btnPickUnitClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    Troop: TUnitEntry;
  end;

var
  frmEditUnit: TfrmEditUnit;

implementation

uses uPickTroop, Math;

{$R *.dfm}

procedure TfrmEditUnit.btnPickUnitClick(Sender: TObject);
begin
  if frmPickUnit.ShowModal = mrOk then
  begin
    Troop.id := frmPickUnit.id;
    try
      txtUnit.Text := frmPickUnit.ssItems[frmPickUnit.id];
    except
    end;  
  end;
end;

procedure TfrmEditUnit.btnOkClick(Sender: TObject);
begin
  try
    Troop.count := StrToInt(Trim(txtAmmount.Text));
    Troop.wounded := StrToInt(Trim(txtWounded.Text));
    Troop.upgrade_ready := StrToInt(Trim(txtUpgrade.Text));
  except
    MessageBox(Handle, 'You have entered wrong data', nil, MB_ICONERROR);
    Exit;
  end;
  Troop.prisoner := cbPrisoner.Checked;
end;

end.
