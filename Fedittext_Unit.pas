unit Fedittext_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxGDIPlusClasses, ExtCtrls, StdCtrls, Buttons, acPNG,
  System.ImageList, Vcl.ImgList, Vcl.ExtDlgs;

type
  TFedittext = class(TForm)
    Image2: TImage;
    Edit1: TEdit;
    Edit2: TEdit;
    Memo1: TMemo;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Button4: TButton;
    Button6: TButton;
    ToolbarImages: TImageList;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SaveTextFileDialog1: TSaveTextFileDialog;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button5: TButton;
    Edit3: TEdit;
    Label3: TLabel;
    Edit4: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fedittext: TFedittext;
              FS: TBufferedFileStream;  //saves a little
 FN, data,s: string;
        vLinesCounter: Int64;
        sto:Integer;
           Reader: TStreamReader;
implementation



{$R *.dfm}

procedure TFedittext.Button1Click(Sender: TObject);
var i,z:Integer;
 stro:string;
 begin
 edit4.Clear;
 if Edit3.text='' then
begin
 edit4.text:='Click Open File First ';
Exit;

end ;
  z:=0;
  vLinesCounter:= 0;

  FN :=OpenTextFileDialog1.FileName; //
  FS := TBufferedFileStream.Create(FN,fmOpenRead or fmShareDenyWrite );
  try
    Reader := TStreamReader.Create(FS);
    Try
      while not Reader.EndOfStream do
      begin
        if (sto=0) then
        begin
        Exit;
        end;

        stro:=Reader.ReadLine;
  Memo1.Lines.Add(Edit1.text+ stro+Edit2.text) ;
        Inc(vLinesCounter);
        if vLinesCounter mod 1000 = 0 then
        begin
        Application.ProcessMessages ;
        inc(i);
        end;
     end;
    Finally
      Reader.Free
    End;
  finally
    FS.Free;
end;
 end;

procedure TFedittext.Button4Click(Sender: TObject);
begin
sto:=1;
Memo1.Clear;
if OpentextfileDialog1.execute then
begin
 try
 Memo1.lines.loadfromfile(opentextfiledialog1.filename);
 except
 Application.ProcessMessages;
 edit3.Text:=opentextfiledialog1.filename;
 end;
 edit3.Text:=opentextfiledialog1.filename;
end;
end;

procedure TFedittext.Button5Click(Sender: TObject);
begin
sto:=0;
end;

procedure TFedittext.Button6Click(Sender: TObject);
begin
if savetextfileDialog1.execute then Memo1.lines.savetofile(savetextfiledialog1.filename);
end;

end.
