unit EnterName;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
   Vcl.ExtCtrls, TopPlayers, GameLib, Vcl.Menus;

type
   TFEnterName = class(TForm)
      ImgBackground: TImage;
      EdtName: TEdit;
      NoPopupMenu: TPopupMenu;
      LPoints: TLabel;
      BtnOk: TLabel;
      BtnNo: TLabel;
      LTip: TLabel;
      procedure BtnOkClick(Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure EdtNameKeyPress(Sender: TObject; var Key: Char);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure BtnNoClick(Sender: TObject);
    procedure EdtNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
   private
      function RightName: Boolean;
   public
      Points: Integer;
      Game: TGame;
   end;

var
   FEnterName: TFEnterName;

implementation

{$R *.dfm}

uses
   ColorGame, FruitGame;

procedure TFEnterName.EdtNameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   TEdit(Sender).ReadOnly := (Shift = [ssShift]) or (Shift = [ssCtrl]);
end;

procedure TFEnterName.EdtNameKeyPress(Sender: TObject; var Key: Char);
begin
   LTip.Visible := False;
   if (Length(EdtName.Text) > 15) and not (Ord(Key) in [127, 8]) then
         Key := #0;
   if not ((Key in ['A'..'Z', 'a'..'z', ' ', '0'..'9']) or (Ord(Key) in [127, 8])
      or ((Ord(Key) > $40F) and (Ord(Key) < $45F)) or (Ord(Key) = $451)) then
         Key := #0;
end;

function TFEnterName.RightName: Boolean;
var
   i: Integer;
   Name: string;
begin
   RightName := True;
   Name := EdtName.Text;
   if Length(Name) > 0 then
   begin
      i := Low(Name);
      if Length(Name) <> 1 then
         while (i <> (High(Name) - 1)) do
            if (Name[i] = ' ') and (Name[i + 1] = ' ') then
               Delete(Name, i, 1)
            else
               Inc(i);
      while Name[1] = ' ' do
         Delete(Name, 1, 1);
   end;
   EdtName.Text := Name;
   if Length(Name) = 0 then
      RightName := False;
end;

procedure TFEnterName.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   LPoints.Caption := '';
   LTip.Visible := False;
   EdtName.Clear;
end;

procedure TFEnterName.FormShow(Sender: TObject);
begin
   LPoints.Caption := IntToStr(Points);
end;

procedure TFEnterName.BtnNoClick(Sender: TObject);
begin
   FColorGame.Close;
   FFruitGame.Close;
   FEnterName.Close;
end;

procedure TFEnterName.BtnOkClick(Sender: TObject);
begin
   if RightName then
   begin
      if Game = GColor then
      begin
         FTop.FindPositionInTop(Points, GColor);
         FColorGame.Close;
      end
      else
      begin
         FTop.FindPositionInTop(Points, GFruit);
         FFruitGame.Close;
      end;
      FEnterName.Close;
   end;
      LTip.Visible := True;
end;

end.
