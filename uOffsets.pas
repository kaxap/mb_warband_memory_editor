unit uOffsets;

interface
   uses Windows, uTypes, Classes, SysUtils;


type

  TGameOffsetsList = record
    dwChar: DWORD;
    pTable: Pointer;
    dwInventory: DWORD;
    dwParty1: DWORD;
    dwParty2: DWORD;
    dwParty3: DWORD;
    dwPartyCount: DWORD;
    pWeaponSkillLimit: Pointer;
  end;

  TGameOffsetsManager = class
  public
    offsets: TGameOffsetsList;
    constructor Create;
  end;

var
  gOffsetMan: TGameOffsetsManager;

implementation

{ TGameOffsetsManager }

constructor TGameOffsetsManager.Create;
begin
  offsets.dwChar := $140EC;
  offsets.pTable := Pointer($0099BEF4);
  offsets.dwInventory := $2D0;
  offsets.dwParty1 := $138D4 + $7E0;
  offsets.dwParty2 := $0;
  offsets.dwParty3 := $23C;
  offsets.dwPartyCount := $c;
  offsets.pWeaponSkillLimit := Pointer($008EAE98);
end;


initialization
begin
  gOffsetMan := TGameOffsetsManager.Create;
end;

end.
