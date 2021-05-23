object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Consuming C# APIs Banking and Transfer'
  ClientHeight = 272
  ClientWidth = 491
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 491
    Height = 272
    Align = alClient
    BorderWidth = 10
    TabOrder = 0
    object pgControl: TPageControl
      Left = 11
      Top = 11
      Width = 469
      Height = 250
      ActivePage = tabGetAccounts
      Align = alClient
      TabOrder = 0
      object tabGetAccounts: TTabSheet
        Caption = 'GetAccounts'
        object pnlTop: TPanel
          Left = 0
          Top = 0
          Width = 461
          Height = 41
          Align = alTop
          TabOrder = 0
          object btnGetAccounts: TButton
            Left = 8
            Top = 8
            Width = 97
            Height = 25
            Caption = 'GetAccounts'
            TabOrder = 0
            OnClick = btnGetAccountsClick
          end
          object btnGetAccountsJsonResult: TButton
            Left = 110
            Top = 8
            Width = 97
            Height = 25
            Caption = 'GetJsonResult'
            TabOrder = 1
            OnClick = btnGetAccountsJsonResultClick
          end
          object edtUrlBanking: TEdit
            Left = 214
            Top = 11
            Width = 223
            Height = 21
            Enabled = False
            TabOrder = 2
            Text = 'https://localhost:5001/api/Banking'
          end
        end
        object pnlClient: TPanel
          Left = 0
          Top = 41
          Width = 461
          Height = 181
          Align = alClient
          BorderWidth = 10
          TabOrder = 1
          object gridAccounts: TDBGrid
            Left = 11
            Top = 11
            Width = 439
            Height = 159
            Align = alClient
            DataSource = dsAccounts
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'Id'
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'AccountType'
                Width = 222
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'AccountBalance'
                Width = 95
                Visible = True
              end>
          end
        end
      end
      object tabGetTransfers: TTabSheet
        Caption = 'GetTransfers'
        ImageIndex = 2
        object pnlTopTransfers: TPanel
          Left = 0
          Top = 0
          Width = 461
          Height = 41
          Align = alTop
          TabOrder = 0
          object btnGetTransfers: TButton
            Left = 8
            Top = 8
            Width = 97
            Height = 25
            Caption = 'GetTransfers'
            TabOrder = 0
            OnClick = btnGetTransfersClick
          end
          object btnGetTransfersJsonResult: TButton
            Left = 110
            Top = 8
            Width = 97
            Height = 25
            Caption = 'GetJsonResult'
            TabOrder = 1
            OnClick = btnGetTransfersJsonResultClick
          end
          object edtUrlTransfer: TEdit
            Left = 222
            Top = 11
            Width = 223
            Height = 21
            Enabled = False
            TabOrder = 2
            Text = 'https://localhost:5003/apiTransfer'
          end
        end
        object pnlCenterGetTransfers: TPanel
          Left = 0
          Top = 41
          Width = 461
          Height = 181
          Align = alClient
          BorderWidth = 10
          TabOrder = 1
          object DBGrid1: TDBGrid
            Left = 11
            Top = 11
            Width = 439
            Height = 159
            Align = alClient
            DataSource = dsTransfers
            TabOrder = 0
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'Tahoma'
            TitleFont.Style = []
            Columns = <
              item
                Expanded = False
                FieldName = 'Id'
                Width = 36
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'FromAccount'
                Width = 81
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ToAccount'
                Width = 99
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'TransferAmount'
                Width = 104
                Visible = True
              end>
          end
        end
      end
      object tabPost: TTabSheet
        Caption = 'Posting Banking Transfers through Rest C# API into RabbitMQ'
        ImageIndex = 1
        object pnlTopPostBanking: TPanel
          Left = 0
          Top = 0
          Width = 461
          Height = 81
          Align = alTop
          TabOrder = 0
          object lbFrom: TLabel
            Left = 5
            Top = 1
            Width = 63
            Height = 13
            Caption = 'FromAccount'
          end
          object lbToAccount: TLabel
            Left = 116
            Top = 1
            Width = 51
            Height = 13
            Caption = 'ToAccount'
          end
          object lbTransferAmount: TLabel
            Left = 227
            Top = 1
            Width = 78
            Height = 13
            Caption = 'TransferAmount'
          end
          object edtFromAccount: TEdit
            Left = 5
            Top = 15
            Width = 108
            Height = 21
            TabOrder = 0
          end
          object edtToAccount: TEdit
            Left = 116
            Top = 15
            Width = 108
            Height = 21
            TabOrder = 1
          end
          object edtTransferAmount: TEdit
            Left = 227
            Top = 15
            Width = 108
            Height = 21
            TabOrder = 2
          end
          object btnPost: TButton
            Left = 342
            Top = 11
            Width = 74
            Height = 25
            Caption = 'Post'
            TabOrder = 3
            OnClick = btnPostClick
          end
          object edtUrlSendTransfer: TEdit
            Left = 7
            Top = 49
            Width = 223
            Height = 21
            Enabled = False
            TabOrder = 4
            Text = 'https://localhost:5001/api/Banking'
          end
        end
        object pnlClientTabPost: TPanel
          Left = 0
          Top = 81
          Width = 461
          Height = 141
          Align = alClient
          BorderWidth = 10
          Caption = 'pnlClientTabPost'
          TabOrder = 1
          object mmPost: TMemo
            Left = 11
            Top = 11
            Width = 439
            Height = 119
            Align = alClient
            ReadOnly = True
            TabOrder = 0
          end
        end
      end
    end
  end
  object cdsAccounts: TClientDataSet
    PersistDataPacket.Data = {
      700000009619E0BD01000000180000000300000000000300000070000E416363
      6F756E7442616C616E6365080004000000010007535542545950450200490006
      004D6F6E6579000B4163636F756E745479706501004900000001000557494454
      4802000200320002496404000100000000000000}
    Active = True
    Aggregates = <>
    IndexFieldNames = 'id'
    Params = <>
    Left = 72
    Top = 120
    object cdsAccountsId: TIntegerField
      FieldName = 'Id'
    end
    object cdsAccountsAccountType: TStringField
      FieldName = 'AccountType'
      Size = 50
    end
    object cdsAccountsAccountBalance: TCurrencyField
      FieldName = 'AccountBalance'
    end
  end
  object dsAccounts: TDataSource
    AutoEdit = False
    DataSet = cdsAccounts
    Left = 148
    Top = 120
  end
  object cdsTransfers: TClientDataSet
    PersistDataPacket.Data = {
      760000009619E0BD010000001800000004000000000003000000760002496404
      000100000000000B46726F6D4163636F756E74040001000000000009546F4163
      636F756E7404000100000000000E5472616E73666572416D6F756E7408000400
      0000010007535542545950450200490006004D6F6E6579000000}
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Id'
        DataType = ftInteger
      end
      item
        Name = 'FromAccount'
        DataType = ftInteger
      end
      item
        Name = 'ToAccount'
        DataType = ftInteger
      end
      item
        Name = 'TransferAmount'
        DataType = ftCurrency
      end>
    IndexDefs = <>
    IndexFieldNames = 'id'
    Params = <>
    StoreDefs = True
    Left = 272
    Top = 144
    object cdsTransfersId: TIntegerField
      FieldName = 'Id'
    end
    object cdsTransfersFromAccount: TIntegerField
      FieldName = 'FromAccount'
    end
    object cdsTransfersToAccount: TIntegerField
      FieldName = 'ToAccount'
    end
    object cdsTransfersTransferAmount: TCurrencyField
      FieldName = 'TransferAmount'
    end
  end
  object dsTransfers: TDataSource
    AutoEdit = False
    DataSet = cdsTransfers
    Left = 348
    Top = 144
  end
end
