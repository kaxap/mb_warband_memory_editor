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
    FItems: TStringList;
    FWindowCaption: String;
    procedure LoadGameNames();
    function getGameCount: Integer;
    function getGameName(index: Integer): String;
    function getGameDesc(index: Integer): String;
    procedure LoadTroops(const filename: String);
    procedure LoadItems(const filename: String);
  public
    offsets: TGameOffsetsList;
    constructor Create;
    destructor Destroy; override;
    function SwitchToGame(const index: Integer): Boolean;
    property GameCount:Integer read getGameCount;
    property GameName[index: Integer]: String read getGameName;
    property GameDesc[index: Integer]: String read getGameDesc;
    property Troops: TStringList read FTroops;
    property Items: TStringList read FItems;
    property WindowCaption: String read FWindowCaption;
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
  FItems := TStringList.Create;
  LoadGameNames();
  FWindowCaption := STR_WINDOW_CAPTION_DEFAULT;
end;

destructor TGameManager.Destroy;
begin
  try
    FTroops.Free;
    FGameNames.Free;
    FItems.Free;
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
  Result := uFileManager.getStringFromFile(FDataDir + '\' +
  FGameNames[index] + '\' + STR_FILENAME_DESC);
end;

function TGameManager.getGameName(index: Integer): String;
begin
  Result := FGameNames[index];
end;

procedure TGameManager.LoadGameNames();
begin
  uFileManager.getDirList(FDataDir, '*.*', FGameNames);
end;

procedure TGameManager.LoadItems(const filename: String);
const
  PREFIX_ITEM = #32'itm_';
var
  ss: TStringList;
  i, j, k: Integer;
  s: String;
begin
  FItems.Clear;
  
  ss := TStringList.Create;
  try
    ss.LoadFromFile(filename);
    for i := 0 to ss.Count - 1 do
    begin
      if Copy(ss[i], 1, Length(PREFIX_ITEM)) = PREFIX_ITEM then
      begin
        j := PosEx(#32, ss[i], Length(PREFIX_ITEM));
        k := PosEx(#32, ss[i], j + 1);
        if j > 0 then
        begin
          s := Copy(ss[i], j + 1, k - j -1);
          FItems.Add(Format('%s [%d]', [s, FItems.Count]));

        end;
      end;
    end;
  finally
    ss.Free;
  end;

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
  ini: TIniFile;
  filename_troops, filename_items: String;
  path: String;
begin
  Result := False;
  path := FDataDir + '\' + getGameName(index) + '\';
  ini := TIniFile.Create(path + STR_FILE_GAME_SETTINGS);
  try
    //get filenames
    filename_troops := ini.ReadString(STR_SECTION_FILES, STR_FILENAME_TROOPS,
      STR_FILENAME_TROOPS);
    filename_items := ini.ReadString(STR_SECTION_FILES, STR_FILENAME_ITEMS,
      STR_FILENAME_ITEMS);

    FWindowCaption := ini.ReadString(STR_SECTION_GAME, STR_WINDOW_CAPTION,
      STR_WINDOW_CAPTION_DEFAULT);

    //load offsets  
    with offsets do
    begin
      dwChar := ini.ReadInteger(STR_SECTION_OFFSETS, STR_OFFSET_CHAR, 0);
      dwInventory := ini.ReadInteger(STR_SECTION_OFFSETS, STR_OFFSET_INVENTORY, 0);
      dwParty1 := ini.ReadInteger(STR_SECTION_OFFSETS, STR_OFFSET_PARTY_OFFSET1, 0);
      dwParty2 := ini.ReadInteger(STR_SECTION_OFFSETS, STR_OFFSET_PARTY_OFFSET2, 0);
      dwParty3 := ini.ReadInteger(STR_SECTION_OFFSETS, STR_OFFSET_PARTY_OFFSET3, 0);
      dwPartyCount := ini.ReadInteger(STR_SECTION_OFFSETS, STR_OFFSET_PARTY_COUNT, 0);

      pTable := Pointer(ini.ReadInteger(STR_SECTION_OFFSETS, STR_OFFSET_TABLE, 0));
      pWeaponSkillLimit := Pointer(ini.ReadInteger(STR_SECTION_OFFSETS,
        STR_OFFSET_WEAPON_SKILL_LIMIT, 0));
    end;
  finally
    ini.Free;
  end;

  LoadTroops(path + filename_troops);
  LoadItems(path + filename_items);
end;

initialization
begin
  gGameManager := TGameManager.Create;
end;

end.
