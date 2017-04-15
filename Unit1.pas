unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.Math, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, IntervalArithmetic,
  Vcl.Grids, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
  procedure GaussSeidel (
                        mit       : Integer;
                        eps       : Extended);
    procedure kolejna_wart_macierzyClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  a         : array of array of Extended;
  b         : array of Extended;
  x         : array of Extended;
  it        : Integer;
  st        : Integer;
  n         : Integer;
  indexi    : Integer = 1;
  indexj    : Integer = 1;
  flag_button    : Integer = 1; //flaga przycisku
  { 1 - wprowadzenie wartosci n
    2 - wprowadzenie wartosci macierzy a
    3 - wprowadzenie wartosci macierzy b
    4 - wprowadzenie wartosci macierzy x
    5 - koniec wprowadzania wartosci
  }
implementation

{$R *.dfm}

procedure TForm1.kolejna_wart_macierzyClick(Sender: TObject);
begin
  //a[indexi,indexj]:=
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  if flag_button = 1 then
  begin
    n := StrToInt(Edit1.Text);
    flag_button := True;
    Button1.Caption := 'Wprowadz wart macierzy';
    flag_button := 2;
    Edit1.Text := 'x[1,1]';
  end;
  if flag then

  begin

  end;
  if True then

end;

procedure TForm1.GaussSeidel (mit       : Integer;
                             eps       : Extended);
var i,ih,k,kh,khh,lz1,lz2 : Integer;
    max,r                 : Extended;
    cond                  : Boolean;
    x1                    : array of Extended;
begin
    SetLength(x1, n);
    if n<1
      then st:=1
      else begin
             st:=0;
             cond:=true;
             for k:=1 to n do
               x1[k]:=0;
             repeat
               lz1:=0;
               khh:=0;
               for k:=1 to n do
                 begin
                   lz2:=0;
                   if a[k,k]=0
                     then begin
                            kh:=k;
                            for i:=1 to n do
                              if a[i,k]=0
                                then lz2:=lz2+1;
                            if lz2>lz1
                              then begin
                                     lz1:=lz2;
                                     khh:=kh
                                   end
                          end
                 end;
               if khh=0
                 then cond:=false
                 else begin
                        max:=0;
                        for i:=1 to n do
                          begin
                            r:=abs(a[i,khh]);
                            if (r>max) and (x1[i]=0)
                              then begin
                                     max:=r;
                                     ih:=i
                                   end
                          end;
                        if max=0
                          then st:=2
                          else begin
                                 for k:=1 to n do
                                   begin
                                     r:=a[khh,k];
                                     a[khh,k]:=a[ih,k];
                                     a[ih,k]:=r
                                   end;
                                 r:=b[khh];
                                 b[khh]:=b[ih];
                                 b[ih]:=r;
                                 x1[khh]:=1
                               end
                      end
             until not cond or (st=2);
             if not cond
               then begin
                      it:=0;
                      repeat
                        it:=it+1;
                        if it>mit
                          then begin
                                 st:=3;
                                 it:=it-1
                               end
                          else begin
                                 for i:=1 to n do
                                   begin
                                     r:=b[i];
                                     for k:=1 to i-1 do
                                       r:=r-a[i,k]*x[k];
                                     for k:=i+1 to n do
                                       r:=r-a[i,k]*x1[k];
                                     x1[i]:=r/a[i,i]
                                   end;
                                 cond:=true;
                                 i:=0;
                                 repeat
                                   i:=i+1;
                                   max:=abs(x[i]);
                                   r:=abs(x1[i]);
                                   if max<r
                                     then max:=r;
                                   if max<>0
                                     then if abs(x[i]-x1[i])/max>=eps
                                            then cond:=false
                                 until (i=n) or not cond;
                                 for i:=1 to n do
                                   x[i]:=x1[i]
                               end
                      until (st=3) or cond
                    end
           end
  end;

end.
