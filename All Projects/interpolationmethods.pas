unit interpolationMethods;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  TInterpolation = class
    public
      function lagrange(XList, YList: TStringList): string;
    private

  end;

implementation

function TInterpolation.lagrange(XList, YList: TStringList): string;
var
  i,j,n : Integer;
  dividendo: Double;
  polinomy : String;
  lagrangiano: String;
begin
  if ( XList.Count < 1) then begin
     polinomy:='Ingrese elementos';
     Exit;
  end;

  n := XList.Count;
  polinomy:='';
  //Result := XList[n-1] + ' ' +YList[n-1];

  for i:=0 to n-1 do begin
    dividendo:= 1;
    lagrangiano:='';
    for j := 0 to n-1 do begin

      if( i <> j) then begin
        dividendo := dividendo*(StrToFloat( XList[i]) - StrToFloat( XList[j]) );
        lagrangiano := lagrangiano + '(x-'+ XList[j] + ')*';
      end;

    end;
    lagrangiano := Copy(lagrangiano,1, lagrangiano.Length-1);
    polinomy:= polinomy + YList[i]+ '/' +FloatToStr(dividendo)+'*(' + lagrangiano +') + ';

  end;
  polinomy:= Copy(polinomy,1,polinomy.Length-2);
  Result := polinomy;
end;

end.

