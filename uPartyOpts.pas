unit uPartyOpts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, ExtCtrls, uTypes, StrUtils;

type
  TfrmPartyOpts = class(TForm)
    Panel1: TPanel;
    btnClose: TButton;
    lvUnits: TListView;
    btnRefresh: TButton;
    btnEdit: TButton;
    btnSave: TButton;
    procedure btnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure lvUnitsDblClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
  private
    { Private declarations }
    AMemory: TMemoryStream;
    dwBaseAddr: DWORD;
    dwCountAddr: DWORD;
    procedure AddUnitToTable(const UnitEntry: TUnitEntry;
      const Data: Integer);
  public
    { Public declarations }
    dwProcessId: DWORD;
    ATroops: TStringList;
    function ObtainBaseAddr: Boolean;
    function RefreshGameData: Boolean;
    function ReadData(const offset: Integer): TUnitEntry;
    function WriteData(const offset: Integer; Troop: TUnitEntry): Boolean;
    function SaveData: Boolean;
  end;

var
  frmPartyOpts: TfrmPartyOpts;

implementation

uses uPickTroop, uEditUnit;

{$R *.dfm}

function TfrmPartyOpts.ObtainBaseAddr: Boolean;
const
  ADDR_STATIC = $009D5E2C; {old $9F3E20;} { $009c4de8;}
  OFFSET1 = $138D4 + $7E0; {old $138E4 + $7C0; } { $140b4;}
  OFFSET2 = $0;
  OFFSET3 = $23C; {old $234;} { $23c;}
  OFFSET_COUNT = $c;

var
  hProcess: THandle;
  dwBytesRead: DWORD;
  addr1, addr2, addr3: DWORD;
begin
  Result := False;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);
  if hProcess = 0 then
    Exit;

  try

    if (ReadProcessMemory(hProcess, Pointer(ADDR_STATIC), @addr1,
      SizeOf(addr1), dwBytesRead)) AND (dwBytesRead = SizeOf(addr1)) then
    begin
      if (ReadProcessMemory(hProcess, Pointer(addr1 + OFFSET1), @addr2,
        SizeOf(addr2), dwBytesRead)) AND (dwBytesRead = SizeOf(addr2)) then
      begin
        if (ReadProcessMemory(hProcess, Pointer(addr2 + OFFSET2), @addr3,
          SizeOf(addr3), dwBytesRead)) AND (dwBytesRead = SizeOf(addr3)) then
        begin

          dwCountAddr := addr3 + OFFSET3 + OFFSET_COUNT;

          if (ReadProcessMemory(hProcess, Pointer(addr3 + OFFSET3), @dwBaseAddr,
            SizeOf(dwBaseAddr), dwBytesRead)) AND (dwBytesRead = SizeOf(dwBaseAddr)) then
          begin
            Result := True;
            Caption := Format('Party options [%.8x]', [dwCountAddr]);
          end;
        end;

      end;

    end;

  finally
    CloseHandle(hProcess);
  end;

end;

procedure TfrmPartyOpts.btnCloseClick(Sender: TObject);
begin
  Close;
end;

function TfrmPartyOpts.RefreshGameData: Boolean;
var
  i, j, k: Integer;
  GameUnit: TUnitEntry;
  hProcess: THandle;
  offset: Integer;
  dwBytesRead: DWORD;
  max_count: Integer;
  count: Integer;
begin
  Result := False;

  AMemory.Clear;
  lvUnits.Clear;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);
  if hProcess = 0 then
    Exit;


  if NOT (ReadProcessMemory(hProcess, Pointer(dwCountAddr), @max_count,
     SizeOf(max_count), dwBytesRead)) AND (dwBytesRead = SizeOf(max_count)) then
  begin
    CloseHandle(hProcess);
    Exit;
  end;

  if max_count <= 0 then
  begin
    CloseHandle(hProcess);
    Exit;
  end;

  try
    FillChar(GameUnit, SizeOf(GameUnit), 0);
    offset := 0;
    count := 0;

    repeat
      if (ReadProcessMemory(hProcess, Pointer(dwBaseAddr + offset), @GameUnit,
        SizeOf(GameUnit), dwBytesRead)) AND (dwBytesRead = SizeOf(GameUnit)) then
      begin
        AMemory.Write(GameUnit, SizeOf(GameUnit));
        AddUnitToTable(GameUnit, offset);
        offset := offset + SizeOf(GameUnit);
        Inc(count);
        Result := True;
      end else
        Break;
    until max_count <= count;

  finally
    CloseHandle(hProcess);
  end;
end;

