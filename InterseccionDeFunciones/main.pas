unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  StdCtrls, LCLType, ExtCtrls, ColorBox, ComCtrls, EditBtn, Grids, ParseMath,
  TASeries, TAFuncSeries, TARadialSeries, TATools, Types, Result,
  FunctionOperations;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnIntersection: TButton;
    BtnClearLBox: TButton;
    Chart1: TChart;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    colorbtnFunction: TColorButton;
    ediMin: TEdit;
    ediMax: TEdit;
    ediStep: TEdit;
    EdtPrecision: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LblInterseccionTitle: TLabel;
    Label5: TLabel;
    LblPrecision: TLabel;
    LBoxIntersection: TListBox;
    Panel1: TPanel;
    ScrollBox1: TScrollBox;
    StatusBar1: TStatusBar;
    StrGridResIntersection: TStringGrid;
    TrackBar1: TTrackBar;
    trbarVisible: TTrackBar;

    procedure BtnClearLBoxClick(Sender: TObject);
    procedure BtnIntersectionClick(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure FormDestroy(Sender: TObject);
    procedure FunctionSeriesCalculate(const AX: Double; out AY: Double);
    procedure FormShow(Sender: TObject);
    procedure FunctionsEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure trbarVisibleChange(Sender: TObject);
  private
    FunctionList,
    EditList,
    LabelList: TList;
    ActiveFunction: Integer;
    min,
    max: Real;
    Parse  : TparseMath;
    function f( x: Real ): Real;
    function evaluar( x: Real; fun: String ): Real;
    procedure CreateNewFunction;
    procedure Graphic2D;

  public

  end;

var
  Form1: TForm1;

implementation

const
  FunctionEditName = 'FunctionEdit';
  FunctionSeriesName = 'FunctionLines';

procedure TForm1.FormCreate(Sender: TObject);
begin
  FunctionList:= TList.Create;
  EditList:= TList.Create;
  min:= -5.0;
  max:= 5.0;
  Parse:= TParseMath.create();
  Parse.AddVariable('x', min);

  //LBoxIntersection.AddItem('Function 1',Nil);
  //LBoxIntersection.AddItem('Function 2',Nil);
end;

procedure TForm1.trbarVisibleChange(Sender: TObject);
begin
  Self.AlphaBlendValue:= trbarVisible.Position;
end;

function TForm1.f( x: Real ): Real;
begin
  //func:= TEdit( EditList[ ActiveFunction ] ).Text;
  Parse.Expression:= TEdit( EditList[ ActiveFunction ] ).Text;
  Parse.NewValue('x', x);
  Result:= Parse.Evaluate();
end;

function TForm1.evaluar( x: Real; fun: String ): Real;
begin
  //func:= TEdit( EditList[ ActiveFunction ] ).Text;
  Parse.Expression:= fun;
  Parse.NewValue('x', x);
  Result:= Parse.Evaluate();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  Parse.destroy;
  FunctionList.Destroy;
  EditList.Destroy;
end;

procedure TForm1.ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
  APoint: TPoint);
var
  x,y: Double;
begin
  //LabelList.Add( TLabel(LBoxIntersection) );
    with ATool as TDatapointClickTool do
      if (Series is TLineSeries) then
        with TLineSeries(Series) do begin
          x := GetXValue(PointIndex);
          y := GetYValue(PointIndex);
          //Statusbar1.SimpleText := Format('%s: x = %f, y = %f', [Title, x, y]);
          LBoxIntersection.AddItem(TEdit(EditList.Items[Tag]).Caption, TEdit(EditList.Items[Tag]));
          Statusbar1.SimpleText := Format('%s: x = %f, y = %f', [TEdit(EditList.Items[Tag]).Caption, x, y]);
        end
      else
        Statusbar1.SimpleText := 'aaa';
end;

procedure TForm1.BtnIntersectionClick(Sender: TObject);
var
  function1, function2 : String;
  funOp : TFunOperations;
  Res : TResult;
  ResY : TStringList;
  i: Integer;
begin
    funOp := TFunOperations.create();
    function1:= LBoxIntersection.Items[LBoxIntersection.Count-2];
    function2:= LBoxIntersection.Items[LBoxIntersection.Count-1];
    //ShowMessage(function1 + '-' +function2);
    Res := funOp.intersection(function1, function2, StrToFloat( ediMin.Text), StrToFloat( ediMax.Text), StrToFloat(EdtPrecision.Text) );
    {
    for i := 0 to Res.result.Count - 1 do
    begin
        resY.Add( FloatToStr( evaluar(StrToFloat(Res.result[i]), function1 + '-' +function2 ) ));
    end;
    }
    StrGridResIntersection.RowCount:= Res.result.Count;
    StrGridResIntersection.Cols[0].Assign(Res.result);
    //StrGridResIntersection.Cols[1].Assign(ResY);
end;

procedure TForm1.BtnClearLBoxClick(Sender: TObject);
begin
  LBoxIntersection.Clear;
end;

procedure TForm1.FunctionSeriesCalculate(const AX: Double; out AY: Double);
begin
   // AY:= f( AX )

end;

procedure TForm1.FormShow(Sender: TObject);
begin
  CreateNewFunction;
end;

procedure TForm1.FunctionsEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  if not (key = VK_RETURN) then
     exit;

   with TEdit( Sender ) do begin
       ActiveFunction:= Tag;
       Graphic2D;
       if tag = EditList.Count - 1 then
          CreateNewFunction;
   end;

end;

procedure TForm1.Graphic2D;
var x, h: Real;

begin
  h:= StrToFloat( ediStep.Text );
  min:= StrToFloat( ediMin.Text );
  max:= StrToFloat( ediMax.Text );

  with TLineSeries( FunctionList[ ActiveFunction ] ) do begin
       LinePen.Color:= colorbtnFunction.ButtonColor;
       LinePen.Width:= TrackBar1.Position;

  end;

  x:= min;
  TLineSeries( FunctionList[ ActiveFunction ] ).Clear;
  with TLineSeries( FunctionList[ ActiveFunction ] ) do
  repeat
      AddXY( x, f(x) );
      x:= x + h
  until ( x>= max );


end;

procedure TForm1.CreateNewFunction;
begin
   EditList.Add( TEdit.Create(ScrollBox1) );

   //We create Edits with functions
   with Tedit( EditList.Items[ EditList.Count - 1 ] ) do begin
        Parent:= ScrollBox1;
        Align:= alTop;
        name:= FunctionEditName + IntToStr( EditList.Count );
        OnKeyUp:= @FunctionsEditKeyUp;
        Font.Size:= 15;
        Text:= EmptyStr;
        Tag:= EditList.Count - 1;
        SetFocus;
   end;

   //We create serial functions
   FunctionList.Add( TLineSeries.Create( Chart1 ) );
   with TLineSeries( FunctionList[ FunctionList.Count - 1 ] ) do begin
        Name:= FunctionSeriesName + IntToStr( FunctionList.Count );
        Tag:= EditList.Count - 1; // Edit Asossiated
   end;

   Chart1.AddSeries( TLineSeries( FunctionList[ FunctionList.Count - 1 ] ) );

end;

{$R *.lfm}

end.

