library ISLIdHttpRequest;

uses
  IdHTTP,
  Vcl.Forms,
  Vcl.Dialogs,
  IdMultipartFormData,
  Winapi.Windows,
  System.SysUtils,
  System.Classes,
  IdSSLOpenSSL,
  uOutputStream in '..\lib\uOutputStream.pas';

{$R *.res}

type
  TExtendedIdHTTP = Class(TIdHTTP)
  private
  protected
    function DeleteWithSource(AUrl, ASource, AHeaderP, AHeaderV: WideString): WideString;
  public
  End;

var
  IdHTTP: TExtendedIdHTTP;
  IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;

function TExtendedIdHTTP.DeleteWithSource(AUrl, ASource, AHeaderP, AHeaderV: WideString): WideString;
var
  JsonStream: TStringStream;
begin
  JsonStream := TStringStream.Create;
  JsonStream.WriteString(ASource);
  if AHeaderP <> '' then
    Self.Request.CustomHeaders.AddValue(AHeaderP, AHeaderV);
  DoRequest(Id_HTTPMethodDelete, AUrl, JsonStream, nil, []);
end;

procedure Init;
begin
  IdHTTP.Request.ContentType := 'application/json';
  IdHTTP.Request.ContentEncoding := 'UTF-8';
end;

procedure CreateObjects(AUrl: string);
begin
  IdHTTP := TExtendedIdHTTP.Create(nil);
  if Pos('https', AnsiLowerCase(AUrl)) > 0 then
  begin
    IdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
    IdHTTP.IOHandler := IdSSLIOHandlerSocketOpenSSL;
    IdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv23;
    IdSSLIOHandlerSocketOpenSSL.SSLOptions.Mode := sslmUnassigned;
  end;
  Init;
end;

procedure DestroyObjects;
begin
  if Assigned(IdSSLIOHandlerSocketOpenSSL) then
    FreeAndNil(IdSSLIOHandlerSocketOpenSSL);
  FreeAndNil(IdHTTP);
end;

function Delete(AUrl, AHeaderP, AHeaderV: WideString): WideString; stdcall; export;
begin
  CreateObjects(AUrl);
  try
    if AHeaderP <> '' then
      IdHTTP.Request.CustomHeaders.AddValue(AHeaderP, AHeaderV);
    IdHTTP.Delete(AUrl);
  except
    on E: Exception do
    begin
      Result := IdHTTP.ResponseText;
      DestroyObjects;
      Exit;
    end;
  end;
  Result := IdHTTP.ResponseText;
  DestroyObjects;
end;

function DeleteWithSource(AUrl, ASource, AHeaderP, AHeaderV: WideString): WideString; stdcall; export;
begin
  CreateObjects(AUrl);
  try
    IdHTTP.DeleteWithSource(AUrl, ASource, AHeaderP, AHeaderV);
  except
    on E: Exception do
    begin
      Result := IdHTTP.ResponseText;
      DestroyObjects;
      Exit;
    end;
  end;
  Result := IdHTTP.ResponseText;
  DestroyObjects;
end;

function Put(AUrl, AJsonSource, AHeaderP, AHeaderV: WideString): WideString; stdcall; export;
var
  vSource: TStringStream;
begin
  CreateObjects(AUrl);
  vSource := TStringStream.Create(AJsonSource);
  try
    if AHeaderP <> '' then
      IdHTTP.Request.CustomHeaders.AddValue(AHeaderP, AHeaderV);
    Result := IdHTTP.Put(AUrl, vSource);
  except
    on E: Exception do
    begin
      Result := IdHTTP.ResponseText;
      DestroyObjects;
      Exit;
    end;
  end;
  if Result = '' then
    Result := IdHTTP.ResponseText;
  FreeAndNil(vSource);
  DestroyObjects;
end;