procedure TfrmPartyOpts.AddUnitToTable(const UnitEntry: TUnitEntry;
  const Data: Integer);
var
  item: TListItem;
begin
  item := lvUnits.Items.Add();
  item.Caption := '';
  try
    item.SubItems.Add(ATroops[UnitEntry.id]);
  except
  end;
  item.SubItems.Add(IntToStr(UnitEntry.count));
  item.SubItems.Add(IntToStr(UnitEntry.wounded));

  if UnitEntry.prisoner then
    item.SubItems.Add('yes')
  else
    item.SubItems.Add('');

  item.SubItems.Add(IntToStr(UnitEntry.upgrade_ready));  
  item.Data := Pointer(Data);

end;

procedure TfrmPartyOpts.FormCreate(Sender: TObject);
const
  PREFIX_TROOP = 'trp_';
var
  ss: TStringList;
  i, j, k: Integer;
  s: String;
begin
  ATroops := TStringList.Create;

  ss := TStringList.Create;
  try
    ss.LoadFromFile(ExtractFilePath(Application.ExeName) + 'troops.txt');
    for i := 0 to ss.Count - 1 do
    begin
      if Copy(ss[i], 1, Length(PREFIX_TROOP)) = PREFIX_TROOP then
      begin
        //find 2 first spaces after prefix
        j := PosEx(#32, ss[i], Length(PREFIX_TROOP));
        k := PosEx(#32, ss[i], j + 1);
        if j > 0 then
        begin
          //copy text between spaces
          s := Copy(ss[i], j + 1, k - j - 1);
          ATroops.Add(Format('%s [%d]', [s, ATroops.Count]));
        end;
      end;
    end;
  finally
    ss.Free;
  end;

  AMemory := TMemoryStream.Create;

end;

procedure TfrmPartyOpts.lvUnitsDblClick(Sender: TObject);
begin
  btnEdit.Click;
end;

procedure TfrmPartyOpts.btnEditClick(Sender: TObject);
begin
  if lvUnits.Selected = nil then Exit;

  with frmEditUnit, lvUnits.Selected do
  begin
    txtUnit.Text := SubItems[0];
    txtAmmount.Text := SubItems[1];
    txtWounded.Text := SubItems[2];
    cbPrisoner.Checked := SubItems[3] <> '';
    txtUpgrade.Text := SubItems[4];
    Troop := ReadData(Integer(Data));

    if ShowModal = mrOk then
    begin
      WriteData(Integer(Data), Troop);
      SubItems[0] := txtUnit.Text;
      SubItems[1] := txtAmmount.Text;
      SubItems[2] := txtWounded.Text;
      if cbPrisoner.Checked then
        SubItems[3] := 'yes' else SubItems[3] := '';
      SubItems[4] := txtUpgrade.Text;
    end;
    //FocusControl(btnPickUnit);
  end;
end;

function TfrmPartyOpts.ReadData(const offset: Integer): TUnitEntry;
var
  pUnitEntry: ^TUnitEntry;
begin
  pUnitEntry := Pointer(Integer(AMemory.Memory) + offset);
  Result := pUnitEntry^;
end;

function TfrmPartyOpts.SaveData: Boolean;
var
  hProcess: THandle;
  dwBytesWritten: DWORD;
begin
  Result := False;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);
  if hProcess = 0 then
    Exit;

  try
    if (WriteProcessMemory(hProcess, Pointer(dwBaseAddr), AMemory.Memory,
      AMemory.Size, dwBytesWritten) AND (dwBytesWritten = AMemory.Size)) then
        Result := True;
  finally
    CloseHandle(hProcess);
  end;  
end;

function TfrmPartyOpts.WriteData(const offset: Integer;
  Troop: TUnitEntry): Boolean;
var
  pTroop: ^TUnitEntry;
begin
  pTroop := Pointer(Integer(AMemory.Memory) + offset);
  pTroop^.count := Troop.count;
  pTroop^.id := Troop.id;
  pTroop^.prisoner := Troop.prisoner;
  pTroop^.unk2 := Troop.unk2;
  pTroop^.wounded := Troop.wounded;
  pTroop^.upgrade_ready := Troop.upgrade_ready;
  pTroop^.unk4 := Troop.unk4;
  pTroop^.pUnk := Troop.pUnk;
end;

procedure TfrmPartyOpts.btnSaveClick(Sender: TObject);
begin
  if NOT SaveData then
    ShowMessage('Cannot save data, sorry.');
end;

procedure TfrmPartyOpts.btnRefreshClick(Sender: TObject);
begin
  RefreshGameData;
end;

end.
