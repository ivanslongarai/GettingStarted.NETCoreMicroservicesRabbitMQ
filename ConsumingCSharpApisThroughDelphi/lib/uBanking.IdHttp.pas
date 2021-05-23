unit uBanking.IdHttp;

interface

uses
  SysUtils, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHttp, IdSSLOpenSSL,
  uTransfer, System.Classes, Rest.Json;

type
  TBankingIdHttp = class
  private
    class var IdHttp: TIdHTTP;
    class var IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    class procedure InitIdHttp;
    class procedure FreeIdHttp;
  public
    class function Get(AUrl: string): string;
    class function Post(AUrl: string; ATransfer: TTransfer): string;
  end;

implementation

uses Pkg.Json.DTO;

class function TBankingIdHttp.Get(AUrl: string): string;
begin
  InitIdHttp;
  try
    Result := '{"Items":' + IdHttp.Get(AUrl) + '}';
  finally
    FreeIdHttp;
  end;
end;

class function TBankingIdHttp.Post(AUrl: string; ATransfer: TTransfer): string;
var
  JsonToSend: TStringStream;
begin
  InitIdHttp;
  try
    JsonToSend := TStringStream.Create(TJson.ObjectToJsonString(ATransfer));
    Result := TJsonDTO.PrettyPrintJSON(IdHttp.Post(AUrl, JsonToSend));
  finally
    FreeIdHttp;
    FreeAndNil(JsonToSend);
  end;
end;

class procedure TBankingIdHttp.InitIdHttp;
begin
  IdHttp := TIdHTTP.Create(nil);
  IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHttp.IOHandler := IdSSLIOHandlerSocketOpenSSL;
  IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv23;
  IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := sslmUnassigned;
  IdHttp.Request.ContentType := 'application/json';
  IdHttp.Request.ContentEncoding := 'UTF-8';
end;

class procedure TBankingIdHttp.FreeIdHttp;
begin
  FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
  FreeAndNil(IdHttp);
end;

end.
