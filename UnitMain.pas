unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.DBGrids, Vcl.ToolWin, System.ImageList,
  Vcl.ImgList, TypInfo, Vcl.Imaging.GIFImg,  System.IOUtils;

type
  TfrmMain = class(TForm)
    pcMain: TPageControl;
    pBottom: TPanel;
    tsUnits: TTabSheet;
    tsComponents: TTabSheet;
    tsProjects: TTabSheet;
    tsProjectGroups: TTabSheet;
    tsSummary: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    lProjectGroups: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    tsSelectProject: TTabSheet;
    btnSelectFolder: TButton;
    txtRootFolder: TEdit;
    Label21: TLabel;
    btnNext: TButton;
    cbProjectType: TComboBox;
    Label22: TLabel;
    ProgressBar1: TProgressBar;
    Image1: TImage;
    sgProjectGroup: TStringGrid;
    sgProjects: TStringGrid;
    sgUnits: TStringGrid;
    sgComponents: TStringGrid;
    chbxRecursively: TCheckBox;
    Memo1: TMemo;

    procedure btnSelectFolderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

uses Mat.SupportedDevelopmentTools, ProjectParserClasses;

procedure ClearStringGrid(const Grid: TStringGrid);
var
  c, r: Integer;
begin
  for c := 0 to Pred(Grid.ColCount) do
    for r := 0 to Pred(Grid.RowCount) do
      Grid.Cells[c, r] := '';
end;


procedure TfrmMain.btnNextClick(Sender: TObject);
var
  LPath: string;
  pf: TProjectFile;
begin
  ClearStringGrid(sgProjects);
  LPath := txtRootFolder.Text;
  if TDirectory.Exists(LPath) then
  begin
    ProjectsList.ParseDirectory(LPath, chbxRecursively.Checked);
    for pf in ProjectsList do
    begin
      if pf.Title.IsEmpty then
      //  lstProjectsList.Items.Add(pf.FileName)
      memo1.Lines.Add(pf.FileName)
      else
      //  lstProjectsList.Items.Add(pf.Title + ' (' + pf.FileName + ')');
         memo1.Lines.Add(pf.Title + ' (' + pf.FileName + ')');
        memo1.Lines.Add( pf.Units[0].UnitFileName );
    end;
   // lstProjectsList.Items.SaveToFile('list.txt');
  end
  else
    ShowMessage('Incorrect path');
end;


procedure TfrmMain.btnSelectFolderClick(Sender: TObject);
begin
    with TFileOpenDialog.Create(nil) do
    try
        Options := [fdoPickFolders];
        if Execute then
            txtRootFolder.Text := FileName;
    finally
        Free;
    end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var i: Integer;
begin
  for i := Ord(Low(TSupportedDevelopmentTools)) to Ord(High(TSupportedDevelopmentTools)) do
 cbProjectType.Items.Add(GetEnumName(TypeInfo(TSupportedDevelopmentTools), i));
end;


end.
