unit Fjointure_Unit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, dxGDIPlusClasses, ExtCtrls, StdCtrls, ExtDlgs, Buttons, acPNG,
  System.ImageList, Vcl.ImgList;

type
  TFjointure = class(TForm)
    Image1: TImage;
    Button2: TButton;
    OpenTextFileDialog1: TOpenTextFileDialog;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button3: TButton;
    GroupBox2: TGroupBox;
    ListBox1: TListBox;
    Panel1: TPanel;
    Button1: TButton;
    Edit5: TEdit;
    ToolbarImages: TImageList;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fjointure: TFjointure;

implementation



{$R *.dfm}


procedure MergeFiles(FirstSplitFileName, OutFileName : TFileName) ;
// FirstSplitFileName == the name of the first piece of the split file
// OutFileName == the name of the resulting merged file
var
   fs, ss: TFileStream;
   cnt: integer;
begin
   cnt := 1;
   fs := TFileStream.Create(OutFileName, fmCreate or fmShareExclusive) ;
   try
     while FileExists(FirstSplitFileName) do
     begin
       ss := TFileStream.Create(FirstSplitFileName, fmOpenRead or fmShareDenyWrite) ;
       try
         fs.CopyFrom(ss, 0) ;
       finally
         ss.Free;
       end;
       Inc(cnt) ;
       FirstSplitFileName := ChangeFileExt(FirstSplitFileName, Format('%s%d', ['._',cnt])) ;
     end;
   finally
     fs.Free;
   end;
end;


procedure TFjointure.Button1Click(Sender: TObject);
begin
if OpenTextFileDialog1.Execute  then
ListBox1.Items.Add(OpenTextFileDialog1.FileName);

end;

procedure TFjointure.Button2Click(Sender: TObject);
var i:Integer;
begin

for I := 0 to Listbox1.items.Count - 1 do
begin
try
MergeFiles(ListBox1.Items[i],Edit1.text);
except
Edit5.text:='Files Joinded Succesfully !, Check the folder !';
 Exit;
end;

end;
Edit5.text:='Files Joinded Succesfully !, Check the folder !';
end;

procedure TFjointure.Button3Click(Sender: TObject);
begin
if OpenTextFileDialog1.Execute  then
Edit1.Text:=OpenTextFileDialog1.FileName;
end;

end.
