unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ComCtrls, Spin;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label1: TLabel;
    Label2: TLabel;
    LabelStatus: TLabel;
    LogBox: TListBox;
    EditHeads: TSpinEdit;
    EditTails: TSpinEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure EditHeadsChange(Sender: TObject);
    procedure EditHeadsClick(Sender: TObject);
    procedure EditHeadsKeyPress(Sender: TObject; var Key: char);
    procedure EditTailsChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Round : Integer = 1;
  Turn  : Integer = 1;
const
  Rounds = 5;
  Turns  = 7;

implementation

{$R *.lfm}

{ TForm1 }

Procedure UpdateScore;
begin
   If Turn > Turns then
   begin
     // end of round reached
     Turn := 1;
     Inc(Round);
     Form1.EditHeads.Value := 0;
     Form1.EditTails.Value := 0;
     If Round > Rounds then
     begin
       // end of game reached ...
       ShowMessage('You have reached the end of the game');
       Application.Terminate;
     end
     else
       ShowMessage('Now Starting Round '+IntToStr(Round));
   end;
   Form1.LabelStatus.Caption := 'Round '+ IntToStr(Round)+ ' Turn '+ IntToStr(Turn);
end;

Procedure Log(S : String);
begin
  Form1.LogBox.Items.Add(S);
  Turn := Form1.EditHeads.Value + Form1.EditTails.Value + 1;
  UpdateScore;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Log('Clicked Heads');
  EditHeads.Value:= EditHeads.Value+1;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  Log('Clicked Coin Flip');
  If (Random >= 0.5) then
    begin
      Log('Fair Toss - Heads');
      EditHeads.Value := EditHeads.Value+1;
    end
  else
    begin
      Log('Fair Toss - Tails');
      EditTails.Value := EditTails.Value+1;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Log('Clicked Tails');
  EditTails.Value := EditTails.Value + 1;
end;

procedure TForm1.EditHeadsChange(Sender: TObject);
begin
  Log('Heads: ' + EditHeads.Text);
end;

procedure TForm1.EditHeadsClick(Sender: TObject);
begin
end;

procedure TForm1.EditHeadsKeyPress(Sender: TObject; var Key: char);
begin

end;

procedure TForm1.EditTailsChange(Sender: TObject);
begin
  Log('Tails: ' + EditTails.Text);
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  UpdateScore;
end;

initialization
  randomize;
end.

