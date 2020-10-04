program Stc.MigrationAnalysisTool;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {frmMain},
  Mat.SupportedDevelopmentTools in 'Classes\Mat.SupportedDevelopmentTools.pas',
  UnitParserClasses in 'Classes\UnitParserClasses.pas',
  ProjectParserClasses in 'Classes\ProjectParserClasses.pas',
  ProjectGroupParserClasses in 'Classes\ProjectGroupParserClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
