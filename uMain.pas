unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Inifiles, ExtCtrls, uTypes, XPMan;

type
  TForm1 = class(TForm)
    txtProcessId: TEdit;
    txtAddr: TEdit;
    btnAdd: TButton;
    btnDuplicate: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    txtItemId: TEdit;
    txtUsedAmmount: TEdit;
    cbFlag: TComboBox;
    btnModItem: TButton;
    cbFlagSync: TCheckBox;
    tmrModDataSync: TTimer;
    btnGuessAddr: TButton;
    btnOpenItems: TButton;
    btnClose: TButton;
    btnDup8: TButton;
    btnCharOpts: TButton;
    Button1: TButton;
    XPManifest1: TXPManifest;
    tmrOnLoad: TTimer;
    procedure btnAddClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnDuplicateClick(Sender: TObject);
    procedure cbFlagChange(Sender: TObject);
    procedure btnModItemClick(Sender: TObject);
    procedure tmrModDataSyncTimer(Sender: TObject);
    procedure btnGuessAddrClick(Sender: TObject);
    procedure txtItemIdKeyPress(Sender: TObject; var Key: Char);
    procedure txtUsedAmmountKeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseClick(Sender: TObject);
    procedure btnOpenItemsClick(Sender: TObject);
    procedure btnDup8Click(Sender: TObject);
    procedure btnCharOptsClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tmrOnLoadTimer(Sender: TObject);
  private
    { Private declarations }
    procedure EditProcessData(Action: TDataAction; Item: TGameItem;
      Param: Integer = 0);
    function SetWeaponSkillLimit(const hProcess: THandle;
      limit: Double): Boolean;
  public
    { Public declarations }
  end;


var
  Form1: TForm1;


implementation

uses uPickItem, uConst, uCharacterOpts, uPartyOpts, uPickTroop, uGameManager,
  uGameSelector;

{$R *.dfm}

function EnableDebugPrivilege(const Value: Boolean): Boolean;
const
  SE_DEBUG_NAME = 'SeDebugPrivilege';
var
  hToken: THandle;
  tp: TOKEN_PRIVILEGES;
  d: DWORD;
begin
  Result := False;
  if OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES, hToken) then
  begin
    tp.PrivilegeCount := 1;
    LookupPrivilegeValue(nil, SE_DEBUG_NAME, tp.Privileges[0].Luid);
    if Value then
      tp.Privileges[0].Attributes := $00000002
    else
      tp.Privileges[0].Attributes := $80000000;
    AdjustTokenPrivileges(hToken, False, tp, SizeOf(TOKEN_PRIVILEGES), nil, d);
    if GetLastError = ERROR_SUCCESS then
    begin
      Result := True;
    end;
    CloseHandle(hToken);
  end;
end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
  EditProcessData(daIncrementItemId, NULL_GAME_ITEM);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ini: TIniFile;
begin
  ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'settings.ini');
  try
    ini.WriteString('params', 'procid', txtProcessId.Text);
    ini.WriteString('params', 'addr', txtAddr.Text);
  finally
    Ini.Free;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  ini: TIniFile;
  wnd: Integer;
  dwProcessID: DWORD;
begin
  {if NOT EnableDebugPrivilege(true) then
    MessageBox(Handle, 'Cannot enable debug privileges', nil, MB_ICONERROR);}
  ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'settings.ini');
  try
    txtProcessId.Text := ini.ReadString('params', 'procid', txtProcessId.Text);
    txtAddr.Text := ini.ReadString('params', 'addr', txtAddr.Text);
  finally
    Ini.Free;
  end;

  txtItemId.Tag := TAG_SYNCED;
  txtUsedAmmount.Tag := TAG_SYNCED;
  cbFlag.Tag := TAG_SYNCED;

  //btnGuessAddr.Click;
end;

procedure TForm1.EditProcessData(Action: TDataAction; Item: TGameItem;
      Param: Integer = 0);
var
  hProcess: THandle;
  data: TGameItem;
  dwProcessId: DWORD;
  dwAddress: DWORD;
  dwBytesRead: DWORD;
