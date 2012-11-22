object frmPickUnit: TfrmPickUnit
  Left = 192
  Top = 124
  Width = 297
  Height = 320
  Caption = 'Pick unit'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
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
  object btnClose: TButton
    Left = 184
    Top = 248
    Width = 75
    Height = 25
    Cancel = True
    Caption = '&Cancel'
    ModalResult = 2
    TabOrder = 3
  end
end
