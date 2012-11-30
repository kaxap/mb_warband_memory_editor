unit uPickItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;


type
  TfrmPickItem = class(TForm)
    Label1: TLabel;
    lbItems: TListBox;
    btnOk: TButton;
    Button1: TButton;
    txtSearch: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure txtSearchChange(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure lbItemsDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
  public
    { Public declarations }
  end;

var
  frmPickItem: TfrmPickItem;

implementation

uses StrUtils, uMain, uConst, uGameManager;

{$R *.dfm}

procedure TfrmPickItem.Button1Click(Sender: TObject);
begin
  {ModalResult := mrCancel;
  Close;}
end;

procedure TfrmPickItem.FormCreate(Sender: TObject);
begin
  lbItems.Tag := TAG_INDEX;
  lbItems.ItemIndex := 0;
end;

procedure TfrmPickItem.txtSearchChange(Sender: TObject);
var
  s: String;
  i: Integer;
  id: Integer;
begin
  lbItems.Clear;
  if txtSearch.Text = '' then
  begin
    lbItems.Canvas.Lock;
    try
      lbItems.Tag := TAG_INDEX;
      lbItems.Items.AddStrings(gGameManager.Items);
    finally
      lbItems.Canvas.Unlock;
    end;
    Exit;
  end;

  s := AnsiLowerCase(txtSearch.Text);

  lbItems.Canvas.Lock;
  try
    lbItems.Tag := TAG_DATA;

    for i := 0 to gGameManager.Items.Count - 1 do
    begin
      if Pos(s, AnsiLowerCase(gGameManager.Items[i])) > 0 then
      begin
        lbItems.AddItem(gGameManager.Items[i], Pointer(i));
      end;
    end;

  finally
    lbItems.Canvas.Unlock;
  end;

end;

procedure TfrmPickItem.lbItemsDblClick(Sender: TObject);
begin
  btnOk.Click;
end;

procedure TfrmPickItem.btnOkClick(Sender: TObject);
var
  id: Integer;
begin
  try
    if lbItems.Tag = TAG_INDEX then
      id := lbItems.ItemIndex
    else
      id := Integer(lbItems.Items.Objects[lbItems.ItemIndex]);
  finally
    if id >= 0 then Form1.txtItemId.Text := IntToStr(id);
    //ModalResult := mrOk;
    //Close;
  end;

  lbItems.ItemIndex := 0;
end;

procedure TfrmPickItem.FormShow(Sender: TObject);
begin
  //show all items when search box is epty
  if (txtSearch.Text = '') AND (lbItems.Count = 0) then
    txtSearch.OnChange(nil);
end;

end.
