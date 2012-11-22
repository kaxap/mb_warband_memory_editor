unit uCharacterOpts;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmCharOpts = class(TForm)
    GroupBox4: TGroupBox;
    txtOneHanded: TLabeledEdit;
    txtTwoHanded: TLabeledEdit;
    txtPolearms: TLabeledEdit;
    txtArchery: TLabeledEdit;
    txtCrossbows: TLabeledEdit;
    txtThrowing: TLabeledEdit;
    txtUnk1: TLabeledEdit;
    txtUnk2: TLabeledEdit;
    txtUnk3: TLabeledEdit;
    txtUnk4: TLabeledEdit;
    GroupBox1: TGroupBox;
    txtAttrPoints: TLabeledEdit;
    txtSkillPoints: TLabeledEdit;
    txtWeaponPoints: TLabeledEdit;
    GroupBox2: TGroupBox;
    txtStr: TLabeledEdit;
    txtAgi: TLabeledEdit;
    txtInt: TLabeledEdit;
    txtCha: TLabeledEdit;
    GroupBox3: TGroupBox;
    txtMoney: TEdit;
    btnOk: TButton;
    btnCancel: TButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private
    { Private declarations }
    function ReadDataInt(offset: Integer; Edit: TCustomEdit): Boolean;
    function ReadDataFloat(offset: Integer; Edit: TCustomEdit): Boolean;
    function WriteDataInt(offset: Integer; Edit: TCustomEdit): Boolean;
    function WriteDataFloat(offset: Integer; Edit: TCustomEdit): Boolean;
    function WriteDataFromTextBoxes: Boolean;
  public
    { Public declarations }
    dwProcessId: DWORD;
    dwBaseAddress: DWORD;
    function ReadDataToTextBoxes: Boolean;
  end;

var
  frmCharOpts: TfrmCharOpts;

implementation

uses uConst;

{$R *.dfm}

procedure TfrmCharOpts.btnCancelClick(Sender: TObject);
begin
  Close;
end;

function TfrmCharOpts.ReadDataFloat(offset: Integer;
  Edit: TCustomEdit): Boolean;
var
  hProcess: THandle;
  data: Single;
  dwBytesRead: DWORD;
begin
  Result := False;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);
  if hProcess = INVALID_HANDLE_VALUE then
    Exit;

  try

    if (ReadProcessMemory(hProcess, Pointer(dwBaseAddress + offset), @data,
      SizeOf(data), dwBytesRead)) AND (dwBytesRead = SizeOf(data)) then
    begin
      Edit.Text := Format('%.2f', [data]);
      Result := True;
    end;

  finally
    CloseHandle(hProcess);
  end;

end;

function TfrmCharOpts.ReadDataInt(offset: Integer;
  Edit: TCustomEdit): Boolean;
var
  hProcess: THandle;
  data: Integer;
  dwBytesRead: DWORD;
begin
  Result := False;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);
  if hProcess = INVALID_HANDLE_VALUE then
    Exit;

  try

    if (ReadProcessMemory(hProcess, Pointer(dwBaseAddress + offset), @data,
      SizeOf(data), dwBytesRead)) AND (dwBytesRead = SizeOf(data)) then
    begin
      Edit.Text := IntToStr(data);
      Result := True;
    end;

  finally
    CloseHandle(hProcess);
  end;

end;

function TfrmCharOpts.ReadDataToTextBoxes: Boolean;
begin
  Result := ReadDataInt(OFFSET_STAT_POINTS, txtAttrPoints) AND
    ReadDataInt(OFFSET_SKILL_POINTS, txtSkillPoints) AND
    ReadDataInt(OFFSET_WEAPON_POINTS, txtWeaponPoints) AND
    ReadDataInt(OFFSET_STR, txtStr) AND
    ReadDataInt(OFFSET_AGI, txtAgi) AND
    ReadDataInt(OFFSET_INT, txtInt) AND
    ReadDataInt(OFFSET_CHA, txtCha) AND
    ReadDataFloat(OFFSET_WEAPON_ONEHANDED, txtOneHanded) AND
    ReadDataFloat(OFFSET_WEAPON_TWOHANDED, txtTwoHanded) AND
    ReadDataFloat(OFFSET_WEAPON_POLEARMS, txtPolearms) AND
    ReadDataFloat(OFFSET_WEAPON_ARCHERY, txtArchery) AND
    ReadDataFloat(OFFSET_WEAPON_CROSSBOWS, txtCrossbows) AND
    ReadDataFloat(OFFSET_WEAPON_THROWING, txtThrowing) AND
    ReadDataFloat(OFFSET_WEAPON_UNK1, txtUnk1) AND
    ReadDataFloat(OFFSET_WEAPON_UNK2, txtUnk2) AND
    ReadDataFloat(OFFSET_WEAPON_UNK3, txtUnk3) AND
    {ReadDataFloat(OFFSET_WEAPON_UNK4, txtUnk4) AND}
    ReadDataInt(OFFSET_MONEY, txtMoney);
