object FormStart: TFormStart
  Left = 300
  Top = 134
  BorderStyle = bsDialog
  Caption = 'Select channels'
  ClientHeight = 227
  ClientWidth = 549
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 549
    Height = 227
    Align = alClient
    Caption = 
      'Select the desired channel and then enter the settings of the se' +
      'lected data type:'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object CheckBox1: TCheckBox
      Left = 14
      Top = 40
      Width = 73
      Height = 17
      Caption = 'Channel 0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object CheckBox2: TCheckBox
      Left = 14
      Top = 66
      Width = 73
      Height = 17
      Caption = 'Channel 1'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
    object CheckBox3: TCheckBox
      Left = 14
      Top = 92
      Width = 73
      Height = 17
      Caption = 'Channel 2'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
    end
    object CheckBox4: TCheckBox
      Left = 14
      Top = 118
      Width = 73
      Height = 17
      Caption = 'Channel 3'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object CheckBox5: TCheckBox
      Left = 14
      Top = 240
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 4'
      TabOrder = 4
    end
    object CheckBox6: TCheckBox
      Left = 14
      Top = 266
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 5'
      TabOrder = 5
    end
    object CheckBox7: TCheckBox
      Left = 14
      Top = 292
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 6'
      TabOrder = 6
    end
    object CheckBox8: TCheckBox
      Left = 14
      Top = 318
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 7'
      TabOrder = 7
    end
    object CheckBox9: TCheckBox
      Left = 14
      Top = 344
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 8'
      Enabled = False
      TabOrder = 8
    end
    object CheckBox10: TCheckBox
      Left = 14
      Top = 370
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 9'
      Checked = True
      State = cbChecked
      TabOrder = 9
    end
    object CheckBox11: TCheckBox
      Left = 14
      Top = 396
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 10'
      TabOrder = 10
    end
    object CheckBox12: TCheckBox
      Left = 14
      Top = 422
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 11'
      TabOrder = 11
    end
    object CheckBox13: TCheckBox
      Left = 14
      Top = 448
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 12'
      TabOrder = 12
    end
    object CheckBox14: TCheckBox
      Left = 14
      Top = 474
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 13'
      TabOrder = 13
    end
    object CheckBox15: TCheckBox
      Left = 14
      Top = 500
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 14'
      TabOrder = 14
    end
    object CheckBox16: TCheckBox
      Left = 14
      Top = 526
      Width = 73
      Height = 17
      Caption = #202#224#237#224#235' 15'
      TabOrder = 15
    end
    object Edit1: TEdit
      Left = 403
      Top = 32
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 16
      Text = 'Channel name'
    end
    object Edit2: TEdit
      Left = 403
      Top = 58
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 17
      Text = 'Channel name'
    end
    object Edit3: TEdit
      Left = 403
      Top = 84
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 18
      Text = 'Channel name'
    end
    object Edit4: TEdit
      Left = 403
      Top = 110
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 19
      Text = 'Channel name'
    end
    object Edit5: TEdit
      Left = 347
      Top = 239
      Width = 121
      Height = 26
      TabOrder = 20
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit6: TEdit
      Left = 347
      Top = 265
      Width = 121
      Height = 26
      TabOrder = 21
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit7: TEdit
      Left = 347
      Top = 291
      Width = 121
      Height = 26
      TabOrder = 22
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit8: TEdit
      Left = 347
      Top = 317
      Width = 121
      Height = 26
      TabOrder = 23
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit9: TEdit
      Left = 347
      Top = 343
      Width = 121
      Height = 26
      TabOrder = 24
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit10: TEdit
      Left = 347
      Top = 369
      Width = 121
      Height = 26
      TabOrder = 25
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit11: TEdit
      Left = 347
      Top = 395
      Width = 121
      Height = 26
      TabOrder = 26
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit12: TEdit
      Left = 347
      Top = 421
      Width = 121
      Height = 26
      TabOrder = 27
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit13: TEdit
      Left = 347
      Top = 446
      Width = 121
      Height = 26
      TabOrder = 28
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit14: TEdit
      Left = 347
      Top = 472
      Width = 121
      Height = 26
      TabOrder = 29
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit15: TEdit
      Left = 347
      Top = 498
      Width = 121
      Height = 26
      TabOrder = 30
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object Edit16: TEdit
      Left = 347
      Top = 524
      Width = 121
      Height = 26
      TabOrder = 31
      Text = #205#224#231#226#224#237#232#229' '#234#224#237#224#235#224
    end
    object BitBtn1: TBitBtn
      Left = 216
      Top = 184
      Width = 75
      Height = 25
      Caption = 'OK'
      Default = True
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 32
      OnClick = BitBtn1Click
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object Edit17: TEdit
      Left = 87
      Top = 32
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 33
      Text = 'Coefficient'
    end
    object Edit18: TEdit
      Left = 87
      Top = 58
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 34
      Text = 'Coefficient'
    end
    object Edit19: TEdit
      Left = 87
      Top = 84
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 35
      Text = 'Coefficient'
    end
    object Edit20: TEdit
      Left = 87
      Top = 110
      Width = 121
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 36
      Text = 'Coefficient'
    end
    object Edit21: TEdit
      Left = 87
      Top = 239
      Width = 121
      Height = 26
      TabOrder = 37
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit22: TEdit
      Left = 87
      Top = 265
      Width = 121
      Height = 26
      TabOrder = 38
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit23: TEdit
      Left = 87
      Top = 291
      Width = 121
      Height = 26
      TabOrder = 39
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit24: TEdit
      Left = 87
      Top = 317
      Width = 121
      Height = 26
      TabOrder = 40
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit25: TEdit
      Left = 87
      Top = 343
      Width = 121
      Height = 26
      TabOrder = 41
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit26: TEdit
      Left = 87
      Top = 369
      Width = 121
      Height = 26
      TabOrder = 42
      Text = '6,034'
    end
    object Edit27: TEdit
      Left = 87
      Top = 395
      Width = 121
      Height = 26
      TabOrder = 43
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit28: TEdit
      Left = 87
      Top = 421
      Width = 121
      Height = 26
      TabOrder = 44
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit29: TEdit
      Left = 87
      Top = 446
      Width = 121
      Height = 26
      TabOrder = 45
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit30: TEdit
      Left = 87
      Top = 472
      Width = 121
      Height = 26
      TabOrder = 46
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit31: TEdit
      Left = 87
      Top = 498
      Width = 121
      Height = 26
      TabOrder = 47
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit32: TEdit
      Left = 87
      Top = 524
      Width = 121
      Height = 26
      TabOrder = 48
      Text = #202#238#253#244#244#232#246#232#229#237#242
    end
    object Edit33: TEdit
      Left = 215
      Top = 32
      Width = 170
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 49
      Text = 'Unit of measurement'
    end
    object Edit34: TEdit
      Left = 215
      Top = 58
      Width = 170
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 50
      Text = 'Unit of measurement'
    end
    object Edit35: TEdit
      Left = 215
      Top = 84
      Width = 170
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 51
      Text = 'Unit of measurement'
    end
    object Edit36: TEdit
      Left = 215
      Top = 110
      Width = 170
      Height = 26
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 52
      Text = 'Unit of measurement'
    end
    object Edit37: TEdit
      Left = 215
      Top = 239
      Width = 121
      Height = 26
      TabOrder = 53
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit38: TEdit
      Left = 215
      Top = 265
      Width = 121
      Height = 26
      TabOrder = 54
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit39: TEdit
      Left = 215
      Top = 291
      Width = 121
      Height = 26
      TabOrder = 55
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit40: TEdit
      Left = 215
      Top = 317
      Width = 121
      Height = 26
      TabOrder = 56
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit41: TEdit
      Left = 215
      Top = 343
      Width = 121
      Height = 26
      TabOrder = 57
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit42: TEdit
      Left = 215
      Top = 369
      Width = 121
      Height = 26
      TabOrder = 58
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit43: TEdit
      Left = 215
      Top = 395
      Width = 121
      Height = 26
      TabOrder = 59
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit44: TEdit
      Left = 215
      Top = 421
      Width = 121
      Height = 26
      TabOrder = 60
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit45: TEdit
      Left = 215
      Top = 446
      Width = 121
      Height = 26
      TabOrder = 61
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit46: TEdit
      Left = 215
      Top = 472
      Width = 121
      Height = 26
      TabOrder = 62
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit47: TEdit
      Left = 215
      Top = 498
      Width = 121
      Height = 26
      TabOrder = 63
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
    object Edit48: TEdit
      Left = 215
      Top = 524
      Width = 121
      Height = 26
      TabOrder = 64
      Text = #197#228#232#237#232#246#224' '#232#231#236#229#240#229#237#232#255
    end
  end
end
