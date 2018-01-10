unit tsuma;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, math;

type
  TSumaN = class
    private

    public
      n: Integer;
      function suma1():QWord;
      function sumaPares():Integer;
      function sumaImpares():Integer;
      function sumaParesForm():Integer;
  end;

implementation

function TSumaN.suma1(): QWord;
begin
  Result := trunc(n * ( n + 1) / 2);

end;

function TSumaN.sumaPares(): Integer;
var
  i: Integer;
begin
  Result := 0;
  i := 2;
  while( i <= n ) do
  begin
    Result += i;
    i += 2;
  end;
end;

function TSumaN.sumaImpares(): Integer;
var
  i: Integer;
begin
  Result := 0;
  i := 1;
  while( i <= n ) do
  begin
    Result += i;
    i += 2;
  end;
end;

function TSumaN.sumaParesForm():Integer;
var
  countP: Integer;
begin
  countP:= Ceil(n/2);
  Result:= n*(n+1);
end;

end.


