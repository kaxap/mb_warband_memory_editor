unit uOffsets;

interface
   uses Windows, uTypes, Classes, SysUtils, IniFiles, uConst;


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
  private
    FGameNames: TStringList;
    FDataDir: String;
    procedure LoadGameNames();
    function getGameCount: Integer;
    function getGameName(index: Integer): String;
    function getGameDesc(index: Integer): String;
  public
    offsets: TGameOffsetsList;
    constructor Create;
    destructor Destroy; override;
    property GameCount:Integer read getGameCount;
    property GameName[index: Integer]: String read getGameName;
    property GameDesc[index: Integer]: String read getGameDesc;
    function SwitchToGame(const index: Integer): Boolean;
  end;

var
  gOffsetMan: TGameOffsetsManager;

implementation

uses uFileManager;

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

  FDataDir := gstrRootDir + STR_GAMEDATA_DIR;
  FGameNames := TStringList.Create;
end;

destructor TGameOffsetsManager.Destroy;
begin
  FGameNames.Free;
  inherited;
end;

function TGameOffsetsManager.getGameCount: Integer;
begin
  Result := FGameNames.Count;
end;

function TGameOffsetsManager.getGameDesc(index: Integer): String;
begin
  Result := uFileManager.getStringFromFile(FDataDir + FGameNames[index] +
    '\description.txt');
end;

function TGameOffsetsManager.getGameName(index: Integer): String;
begin
  Result := FGameNames[index];
end;

procedure TGameOffsetsManager.LoadGameNames();
begin
  uFileManager.getDirList(FDataDir, '*.*', FGameNames);
end;

function TGameOffsetsManager.SwitchToGame(const index: Integer): Boolean;
var
  i: Integer;
begin

end;

initialization
begin
  gOffsetMan := TGameOffsetsManager.Create;
end;

end.
