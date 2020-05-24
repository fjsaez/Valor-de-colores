program ValorColores;

uses
  System.StartUpCopy,
  FMX.Forms,
  Principal in 'Principal.pas' {FPrinc};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='Valor de colores';
  Application.CreateForm(TFPrinc, FPrinc);
  Application.Run;
end.
