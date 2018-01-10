unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls, Menus, taylorserie;

type
  TResult = record
    result: string;
    matrix: array of array of string;
  end;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    StringGrid1: TStringGrid;
    procedure Button1Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
   res: TResult;
   taylor: TTaylorSerie;
   x, e: Double;
begin

  x := Edit1.Text;
  e := Edit2.Text;
  taylor := TTaylorSerie.create();
  res := taylor.sin();
end;

end.

