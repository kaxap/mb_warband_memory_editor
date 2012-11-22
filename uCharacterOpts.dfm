object frmCharOpts: TfrmCharOpts
  Left = 193
  Top = 177
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Character options'
  ClientHeight = 483
  ClientWidth = 329
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
  object GroupBox4: TGroupBox
    Left = 8
    Top = 8
    Width = 153
    Height = 425
    Caption = 'Weapon stats'
    TabOrder = 2
    object txtOneHanded: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 59
      EditLabel.Height = 13
      EditLabel.Caption = 'One handed'
      TabOrder = 0
    end
    object txtTwoHanded: TLabeledEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = 'Two handed'
      TabOrder = 1
    end
    object txtPolearms: TLabeledEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      EditLabel.Width = 67
      EditLabel.Height = 13
      EditLabel.Caption = 'Three handed'
      TabOrder = 2
    end
    object txtArchery: TLabeledEdit
      Left = 16
      Top = 152
      Width = 121
      Height = 21
      EditLabel.Width = 36
      EditLabel.Height = 13
      EditLabel.Caption = 'Archery'
      TabOrder = 3
    end
    object txtCrossbows: TLabeledEdit
      Left = 16
      Top = 192
      Width = 121
      Height = 21
      EditLabel.Width = 51
      EditLabel.Height = 13
      EditLabel.Caption = 'Crossbows'
      TabOrder = 4
    end
    object txtThrowing: TLabeledEdit
      Left = 16
      Top = 232
      Width = 121
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'Throwing'
      TabOrder = 5
    end
    object txtUnk1: TLabeledEdit
      Left = 16
      Top = 272
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Unknown?'
      TabOrder = 6
    end
    object txtUnk2: TLabeledEdit
      Left = 16
      Top = 312
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Unknown?'
      TabOrder = 7
    end
    object txtUnk3: TLabeledEdit
      Left = 16
      Top = 352
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Unknown?'
      TabOrder = 8
    end
    object txtUnk4: TLabeledEdit
      Left = 16
      Top = 392
      Width = 121
      Height = 21
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = 'Unknown?'
      TabOrder = 9
    end
  end
  object GroupBox1: TGroupBox
    Left = 168
    Top = 8
    Width = 153
    Height = 153
    Caption = 'Points'
    TabOrder = 0
    object txtAttrPoints: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 73
      EditLabel.Height = 13
      EditLabel.Caption = 'Attribute points:'
      TabOrder = 0
    end
    object txtSkillPoints: TLabeledEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 53
      EditLabel.Height = 13
      EditLabel.Caption = 'Skill points:'
      TabOrder = 1
    end
    object txtWeaponPoints: TLabeledEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      EditLabel.Width = 75
      EditLabel.Height = 13
      EditLabel.Caption = 'Weapon points:'
      TabOrder = 2
    end
  end
  object GroupBox2: TGroupBox
    Left = 168
    Top = 176
    Width = 153
    Height = 185
    Caption = 'Stats'
    TabOrder = 1
    object txtStr: TLabeledEdit
      Left = 16
      Top = 32
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'STR'
      TabOrder = 0
    end
    object txtAgi: TLabeledEdit
      Left = 16
      Top = 72
      Width = 121
      Height = 21
      EditLabel.Width = 18
      EditLabel.Height = 13
      EditLabel.Caption = 'AGI'
      TabOrder = 1
    end
    object txtInt: TLabeledEdit
      Left = 16
      Top = 112
      Width = 121
      Height = 21
      EditLabel.Width = 18
      EditLabel.Height = 13
      EditLabel.Caption = 'INT'
      TabOrder = 2
    end
    object txtCha: TLabeledEdit
      Left = 16
      Top = 152
      Width = 121
      Height = 21
      EditLabel.Width = 22
      EditLabel.Height = 13
      EditLabel.Caption = 'CHA'
      TabOrder = 3
    end
  end
  object GroupBox3: TGroupBox
    Left = 168
    Top = 384
    Width = 153
    Height = 49
    Caption = 'Money'
    TabOrder = 3
    object txtMoney: TEdit
      Left = 8
      Top = 16
      Width = 137
      Height = 21
      TabOrder = 0
      Text = '0'
    end
  end
  object btnOk: TButton
    Left = 144
    Top = 448
    Width = 75
    Height = 25
    Caption = 'OK'
    Default = True
    TabOrder = 4
    OnClick = btnOkClick
  end
  object btnCancel: TButton
    Left = 232
    Top = 448
    Width = 75
    Height = 25
    Caption = 'Cancel'
    TabOrder = 5
    OnClick = btnCancelClick
  end
end
