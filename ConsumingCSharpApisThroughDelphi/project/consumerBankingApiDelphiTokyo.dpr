program consumerBankingApiDelphiTokyo;

uses
  Vcl.Forms,
  uMain in '..\Src\uMain.pas' {frmMain},
  Pkg.Json.DTO in '..\lib\Pkg.Json.DTO.pas',
  uBanking.IdHttp in '..\lib\uBanking.IdHttp.pas',
  uAccount in '..\classes\uAccount.pas',
  uTransfer in '..\classes\uTransfer.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
