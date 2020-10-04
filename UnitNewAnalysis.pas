unit UnitNewAnalysis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, TypInfo;

type
  TfrmNewAnalysis = class(TForm)
    Label1: TLabel;
    cbProjectType: TComboBox;
    Label2: TLabel;
    txtRootFolder: TEdit;
    btnSelectFolder: TButton;
    btnNext: TButton;
    procedure btnSelectFolderClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmNewAnalysis: TfrmNewAnalysis;

implementation

{$R *.dfm}

uses UnitMain, Mat.SupportedDevelopmentTools;

procedure TfrmNewAnalysis.btnNextClick(Sender: TObject);
begin
frmMain:=tfrmMain.create(self);
frmMain.show;
end;

procedure TfrmNewAnalysis.btnSelectFolderClick(Sender: TObject);

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

procedure TfrmNewAnalysis.FormCreate(Sender: TObject);
var i: Integer;
begin
  for i := Ord(Low(TSupportedDevelopmentTools)) to Ord(High(TSupportedDevelopmentTools)) do
 cbProjectType.Items.Add(GetEnumName(TypeInfo(TSupportedDevelopmentTools), i));
end;




end.
