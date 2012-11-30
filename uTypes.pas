unit uTypes;

interface
  uses Windows;
  
type
  TDataAction = (daIncrementItemId, daDuplicate, daModificate);

  TGameItem = packed record
    id: Integer;
    used_ammount: Word;
    unk: byte;
    flag: byte;
  end;

  TUnitEntry = packed record
    count: Integer;
    id: Integer;
    prisoner: BOOL;
    unk2: Integer;
    wounded: Integer;
    upgrade_ready: Integer;
    unk4: Integer;
    pUnk: Pointer;
  end;

implementation

end.
