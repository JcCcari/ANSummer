unit main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, TAGraph, Forms, Controls, Graphics, Dialogs,
  TAChartUtils, StdCtrls, LCLType, ExtCtrls, ColorBox, ComCtrls, EditBtn, Grids,
  Spin, TASeries, TAFuncSeries, TARadialSeries, TATools, Types, ParseMath,
  Result, FunctionOperations, math, resultmethods, ClosedMethods, mOpenMethod,
  interpolationMethods, generalizatedNewton;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnOpenExecute: TButton;
    BtnIntersection: TButton;
    BtnClearLBox: TButton;
    BtnClearFunctions: TButton;
    BtnClosedExecute: TButton;
    BtnInterpolationExecute: TButton;
    BtnInterpolationEvaluate: TButton;
    BtnGenNewtonExecute: TButton;
    BtnInterpolationClear: TButton;
    Chart1: TChart;
    Chart2: TChart;
    CBoxInterpolationShowPoints: TCheckBox;
    CBoxInterpolationShowValuePoints: TCheckBox;
    CBoxInterpolationDrawFunc: TCheckBox;
    CheckGroup1: TCheckGroup;
    InterpolationPoints: TLineSeries;
    EdtInterpolationRes: TEdit;
    InterpolationSerie: TLineSeries;
    ChartToolset1ZoomClickTool1: TZoomClickTool;
    ChartToolset1ZoomDragTool1: TZoomDragTool;
    EdtInterpolationXYpoints: TEdit;
    EdtClosedA: TEdit;
    EdtOpenXinitial: TEdit;
    EdtClosedB: TEdit;
    EdtClosedError: TEdit;
    EdtOpenError: TEdit;
    EdtClosedFunction: TEdit;
    EdtOpenFunction: TEdit;
    EdtOpenFunctionDeriv: TEdit;
    intersectionPoints: TLineSeries;
    ChartToolset1: TChartToolset;
    ChartToolset1DataPointClickTool1: TDataPointClickTool;
    ChartToolset1ZoomMouseWheelTool1: TZoomMouseWheelTool;
    colorbtnFunction: TColorButton;
    ediMin: TEdit;
    ediMax: TEdit;
    ediStep: TEdit;
    EdtPrecision: TEdit;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EdtInterpolationEvaluate: TLabeledEdit;
    LblInterseccionTitle: TLabel;
    Label5: TLabel;
    LblPrecision: TLabel;
    LBoxIntersection: TListBox;
    MemoGenNewtonRes: TMemo;
    MemoInterpolationRes: TMemo;
    MemoOpenRes: TMemo;
    MemoClosedRes: TMemo;
    PageControl1: TPageControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PanelClosedHeader: TPanel;
    PanelClosedHeader1: TPanel;
    RBtnLagrange: TRadioButton;
    RadioGroup2: TRadioGroup;
    RadioGroup3: TRadioGroup;
    RBtnBisection: TRadioButton;
    RBtnNewton: TRadioButton;
    RBtnFakePosition: TRadioButton;
    RadioGroup1: TRadioGroup;
    RBtnSecant: TRadioButton;
    ScrollBox1: TScrollBox;
    SpinInterpolationXMin: TSpinEdit;
    SpinInterpolationXMax: TSpinEdit;
    SpinGenNewton: TSpinEdit;
    StatusBar1: TStatusBar;
    StrGridGenNewtonRes: TStringGrid;
    StrGridGenNewtonVars: TStringGrid;
    StrGridGenNewtonFuncs: TStringGrid;
    StrGridGenNewtonXIni: TStringGrid;
    StsBarXPoint: TStatusBar;
    StrGridOpen: TStringGrid;
    StrGridResIntersection: TStringGrid;
    StrGridClosed: TStringGrid;
    TabSheetGeneralizatedNewton: TTabSheet;
    TabSheetIntrapolation: TTabSheet;
    TabSheetOpenMethods: TTabSheet;
    TabSheetIntersection: TTabSheet;
    TabSheetClosedMethods: TTabSheet;
    TrackBar1: TTrackBar;
    trbarVisible: TTrackBar;

    procedure BtnClearFunctionsClick(Sender: TObject);
    procedure BtnClearLBoxClick(Sender: TObject);
    procedure BtnClosedExecuteClick(Sender: TObject);
    procedure BtnGenNewtonExecuteClick(Sender: TObject);
    procedure BtnInterpolationClearClick(Sender: TObject);
    procedure BtnInterpolationEvaluateClick(Sender: TObject);
    procedure BtnInterpolationExecuteClick(Sender: TObject);
    procedure BtnIntersectionClick(Sender: TObject);
    procedure BtnOpenExecuteClick(Sender: TObject);
    procedure ChartToolset1DataPointClickTool1PointClick(ATool: TChartTool;
      APoint: TPoint);
    procedure FormDestroy(Sender: TObject);
    procedure FunctionSeriesCalculate(const AX: Double; out AY: Double);
    procedure FormShow(Sender: TObject);
    procedure FunctionsEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure SpinGenNewtonChange(Sender: TObject);
    procedure trbarVisibleChange(Sender: TObject);
  private
    FunctionList,
    EditList: TList;
    ActiveFunction: Integer;
    min,
    max: Real;
    Parse  : TparseMath;
    function f( x: Real ): Real;
    function evaluar( x: Real; fun: String ): Real;
    procedure CreateNewFunction;
    procedure Graphic2D;
    procedure DrawPoint(x,y: Double; functSerie: TLineSeries);
    procedure DrawPointList(xPoints,yPoints: TStringList; functSerie: TLineSeries );
    procedure DrawLineSerie( functSerie: TLineSeries; funExpression:String ;xmin,xmax: Double);

    function getYValuesFromXValues( Xvalues: TStringList; fun: String): TStringList;

    procedure clearStrGridClosed;
  public

  end;

