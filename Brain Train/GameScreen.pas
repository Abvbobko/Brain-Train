unit GameScreen;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
   Vcl.ExtCtrls, GameLib, Vcl.Imaging.pngimage, ColorGame, TopPlayers,
   Vcl.ComCtrls, FruitGame, Question, Help;

const
   N = 3;
   Start_Point = 90;
   Distance = 600;
   TopOffsetOfIcon = 13;
   LeftOffsetOfIcon = 25;

type
   TTrain = array[0..N] of TImage;

   TFMainMenu = class(TForm)
      ImgBackground: TImage;
      ImgMainText: TImage;
      BtnClose: TImage;
      ColorGameIcon: TImage;
      FruitGameIcon: TImage;
      TopIcon: TImage;
      TmrTrain: TTimer;
    BtnHelp: TImage;
      procedure FormCreate(Sender: TObject);
      procedure TmrTrainTimer(Sender: TObject);
      procedure BtnCloseClick(Sender: TObject);
      procedure ColorGameIconClick(Sender: TObject);
      procedure FruitGameIconClick(Sender: TObject);
      procedure TopIconClick(Sender: TObject);
    procedure BtnHelpClick(Sender: TObject);
   private
      { Private declarations }
   public
      Train: TTrain;
   end;

var
   FMainMenu: TFMainMenu;

implementation

{$R *.dfm}

procedure TFMainMenu.BtnCloseClick(Sender: TObject);
begin
   TmrTrain.Enabled := False;
   FMainMenu.Enabled := False;
   FQuestion.NumbOfParentForm := 0;
   FQuestion.Show;
end;

procedure TFMainMenu.BtnHelpClick(Sender: TObject);
begin
   TmrTrain.Enabled := False;
   FMainMenu.Enabled := False;
   FHelp.Show;
end;

procedure TFMainMenu.ColorGameIconClick(Sender: TObject);
begin
   FColorGame.Show;
end;

procedure TFMainMenu.FormCreate(Sender: TObject);
var
   i: Integer;
begin
   for i := 0 to N do
   begin
      Train[i] := TImage.Create(FMainMenu);
      with Train[i] do
      begin
         Parent := FMainMenu;
         if i = 0 then
            Picture.LoadFromFile('Img\Train\Train.bmp')
         else
            if i = N then
               Picture.LoadFromFile('Img\Train\WagonEnd.bmp')
            else
               Picture.LoadFromFile('Img\Train\Wagon.bmp');
         Stretch := True;
         Top := 284;
         Left := Distance + i * 100;
         Transparent := True;
      end;
   end;
   TmrTrain.Enabled := True;
end;

procedure TFMainMenu.FruitGameIconClick(Sender: TObject);
begin
   FFruitGame.Show;
end;

procedure TFMainMenu.TmrTrainTimer(Sender: TObject);
var
   i: Integer;
begin
   for i := 0 to N do
      Train[i].Left := Train[i].Left - 5;
   if Train[0].Left = Start_Point then
   begin
      ColorGameIcon.Top := Train[1].Top - TopOffsetOfIcon;
      ColorGameIcon.Left := Train[1].Left + LeftOffsetOfIcon;
      FruitGameIcon.Top := Train[2].Top - TopOffsetOfIcon;
      FruitGameIcon.Left := Train[2].Left + LeftOffsetOfIcon;
      TopIcon.Top := Train[3].Top - TopOffsetOfIcon;
      TopIcon.Left := Train[3].Left + LeftOffsetOfIcon;
      ColorGameIcon.Visible := True;
      FruitGameIcon.Visible := True;
      TopIcon.Visible := True;
      ColorGameIcon.BringToFront;
      FruitGameIcon.BringToFront;
      TopIcon.BringToFront;
      TmrTrain.Enabled := False;
   end;
end;

procedure TFMainMenu.TopIconClick(Sender: TObject);
begin
   FTop.Show;
end;

end.
