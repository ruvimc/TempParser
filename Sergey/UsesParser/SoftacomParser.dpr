program SoftacomParser;

uses
  Vcl.Forms,
  SoftacomParserMainFormUnit in 'SoftacomParserMainFormUnit.pas' {Form1},
  SoftacomParser.ProjectParser in 'Units\SoftacomParser.ProjectParser.pas',
  SoftacomParser.UnitParser in 'Units\SoftacomParser.UnitParser.pas',
  SoftacomParser.ProjectGroupParser in 'Units\SoftacomParser.ProjectGroupParser.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
