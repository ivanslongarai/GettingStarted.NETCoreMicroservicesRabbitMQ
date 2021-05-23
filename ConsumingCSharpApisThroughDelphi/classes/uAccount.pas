//Unit created at: https://jsontodelphi.com/

unit uAccount;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TAccount = class
  private
    FAccountBalance: double;
    FAccountType: string;
    FId: Integer;
  published
    property AccountBalance: double read FAccountBalance write FAccountBalance;
    property AccountType: string read FAccountType write FAccountType;
    property Id: Integer read FId write FId;
  end;

  TAccountDTO = class(TJsonDTO)
  private
    [JSONName('Items')]
    FItemsArray: TArray<TAccount>;
    [GenericListReflect]
    FItems: TObjectList<TAccount>;
    function GetItems: TObjectList<TAccount>;
  published
    property Items: TObjectList<TAccount> read GetItems;
    destructor Destroy; override;
  end;

implementation

destructor TAccountDTO.Destroy;
begin
  GetItems.Free;
  inherited;
end;

function TAccountDTO.GetItems: TObjectList<TAccount>;
begin
  if not Assigned(FItems) then
  begin
    FItems := TObjectList<TAccount>.Create;
    FItems.AddRange(FItemsArray);
  end;
  Result := FItems;
end;

end.

