object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 560
  ClientWidth = 918
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pgcFunctions: TPageControl
    Left = 0
    Top = 49
    Width = 918
    Height = 511
    ActivePage = tsParsingProjects
    Align = alClient
    TabOrder = 0
    object tsParsingUses: TTabSheet
      Caption = 'Parsing Uses'
      object lstComponentsGroup: TListBox
        Left = 739
        Top = 0
        Width = 171
        Height = 442
        Align = alRight
        ItemHeight = 13
        TabOrder = 0
      end
      object mmoUnits: TMemo
        Left = 0
        Top = 0
        Width = 739
        Height = 442
        Align = alClient
        TabOrder = 1
      end
      object pnlBottom: TPanel
        Left = 0
        Top = 442
        Width = 910
        Height = 41
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 2
        DesignSize = (
          910
          41)
        object btnRunParsingUses: TButton
          Left = 828
          Top = 9
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Run'
          TabOrder = 0
          OnClick = btnRunParsingUsesClick
        end
      end
    end
    object tsParsingProjects: TTabSheet
      Caption = 'Parsing Projects'
      ImageIndex = 1
      object splProjectsList: TSplitter
        Left = 209
        Top = 35
        Height = 407
        OnMoved = splProjectsListMoved
        ExplicitLeft = 200
        ExplicitTop = 3
      end
      object splProjectUnits: TSplitter
        Left = 460
        Top = 35
        Height = 407
        OnMoved = splProjectUnitsMoved
        ExplicitLeft = 412
        ExplicitTop = 19
      end
      object pnlParsingProjects: TPanel
        Left = 0
        Top = 442
        Width = 910
        Height = 41
        Align = alBottom
        BevelInner = bvLowered
        TabOrder = 0
        DesignSize = (
          910
          41)
        object btnRunParsingProjects: TButton
          Left = 828
          Top = 9
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = 'Run'
          TabOrder = 0
          OnClick = btnRunParsingProjectsClick
        end
        object Button1: TButton
          Left = 440
          Top = 6
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 1
          OnClick = Button1Click
        end
      end
      object lstProjectUnitUses: TListBox
        Left = 463
        Top = 35
        Width = 264
        Height = 407
        Align = alLeft
        ItemHeight = 13
        TabOrder = 3
      end
      object lstProjectsList: TListBox
        Left = 0
        Top = 35
        Width = 209
        Height = 407
        Align = alLeft
        ItemHeight = 13
        TabOrder = 1
        OnClick = lstProjectsListClick
      end
      object lstProjectUnits: TListBox
        Left = 212
        Top = 35
        Width = 248
        Height = 407
        Align = alLeft
        ItemHeight = 13
        TabOrder = 2
        OnClick = lstProjectUnitsClick
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 910
        Height = 35
        Align = alTop
        TabOrder = 4
        object pnlProjectsListTitle: TPanel
          Left = 1
          Top = 1
          Width = 211
          Height = 33
          Align = alLeft
          Caption = 'Projects'
          TabOrder = 0
        end
        object pnlProjectUnitsTitle: TPanel
          Left = 212
          Top = 1
          Width = 251
          Height = 33
          Align = alLeft
          Caption = 'Units'
          TabOrder = 1
        end
        object Panel4: TPanel
          Left = 463
          Top = 1
          Width = 264
          Height = 33
          Align = alLeft
          Caption = 'Uses'
          TabOrder = 2
        end
      end
      object lstProjectsGroupList: TListBox
        Left = 728
        Top = 35
        Width = 182
        Height = 407
        Align = alRight
        ItemHeight = 13
        TabOrder = 5
        OnClick = lstProjectsGroupListClick
      end
    end
  end
  object gbDirectory: TGroupBox
    Left = 0
    Top = 0
    Width = 918
    Height = 49
    Align = alTop
    Caption = 'Directory'
    TabOrder = 1
    DesignSize = (
      918
      49)
    object chbxRecursively: TCheckBox
      Left = 836
      Top = 18
      Width = 75
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'Recursively'
      Checked = True
      State = cbChecked
      TabOrder = 1
    end
    object edtDirecotory: TEdit
      Left = 10
      Top = 16
      Width = 797
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 2
    end
    object btnSelectDirectory: TButton
      Left = 806
      Top = 16
      Width = 24
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 0
      OnClick = btnSelectDirectoryClick
    end
  end
  object dlgOpenDirectory: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoPickFolders]
    Left = 872
    Top = 472
  end
end
