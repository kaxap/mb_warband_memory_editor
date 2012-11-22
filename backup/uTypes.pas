unit uTypes;

interface

type
  TDataAction = (daIncrementItemId, daDuplicate, daModificate);

  TGameItem = packed record
    id: Integer;
    used_ammount: Word;
    unk: byte;
    flag: byte;
  end;


implementation

end.
