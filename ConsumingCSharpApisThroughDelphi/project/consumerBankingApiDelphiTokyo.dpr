program consumerBankingApiDelphiTokyo;

uses
  Vcl.Forms,
  uMain in '..\Src\uMain.pas' {frmMain},
  Pkg.Json.DTO in '..\lib\Pkg.Json.DTO.pas',
  uAccount in '..\classes\uAccount.pas',
  uTransfer in '..\classes\uTransfer.pas',
  uISLIDHttpDll in '..\lib\uISLIDHttpDll.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