var
  Form1: TForm1;

implementation

const
  FunctionEditName = 'FunctionEdit';
  FunctionSeriesName = 'FunctionLines';
  col_a = 0;
  col_b = 1;
  col_xn = 2;
  col_sign = 3;
  col_error = 4;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FunctionList:= TList.Create;
  EditList:= TList.Create;
  min:= -5.0;
  max:= 5.0;
  Parse:= TParseMath.create();
  Parse.AddVariable('x', min);
end;

procedure TForm1.SpinGenNewtonChange(Sender: TObject);
begin
  StrGridGenNewtonVars.RowCount:= SpinGenNewton.Value ;
  StrGridGenNewtonFuncs.RowCount:= SpinGenNewton.Value ;
  StrGridGenNewtonXIni.RowCount:= SpinGenNewton.Value ;
end;

procedure TForm1.trbarVisibleChange(Sender: TObject);
begin
  Self.AlphaBlendValue:= trbarVisible.Position;
end;

function TForm1.f( x: Real ): Real;
begin
  Parse.Expression:= TEdit( EditList[ ActiveFunction ] ).Text;
  Parse.NewValue('x', x);
  Result:= Parse.Evaluate();
end;

function TForm1.evaluar( x: Real; fun: String ): Real;
begin
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
    with ATool as TDatapointClickTool do
      if (Series is TLineSeries) then
        with TLineSeries(Series) do begin
          x := GetXValue(PointIndex);
          y := GetYValue(PointIndex);

          LBoxIntersection.AddItem(TEdit(EditList.Items[Tag]).Caption, TEdit(EditList.Items[Tag]));
          Statusbar1.SimpleText := Format(' %s : x = %f, y = %f', [TEdit(EditList.Items[Tag]).Caption, x, y]);
        end
      else
        Statusbar1.SimpleText := 'Unknown Function';
end;

procedure TForm1.DrawPoint(x,y: Double; functSerie: TLineSeries);
begin
    functSerie.AddXY(x,y);
end;

procedure TForm1.DrawPointList(xPoints,yPoints: TStringList; functSerie: TLineSeries );
var i : Integer;
begin
    for i:=0 to xPoints.Count-1 do begin
        DrawPoint( StrToFloat( xPoints[i] ), StrToFloat( yPoints[i] ), functSerie);
        DrawPoint(NaN,NaN,functSerie);
    end;
end;

function TForm1.getYValuesFromXValues( Xvalues: TStringList; fun: String): TStringList;
var i:Integer;
begin
    Result := TStringList.Create;
    for i := 0 to Xvalues.Count - 1 do
    begin
        //if( Xvalues[i] <> 'No') then
         Result.Add( FloatToStr( evaluar(StrToFloat(Xvalues[i]), fun)) );
    end;
end;

procedure TForm1.BtnIntersectionClick(Sender: TObject);
var
  function1, function2 : String;
  funOp : TFunOperations;
  Res : TResult;
  ResY : TStringList;
  i: Integer;
