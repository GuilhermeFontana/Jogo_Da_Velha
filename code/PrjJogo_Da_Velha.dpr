program PrjJogo_Da_Velha;

uses
  Vcl.Forms,
  UntPincipal in 'UntPincipal.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