begin
  try
    dwProcessId := StrToInt('$' + txtProcessId.Text);
    dwAddress := StrToInt('$' + txtAddr.Text);
  except
    Application.MessageBox('Errorneus data', nil, MB_ICONERROR);
    Exit;
  end;

  if (dwAddress = 0) then
    Exit;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, FAlse, dwProcessId);
  if (hProcess = 0) then
  begin
    Application.MessageBox('Cannot open process', nil, MB_ICONERROR);
    Exit;
  end;

  if NOT ReadProcessMemory(hProcess,
    Pointer(dwAddress), @data, SizeOf(data), dwBytesRead) OR
      (dwBytesRead <> SizeOf(data)) then
  begin
    Application.MessageBox('Cannot READ data from process'' memory', nil,
      MB_ICONERROR);
    CloseHandle(hProcess);
    Exit;
  end;

  case Action of
    daIncrementItemId:
      data.id := data.id + 1;
    daDuplicate:
      dwAddress := dwAddress + SizeOf(data) * Param;
    daModificate:
      begin
        data.id := Item.id;
        data.used_ammount := Item.used_ammount;
        data.flag := Item.flag;
      end;
  end;


  if NOT WriteProcessMemory(hProcess,
    Pointer(dwAddress), @data, SizeOf(data), dwBytesRead) OR
      (dwBytesRead <> SizeOf(data)) then
  begin
    Application.MessageBox('Cannot WRITE data to process'' memory', nil,
      MB_ICONERROR);
  end else
    Caption := Format('%d written', [data.id]);

  CloseHandle(hProcess);
end;

procedure TForm1.btnDuplicateClick(Sender: TObject);
begin
  EditProcessData(daDuplicate, NULL_GAME_ITEM, 1);
end;

procedure TForm1.cbFlagChange(Sender: TObject);
begin
  cbFlag.Tag := TAG_MODIFIED;

  if (cbFlagSync.State = cbChecked) then
    btnModItem.Click;
end;

procedure TForm1.btnModItemClick(Sender: TObject);
var
  item: TGameItem;
begin
  item.id := StrToInt(txtItemId.Text);
  item.used_ammount := StrToInt(txtUsedAmmount.Text);
  item.flag := cbFlag.ItemIndex;
  EditProcessData(daModificate, item);

  txtItemId.Tag := TAG_SYNCED;
  txtUsedAmmount.Tag := TAG_SYNCED;
  cbFlag.Tag := TAG_SYNCED;
end;

procedure TForm1.tmrModDataSyncTimer(Sender: TObject);
var
  data: TGameItem;
  dwProcessId, dwAddress: DWORD;
  hProcess: THandle;
  dwBytesRead: DWORD;
begin
  try
    dwProcessId := StrToInt('$' + txtProcessId.Text);
    dwAddress := StrToInt('$' + txtAddr.Text);
  except
    Exit;
  end;

  if (dwAddress = 0) then
    Exit;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, FAlse, dwProcessId);
  if (hProcess = 0) then
  begin
    //Application.MessageBox('Cannot open process', nil, MB_ICONERROR);
    Exit;
  end;

  if NOT ReadProcessMemory(hProcess,
    Pointer(dwAddress), @data, SizeOf(data), dwBytesRead) OR
      (dwBytesRead <> SizeOf(data)) then
  begin
    CloseHandle(hProcess);
    Exit;
  end;

  if (NOT txtItemId.Focused) AND (txtItemId.Tag = TAG_SYNCED) then
    txtItemId.Text := IntToStr(data.id);

  if (NOT txtUsedAmmount.Focused) AND (txtUsedAmmount.Tag = TAG_SYNCED) then
    txtUsedAmmount.Text := IntToStr(data.used_ammount);

  if NOT GetForegroundWindow = Handle then
    cbFlag.ItemIndex := data.flag;

  CloseHandle(hProcess);
end;

procedure TForm1.btnGuessAddrClick(Sender: TObject);
(*const
  CHAR_OFFSET =  { $140DC;} $140EC;
  TABLE_ADDR =  {1.153 $009D5E2C; } {1.154 } $0099BEF4; { $009f3e20;} { $009c4de8;}
  INVENTORY_OFFSET = $2D0;*)

var
  dwProcessId, dwAddress: DWORD;
  hProcess: THandle;
  dwBytesRead: DWORD;
  pTable: DWORD;
  pCharacter: DWORD;
  dwInventory: DWORD;
  wnd: HWND;
