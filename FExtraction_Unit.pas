unit FExtraction_Unit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, acPNG, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.StdCtrls, Vcl.ExtDlgs;

type
  TFExtraction = class(TForm)
    Image1: TImage;
    Memo1: TMemo;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Button4: TButton;
    Button9: TButton;
    Button6: TButton;
    ToolbarImages: TImageList;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Memo2: TMemo;
    Button10: TButton;
    Button7: TButton;
    Button8: TButton;
    Edit3: TEdit;
    Button5: TButton;
    SaveTextFileDialog1: TSaveTextFileDialog;
    Edit1: TEdit;
    procedure Button10Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  FExtraction: TFExtraction;

   Reader: TStreamReader;
  FS: TBufferedFileStream;  //saves a little
 FN, data,s: string;
       eT, vLinesCounter: Int64;
        sto:Integer;
        ts : TStrings;
implementation

{$R *.dfm}

//-----------functions----
function FileSize(const aFilename: String): Int64;
  var
    info: TWin32FileAttributeData;
  begin
    result := -1;

    if NOT GetFileAttributesEx(PWideChar(aFileName), GetFileExInfoStandard, @info) then
      EXIT;

    result := Int64(info.nFileSizeLow) or Int64(info.nFileSizeHigh shl 32);
  end;

//---------/functions------
//--------procedures----
  procedure Split (const Delimiter: Char; Input: string; const Strings: TStrings) ;
begin
Assert(Assigned(Strings)) ;
Strings.Clear;
Strings.Delimiter := Delimiter;
Strings.DelimitedText := Input;
end ;

//--------/procedures---

procedure TFExtraction.Button10Click(Sender: TObject);
begin
Memo2.Clear;
if OpenDialog1.execute then

Memo2.Lines.Add('File Size : '+VarToStr(FileSize(OpenDialog1.FileName))+' Bytes ');
end;

procedure TFExtraction.Button4Click(Sender: TObject);
begin
Button10.Click;
Button7.Click;
Button8.Click;
end;

procedure TFExtraction.Button5Click(Sender: TObject);
var i:Integer;

begin
ts := TStringList.Create;
Split(' ', edit1.text, ts);
for I := 0 to ts.Count - 1 do
 begin
  if StrPos(PChar(ts[i]), '@') <> nil then
   ListBox1.Items.Add(ts[i]);
  end;
ts.free;

end;

procedure TFExtraction.Button6Click(Sender: TObject);
begin
if SaveTextFileDialog1.Execute then
ListBox1.Items.SaveToFile(SaveTextFileDialog1.FileName);
end;

procedure TFExtraction.Button7Click(Sender: TObject);
var
  i: integer;
  tf: textfile;
  bf: array[0..64256] of char;
  start,stop: tdatetime;
  s,s2: string;
  t: extended;
begin
  i := 0;                           // 3938750 lines in text file
  assignfile(tf,OpenDialog1.filename);  // 194,981,888 bytes  on disk
  system.settextbuf(tf,bf,sizeof(bf));
  reset(tf);
  start := time;
  while not(EOF(tf)) do
  begin
    readln(tf);
    inc(i);
  end;
  stop := time;
  closefile(tf);
  t := stop - start;           // about 4 seconds on my old system
  s := 'Lines read = '+inttostr(i)+char(13)+
        ' elapsed time = '+floattostr(t);
  Edit3.Text:=inttostr(i);
  Memo2.Lines.Add(s);
  end;


procedure TFExtraction.Button8Click(Sender: TObject);
var i,z:Integer;
 pourcent:double;
 stro:string;
 begin
  z:=0;
  et := GetTickCount64;
  vLinesCounter:= 0;


  FN :=OpenDialog1.FileName; //lactually just changed all (?) to (') 87xxx of the things
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
  Memo1.Lines.Add( stro) ;
      //-------------------
if strpos(PChar(stro), '@') <> nil then
       begin
       Edit1.Text:=stro;
       Button5.Click;
       z:=z+1;
       end;
      //--------------------

        Inc(vLinesCounter);
        if vLinesCounter mod 1000 = 0 then
        begin

        Application.ProcessMessages ;
        Memo2.Lines.Add('Lines Done : '+ vLinesCounter.tostring+' / '+Edit3.Text+' Percentage  :'+formatfloat('0.0',((vLinesCounter / strtoint(Edit3.Text))*100))+'%' );

        inc(i);
        end;
     end;
    Finally
      Reader.Free
    End;
  finally
    FS.Free;


  eT := GetTickCount64 - eT;
 Memo2.Lines.Add(vLinesCounter.tostring + ' Records loaded in ' + (eT/1000).tostring + ' seconds.');
end;
 end;



procedure TFExtraction.Button9Click(Sender: TObject);
begin
sto:=0;
end;

procedure TFExtraction.FormCreate(Sender: TObject);
begin
sto:=1;
end;

end.
