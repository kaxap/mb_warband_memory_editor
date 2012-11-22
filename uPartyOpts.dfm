object frmPartyOpts: TfrmPartyOpts
  Left = 194
  Top = 124
  Width = 553
  Height = 370
  Caption = 'Party options'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 282
    Width = 537
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      537
      50)
    object btnClose: TButton
      Left = 447
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
    object btnRefresh: TButton
      Left = 104
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 1
      OnClick = btnRefreshClick
    end
    object btnEdit: TButton
      Left = 17
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Edit'
      Default = True
      TabOrder = 2
      OnClick = btnEditClick
    end
    object btnSave: TButton
      Left = 344
      Top = 12
      Width = 75
      Height = 25
      Caption = 'Save'
      TabOrder = 3
      OnClick = btnSaveClick
    end
  end
  object lvUnits: TListView
    Left = 0
    Top = 0
    Width = 537
    Height = 282
    Align = alClient
    Columns = <
      item
        MaxWidth = 1
        Width = 0
      end
      item
        AutoSize = True
        Caption = 'Unit'
      end
      item
        Caption = 'Ammount'
        MaxWidth = 70
        Width = 70
      end
      item
        Caption = 'Wounded'
        MaxWidth = 70
        Width = 70
      end
      item
        Caption = 'Prisoner?'
        Width = 70
      end
      item
        Caption = 'Upgrade'
        Width = 70
      end>
    GridLines = True
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = lvUnitsDblClick
  end
end
