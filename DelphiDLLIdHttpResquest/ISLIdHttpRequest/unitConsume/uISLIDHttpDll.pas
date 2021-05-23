unit uISLIDHttpDll;

interface
uses Windows;

type
  TISLIDHttp = class
  public
    class function Delete(AUrl, AHeaderP, AHeaderV: WideString): WideString;
    class function DeleteWithSource(AUrl, ASource, AHeaderP, AHeaderV: WideString): WideString;
    class function Put(AUrl, AJsonSource, AHeaderP, AHeaderV: WideString): WideString;
    class function Get(AUrl, AHeaderP, AHeaderV: WideString): WideString;
    class function Post(AUrl, AJson, AHeaderP, AHeaderV: WideString): WideString;
    class function PostUpload(AUrl, AJsonPath, AAnexoPath, ATipoAnexo, AHeaderP, AHeaderV: WideString): WideString;
    class function PostDownload(AUrl, AJson, AFileName, AHeaderP, AHeaderV: WideString): WideString;
  end;

implementation

const
  cLibrary = 'ISLIdHttpRequest.dll';

type
  TDelete = function(AUrl, AHeaderP, AHeaderV: WideString): WideString; stdcall;
  TDeleteWithSource = function(AUrl, ASource, AHeaderP, AHeaderV: WideString): WideString; stdcall;
  TPut = function(AUrl, AJsonSource, AHeaderP, AHeaderV: WideString): WideString; stdcall;
  TGet = function(AUrl, AHeaderP, AHeaderV: WideString): WideString; stdcall;
  TPost = function(AUrl, AJson, AHeaderP, AHeaderV: WideString): WideString; stdcall;
  TPostUpload = function(AUrl, AJsonPath, AAnexoPath, ATipoAnexo, AHeaderP, AHeaderV: WideString): WideString; stdcall;
  TPostDownload = function(AUrl, AJson, AFileName, AHeaderP, AHeaderV: WideString): WideString; stdcall;

class function TISLIDHttp.Delete(AUrl, AHeaderP, AHeaderV: WideString): WideString;
var
  Handle: THandle;
  Delete: TDelete;
begin
  Result := '';
  Handle := LoadLibrary(cLibrary);
  if Handle <> 0 then
  begin
    @Delete := GetProcAddress(Handle, 'Delete');
    if @Delete <> nil then
      Result := Delete(AUrl, AHeaderP, AHeaderV);
    FreeLibrary(Handle);
  end;
end;

class function TISLIDHttp.DeleteWithSource(AUrl, ASource, AHeaderP, AHeaderV: WideString): WideString;
var
  Handle: THandle;
  DeleteWithSource: TDeleteWithSource;
begin
  Result := '';
  Handle := LoadLibrary(cLibrary);
  if Handle <> 0 then
  begin
    @DeleteWithSource := GetProcAddress(Handle, 'DeleteWithSource');
    if @DeleteWithSource <> nil then
      Result := DeleteWithSource(AUrl, ASource, AHeaderP, AHeaderV);
    FreeLibrary(Handle);
  end;

end;

class function TISLIDHttp.Put(AUrl, AJsonSource, AHeaderP, AHeaderV: WideString): WideString;
var
  Handle: THandle;
  Put: TPut;
begin
  Handle := LoadLibrary(cLibrary);
  if Handle <> 0 then
  begin
    @Put := GetProcAddress(Handle, 'Put');
    if @Put <> nil then
      Result := Put(AUrl, AJsonSource, AHeaderP, AHeaderV);
    FreeLibrary(Handle);
  end;
end;

class function TISLIDHttp.Get(AUrl, AHeaderP, AHeaderV: WideString): WideString;
var
  Handle: THandle;
  Get: TGet;
begin
  Result := '';
  Handle := LoadLibrary(cLibrary);
  if Handle <> 0 then
  begin
    @Get := GetProcAddress(Handle, 'Get');
    if @Get <> nil then
      Result := Get(AUrl, AHeaderP, AHeaderV);
    FreeLibrary(Handle);
  end;
end;

class function TISLIDHttp.Post(AUrl, AJson, AHeaderP, AHeaderV: WideString): WideString;
var
  Handle: THandle;
  Post: TPost;
begin
  Result := '';
  Handle := LoadLibrary(cLibrary);
  if Handle <> 0 then
  begin
    @Post := GetProcAddress(Handle, 'Post');
    if @Post <> nil then
      Result := Post(AUrl, AJson, AHeaderP, AHeaderV);
    FreeLibrary(Handle);
  end;
end;

class function TISLIDHttp.PostUpload(AUrl, AJsonPath, AAnexoPath, ATipoAnexo, AHeaderP, AHeaderV: WideString): WideString;
var
  Handle: THandle;
  PostUpload: TPostUpload;
begin
  Result := '';
  Handle := LoadLibrary(cLibrary);
  if Handle <> 0 then
  begin
    @PostUpload := GetProcAddress(Handle, 'PostUpload');
    if @PostUpload <> nil then
      Result := PostUpload(AUrl, AJsonPath, AAnexoPath, ATipoAnexo, AHeaderP, AHeaderV);
    FreeLibrary(Handle);
  end;
end;

class function TISLIDHttp.PostDownload(AUrl, AJson, AFileName, AHeaderP, AHeaderV: WideString): WideString;
var
  Handle: THandle;
  PostDownload: TPostDownload;
begin
  Result := '';
  Handle := LoadLibrary(cLibrary);
  if Handle <> 0 then
  begin
    @PostDownload := GetProcAddress(Handle, 'PostDownload');
    if @PostDownload <> nil then
      Result := PostDownload(AUrl, AJson, AFileName, AHeaderP, AHeaderV);
    FreeLibrary(Handle);
  end;
end;

end.
