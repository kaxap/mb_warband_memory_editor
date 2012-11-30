unit uConst;

interface
uses uTypes;

const
  NULL_GAME_ITEM: TGameItem = (id: 0);

  TAG_SYNCED = 0;
  TAG_MODIFIED = 1;
  TAG_INDEX = 3;
  TAG_DATA = 4;

  OFFSET_STAT_POINTS = -$10;
  OFFSET_WEAPON_POINTS = -$C;
  OFFSET_SKILL_POINTS = -$14;
  OFFSET_STR = -$60;
  OFFSET_AGI = -$5C;
  OFFSET_INT = -$58;
  OFFSET_CHA = -$54;
  OFFSET_MONEY = +$300;
  OFFSET_WEAPON_ONEHANDED = -$38;
  OFFSET_WEAPON_TWOHANDED = -$34;
  OFFSET_WEAPON_POLEARMS = -$30;
  OFFSET_WEAPON_ARCHERY = -$2C;
  OFFSET_WEAPON_CROSSBOWS = -$28;
  OFFSET_WEAPON_THROWING = -$24;
  OFFSET_WEAPON_UNK1 = -$20;
  OFFSET_WEAPON_UNK2 = -$1C;
  OFFSET_WEAPON_UNK3 = -$18;
  OFFSET_WEAPON_UNK4 = -$14;

  STR_FILE_OFFSETS = 'offsets.ini';
  STR_SECTION_OFFSETS = 'offsets';
  STR_OFFSET_CHAR = 'CHAR';
  STR_OFFSET_TABLE = 'TABLE';
  STR_OFFSET_INVENTORY = 'INVENTORY';
  STR_OFFSET_PARTY_OFFSET1 = 'PARTY_1';
  STR_OFFSET_PARTY_OFFSET2 = 'PARTY_2';
  STR_OFFSET_PARTY_OFFSET3 = 'PARTY_3';
  STR_OFFSET_PARTY_COUNT = 'PARTY_COUNT';
  STR_OFFSET_WEAPON_SKILL_LIMIT = 'WEAPON_SKILL_LIMIT';
  
implementation

end.
