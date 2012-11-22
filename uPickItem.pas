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
  private
    ssItems: TStringList;
  public
    { Public declarations }
  end;

var
  frmPickItem: TfrmPickItem;

implementation

uses StrUtils, uMain, uConst;

{$R *.dfm}

procedure TfrmPickItem.Button1Click(Sender: TObject);
begin
  {ModalResult := mrCancel;
  Close;}
end;

procedure TfrmPickItem.FormCreate(Sender: TObject);
const
  PREFIX_ITEM = #32'itm_';
var
  ss: TStringList;
  i, j, k: Integer;
  s: String;
begin
  ssItems := TStringList.Create;

  ss := TStringList.Create;
  try
    ss.LoadFromFile(ExtractFilePath(Application.ExeName) + 'item_kinds1.txt');
    for i := 0 to ss.Count - 1 do
    begin
      if Copy(ss[i], 1, Length(PREFIX_ITEM)) = PREFIX_ITEM then
      begin
        j := PosEx(#32, ss[i], Length(PREFIX_ITEM));
        k := PosEx(#32, ss[i], j + 1);
        if j > 0 then
        begin
          s := Copy(ss[i], j + 1, k - j -1);
          ssItems.Add(Format('%s [%d]', [s, ssItems.Count]));

        end;
      end;
    end;
  finally
    ss.Free;
  end;

  lbItems.Items.AddStrings(ssItems);
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
      lbItems.Items.AddStrings(ssItems);
    finally
      lbItems.Canvas.Unlock;
    end;
    Exit;
  end;

  s := AnsiLowerCase(txtSearch.Text);

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
end;

procedure TfrmPickItem.lbItemsDblClick(Sender: TObject);
var
  s: String;
  i: Integer;
begin

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

procedure TfrmPickItem.btnOkClick(Sender: TObject);
var
  id: Integer;
begin
  if lbItems.ItemIndex < 0 then
    Exit;

  id := -1;
  btnOk.Click;
end;

end.
