unit mResult;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
    TResultM = record
      result: string;
      matrix: array of array of string;
      AList,
      BList,
      XnList,
      SignList,
      ErrorList: TStringList;
      thereAreResult: Boolean;
    end;

implementation

end.

