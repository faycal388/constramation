unit Fcoupure_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxGDIPlusClasses, ExtCtrls, ExtDlgs, StdCtrls, Buttons, acPNG,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls;

type
  TFcoupure = class(TForm)
    Image1: TImage;
    OpenTextFileDialog1: TOpenTextFileDialog;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Button4: TButton;
    ToolbarImages: TImageList;
    Button1: TButton;
    Label5: TLabel;
    Edit3: TEdit;
    Label6: TLabel;
    Label2: TLabel;
    UpDown1: TUpDown;
    Edit5: TEdit;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fcoupure: TFcoupure;
            lextention:string;
            noms_fichiers:array[1..10] of string;
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

//--------
procedure SplitFile(FileName : TFileName; FilesByteSize : Integer) ;
// FileName == file to split into several smaller files
// FilesByteSize == the size of files in bytes
var
   fs, ss: TFileStream;
   cnt : integer;
   SplitName: String;

begin


   fs := TFileStream.Create(FileName, fmOpenRead or fmShareDenyWrite) ;
   try
     for cnt := 1 to Trunc(fs.Size / FilesByteSize) + 1 do
     begin
//       SplitName := ChangeFileExt(FileName, Format('%s%d', ['._',cnt])) ;
       SplitName :=noms_fichiers[cnt];

       ss := TFileStream.Create(SplitName, fmCreate or fmShareExclusive) ;
       try
//         if fs.Size - fs.Position
          if fs.Size < fs.Position  then
           FilesByteSize := fs.Size - fs.Position;
         ss.CopyFrom(fs, FilesByteSize) ;
       finally
        FreeAndNil(ss);
//         ss.Free;
       end;
     end;
   finally
     FreeAndNil(fs);
//     fs.Free;
   end;

end;

//** Note: a 3 KB file 'myfile.ext' will be split into 'myfile._1', 'myfile._2','myfile._3' if FilesByteSize parameter equals 1024 (1 KB).

//**** Usage:
//**** SplitFile('c:\mypicture.bmp', 1024) ; //into 1 KB files
//**** ...
//*** MergeFiles('c:\mypicture._1','c:\mymergedpicture.bmp') ;
//--------


procedure TFcoupure.Button1Click(Sender: TObject);
var i:Integer;
d1:TDate;
t1:TTime;
annee,mois,jour:Word;
heure,minutes,secondes,ms:Word;
begin
d1:=now;
t1:=Now;
DecodeDate(d1,annee,mois,jour);
Decodetime(t1,heure,minutes,secondes,ms);
for I := 1 to StrToInt(Edit2.text) do
begin
ListBox1.Items.Add(Edit1.Text+'_'+inttostr(i)+'_'+vartostr(annee)+vartostr(mois)+vartostr(jour)+'_'+vartostr(heure)+vartostr(minutes)+vartostr(secondes)+lextention);
noms_fichiers[i]:=Edit1.Text+'_'+inttostr(i)+'_'+vartostr(annee)+vartostr(mois)+vartostr(jour)+'_'+vartostr(heure)+vartostr(minutes)+vartostr(secondes)+lextention;
end;

end;

procedure TFcoupure.Button2Click(Sender: TObject);
var taille:Integer;
  I: Integer;
begin
Edit5.Clear;
taille:=StrToInt(Edit4.text)*1024;

for I := 0 to ListBox1.Items.Count-1 do
begin
try
SplitFile(OpenDialog1.filename, taille) ; //into 1 KB files
except
Edit5.text:='Cut Done, Check the folder !';
 Exit;
end;
end;
Edit5.text:='Cut Done, Check the folder !';

end;

procedure TFcoupure.Button4Click(Sender: TObject);

begin
Edit1.Clear;
Edit2.Clear;
Edit3.Clear;
Edit4.Clear;
Edit5.Clear;
ListBox1.Clear;
if OpenDialog1.execute then
begin
//Edit1.Text:=OpenDialog1.FileName;
Edit1.Text:=ExtractFileName(OpenDialog1.FileName);
;
Edit1.Text := Copy(ExtractFileName(OpenDialog1.FileName), 1,Length(ExtractFileExt(OpenDialog1.FileName))+5);

lextention:=ExtractFileext(OpenDialog1.FileName);

Edit3.Text:=VarToStr(FileSize(OpenDialog1.FileName)div 1024);
end;
end;

procedure TFcoupure.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
Edit4.Text:=IntToStr(strtoint(Edit3.Text) div strtoint(Edit2.text));
end;

end.
