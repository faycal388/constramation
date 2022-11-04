unit Fiche_principale_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, dxGDIPlusClasses,
  Vcl.ExtCtrls;

type
  TFiche_principale = class(TForm)
    Image2: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  Fiche_principale: TFiche_principale;

implementation

{$R *.dfm}

uses FExtraction_Unit, Fjointure_Unit, Fcoupure_Unit, Fedittext_Unit;

procedure TFiche_principale.SpeedButton1Click(Sender: TObject);
begin
fextraction.show;
end;

procedure TFiche_principale.SpeedButton2Click(Sender: TObject);
begin
with Fjointure do
begin
Edit1.Clear;
Edit5.Clear;
ListBox1.Clear;
Show;
end;


end;

procedure TFiche_principale.SpeedButton3Click(Sender: TObject);
begin
fcoupure.show;
end;

procedure TFiche_principale.SpeedButton4Click(Sender: TObject);
begin
fedittext.show;
end;

end.
