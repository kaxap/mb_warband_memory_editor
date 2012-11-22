object frmEditUnit: TfrmEditUnit
  Left = 486
  Top = 124
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Edit unit'
  ClientHeight = 210
  ClientWidth = 332
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 16
    Width = 22
    Height = 13
    Caption = 'Unit:'
  end
  object Label2: TLabel
    Left = 18
    Top = 51
    Width = 47
    Height = 13
    Caption = 'Ammount:'
  end
  object Label3: TLabel
    Left = 16
    Top = 83
    Width = 50
    Height = 13
    Caption = 'Wounded:'
  end
  object Label4: TLabel
    Left = 22
    Top = 115
    Width = 44
    Height = 13
    Caption = 'Upgrade:'
  end
  object txtUnit: TEdit
    Left = 72
    Top = 13
    Width = 225
    Height = 21
    TabStop = False
    Color = clBtnFace
    TabOrder = 6
  end
  object btnPickUnit: TButton
    Left = 303
    Top = 12
    Width = 21
    Height = 21
    Caption = '...'
    TabOrder = 0
    OnClick = btnPickUnitClick
  end
  object txtAmmount: TEdit
    Left = 72
    Top = 48
    Width = 97
    Height = 21
    TabOrder = 1
    Text = '0'
  end
  object txtWounded: TEdit
    Left = 72
    Top = 80
    Width = 97
    Height = 21
    TabOrder = 2
    Text = '0'
  end
  object cbPrisoner: TCheckBox
    Left = 72
    Top = 144
    Width = 257
    Height = 17
    Caption = 'Prisoner (modifying can cause fatal errors)'
    TabOrder = 3
  end
  object btnOk: TButton
    Left = 136
    Top = 168
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 4
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 224
    Top = 168
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 5
  end
  object txtUpgrade: TEdit
    Left = 72
    Top = 112
    Width = 97
    Height = 21
    TabOrder = 7
    Text = '0'
  end
end
