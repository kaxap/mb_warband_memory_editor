unit uFileManager;

interface
  uses Windows, Classes, SysUtils;

var
  gstrRootDir: String;

  function AddSlash(const path: String): String;
  function getAllList(const path, mask: String; const attr: Integer;
    list: TStrings): Integer;
  function getFileList(const path, mask: String; list: TStrings): Integer;
  function getDirList(const path, mask: String; list: TStrings): Integer;
  function getStringFromFile(const filename: String): String;

implementation

function getStringFromFile(const filename: String): String;
var
  ss: TStringList;
begin
  ss := TStringList.Create;
  try
    ss.LoadFromFile(filename);
    Result := ss.GetText;
  except
    Result := '';
  end;
  ss.Free;
end;

function getFileList(const path, mask: String; list: TStrings): Integer;
begin
  Result := getAllList(path, mask, faAnyFile XOR faDirectory, list);
end;

function getDirList(const path, mask: String; list: TStrings): Integer;
begin
  Result := getAllList(path, mask, faDirectory, list);
end;

function AddSlash(const path: String): String;
//add slash at the end if absent
var
  lastChar: String;
begin
  lastChar := path[Length(path)];

  if (lastChar <> '\') OR (lastChar <> '/') then
    Result := path + '\'
  else
    Result := path;
end;


function getAllList(const path, mask: String; const attr: Integer;
  list: TStrings): Integer;

var SearchRec: TSearchRec;
    DirWithMask: string;
begin
  if path = '' then
    Exit;

  list.Clear;

  DirWithMask := AddSlash(path) + mask;

  //enum
  if FindFirst(DirWithMask, attr, SearchRec) = 0 then
  begin
    repeat

      if (SearchRec.Attr <> attr) or
         (SearchRec.Name = '.') or
         (SearchRec.Name = '..') then continue;

      list.Add(SearchRec.Name);

    until FindNext(SearchRec)<>0;

    FindClose(SearchRec);

    //return count
    Result := list.Count;
  end else // if FindFirst <> 0...
    Result := 0;
end;


initialization
  gstrRootDir := ExtractFilePath(ParamStr(0));


end.