begin

  wnd := FindWindow(nil, 'Mount&Blade Warband');
  if wnd > 0 then
  begin
    GetWindowThreadProcessId(wnd, @dwProcessId);
    txtProcessId.Text := Format('%x', [dwProcessId]);
  end else
  begin
    //txtProcessId.Text := '0';
    Exit;
  end;

  //for more comfortly playing in windowed mode
  //remove borders
  SetWindowLong(wnd, GWL_STYLE, GetWindowLong(wnd, GWL_STYLE) XOR
    WS_OVERLAPPEDWINDOW);

  //make always on top
  SetWindowPos(wnd, HWND_TOP,
    Monitor.Left, Monitor.Top, Monitor.Width, Monitor.Height,
    SWP_SHOWWINDOW);

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);

  try
  
    if (hProcess = 0) then
    begin
      tmrModDataSync.Enabled := False;
      MessageBox(Handle, 'Cannot open process', nil, MB_ICONERROR);
      Exit;
    end;

    if NOT ReadProcessMemory(hProcess,
      gGameManager.offsets.pTable, @pTable, SizeOf(pTable), dwBytesRead) OR
        (dwBytesRead <> SizeOf(pTable)) then
    begin
      Application.MessageBox('Cannot READ data from process'' memory', nil,
        MB_ICONERROR);
      CloseHandle(hProcess);
      Exit;
    end;

    pTable := pTable + gGameManager.offsets.dwChar;

    if ReadProcessMemory(hProcess, Pointer(pTable), @pCharacter, SizeOf(pCharacter),
      dwBytesRead) then
    begin
      dwInventory := pCharacter + gGameManager.offsets.dwInventory;
      txtAddr.Text := Format('%x', [dwInventory]);
    end;

    SetWeaponSkillLimit(hProcess, 10000.0);
    
  finally
    CloseHandle(hProcess);
  end;


end;

procedure TForm1.txtItemIdKeyPress(Sender: TObject; var Key: Char);
begin
  txtItemId.Tag := TAG_MODIFIED;
end;

procedure TForm1.txtUsedAmmountKeyPress(Sender: TObject; var Key: Char);
begin
  txtUsedAmmount.Tag := TAG_MODIFIED;
end;

procedure TForm1.btnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.btnOpenItemsClick(Sender: TObject);
begin
  if frmPickItem.ShowModal = mrOk then
    txtItemId.Tag := TAG_MODIFIED;
end;

procedure TForm1.btnDup8Click(Sender: TObject);
var
  i: Integer;
begin
  for i := 1 to 9 do
    EditProcessData(daDuplicate, NULL_GAME_ITEM, i);
end;

procedure TForm1.btnCharOptsClick(Sender: TObject);
var
  dwProcessId, dwAddress: DWORD;
begin
  try
    dwProcessId := StrToInt('$' + txtProcessId.Text);
    dwAddress := StrToInt('$' + txtAddr.Text);
  except
    Exit;
  end;

  if (dwAddress = 0) then
    Exit;

  frmCharOpts.dwProcessId := dwProcessId;
  frmCharOpts.dwBaseAddress := dwAddress;
  if frmCharOpts.ReadDataToTextBoxes then
    frmCharOpts.ShowModal;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  dwProcessId: DWORD;
begin
  try
    dwProcessId := StrToInt('$' + txtProcessId.Text);
  except
    Exit;
  end;

  frmPartyOpts.dwProcessId := dwProcessId;

  //frmPickUnit.Show;
  if frmPartyOpts.ObtainBaseAddr then
  begin
    if frmPartyOpts.RefreshGameData then
      frmPartyOpts.Show;
  end;
end;

function TForm1.SetWeaponSkillLimit(const hProcess: THandle;
  limit: Double): Boolean;

  procedure ShowLastError;
  begin
    MessageBox(Handle,
      PChar('Error on writing max weapon skill limit: ' +
      SysErrorMessage(GetLastError())), nil, MB_ICONERROR);
  end;

(*const
  WEAPON_SKILL_LIMIT_ADDR:DWORD = {1.153 $008F5EA0;} {1.154} $008EAE98;*)

var
  bytesWritten: DWORD;
  OldProtect: DWORD;
  temp: DWORD;
begin
  Result := VirtualProtectEx(hProcess, gGameManager.offsets.pWeaponSkillLimit,
    SizeOf(limit), PAGE_EXECUTE_READWRITE, OldProtect);

  if NOT Result then
  begin
    ShowLastError;
    Exit;
  end;

  Result := WriteProcessMemory(hProcess, gGameManager.offsets.pWeaponSkillLimit,
    @limit, SizeOf(limit), bytesWritten) AND (bytesWritten = SizeOf(limit));

  if NOT Result then
    ShowLastError;

  Result := VirtualProtectEx(hProcess, gGameManager.offsets.pWeaponSkillLimit,
    SizeOf(limit), OldProtect, temp);

  if NOT Result then
    ShowLastError;
end;

procedure TForm1.tmrOnLoadTimer(Sender: TObject);
begin
  tmrOnLoad.Enabled := False;
  frmGameSelector.UpdateGameNames;
  if frmGameSelector.ShowModal = mrOk then
    btnGuessAddr.Click;
end;

end.
