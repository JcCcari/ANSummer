unit FunctionOperations;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Result, mOpenMethod, ClosedMethods, ParseMath;

type
  TFunOperations = class

    public
      constructor create();
      function bolzano( x1,x2: Double; fun: String): Integer;
      function evaluar(valorX : Real ; f_x : String ) : Real;
      function intersection( f1, f2 : String; xmin, xmax, e: Double): TResult;
    private
      open: TOpenMethod;
      closed : TClosedMethods;
  end;

implementation

constructor TFunOperations.create();
begin
  open := TOpenMethod.Create();
  closed := TClosedMethods.create();
end;

function TFunOperations.bolzano( x1,x2: Double; fun: String): Integer;
var
  fx1, fx2: Double;
begin
  fx1 := evaluar(x1,fun);
  fx2 := evaluar(x2,fun);
  if( fx1 = 0) then // x1 is the solution
      Result := 1;
  if( fx2 = 0) then // x2 is the solution
      Result := 2;

  if ( (fx1*fx2) < 0 ) then // success bolzano test
      Result := 3
  //if ( (fx1*fx2) > 0 ) then //else  // don´t succes test
  else  // don´t succes test
      Result := 0;

  //Result := ( (fx1*fx2) < 0 );
end;

function TFunOperations.evaluar(valorX : Real ; f_x : String ) : Real;
var
   MiParse : TParseMath;
begin
  try
   Miparse := TParseMath.create();
   MiParse.AddVariable('x',valorX);
   MiParse.Expression:= f_x;
   evaluar := MiParse.Evaluate();
  except
     evaluar:=0.0;
     Exit;
  end;
end;

// use closed method - parameter [ Point - 1 , Point +1]
// use open method - parameter [Result closed method]
function TFunOperations.intersection( f1, f2 : String; xmin, xmax, e: Double): TResult;
var
  funExpression: String;
  xa, xb: Double;
  thereSolution : Integer;
  resultTemp: String;
begin
  Result.result := TStringList.Create;
  funExpression := f1 + '-' + f2;
  xa:= xmin;
  while( xa <= xmax )do begin
    xb := xa + 0.5;
    thereSolution:= bolzano(xa,xb,funExpression);
    //xa := xb;
    //Result.result.Add( IntToStr(thereSolution));
    case thereSolution of
     1:
       Result.result.Add( FloatToStr(xa) );
     2:
       Result.result.Add( FloatToStr(xb) );
     3:
       begin
         resultTemp := closed.bisectionMethod(xa,xb,0.01,funExpression).result;
         resultTemp := open.secante(StrToFloat(resultTemp),funExpression, e ).result;
         //resultTemp:='res';
         Result.result.Add( resultTemp );
       end;
    end;
    xa := xb;
    {
    if ( thereSolution = 0 ) then begin
        xa := xb;
        Continue;
    end
    else begin
      if ( thereSolution = 1 ) then
          Result.result.Add( FloatToStr(xa) )
      else begin
          if ( thereSolution = 2 ) then
              Result.result.Add( FloatToStr(xb) )
          else begin //if ( thereSolution = 3) then
              resultTemp := closed.bisectionMethod(xa,xb,0.01,funExpression).result;
              resultTemp := open.secante(StrToFloat(resultTemp),funExpression, e ).result;
              Result.result.Add( resultTemp );
          end;
      end;
      xa := xb;
    end;
    }
    //xb := xa;
  end;
end;

end.

