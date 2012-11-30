unit uPickTroop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPickUnit = class(TForm)
    Label1: TLabel;
    txtSearch: TEdit;
    lbItems: TListBox;
    btnOk: TButton;
    btnClose: TButton;
    procedure txtSearchChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lbItemsDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ssItems: TStringList;
    id: Integer;
  end;

var
  frmPickUnit: TfrmPickUnit;

implementation

uses uConst, uPartyOpts, uGameManager;

{$R *.dfm}

procedure TfrmPickUnit.txtSearchChange(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  lbItems.Clear;
  if txtSearch.Text = '' then
  begin
    lbItems.Canvas.Lock;
    try
      lbItems.Tag := TAG_INDEX;
      lbItems.Items.AddStrings(ssItems);
    finally
      lbItems.Canvas.Unlock;
    end;
    Exit;
  end;

  s := AnsiLowerCase(txtSearch.Text);

  lbItems.Canvas.Lock;
  try
    lbItems.Tag := TAG_DATA;

    for i := 0 to ssItems.Count - 1 do
    begin
      if Pos(s, AnsiLowerCase(ssItems[i])) > 0 then
      begin
        lbItems.AddItem(ssItems[i], Pointer(i));
      end;
    end;

  finally
    lbItems.Canvas.Unlock;
  end;

  lbItems.ItemIndex := 0;
end;

procedure TfrmPickUnit.btnOkClick(Sender: TObject);
begin
  if lbItems.ItemIndex < 0 then
    Exit;

  id := -1;

  try
    if lbItems.Tag = TAG_INDEX then
      id := lbItems.ItemIndex
    else
      id := Integer(lbItems.Items.Objects[lbItems.ItemIndex]);
  finally
  end;
end;

procedure TfrmPickUnit.FormCreate(Sender: TObject);
begin
  ssItems := gGameManager.Troops;
  lbItems.Items.AddStrings(ssItems);
  lbItems.Tag := TAG_INDEX;
  lbItems.ItemIndex := 0;
end;

procedure TfrmPickUnit.lbItemsDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

end.
