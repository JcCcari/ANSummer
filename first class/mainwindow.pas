unit mainwindow;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, tsuma;

type

  { TForm1 }

  TForm1 = class(TForm)
    BtnExecute: TButton;
    EditN: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblParForm: TLabel;
    lblResPar: TLabel;
    lblResImpar: TLabel;
    LblResult: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    RadioGroup1: TRadioGroup;
    procedure BtnExecuteClick(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1; // autocreacion de la clase // instanciacion

implementation

{$R *.lfm}     // lfm = lazarus form, propiedades del formulario

{ TForm1 }

procedure TForm1.BtnExecuteClick(Sender: TObject);
var
  MySum : TSumaN;
begin
  Mysum := TSumaN.Create;
  MySum.n := StrToInt(EditN.Text);
  LblResult.Caption:= IntToStr(MySum.suma1());
  lblResPar.Caption:=IntToStr(MySum.sumaPares());
  lblResImpar.Caption:=IntToStr(MySum.sumaImpares());
  //lblParForm.Caption:=IntToStr(MySum.sumaParesForm());
  MySum.Destroy;
end;

end.