end;

function TfrmCharOpts.WriteDataFloat(offset: Integer;
  Edit: TCustomEdit): Boolean;
var
  hProcess: THandle;
  data: Single;
  dwBytesWritten: DWORD;
begin
  Result := False;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);
  if hProcess = INVALID_HANDLE_VALUE then
    Exit;

  try
    if TryStrToFloat(Edit.Text, data) then
      if (WriteProcessMemory(hProcess, Pointer(dwBaseAddress + offset), @data,
        SizeOf(data), dwBytesWritten)) AND (dwBytesWritten = SizeOf(data)) then
      begin
        Result := True;
      end;
  finally
    CloseHandle(hProcess);
  end;

end;

function TfrmCharOpts.WriteDataInt(offset: Integer;
  Edit: TCustomEdit): Boolean;
var
  hProcess: THandle;
  data: Integer;
  dwBytesWritten: DWORD;
begin
  Result := False;

  hProcess := OpenProcess(PROCESS_ALL_ACCESS, False, dwProcessId);
  if hProcess = INVALID_HANDLE_VALUE then
    Exit;

  try
    if TryStrToInt(Edit.Text, data) then
      if (WriteProcessMemory(hProcess, Pointer(dwBaseAddress + offset), @data,
        SizeOf(data), dwBytesWritten)) AND (dwBytesWritten = SizeOf(data)) then
      begin
        Result := True;
      end;
  finally
    CloseHandle(hProcess);
  end;

end;

function TfrmCharOpts.WriteDataFromTextBoxes: Boolean;
begin
  Result := WriteDataInt(OFFSET_STAT_POINTS, txtAttrPoints) AND
    WriteDataInt(OFFSET_SKILL_POINTS, txtSkillPoints) AND
    WriteDataInt(OFFSET_WEAPON_POINTS, txtWeaponPoints) AND
    WriteDataInt(OFFSET_STR, txtStr) AND
    WriteDataInt(OFFSET_AGI, txtAgi) AND
    WriteDataInt(OFFSET_INT, txtInt) AND
    WriteDataInt(OFFSET_CHA, txtCha) AND
    WriteDataFloat(OFFSET_WEAPON_ONEHANDED, txtOneHanded) AND
    WriteDataFloat(OFFSET_WEAPON_TWOHANDED, txtTwoHanded) AND
    WriteDataFloat(OFFSET_WEAPON_POLEARMS, txtPolearms) AND
    WriteDataFloat(OFFSET_WEAPON_ARCHERY, txtArchery) AND
    WriteDataFloat(OFFSET_WEAPON_CROSSBOWS, txtCrossbows) AND
    WriteDataFloat(OFFSET_WEAPON_THROWING, txtThrowing) AND
    WriteDataFloat(OFFSET_WEAPON_UNK1, txtUnk1) AND
    WriteDataFloat(OFFSET_WEAPON_UNK2, txtUnk2) AND
    WriteDataFloat(OFFSET_WEAPON_UNK3, txtUnk3) AND
    {WriteDataFloat(OFFSET_WEAPON_UNK4, txtUnk4) AND}
    WriteDataInt(OFFSET_MONEY, txtMoney);
end;

procedure TfrmCharOpts.btnOkClick(Sender: TObject);
begin
  if NOT WriteDataFromTextBoxes then
    Application.MessageBox('Something went wrong', nil, MB_ICONERROR);
  Close;  
end;

end.
