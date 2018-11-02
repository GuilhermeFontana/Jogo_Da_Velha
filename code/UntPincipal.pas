unit UntPincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Math, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Button1: TButton;
    Label1: TLabel;
    procedure StringGrid1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);


    //atualizar Grid
    procedure Atualiza_Grid ();
    //jogada do computador
    procedure Joga_PC ();
    //verifica se a posição esta dispoivel
    function Verifica_Jogada (C,L: Integer): Boolean;
    //verifica se ouve vitória
    function Verifica_Vitoria (NJ: Integer): Integer;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  //matriz de salvamento
  MSave: array [0..2,0..2] of Integer;
  Jogadas: Integer;

implementation

{$R *.dfm}

procedure TForm1.Atualiza_Grid;
var
  L: Integer;
  C: Integer;
begin
  for L := 0 to 2 do
    begin
      for C := 0 to 2 do
        begin

          //verifica se posição esta ocupada e quem a ocupa

          if MSave[C,L]=1 then //usuário
            begin
              StringGrid1.Cells[C,L]:= '$';
            end
          else
            begin
              if MSave[C,L]=2 then  //computador
                begin
                  StringGrid1.Cells[C,L]:= '%'
                end;

            end;

        end;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  L: Integer;
  C: Integer;
begin
  //zera a matriz de salvamento
  for L := 0 to 2 do
    begin
      for C := 0 to 2 do
        begin
          MSave[C,L]:=0
        end;
    end;

  //limpa a Grid
  for L := 0 to 2 do
    begin
      for C := 0 to 2 do
        begin
          StringGrid1.Cells[C,L]:='';
        end;
    end;

  StringGrid1.Enabled:= True;
  Jogadas:=0;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  L: Integer;
  C: Integer;
begin
  //zera a matriz de salvamento
  for L := 0 to 2 do
    begin
      for C := 0 to 2 do
        begin
          MSave[C,L]:=0
        end;
    end;
end;

procedure TForm1.Joga_PC;
var
  L: Integer;
  C: Integer;
begin
  //escolhe posiçao aleatória
  L:= RandomRange(0,3);
  C:= RandomRange(0,3);

  while Verifica_Jogada(C,L)=False do
    begin
      L:= RandomRange(0,3);
      C:= RandomRange(0,3);
    end;

   MSave[C,L]:=2;

end;

procedure TForm1.StringGrid1Click(Sender: TObject);
begin

  //0 - vazio
  //1 - usuário
  //2 - computador

  if Verifica_Jogada(StringGrid1.Col,StringGrid1.Row)=True then
    begin

      MSave[StringGrid1.Col,StringGrid1.Row]:=1;

      Inc(Jogadas);

    end
  else
    begin

      showmessage ('posição ocupada');

    end;

  if Jogadas<8 then
    begin
      Joga_PC();
      Inc(Jogadas)

    end;


  Atualiza_Grid;

  //usuário
  if Verifica_Vitoria(1)=1 then
    begin

      ShowMessage('O Usuário Venceu');
      StringGrid1.Enabled:= False;

    end;

  //computador
  if Verifica_Vitoria(2)=2 then
    begin

      ShowMessage('O Computador Venceu');
      StringGrid1.Enabled:= False;

    end;

  //empate
  if ((Verifica_Vitoria(1)=0) and (Verifica_Vitoria(2)=0)) then
    begin

      ShowMessage('Empatou');
      StringGrid1.Enabled:= False;

    end;
end;

function TForm1.Verifica_Jogada(C, L: Integer): Boolean;
begin
  if MSave[C,L]=0 then
    begin

      Result:= True;    //posição disponível

    end
  else
    begin

      Result:= False;    //posição indisponível

    end;
end;

function TForm1.Verifica_Vitoria(NJ: Integer): Integer;
var
  L: Integer;
  C: Integer;
  Cont: Integer;
begin
  //linha
  for C := 0 to 2 do
    begin

      Cont:= 0;

      for L := 0 to 2 do
        begin

          if MSave[C,L]=NJ then
            begin

              Inc(Cont)

            end;


        end;

      if Cont=3 then
        begin

          Result:= NJ;
          exit;

        end;

    end;


  //coluna
  for L := 0 to 2 do
    begin

      Cont:= 0;

      for C := 0 to 2 do
        begin

          if MSave[C,L]=NJ then
            begin

              Inc(Cont)

            end;


        end;

      if Cont=3 then
        begin

          Result:= NJ;
          exit;

        end;

    end;


  //diagonal principal
  Cont:= 0;
  for C := 0 to 2 do
    begin

      for L := 0 to 2 do
        begin

          if L = C then
            begin

              if MSave[C,L]=NJ then
                begin

                  Inc(Cont)

                end;

            end;


        end;

      if Cont=3 then
        begin

          Result:= NJ;
          exit;

        end;

    end;


  //diagonal secundária
  Cont:= 0;
  for C := 0 to 2 do
    begin

      for L := 0 to 2 do
        begin

          if 2-L = C then
            begin

              if MSave[C,L]=NJ then
                begin

                  Inc(Cont)

                end;

            end;


        end;

      if Cont=3 then
        begin

          Result:= NJ;
          exit;

        end;

    end;

  if Jogadas=9 then
    begin

      Result:= 0

    end;
end;

end.

initialization
Jogadas:=0
