{         Valor de colores v1.0

   Aplicación simple que devuelve el valor RGB de un color seleccionado de un
   TColorPanel. Realizado solamente con componentes nativos.

   Autor: Francisco J. Sáez S.

   Calabozo, 11 de mayo de 2020
}

unit Principal;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Colors,
  FMX.Edit, FMX.Controls.Presentation, FMX.StdCtrls;

type
  TMiColor = record
    R,G,B: integer;
    Rh,Gh,Bh,
    ColorHex: string;
  end;

  TFPrinc = class(TForm)
    Label1: TLabel;
    ERojo: TEdit;
    EVerde: TEdit;
    Label2: TLabel;
    EAzul: TEdit;
    Label3: TLabel;
    EValHex: TEdit;
    Label4: TLabel;
    ClPanel: TColorPanel;
    ColorBox: TColorBox;
    SpeedButton1: TSpeedButton;
    EAzulH: TEdit;
    EVerdeH: TEdit;
    ERojoH: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    EValDec: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    procedure ClPanelChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ERojoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure ERojoHKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure AsignarColores;
    procedure CargarRegistro(Opc: byte);
  public
    { Public declarations }
  end;

  function ColorHex(R,G,B: string): string;

var
  FPrinc: TFPrinc;
  Col: TMiColor;
  Digitos: byte;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

function ColorHex(R,G,B: string): string;
begin
  if R.Length=1 then R:='0'+R;
  if G.Length=1 then G:='0'+G;
  if B.Length=1 then B:='0'+B;
  result:=R+G+B;
end;

procedure TFPrinc.AsignarColores;
begin
  EValHex.Text:=Col.ColorHex;
  EValDec.Text:=IntToStr(ClPanel.Color);
  //en decimal:
  ERojo.Text:=Col.R.ToString;
  EVerde.Text:=Col.G.ToString;
  EAzul.Text:=Col.B.ToString;
  //en hexadecimal:
  ERojoH.Text:=Col.Rh;
  EVerdeH.Text:=Col.Gh;
  EAzulH.Text:=Col.Bh;
end;

procedure TFPrinc.CargarRegistro(Opc: byte);
begin
  if Opc=1 then    //1: decimal;
  begin
    Col.R:=ERojo.Text.ToInteger;
    Col.G:=EVerde.Text.ToInteger;
    Col.B:=EAzul.Text.ToInteger;
    Col.Rh:=IntToHex(Col.R,Digitos);
    Col.Gh:=IntToHex(Col.G,Digitos);
    Col.Bh:=IntToHex(Col.B,Digitos);
  end
  else             //2: hexadecimal
  begin
    Col.Rh:=ERojoH.Text;
    Col.Gh:=EVerdeH.Text;
    Col.Bh:=EAzulH.Text;
    Col.R:=StrToInt('$'+Col.Rh);
    Col.G:=StrToInt('$'+Col.Gh);
    Col.B:=StrToInt('$'+Col.Bh);
  end;
  Col.ColorHex:=ColorHex(Col.Rh,Col.Gh,Col.Bh);
  ClPanel.Color:=StrToInt('$FF'+Col.ColorHex);
end;

procedure TFPrinc.ERojoHKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if TEdit(Sender).Text='' then TEdit(Sender).Text:='0';
  if TEdit(Sender).IsFocused then CargarRegistro(2);
end;

procedure TFPrinc.ERojoKeyUp(Sender: TObject; var Key: Word; var KeyChar: Char;
  Shift: TShiftState);
begin
  if TEdit(Sender).Text='' then TEdit(Sender).Text:='0';
  if TEdit(Sender).IsFocused then
    if ((StrToInt(TEdit(Sender).Text)>255)) then TEdit(Sender).Text:='0'
    else CargarRegistro(1);
end;

procedure TFPrinc.ClPanelChange(Sender: TObject);
begin
  Col.R:=(ClPanel.Color and $FF0000) shr 16;
  Col.G:=(ClPanel.Color and $FF00) shr 8;
  Col.B:=ClPanel.Color and $FF;
  Col.Rh:=IntToHex(Col.R,Digitos);
  Col.Gh:=IntToHex(Col.G,Digitos);
  Col.Bh:=IntToHex(Col.B,Digitos);
  Col.ColorHex:=ColorHex(Col.Rh,Col.Gh,Col.Bh);
  AsignarColores;
end;

procedure TFPrinc.FormShow(Sender: TObject);
begin
  Digitos:=1;
  ClPanel.Color:=$FFFFFFFF;
  ClPanelChange(Self);
end;

procedure TFPrinc.SpeedButton1Click(Sender: TObject);
begin
  ShowMessage('Valor de colores v1.0'+#10+#10+
    'Aplicación simple que devuelve el valor RGB de un color seleccionado'+#10+
    'de un TColorPanel. Realizado solamente con componentes nativos.'+#10+#10+
    'Autor: Francisco J. Sáez S.'+#10+
    'E-mail: fjsaez@gmail.com'+#10+
    'LinkedIn: linkedin.com/in/francisco-josé-sáez-soto'+#10+#10+
    'Calabozo, 11 de mayo de 2020');
end;

end.
