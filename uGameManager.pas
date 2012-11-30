unit uGameManager;

interface
   uses Windows, uTypes, Classes, SysUtils, IniFiles, uConst, StrUtils;


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

  TGameManager = class
  private
    FGameNames: TStringList;
    FDataDir: String;
    FTroops: TStringList;
    procedure LoadGameNames();
    function getGameCount: Integer;
    function getGameName(index: Integer): String;
    function getGameDesc(index: Integer): String;
    procedure LoadTroops(const filename: String);
  public
    offsets: TGameOffsetsList;
    constructor Create;
    destructor Destroy; override;
    function SwitchToGame(const index: Integer): Boolean;
    property GameCount:Integer read getGameCount;
    property GameName[index: Integer]: String read getGameName;
    property GameDesc[index: Integer]: String read getGameDesc;
    property Troops: TStringList read FTroops;
  end;

var
  gGameManager: TGameManager;

implementation

uses uFileManager;

{ TGameOffsetsManager }

constructor TGameManager.Create;
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
  FTroops := TStringList.Create;
end;

destructor TGameManager.Destroy;
begin
  try
    FTroops.Free;
    FGameNames.Free;
  finally
    inherited;
  end;  
end;

function TGameManager.getGameCount: Integer;
begin
  Result := FGameNames.Count;
end;

function TGameManager.getGameDesc(index: Integer): String;
begin
  Result := uFileManager.getStringFromFile(FDataDir + FGameNames[index] +
    '\description.txt');
end;

function TGameManager.getGameName(index: Integer): String;
begin
  Result := FGameNames[index];
end;

procedure TGameManager.LoadGameNames();
begin
  uFileManager.getDirList(FDataDir, '*.*', FGameNames);
end;

procedure TGameManager.LoadTroops(const filename: String);
const
  PREFIX_TROOP = 'trp_';
var
  ss: TStringList;
  i, j, k: Integer;
  s: String;
begin
  FTroops.Clear;

  ss := TStringList.Create;
  try
    ss.LoadFromFile(filename);
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
          FTroops.Add(Format('%s [%d]', [s, FTroops.Count]));
        end;
      end;
    end;
  finally
    ss.Free;
  end;
end;

function TGameManager.SwitchToGame(const index: Integer): Boolean;
var
  i: Integer;
begin

end;

initialization
begin
  gGameManager := TGameManager.Create;
end;

end.
