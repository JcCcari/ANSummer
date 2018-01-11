unit FunctionOperations;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Result;

type
  TFunOperations = class
    public
      function intersection( f1, f2 : String; x,y : Double): TResult;
    private

  end;

implementation

// use closed method - parameter [ Point - 1 , Point +1]
// use open method - parameter [Result closed method]
function TFunOperations.intersection( f1, f2 : String; x,y : Double): TResult;
begin

end;

end.