begin
    StsBarXPoint.Caption:='0.0';

    if (LBoxIntersection.Count < 2) then
       Exit;

    funOp := TFunOperations.create();
    resY := TStringList.Create();
    function1:= LBoxIntersection.Items[LBoxIntersection.Count-2];
    function2:= LBoxIntersection.Items[LBoxIntersection.Count-1];

    Res := funOp.intersection(function1, function2, StrToFloat( ediMin.Text), StrToFloat( ediMax.Text), StrToFloat(EdtPrecision.Text), StrToFloat(StsBarXPoint.Caption) );

    if( Res.thereIsResult = False) then begin
        ShowMessage('No hay Interseccion en el intervalo ['+ediMin.Text + ','+ediMin.Text+']');
        Exit;
    end;

    ResY := getYValuesFromXValues(Res.result,function1);

    StrGridResIntersection.RowCount:= Res.result.Count;
    //StrGridResIntersection.Cols[0].Assign(funOp.AList);
    //StrGridResIntersection.Cols[1].Assign(funOp.BList);
    //StrGridResIntersection.Cols[2].Assign(funOp.BolzanoList);
    //StrGridResIntersection.Cols[3].Assign(funOp.BolzanoResList);
    StrGridResIntersection.Cols[0].Assign(Res.result);
    StrGridResIntersection.Cols[1].Assign(ResY);

    DrawPointList(Res.result, ResY, intersectionPoints);
end;

procedure TForm1.BtnClosedExecuteClick(Sender: TObject);
var
  Res : TResultM;
  a,b,e : Double;
  closed : TClosedMethods;
  fun : String;
begin
  clearStrGridClosed;

  closed := TClosedMethods.create();

  fun := EdtClosedFunction.Text;
  a := StrToFloat( EdtClosedA.Text );
  b := StrToFloat( EdtClosedB.Text );
  e := StrToFloat( EdtClosedError.Text );

  if ( RBtnBisection.Checked ) then
   Res := closed.bisectionMethod(a,b,e,fun);
  if ( RBtnFakePosition.Checked ) then
   Res := closed.fakePositionMethod(a,b,e,fun);

  StrGridClosed.RowCount:= res.XnList.Count;
  //ShowMessage( FloatToStr(res.XnList.Count));

  StrGridClosed.Cols[col_a].Assign(Res.AList);
  StrGridClosed.Cols[col_b].Assign(Res.BList);
  StrGridClosed.Cols[col_xn].Assign(Res.XnList);
  StrGridClosed.Cols[col_sign].Assign(Res.SignList);
  StrGridClosed.Cols[col_error].Assign(Res.ErrorList);

  MemoClosedRes.Lines.Add( Res.result );
end;

procedure TForm1.BtnOpenExecuteClick(Sender: TObject);
var
  Res : TResultM;
  xIni,e : Double;
  open: TOpenMethod;
  fun, derivada : String;
begin
    open := TOpenMethod.Create;

    xIni := StrToFloat( EdtOpenXinitial.Text );
    e := StrToFloat( EdtOpenError.Text );
    fun := EdtOpenFunction.Text ;
    derivada:= EdtOpenFunctionDeriv.Text ;

    if ( RBtnNewton.Checked) then
      Res := open.newton(xIni,fun,derivada,e);
    if ( RBtnSecant.Checked) then
      Res := open.secante(xIni,fun,e);

    StrGridOpen.RowCount:= res.XnList.Count;
    //ShowMessage( FloatToStr(res.XnList.Count));

    StrGridOpen.Cols[col_xn].Assign(Res.XnList);
    StrGridOpen.Cols[col_error].Assign(Res.ErrorList);

    MemoOpenRes.Lines.Add( Res.result );

end;

procedure TForm1.BtnInterpolationExecuteClick(Sender: TObject);
var
  XPoints, YPoints,XYPoints: TStringList;
  i: Integer;
  polinomy : String;
  interpolation : TInterpolation;
  xmin,xmax: Integer;
begin
    XPoints := TStringList.Create;
    YPoints := TStringList.Create;
    XYPoints := TStringList.Create;
    interpolation := TInterpolation.Create;

    xmin := SpinInterpolationXMin.Value;
    xmax := SpinInterpolationXMax.Value;

    if ( CBoxInterpolationDrawFunc.Checked) then begin
         DrawLineSerie(InterpolationSerie,EdtInterpolationRes.Text,xmin,xmax);
         Exit;
    end;

    extractStrings([','],[],PChar(EdtInterpolationXYpoints.text), XYPoints);

    i := 0;
    while ( i < XYPoints.Count ) do begin
         XPoints.Add( XYPoints[i]);
         YPoints.Add( XYPoints[i+1]);
         i := i + 2;
    end;

    if ( RBtnLagrange.Checked ) then
      polinomy:= interpolation.lagrange(XPoints,YPoints)
    else begin
         ShowMessage('Elija un metodo');
         Exit;
    end;

    MemoInterpolationRes.Lines.Add( polinomy );
    EdtInterpolationRes.Text:= polinomy;
    DrawLineSerie(InterpolationSerie,polinomy,xmin,xmax);

    if (CBoxInterpolationShowValuePoints.Checked) then
      InterpolationPoints.Marks.Style:= smsValue;
    if ( CBoxInterpolationShowPoints.Checked ) then
      InterpolationPoints.ShowPoints:=True;

    DrawPointList(XPoints,YPoints,InterpolationPoints);

