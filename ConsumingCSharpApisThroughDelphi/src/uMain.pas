unit uMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls,
  Data.DB, Datasnap.DBClient, Rest.Json, Vcl.ComCtrls, uISLIDHttpDll;

type
  TfrmMain = class(TForm)
    cdsAccounts: TClientDataSet;
    cdsAccountsId: TIntegerField;
    cdsAccountsAccountType: TStringField;
    cdsAccountsAccountBalance: TCurrencyField;
    dsAccounts: TDataSource;
    pnlMain: TPanel;
    pgControl: TPageControl;
    tabGetAccounts: TTabSheet;
    pnlTop: TPanel;
    btnGetAccounts: TButton;
    btnGetAccountsJsonResult: TButton;
    edtUrlBanking: TEdit;
    pnlClient: TPanel;
    gridAccounts: TDBGrid;
    tabPost: TTabSheet;
    pnlTopPostBanking: TPanel;
    lbFrom: TLabel;
    lbToAccount: TLabel;
    lbTransferAmount: TLabel;
    edtFromAccount: TEdit;
    edtToAccount: TEdit;
    edtTransferAmount: TEdit;
    btnPost: TButton;
    pnlClientTabPost: TPanel;
    mmPost: TMemo;
    tabGetTransfers: TTabSheet;
    pnlTopTransfers: TPanel;
    btnGetTransfers: TButton;
    btnGetTransfersJsonResult: TButton;
    pnlCenterGetTransfers: TPanel;
    DBGrid1: TDBGrid;
    cdsTransfers: TClientDataSet;
    dsTransfers: TDataSource;
    cdsTransfersFromAccount: TIntegerField;
    cdsTransfersToAccount: TIntegerField;
    cdsTransfersTransferAmount: TCurrencyField;
    cdsTransfersId: TIntegerField;
    edtUrlTransfer: TEdit;
    edtUrlSendTransfer: TEdit;
    procedure btnGetAccountsClick(Sender: TObject);
    procedure btnGetAccountsJsonResultClick(Sender: TObject);
    procedure btnPostClick(Sender: TObject);
    procedure btnGetTransfersClick(Sender: TObject);
    procedure btnGetTransfersJsonResultClick(Sender: TObject);
  private
  public
  end;

var
  frmMain: TfrmMain;

implementation

uses uAccount, uTransfer;

{$R *.dfm}

procedure TfrmMain.btnGetAccountsClick(Sender: TObject);
var
  oAccountItems: TAccountDTO;
  I: Integer;
begin
  cdsAccounts.EmptyDataSet;
  oAccountItems := TJson.JsonToObject<TAccountDTO>('{"Items":' + TISLIDHttp.FGet(edtUrlBanking.Text, '', '') + '}');
  try
    for I := 0 to oAccountItems.Items.Count - 1 do
    begin
      cdsAccounts.Insert;
      cdsAccountsId.AsInteger := TAccount(oAccountItems.Items[I]).Id;
      cdsAccountsAccountType.AsString := TAccount(oAccountItems.Items[I]).AccountType;
      cdsAccountsAccountBalance.AsCurrency := TAccount(oAccountItems.Items[I]).AccountBalance;
    end;
    cdsAccounts.First;
  finally
    FreeAndNil(oAccountItems);
  end;
end;

procedure TfrmMain.btnGetAccountsJsonResultClick(Sender: TObject);
begin
  Messagebox(Handle, PWideChar(TAccountDTO.PrettyPrintJSON('{"Items":' + TISLIDHttp.FGet(edtUrlBanking.Text, '', '') + '}')), 'Information', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmMain.btnGetTransfersClick(Sender: TObject);
var
  oTransferItems: TTransferDTO;
  I: Integer;
begin
  cdsTransfers.EmptyDataSet;
  oTransferItems := TJson.JsonToObject<TTransferDTO>('{"Items":' + TISLIDHttp.FGet(edtUrlTransfer.Text, '', '') + '}');
  try
    for I := 0 to oTransferItems.Items.Count - 1 do
    begin
      cdsTransfers.Insert;
      cdsTransfersId.AsInteger := TTransfer(oTransferItems.Items[I]).Id;
      cdsTransfersFromAccount.AsInteger := TTransfer(oTransferItems.Items[I]).FromAccount;
      cdsTransfersToAccount.AsInteger := TTransfer(oTransferItems.Items[I]).ToAccount;
      cdsTransfersTransferAmount.AsCurrency := TTransfer(oTransferItems.Items[I]).TransferAmount;
    end;
    cdsTransfers.First;
  finally
    FreeAndNil(oTransferItems);
  end;
end;

procedure TfrmMain.btnGetTransfersJsonResultClick(Sender: TObject);
begin
  Messagebox(Handle, PWideChar(TTransferDTO.PrettyPrintJSON('{"Items":' + TISLIDHttp.FGet(edtUrlTransfer.Text, '', '') + '}')), 'Information', MB_OK + MB_ICONINFORMATION);
end;

procedure TfrmMain.btnPostClick(Sender: TObject);
var
  oTransfer: TTransfer;
  JsonToSend: TStringStream;
begin
  oTransfer := TTransfer.Create;
  try
    oTransfer.FromAccount := StrToInt(edtFromAccount.Text);
    oTransfer.ToAccount := StrToInt(edtToAccount.Text);
    oTransfer.TransferAmount := StrToFloat(StringReplace(edtTransferAmount.Text, '.', ',', [rfReplaceAll]));
    mmPost.Text := '';
    mmPost.Lines.Add('Sent to RabbitMQ:');
    mmPost.Lines.Add('');
    JsonToSend := TStringStream.Create(TJson.ObjectToJsonString(oTransfer));
    mmPost.Lines.Add(TISLIDHttp.FPost(edtUrlSendTransfer.Text, JsonToSend.DataString, '', ''));
  finally
    FreeAndNil(JsonToSend);
    FreeAndNil(oTransfer);
  end;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
