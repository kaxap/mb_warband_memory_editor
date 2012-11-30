object frmPickItem: TfrmPickItem
  Left = 710
  Top = 128
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Pick an item'
  ClientHeight = 281
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 37
    Height = 13
    Caption = 'Search:'
  end
  object txtSearch: TEdit
    Left = 50
    Top = 13
    Width = 223
    Height = 21
    TabOrder = 0
    OnChange = txtSearchChange
  end
  object lbItems: TListBox
    Left = 8
    Top = 48
    Width = 265
    Height = 193
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = lbItemsDblClick
  end
  object btnOk: TButton
    Left = 96
    Top = 248
    Width = 75
    Height = 25
    Caption = '&OK'
    Default = True
    ModalResult = 1
    TabOrder = 2
    OnClick = btnOkClick
  end
  object Button1: TButton
    Left = 184
    Top = 248
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
    OnClick = Button1Click
  end
end