end;

procedure TForm1.BtnInterpolationEvaluateClick(Sender: TObject);
var
  x,y: Double;
begin
    x := StrToFloat(EdtInterpolationEvaluate.Text);
    y := evaluar(x,EdtInterpolationRes.Text);

    DrawPoint(x,y,InterpolationPoints);
    DrawPoint(NaN,NaN,InterpolationPoints);

    if (CBoxInterpolationShowValuePoints.Checked) then
      InterpolationPoints.Marks.Style:= smsValue;
    if ( CBoxInterpolationShowPoints.Checked ) then
      InterpolationPoints.ShowPoints:=True;

end;

procedure TForm1.BtnGenNewtonExecuteClick(Sender: TObject);
var
  varsMatrix, funcsMatrix: array of string;
  xIniMatrix: array of Real;
  i : Integer;
  newton: TNg;
  Res:String;
begin
  StrGridGenNewtonRes.Clean;
  newton := TNg.Create;
  SetLength(varsMatrix,SpinGenNewton.Value);
  SetLength(funcsMatrix,SpinGenNewton.Value);
  SetLength(xIniMatrix,SpinGenNewton.Value);

  for i:=0 to SpinGenNewton.Value-1 do begin
       varsMatrix[i] := StrGridGenNewtonVars.Cells[0,i];
       funcsMatrix[i] := StrGridGenNewtonFuncs.Cells[0,i];
       xIniMatrix[i] := StrToFloat(StrGridGenNewtonXIni.Cells[0,i]);
  end;

  Res:= newton.newton_generalizado(varsMatrix,funcsMatrix,xIniMatrix);

  StrGridGenNewtonRes.Cols[0].Assign( newton.xnList );
  StrGridGenNewtonRes.Cols[1].Assign( newton.ErrorList );

  StrGridGenNewtonRes.RowCount:= newton.ErrorList.Count;
  MemoGenNewtonRes.Lines.Add( IntToStr(newton.xnList.Count) );
  MemoGenNewtonRes.Lines.Add( IntToStr(newton.ErrorList.Count) );
  MemoGenNewtonRes.Lines.Add( Res );

  newton.Destroy;
end;

procedure TForm1.BtnInterpolationClearClick(Sender: TObject);
begin
  InterpolationSerie.Clear ;
  InterpolationPoints.Clear;
end;

procedure TForm1.BtnClearLBoxClick(Sender: TObject);
begin
  LBoxIntersection.Clear;
  StrGridResIntersection.Clear;
  intersectionPoints.Clear;
  //Chart1.ClearSeries;
end;

procedure TForm1.BtnClearFunctionsClick(Sender: TObject);
var
  pars: TParseMath;
begin
  // limpiar de FunctionList
  pars := TParseMath.create();
  pars.Expression:= 'x+1';
  pars.AddVariable('x',Infinity);
  ShowMessage( FloatToStr( pars.Evaluate() ) );
  pars.destroy;
  //Chart1.ClearSeries;
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

procedure TForm1.DrawLineSerie( functSerie: TLineSeries; funExpression:String ;xmin,xmax: Double);
var x: Double;
const h = 0.001;
begin
  x:= xmin;
  functSerie.Clear;

  with TLineSeries(functSerie) do
  repeat
      AddXY( x, evaluar(x,funExpression) );
      x:= x + h
  until ( x>= xmax );

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

procedure TForm1.clearStrGridClosed;
begin
 with StrGridClosed do begin
    Clean;
    RowCount:= 1;
    Columns[ col_a ].Title.Caption:= 'A';
    Columns[ col_b ].Title.Caption:= 'B';
    Columns[ col_xn ].Title.Caption:= 'Xn';
    Columns[ col_sign ].Title.Caption:= 'Signo';
    Columns[ col_error ].Title.Caption:= 'ERROR';
  end;
end;
{$R *.lfm}

end.


