object frmNewAnalysis: TfrmNewAnalysis
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  Caption = 'New Analysis'
  ClientHeight = 241
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial Narrow'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 88
    Top = 64
    Width = 156
    Height = 16
    Caption = 'Select source project type:'
  end
  object Label2: TLabel
    Left = 88
    Top = 104
    Width = 106
    Height = 16
    Caption = 'Project root folder:'
  end
  object cbProjectType: TComboBox
    Left = 240
    Top = 61
    Width = 145
    Height = 24
    TabOrder = 0
  end
  object txtRootFolder: TEdit
    Left = 240
    Top = 101
    Width = 345
    Height = 24
    ReadOnly = True
    TabOrder = 1
    OnClick = btnSelectFolderClick
  end
  object btnSelectFolder: TButton
    Left = 591
    Top = 101
    Width = 34
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = btnSelectFolderClick
  end
  object btnNext: TButton
    Left = 240
    Top = 144
    Width = 75
    Height = 25
    Caption = 'Next'
    TabOrder = 3
    OnClick = btnNextClick
  end
end
