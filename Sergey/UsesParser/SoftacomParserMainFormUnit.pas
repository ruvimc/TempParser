unit SoftacomParserMainFormUnit;

interface

uses
  rtlconsts,
  winsock,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.IOUtils,
  Vcl.ComCtrls;

type
  TForm1 = class(TForm)
    edtDirecotory: TEdit;
    chbxRecursively: TCheckBox;
    btnSelectDirectory: TButton;
    gbDirectory: TGroupBox;
    pnlBottom: TPanel;
    btnRunParsingUses: TButton;
    mmoUnits: TMemo;
    dlgOpenDirectory: TFileOpenDialog;
    lstComponentsGroup: TListBox;
    pgcFunctions: TPageControl;
    tsParsingUses: TTabSheet;
    tsParsingProjects: TTabSheet;
    lstProjectsList: TListBox;
    pnlParsingProjects: TPanel;
    btnRunParsingProjects: TButton;
    lstProjectUnitUses: TListBox;
    lstProjectUnits: TListBox;
    Panel1: TPanel;
    pnlProjectsListTitle: TPanel;
    pnlProjectUnitsTitle: TPanel;
    Panel4: TPanel;
    splProjectsList: TSplitter;
    splProjectUnits: TSplitter;
    Button1: TButton;
    lstProjectsGroupList: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure btnSelectDirectoryClick(Sender: TObject);
    procedure btnRunParsingUsesClick(Sender: TObject);
    procedure btnRunParsingProjectsClick(Sender: TObject);
    procedure lstProjectsListClick(Sender: TObject);
    procedure lstProjectUnitsClick(Sender: TObject);
    procedure splProjectsListMoved(Sender: TObject);
    procedure splProjectUnitsMoved(Sender: TObject);
   procedure Button1Click(Sender: TObject);
    procedure lstProjectsGroupListClick(Sender: TObject);
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  SoftacomParser.UnitParser, SoftacomParser.ProjectParser,
  SoftacomParser.ProjectGroupParser;

procedure TForm1.FormCreate(Sender: TObject);
begin
  edtDirecotory.Text := 'C:\Release'; //TPath.GetLibraryPath;
  dlgOpenDirectory.DefaultFolder := TPath.GetLibraryPath;
end;

procedure TForm1.lstProjectsGroupListClick(Sender: TObject);
var
  pf: TProjectFile;
begin
  lstProjectsList.Items.Clear;
  for pf in ProjectsGroupList[lstProjectsGroupList.ItemIndex].Projects do
    lstProjectsList.Items.Add(pf.Title + ' 1 ' + pf.FileName + ' 2 ' + pf.FullPath);
  showmessage(inttostr(ProjectsGroupList[0].Projects.count));
end;



procedure TForm1.lstProjectsListClick(Sender: TObject);
var
  uf: TUnitFile;
begin
  lstProjectUnitUses.Items.Clear;
  lstProjectUnits.Items.Clear;

 // for uf in ProjectsList[lstProjectsList.ItemIndex].Units do
  //  lstProjectUnits.Items.Add(uf.UnitFileName + ' ' + uf.UnitPath + ' ' + uf.ClassVariable);

   for uf in   ProjectsGroupList[0].Projects[lstProjectsList.ItemIndex].Units do
    lstProjectUnits.Items.Add(uf.UnitFileName + ' ' + uf.UnitPath + ' ' + uf.ClassVariable);

end;

procedure TForm1.lstProjectUnitsClick(Sender: TObject);
var
  u: string;
begin
  lstProjectUnitUses.Items.Clear;
  for u in ProjectsGroupList[0].Projects[lstProjectsList.ItemIndex].Units[lstProjectUnits.ItemIndex].UsesList do
    lstProjectUnitUses.Items.Add(u);
end;

procedure TForm1.splProjectsListMoved(Sender: TObject);
begin
  pnlProjectsListTitle.Width := lstProjectsList.Width + splProjectsList.Width;
end;

procedure TForm1.splProjectUnitsMoved(Sender: TObject);
begin
  pnlProjectUnitsTitle.Width := lstProjectUnits.Width + splProjectUnits.Width;
end;

procedure TForm1.btnSelectDirectoryClick(Sender: TObject);
begin
  if dlgOpenDirectory.Execute then
  begin
    edtDirecotory.Text := dlgOpenDirectory.FileName;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  LPath: string;
  pgf: TProjectGroupFile;
begin
  lstProjectsGroupList.Clear;
  LPath := edtDirecotory.Text;
  if TDirectory.Exists(LPath) then
  begin
    ProjectsGroupList.ParseDirectory(LPath, chbxRecursively.Checked);
    for pgf in ProjectsGroupList do
    begin
      if pgf.Title.IsEmpty then
        lstProjectsGroupList.Items.Add(pgf.FileName +' : '+ pgf.Version +' : '+ pgf.FullPath )
      else
        lstProjectsGroupList.Items.Add(pgf.Title + ' (' + pgf.FileName + ')');
    end;
    lstProjectsGroupList.Items.SaveToFile('list2.txt');
  end
  else
    ShowMessage('Incorrect path');
end;

procedure TForm1.btnRunParsingUsesClick(Sender: TObject);
var
  LPath: string;
begin
  mmoUnits.Clear;
  LPath := edtDirecotory.Text;
  if TDirectory.Exists(LPath) then
  begin
    UnitParser.ParseDirectories(LPath, chbxRecursively.Checked);
    mmoUnits.Lines.Assign(UnitParser.Units);
    lstComponentsGroup.Items.Assign(UnitParser.ComponentsGroup);
  end
  else
    ShowMessage('Incorrect path');
end;

procedure TForm1.btnRunParsingProjectsClick(Sender: TObject);
var
  LPath: string;
  pf: TProjectFile;
begin
  lstProjectsList.Clear;
  LPath := edtDirecotory.Text;
  if TDirectory.Exists(LPath) then
  begin
    ProjectsList.ParseDirectory(LPath, chbxRecursively.Checked);
    for pf in ProjectsList do
    begin
      if pf.Title.IsEmpty then
        lstProjectsList.Items.Add(pf.FileName)
      else
        lstProjectsList.Items.Add(pf.Title + ' (' + pf.FileName + ')');
    end;
    lstProjectsList.Items.SaveToFile('list.txt');
  end
  else
    ShowMessage('Incorrect path');
end;

end.

