unit Question;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
   Vcl.ExtCtrls, GameLib;

type
   TFQuestion = class(TForm)
      ImgBackground: TImage;
      LQuestion: TLabel;
      LYes: TLabel;
      LNo: TLabel;
      procedure LNoClick(Sender: TObject);
      procedure LYesClick(Sender: TObject);
   private
      { Private declarations }
   public
      NumbOfParentForm: Integer;
   end;

var
   FQuestion: TFQuestion;

implementation

uses
   GameScreen, ColorGame, FruitGame, TopPlayers, EnterName;

{$R *.dfm}

procedure TFQuestion.LNoClick(Sender: TObject);
begin
   FQuestion.Close;
   case NumbOfParentForm of
      0:
         begin
            FMainMenu.Enabled := True;
            if FMainMenu.Train[0].Left <> Start_Point then
               FMainMenu.TmrTrain.Enabled := True;
         end;
      1:
         begin
            FColorGame.Enabled := True;
            if FColorGame.StopPoint = SPGameProcess then
               FColorGame.TmrComputer.Enabled := True
            else
               FColorGame.TmrCountdown.Enabled := True;
         end;
      2:
         begin
            FFruitGame.Enabled := True;
            if FFruitGame.StopPoint = SPGameProcess then
               FFruitGame.TmrToRemember.Enabled := True
            else
               FFruitGame.TmrCountdown.Enabled := True;
         end;
   end;
end;

procedure TFQuestion.LYesClick(Sender: TObject);
begin
   FQuestion.Close;
   case NumbOfParentForm of
      0:
         FMainMenu.Close;
      1:
         begin
            if FColorGame.GameCount - 1 > FTop.TopColor[10].Points then
            begin
               FEnterName.Points := FColorGame.GameCount - 1;
               FEnterName.Game := GColor;
               FColorGame.Enabled := False;
               FEnterName.Show;
            end
            else
               FColorGame.Close;
         end;
      2:
         begin
            if FFruitGame.Points > FTop.TopFruit[10].Points then
            begin
               FEnterName.Points := FFruitGame.Points;
               FEnterName.Game := GFruit;
               FEnterName.Show;
            end
            else
               FFruitGame.Close;
         end;
   end;
end;

end.