function Get(AUrl, AHeaderP, AHeaderV: WideString): WideString; stdcall; export;
begin
  CreateObjects(AUrl);
  try
    if AHeaderP <> '' then
      IdHTTP.Request.CustomHeaders.AddValue(AHeaderP, AHeaderV);
    Result := IdHTTP.Get(AUrl);
  except
    on E: Exception do
    begin
      Result := IdHTTP.ResponseText;
      DestroyObjects;
      Exit;
    end;
  end;
  if Result = '' then
    Result := IdHTTP.ResponseText;
  DestroyObjects;
end;

function Post(AUrl, AJson, AHeaderP, AHeaderV: WideString): WideString; stdcall; export;
var
  JsonToSend: TStringStream;
begin
  CreateObjects(AUrl);
  try
    JsonToSend := TStringStream.Create(AJson);
    if AHeaderP <> '' then
      IdHTTP.Request.CustomHeaders.AddValue(AHeaderP, AHeaderV);
    Result := IdHTTP.Post(AUrl, JsonToSend);
  except
    on E: Exception do
    begin
      Result := IdHTTP.ResponseText;
      DestroyObjects;
      Exit;
    end;
  end;
  if Result = '' then
    Result := IdHTTP.ResponseText;
  DestroyObjects;
end;

function PostUpload(AUrl, AJsonPath, AAnexoPath, ATipoAnexo, AHeaderP, AHeaderV: WideString): WideString; stdcall; export;
var
  idMultiPart: TIdMultiPartFormDataStream;
  sDirectory: string;
  sNewFile: string;
begin
  sDirectory := ExtractFilePath(Application.ExeName);
  if sDirectory[High(sDirectory)] <> '\' then
    sDirectory := sDirectory + '\';
  ForceDirectories(sDirectory + 'ArquivosJson\');
  sNewFile := sDirectory + 'ArquivosJson\' + ExtractFileName(FormatDatetime('ddmmyyyyhhnnss', Now) + AJsonPath);
  CopyFile(PChar(AJsonPath), PChar(sNewFile), False);
  CreateObjects(AUrl);
  Init;
  idMultiPart := TIdMultiPartFormDataStream.Create;
  idMultiPart.AddFile('json', sNewFile, 'application/json');
  idMultiPart.AddFile(ATipoAnexo, AAnexoPath, 'multipart/form-data');
  if AHeaderP <> '' then
    IdHTTP.Request.CustomHeaders.AddValue(AHeaderP, AHeaderV);
  IdHTTP.Request.ContentType := 'multipart/form-data';
  Result := IdHTTP.Post(AUrl, idMultiPart);
  if Result = '' then
    Result := IdHTTP.ResponseText;
  FreeAndNil(idMultiPart);
  DestroyObjects;
  try
    DeleteFile(sNewFile);
    DeleteFile(AJsonPath);
  except
  end;
end;

function PostDownload(AUrl, AJson, AFileName, AHeaderP, AHeaderV: WideString): WideString; stdcall; export;
var
  JsonToSend: TStringStream;
  objMemory: TMemoryStream;
  objOutPut: TOutputStream;
begin
  Result := '';
  try
    CreateObjects(AUrl);
    JsonToSend := TStringStream.Create(AJson);
    if AHeaderP <> '' then
      IdHTTP.Request.CustomHeaders.AddValue(AHeaderP, AHeaderV);
    Result := IdHTTP.Post(AUrl, JsonToSend);
    if Result <> '' then
    begin
      try
        objMemory := TMemoryStream.Create;
        objOutPut := TOutputStream.Create;
        objOutPut.Stream := objMemory;
        objOutPut.Write(Result);
        objOutPut.Flush;
        objOutPut.Close;
        objMemory.SaveToFile(AFileName);
      finally
        FreeAndNil(objOutPut);
      end;
    end
    else
      Result := IdHTTP.ResponseText;
  finally
    DestroyObjects;
  end;
end;

exports Delete;

exports DeleteWithSource;

exports Put;

exports Get;

exports Post;

exports PostUpload;

exports PostDownload;

begin

end.
