//Unit created at: https://jsontodelphi.com/

unit uTransfer;

interface

uses
  Pkg.Json.DTO, System.Generics.Collections, REST.Json.Types;

{$M+}

type
  TTransfer = class
  private
    FFromAccount: Integer;
    FId: Integer;
    FToAccount: Integer;
    FTransferAmount: Double;
  published
    property FromAccount: Integer read FFromAccount write FFromAccount;
    property Id: Integer read FId write FId;
    property ToAccount: Integer read FToAccount write FToAccount;
    property TransferAmount: Double read FTransferAmount write FTransferAmount;
  end;
  
  TTransferDTO = class(TJsonDTO)
  private
    [JSONName('Items')]
    FItemsArray: TArray<TTransfer>;
    [GenericListReflect]
    FItems: TObjectList<TTransfer>;
    function GetItems: TObjectList<TTransfer>;
  published
    property Items: TObjectList<TTransfer> read GetItems;
    destructor Destroy; override;
  end;
  
implementation

{ TRootDTO }

destructor TTransferDTO.Destroy;
begin
  GetItems.Free;
  inherited;
end;

function TTransferDTO.GetItems: TObjectList<TTransfer>;
begin
  if not Assigned(FItems) then
  begin
    FItems := TObjectList<TTransfer>.Create;
    FItems.AddRange(FItemsArray);
  end;
  Result := FItems;
end;

end.
