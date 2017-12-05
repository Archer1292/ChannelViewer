object FormMain: TFormMain
  Left = 34
  Top = 22
  BorderStyle = bsNone
  Caption = 'FormMain'
  ClientHeight = 587
  ClientWidth = 1145
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 873
    Top = 25
    Height = 562
  end
  object pnlCaption: TPanel
    Left = 0
    Top = 0
    Width = 1145
    Height = 25
    Align = alTop
    TabOrder = 0
    object btnClose: TSpeedButton
      Left = 880
      Top = 8
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000F0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00888888888888
        8880877888888888778087778888888777808877788888777880888777888777
        8880888877787778888088888777778888808888887778888880888887777788
        8880888877787778888088877788877788808877788888777880877788888887
        778087788888888877808888888888888880}
      OnClick = ButtonClicks
    end
    object btnMinimize: TSpeedButton
      Tag = 1
      Left = 832
      Top = 0
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        EE000000424DEE0000000000000076000000280000000F0000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00877777777777
        7770877777777777777088888888888888808888888888888880888888888888
        8880888888888888888088888888888888808888888888888880888888888888
        8880888888888888888088888888888888808888888888888880888888888888
        888088888888888888808888888888888880}
      OnClick = ButtonClicks
    end
    object Label1: TLabel
      Left = 5
      Top = 5
      Width = 69
      Height = 18
      Caption = 'Channel 1:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 460
      Top = 5
      Width = 69
      Height = 18
      Caption = 'Channel 2:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 125
      Top = 4
      Width = 198
      Height = 14
      Caption = 'Voltage on the first channel (Volts):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblFirstChannel: TLabel
      Left = 333
      Top = -3
      Width = 13
      Height = 29
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label4: TLabel
      Left = 582
      Top = 6
      Width = 217
      Height = 14
      Caption = 'Voltage on the second channel (Volts):'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblSecondChannel: TLabel
      Left = 806
      Top = -3
      Width = 11
      Height = 29
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object lblDataEntities: TLabel
      Left = 1041
      Top = -1
      Width = 13
      Height = 29
      Caption = '0'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGreen
      Font.Height = -24
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      Transparent = True
    end
    object Label6: TLabel
      Left = 993
      Top = 7
      Width = 45
      Height = 14
      Caption = 'Count - '
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object spnFirstChannel: TSpinEdit
      Left = 80
      Top = 1
      Width = 41
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 15
      MinValue = 0
      ParentFont = False
      TabOrder = 0
      Value = 0
      OnChange = ChangeGraphChannels
    end
    object spnSecondChannel: TSpinEdit
      Left = 535
      Top = 1
      Width = 41
      Height = 26
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxValue = 15
      MinValue = 0
      ParentFont = False
      TabOrder = 1
      Value = 1
      OnChange = ChangeGraphChannels
    end
  end
  object pnlPicture: TPanel
    Left = 0
    Top = 25
    Width = 873
    Height = 562
    Align = alLeft
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnResize = pnlPictureResize
  end
  object Panel1: TPanel
    Left = 876
    Top = 25
    Width = 269
    Height = 562
    Align = alClient
    Caption = 'Panel1'
    TabOrder = 2
    object StringGrid: TStringGrid
      Left = 1
      Top = 1
      Width = 267
      Height = 203
      Align = alClient
      ColCount = 10
      DefaultColWidth = 50
      DefaultRowHeight = 17
      FixedCols = 0
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing]
      ParentFont = False
      TabOrder = 0
      ColWidths = (
        50
        61
        50
        50
        50
        50
        50
        50
        50
        50)
    end
    object GroupBox12: TGroupBox
      Left = 1
      Top = 437
      Width = 267
      Height = 124
      Align = alBottom
      Caption = 'Coordinate square for the selected graph'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object edUp: TEdit
        Left = 112
        Top = 20
        Width = 65
        Height = 27
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        Text = 'edUp'
      end
      object edLeft: TEdit
        Left = 24
        Top = 44
        Width = 65
        Height = 27
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        Text = 'edLeft'
      end
      object edDown: TEdit
        Left = 112
        Top = 60
        Width = 65
        Height = 27
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        Text = 'edDown'
      end
      object edRight: TEdit
        Left = 192
        Top = 44
        Width = 65
        Height = 27
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        Text = 'edRight'
      end
      object Button1: TButton
        Left = 24
        Top = 86
        Width = 233
        Height = 28
        Caption = 'Change the coordinate system'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = Button1Click
      end
    end
    object GroupBox10: TGroupBox
      Left = 1
      Top = 254
      Width = 267
      Height = 183
      Align = alBottom
      Caption = 'Save results mode'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      object Label37: TLabel
        Left = 10
        Top = 24
        Width = 141
        Height = 19
        Caption = 'Recording intervals:'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label39: TLabel
        Left = 206
        Top = 24
        Width = 55
        Height = 16
        Caption = '* 100 '#236#241'.'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label5: TLabel
        Left = 10
        Top = 56
        Width = 188
        Height = 19
        Caption = 'Accuracy (decimal places):'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object SpinEdit5: TSpinEdit
        Left = 156
        Top = 20
        Width = 54
        Height = 29
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 100000000
        MinValue = 1
        ParentFont = False
        TabOrder = 0
        Value = 10
        OnChange = SpinEdit5Change
      end
      object Button2: TButton
        Left = 8
        Top = 83
        Width = 121
        Height = 25
        Caption = 'Write in table'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = Button2Click
      end
      object Button3: TButton
        Left = 136
        Top = 83
        Width = 121
        Height = 25
        Caption = 'Clear table'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = Button3Click
      end
      object Button4: TButton
        Left = 8
        Top = 115
        Width = 121
        Height = 25
        Hint = 
          #193#243#228#229#242' '#241#238#245#240#224#237#229#237#224' '#232#237#244#238#240#236#224#246#232#255' '#232#231' '#225#243#244#229#240#238#226' - '#227#238#240#224#231#228#238' '#225#238#235#229#229' '#239#238#228#240#238#225#237#224#255' ' +
          #232' '#242#238#247#237#224#255' '#239#238' '#241#240#224#226#237#229#237#232#254' '#241' Excel - '#244#238#240#236#224#242#238#236'. '#205#238' '#229#184' '#236#238#230#229#242' '#225#251#242#252' '#238#247#229#237#252 +
          ' '#236#237#238#227#238'.'
        Caption = 'Save to txt'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 3
        OnClick = SaveToTxt
      end
      object Button5: TButton
        Left = 136
        Top = 115
        Width = 121
        Height = 25
        Hint = #193#243#228#229#242' '#241#238#245#240#224#237#229#237#224' '#232#237#244#238#240#236#224#246#232#255' '#232#231' '#242#224#225#235#232#246#251'.'
        Caption = 'Save to Excel'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        OnClick = SaveToExcel
      end
      object spAccuracy: TSpinEdit
        Left = 201
        Top = 52
        Width = 54
        Height = 29
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 18
        MinValue = 0
        ParentFont = False
        TabOrder = 5
        Value = 3
        OnChange = SpinEdit5Change
      end
      object Button6: TButton
        Left = 8
        Top = 147
        Width = 121
        Height = 25
        Hint = 
          #193#243#228#229#242' '#241#238#245#240#224#237#229#237#224' '#232#237#244#238#240#236#224#246#232#255' '#232#231' '#225#243#244#229#240#238#226' - '#227#238#240#224#231#228#238' '#225#238#235#229#229' '#239#238#228#240#238#225#237#224#255' ' +
          #232' '#242#238#247#237#224#255' '#239#238' '#241#240#224#226#237#229#237#232#254' '#241' Excel - '#244#238#240#236#224#242#238#236'. '#205#238' '#229#184' '#236#238#230#229#242' '#225#251#242#252' '#238#247#229#237#252 +
          ' '#236#237#238#227#238'.'
        Caption = 'Clear Graph'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = Button6Click
      end
      object Button7: TButton
        Left = 136
        Top = 147
        Width = 121
        Height = 25
        Hint = #193#243#228#229#242' '#241#238#245#240#224#237#229#237#224' '#232#237#244#238#240#236#224#246#232#255' '#232#231' '#242#224#225#235#232#246#251'.'
        Caption = 'Set zero'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = Button7Click
      end
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 204
      Width = 267
      Height = 50
      Align = alBottom
      Caption = 'Plot'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object Button8: TButton
        Left = 8
        Top = 16
        Width = 121
        Height = 25
        Caption = 'Graph'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = Button8Click
      end
      object cbBlackNWhite: TCheckBox
        Left = 136
        Top = 19
        Width = 137
        Height = 17
        Caption = 'Black-white graph'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = cbBlackNWhiteClick
      end
    end
  end
  object Timer: TTimer
    Enabled = False
    Interval = 330
    OnTimer = TimerTimer
    Left = 368
    Top = 73
  end
  object DataTimer: TTimer
    Enabled = False
    OnTimer = DataTimerTimer
    Left = 856
    Top = 169
  end
  object SaveDialog: TSaveDialog
    DefaultExt = 'txt'
    Filter = #210#229#234#241#242#238#226#251#229' '#244#224#233#235#251' (*.txt)|*.txt'
    Left = 160
    Top = 89
  end
  object dlgExcel: TSaveDialog
    DefaultExt = 'xls'
    Filter = #212#224#233#235#251' Excel (*.xls) |*.xls'
    Left = 200
    Top = 89
  end
end
