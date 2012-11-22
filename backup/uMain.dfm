object Form1: TForm1
  Left = 192
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'M&B Warband helper'
  ClientHeight = 308
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object txtProcessId: TEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'ProcessId'
  end
  object txtAddr: TEdit
    Left = 8
    Top = 40
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'Address'
  end
  object btnAdd: TButton
    Left = 8
    Top = 72
    Width = 113
    Height = 49
    Caption = 'Increment ID'
    TabOrder = 0
    OnClick = btnAddClick
  end
  object btnDuplicate: TButton
    Left = 128
    Top = 72
    Width = 113
    Height = 49
    Caption = 'Duplicate'
    TabOrder = 3
    OnClick = btnDuplicateClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 128
    Width = 265
    Height = 129
    Caption = 'Modificate inventory first item'
    TabOrder = 4
    object Label1: TLabel
      Left = 8
      Top = 22
      Width = 61
      Height = 13
      Caption = 'Item id (dec):'
    end
    object Label2: TLabel
      Left = 8
      Top = 46
      Width = 74
      Height = 13
      Caption = 'Used ammount:'
    end
    object Label3: TLabel
      Left = 8
      Top = 70
      Width = 43
      Height = 13
      Caption = 'Item flag:'
    end
    object txtItemId: TEdit
      Left = 104
      Top = 16
      Width = 121
      Height = 21
      TabOrder = 0
      Text = '0'
      OnKeyPress = txtItemIdKeyPress
    end
    object txtUsedAmmount: TEdit
      Left = 104
      Top = 40
      Width = 121
      Height = 21
      TabOrder = 1
      Text = '0'
      OnKeyPress = txtUsedAmmountKeyPress
    end
    object cbFlag: TComboBox
      Left = 104
      Top = 64
      Width = 121
      Height = 21
      Style = csDropDownList
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 2
      Text = '00 - none'
      OnChange = cbFlagChange
      Items.Strings = (
        '00 - none'
        '01 - cracked'
        '02 - rusty'
        '03 - bent'
        '04 - chipped'
        '05 - battered'
        '06 - poor'
        '07 - crude'
        '08 - old'
        '09 - cheap'
        '0a - fine'
        '0b - well made'
        '0c - sharp'
        '0d - balanced'
        '0e - tempered'
        '0f - deadly'
        '10 - exquisite'
        '11 - masterwork'
        '12 - heavy'
        '13 - strong'
        '14 - powerful'
        '15 - tattered'
        '16 - ragged'
        '17 - rough'
        '18 - sturdy'
        '19 - thick'
        '1a - hardened'
        '1b - reinforced'
        '1c - superb'
        '1d - lordly'
        '1e - lame'
        '1f - swaybacked'
        '20 - stubborn'
        '21 - timid'
        '22 - meek'
        '23 - spirited'
        '24 - champion'
        '25 - fresh'
        '26 - day old'
        '27 - two days old'
        '28 - smelling'
        '29 - rotten'
        '2a - large bag of')
    end
    object btnModItem: TButton
      Left = 144
      Top = 96
      Width = 75
      Height = 25
      Caption = 'Change'
      TabOrder = 3
      OnClick = btnModItemClick
    end
    object cbFlagSync: TCheckBox
      Left = 24
      Top = 100
      Width = 97
      Height = 17
      Caption = 'flag sync'
      TabOrder = 4
    end
    object btnOpenItems: TButton
      Left = 232
      Top = 16
      Width = 21
      Height = 21
      Caption = '...'
      TabOrder = 5
      OnClick = btnOpenItemsClick
    end
  end
  object btnGuessAddr: TButton
    Left = 136
    Top = 8
    Width = 89
    Height = 25
    Caption = 'Refresh'
    TabOrder = 5
    OnClick = btnGuessAddrClick
  end
  object btnClose: TButton
    Left = 184
    Top = 272
    Width = 75
    Height = 25
    Caption = 'Close'
    TabOrder = 6
    OnClick = btnCloseClick
  end
  object btnDup8: TButton
    Left = 248
    Top = 72
    Width = 25
    Height = 49
    Caption = '+8'
    TabOrder = 7
    OnClick = btnDup8Click
  end
  object btnCharOpts: TButton
    Left = 8
    Top = 272
    Width = 113
    Height = 25
    Caption = 'Character options...'
    TabOrder = 8
    OnClick = btnCharOptsClick
  end
  object tmrModDataSync: TTimer
    Interval = 500
    OnTimer = tmrModDataSyncTimer
    Left = 176
    Top = 40
  end
end
