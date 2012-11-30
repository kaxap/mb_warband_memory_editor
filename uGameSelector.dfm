object frmGameSelector: TfrmGameSelector
  Left = 192
  Top = 124
  Width = 481
  Height = 342
  BorderIcons = [biSystemMenu]
  Caption = 'Select game data'
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 465
    Height = 176
    Align = alClient
    BorderWidth = 10
    TabOrder = 0
    object lbGameNames: TListBox
      Left = 11
      Top = 11
      Width = 443
      Height = 154
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClick = lbGameNamesClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 248
    Width = 465
    Height = 56
    Align = alBottom
    TabOrder = 1
    object btnOK: TButton
      Left = 280
      Top = 16
      Width = 75
      Height = 25
      Caption = 'OK'
      TabOrder = 0
      OnClick = btnOKClick
    end
    object btnCancel: TButton
      Left = 368
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 176
    Width = 465
    Height = 72
    Align = alBottom
    BorderWidth = 15
    TabOrder = 2
    object lblDescription: TLabel
      Left = 16
      Top = 16
      Width = 433
      Height = 40
      Align = alClient
      AutoSize = False
      WordWrap = True
    end
  end
end
