unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ExtCtrls, StdCtrls, Grids, ValEdit, ComCtrls, Types, ClosedMethods, mResult;

type

  { TForm1 }

  TForm1 = class(TForm)
      Button1: TButton;
      Button2: TButton;
      Edit1: TEdit;
      Edit2: TEdit;
      Edit3: TEdit;
      Edit4: TEdit;
      Edit5: TEdit;
      Edit6: TEdit;
      Edit7: TEdit;
      Edit8: TEdit;
      Label1: TLabel;
      Label2: TLabel;
      Label3: TLabel;
      Label4: TLabel;
      Label5: TLabel;
      Label6: TLabel;
      Label7: TLabel;
      Memo1: TMemo;
      Memo2: TMemo;
      PageControl1: TPageControl;
      StaticText1: TStaticText;
      Biseccion: TTabSheet;
      FalsaPosicion: TTabSheet;
      StaticText2: TStaticText;
      StringGrid1: TStringGrid;
      StringGrid2: TStringGrid;
      procedure Button1Click(Sender: TObject);
      procedure Button2Click(Sender: TObject);
    private
        data: array[1..7] of string;

    public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }


procedure TForm1.Button1Click(Sender: TObject);
var
  closed: TClosedMethods;
  temp: string;
  a,b,e: Double;
  fExpression: string;
  res : TResult;
  i,j: Integer;
  ma: array of array of string;

begin
  //StringGrid1.Clear;
  // (x/ln(x))+ power( 2.71828182845904523536,x-1) - 10
  // (667.38/x )* (1-power( 2.71828182845904523536,-0,146847*x)) -40
  // sin(x) +(power(x,2)/(x-1)) +3
  //power( 2.71828182845904523536,x) +x-2
  // ln(sen(x))+1
  // 0.7*x*power( 2.71828182845904523536,(-98/x))+0.7*x-35
  fExpression := Edit4.Text;
  a:= StrToFloat(Edit1.Text);
  b:= StrToFloat(Edit2.Text);
  e:= StrToFloat(Edit3.Text);
  closed:= TClosedMethods.create();
  res := closed.bisectionMethod(a, b, e, fExpression);
  Memo1.Lines.Add('Res: ' +res.result);
  ma := res.matrix;
  //Memo1.Lines.Add(IntToStr(Length(res.matrix)));
  //Memo1.Lines.Add(IntToStr(Length(res.matrix[0])));
  //StringGrid1.ColCount:= Length(ma);
  for i:= 0 to Length(ma)-1 do
  begin
    StringGrid1.RowCount:= StringGrid1.RowCount+1;
    for j:=0 to Length(ma[0])-1 do
    begin
         StringGrid1.Cells[j+1,i+1] := ma[i,j];
    end;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  closed: TClosedMethods;
  temp: string;
  a,b,e: Double;
  fExpression: string;
  res : TResult;
  i,j: Integer;
  ma: array of array of string;

begin
  // (x/ln(x))+ power( 2.71828182845904523536,x-1) - 10
  // (667.38/x )* (1-power( 2.71828182845904523536,-0,146847*x)) -40
  // sin(x) +(power(x,2)/(x-1)) +3
  fExpression := Edit5.Text;
  a:= StrToFloat(Edit6.Text);
  b:= StrToFloat(Edit7.Text);
  e:= StrToFloat(Edit8.Text);

  closed:= TClosedMethods.create();
  res := closed.fakePositionMethod(a, b, e, fExpression);
  Memo2.Lines.Add(res.result);
  ma := res.matrix;
  //Memo1.Lines.Add(IntToStr(Length(res.matrix)));
  //Memo1.Lines.Add(IntToStr(Length(res.matrix[0])));
  //StringGrid1.ColCount:= Length(ma);
  for i:= 0 to Length(ma)-1 do
  begin
    StringGrid2.RowCount:= StringGrid2.RowCount+1;
    for j:=0 to Length(ma[0])-1 do
    begin
         StringGrid2.Cells[j+1,i+1] := ma[i,j];
    end;
  end;
end;

end.

