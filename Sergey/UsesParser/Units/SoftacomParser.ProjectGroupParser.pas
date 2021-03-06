unit SoftacomParser.ProjectGroupParser;

interface

uses
  System.Generics.Collections, System.Classes, System.SysUtils, System.IOUtils,
  SoftacomParser.ProjectParser, dialogs;

type

  TProjectGroupFile = class
  private
    FFullPath: string;
    FTitle: string;
    FVersion: string;
    FProjects: TProjectsList;
    function GetFileName: string;
  protected
    function ParseItem(const AStr: string): TProjectFile;
  public
    constructor Create;
    destructor Destroy; override;

    property FullPath: string read FFullPath write FFullPath;
    property FileName: string read GetFileName;
    property Title: string read FTitle write FTitle;
    property Projects: TProjectsList read FProjects write FProjects;
    property Version: string read FVersion write FVersion;
    procedure ParseVersion(const ABlock: string);
  end;

  TProjectsGroupList = class(TList<TProjectGroupFile>)
  protected
    function ParseFile(const APath: string): TProjectGroupFile;
  public
    procedure ParseDirectory(const ADirectory: string; AIsRecursively: Boolean);
  end;

function ProjectsGroupList: TProjectsGroupList;

const
  CRLF = #10#13;

implementation

// uses


uses SoftacomParserMainFormUnit;// SoftacomParser.UnitParser;

var
  FProjectsGroupList: TProjectsGroupList;

function ProjectsGroupList: TProjectsGroupList;
begin
  Result := FProjectsGroupList;
end;

{ TProjectFile }

constructor TProjectGroupFile.Create;
begin
  FProjects := TProjectsList.Create;
end;

destructor TProjectGroupFile.Destroy;
begin
  FProjects.Free;
  inherited;
end;

function TProjectGroupFile.GetFileName: string;
begin
  Result := TPath.GetFileNameWithoutExtension(FFullPath);
end;

function TProjectGroupFile.ParseItem(const AStr: string): TProjectFile;
var
  LData: string;
  p: PChar;
  s: string;
  index: Integer;
  pause: Boolean;
  function PathCombine(a, b: string): string;
  var
    sl1, sl2: TStringList;
    drive: string;
    i: Integer;
  begin
    drive := '';
    sl1 := TStringList.Create;
    sl2 := TStringList.Create;
    try
      if a[2] = ':' then
      begin
        drive := a[1];
        sl1.Delimiter := TPath.DirectorySeparatorChar;
        sl1.DelimitedText := a.Substring(2);
      end
      else

      sl1.DelimitedText := a;
      sl2.Delimiter := TPath.DirectorySeparatorChar;
      sl2.DelimitedText := b;

      while (sl2.Count > 0) and (sl2[0] = '..') do
      begin
        sl1.Delete(sl1.Count - 1);
        sl2.Delete(0);
      end;
      if not drive.IsEmpty then
        Result := drive + ':';
      for i := 0 to sl1.Count - 1 do
        if not sl1[i].IsEmpty then
          Result := Result + TPath.DirectorySeparatorChar + sl1[i];
      for i := 0 to sl2.Count - 1 do
        Result := Result + TPath.DirectorySeparatorChar + sl2[i];
    finally
      sl2.Free;
      sl1.Free;
    end;


  end;

begin

  LData := AStr.Trim + ' ';
  p := PChar(LData);
  Result := TProjectFile.Create;
  index := 1;
  pause := False;
  s := '';
  while (p^ <> #0) do
  begin
    if not pause then
      s := s + p^;
    if ((p^ = ' ') and (s[s.Trim.Length] <> ' ')) or (p^ = #0) then
    begin
      s := s.Trim;
      if s.Equals(':') then
        s := ''
      else
        pause := True;
    end;
    if pause and not s.IsEmpty then
    begin
      case index of
        1:          Result.Title := s;
        2:
          begin
            if s.Trim[1] = '''' then
              s := s.Substring(1);
            if s.Trim[s.Trim.Length] = '''' then
              s := s.Substring(0, s.Trim.Length - 1);
              if (not s.IsEmpty) and (not((s[1] = '.') and (s[2] = '.'))) then
              begin
             s := TPath.Combine(TPath.GetDirectoryName(FFullPath), s);
             end  else
             if (not s.IsEmpty) and ((s[1] = '.') and (s[2] = '.')) then
            begin
            s := PathCombine(TPath.GetDirectoryName(FFullPath), s);
            end
            else if TPath.GetFileName(s)<> s then
            s:= TPath.GetDirectoryName(FFullPath) +  TPath.DirectorySeparatorChar + s;


            Result.FullPath := s;

          end;
      end;
      pause := False;
      inc(index);
      s := '';
    end;
    inc(p);
  end;

        FProjects.Add(ProjectsList.ParseFile(Result.FullPath));
end;

procedure TProjectGroupFile.ParseVersion(const ABlock: string);
var
  s: string;
const
  t = 'version';
begin
  s := ABlock.Substring(Pos(t, ABlock.ToLower) + t.Length).Trim;
  if s[1] = '=' then
    s := s.Substring(2).Trim;
  FVersion:= s;
end;

{ TProjectsList }

procedure TProjectsGroupList.ParseDirectory(const ADirectory: string;
  AIsRecursively: Boolean);
var
  LDirectories: TArray<string>;
  LFiles: TArray<string>;
  LCurrentPath: string;
  LPF: TProjectGroupFile;
begin
  if AIsRecursively then
  begin
    LDirectories := TDirectory.GetDirectories(ADirectory);
    for LCurrentPath in LDirectories do
      ParseDirectory(LCurrentPath, True);
  end;
  LFiles := TDirectory.GetFiles(ADirectory, '*.bpg');
  for LCurrentPath in LFiles do
  begin
    LPF := ParseFile(LCurrentPath);
    Add(LPF);
  end;
end;

function TProjectsGroupList.ParseFile(const APath: string): TProjectGroupFile;
var
  LRowProjectsList: TStringList;
  LFileData: TStringList;
  i: Integer;
  LBlock: string;
  LIsVersionFound: Boolean;
  s: string;
const
  proj = '.dpr';
  vers = 'version';
begin
  Result := TProjectGroupFile.Create;

  LBlock := '';
  LRowProjectsList := nil;
  LFileData := nil;
  try
    LFileData := TStringList.Create;
    LRowProjectsList := TStringList.Create;
    if TFile.Exists(APath) then
    begin
      LFileData.LoadFromFile(APath);
      Result.FullPath := APath;
      LIsVersionFound := False;
      for i := 0 to Pred(LFileData.Count) do
      begin
        if (Pos(proj, LFileData[i].Trim.ToLower) > 0) then
        begin
          LRowProjectsList.Add(LFileData[i].Trim.ToLower);
          Result.ParseItem(LFileData[i].Trim.ToLower);
        end;

        if not LIsVersionFound then
        begin
          if (Pos(vers, LFileData[i].Trim.ToLower) > 0) then
          begin
            Result.ParseVersion(LFileData[i]);
            LIsVersionFound := not Result.FVersion.IsEmpty;
          end;
        end;
      end;
    end;
  finally
    LRowProjectsList.Free;
    LFileData.Free
      end;

end;

initialization

FProjectsGroupList := TProjectsGroupList.Create;

finalization

FProjectsGroupList.Free;

end.
