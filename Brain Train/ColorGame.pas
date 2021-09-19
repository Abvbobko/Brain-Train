unit ColorGame;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Imaging.pngimage,
   Vcl.Imaging.jpeg, Vcl.ExtCtrls, Vcl.StdCtrls, GameLib, Question, TopPlayers,
   EnterName, GameOver;

type
   TFColorGame = class(TForm)
      ImgBackground: TImage;
      BlueBtn: TImage;
      OrangeBtn: TImage;
      GreenBtn: TImage;
      RedBtn: TImage;
      BtnExit: TImage;
      TmrBtnClick: TTimer;
      TmrComputer: TTimer;
      TmrCountdown: TTimer;
      LPointCnt: TLabel;
      LCountdown: TLabel;
      procedure TmrBtnClickTimer(Sender: TObject);
      procedure BlueBtnClick(Sender: TObject);
      procedure OrangeBtnClick(Sender: TObject);
      procedure GreenBtnClick(Sender: TObject);
      procedure RedBtnClick(Sender: TObject);
      procedure BtnClick(Clr: Integer; Btn: TImage; Sender: TObject);
      procedure FormShow(Sender: TObject);
      procedure TmrCountdownTimer(Sender: TObject);
      procedure TmrComputerTimer(Sender: TObject);
      procedure BtnExitClick(Sender: TObject);
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
   private
      ClickTime: Integer;
      Color: Integer;
      Countdown: Integer;
      Count: Integer;
      Turn: TTurn;
      ClrSeq: array of Integer;
      procedure GameOver;
      procedure StrokeToComputer(Sender: TObject);
      procedure GameProcess(Sender: TObject);
      procedure ComputerTurn(Sender: TObject);
      procedure PlayerTurn(Sender: TObject);
   public
      GameCount: Integer;
      StopPoint: TStopPoint;
   end;
  {  0 - blue
     1 - green
     2 - orange
     3 - red     }
var
   FColorGame: TFColorGame;

implementation

{$R *.dfm}

procedure TFColorGame.GameOver;
begin
   if GameCount - 1 > FTop.TopColor[10].Points then
   begin
      FEnterName.Points := GameCount - 1;
      FEnterName.Game := GColor;
      FColorGame.Enabled := False;
      FEnterName.Show;
   end
   else
      FGameOver.Show;
end;

procedure TFColorGame.PlayerTurn(Sender: TObject); //��� ������
begin
   Turn := Player;
   BlueBtn.Enabled := True;
   GreenBtn.Enabled := True;
   OrangeBtn.Enabled := True;
   RedBtn.Enabled := True;
end;

procedure TFColorGame.TmrComputerTimer(Sender: TObject);//����������������� ����
begin
   if Count < GameCount then
   begin
      case ClrSeq[Count] of
         0:
            BlueBtnClick(Sender);
         1:
            GreenBtnClick(Sender);
         2:
            OrangeBtnClick(Sender);
         3:
            RedBtnClick(Sender);
      end;
      Inc(Count);
   end
   else
   begin
      Count := 0;
      TmrComputer.Enabled := False;
      PlayerTurn(Sender);
   end;
end;

procedure TFColorGame.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   LPointCnt.Visible := False;
   TmrComputer.Enabled := False;
end;

procedure TFColorGame.StrokeToComputer(Sender: TObject);
begin
   Inc(GameCount);
   Count := 0;
   LPointCnt.Caption := IntToStr(StrToInt(LPointCnt.Caption) + 1);
   ComputerTurn(Sender);
end;

procedure TFColorGame.BtnClick(Clr: Integer; Btn: TImage; Sender: TObject);
begin
   Btn.Picture.LoadFromFile('Img\ColorGame\ClrButtonClick'+IntToStr(Clr)+'.bmp');
   ClickTime := 3;
   TmrBtnClick.Enabled := True;
   if Turn = Player then
      if Count <= GameCount - 1 then
         if Clr = ClrSeq[Count] then
         begin
            Inc(Count);
            if Count = GameCount then
               StrokeToComputer(Sender);
         end
         else
            GameOver
      else
         StrokeToComputer(Sender);
end;

procedure TFColorGame.BtnExitClick(Sender: TObject);
begin
   if TmrComputer.Enabled then
   begin
      TmrComputer.Enabled := False;
      StopPoint := SPGameProcess;
   end
   else
   begin
      TmrCountdown.Enabled := False;
      StopPoint := SPCountdown;
   end;
   FColorGame.Enabled := False;
   FQuestion.NumbOfParentForm := 1;
   FQuestion.Show;
end;

procedure TFColorGame.BlueBtnClick(Sender: TObject);
begin
   Color := 0;
   BtnClick(Color, BlueBtn, Sender);
end;

procedure TFColorGame.GreenBtnClick(Sender: TObject);
begin
   Color := 1;
   BtnClick(Color, GreenBtn, Sender);
end;

procedure TFColorGame.OrangeBtnClick(Sender: TObject);
begin
   Color := 2;
   BtnClick(Color, OrangeBtn, Sender);
end;

procedure TFColorGame.RedBtnClick(Sender: TObject);
begin
   Color := 3;
   BtnClick(Color, RedBtn, Sender);
end;

procedure TFColorGame.TmrBtnClickTimer(Sender: TObject);
begin
   Dec(ClickTime);
   if ClickTime = 0 then
   begin
      TmrBtnClick.Enabled := False;
      case Color of
         0 :
            BlueBtn.Picture.LoadFromFile('Img\ColorGame\ClrButton'+IntToStr(Color)+'.bmp');
         1 :
            GreenBtn.Picture.LoadFromFile('Img\ColorGame\ClrButton'+IntToStr(Color)+'.bmp');
         2 :
            OrangeBtn.Picture.LoadFromFile('Img\ColorGame\ClrButton'+IntToStr(Color)+'.bmp');
         3 :
            RedBtn.Picture.LoadFromFile('Img\ColorGame\ClrButton'+IntToStr(Color)+'.bmp');
      end;
   end;
end;

procedure TFColorGame.ComputerTurn(Sender: TObject); //��� ����������
begin
   Turn := Computer;
   BlueBtn.Enabled := False;
   GreenBtn.Enabled := False;
   OrangeBtn.Enabled := False;
   RedBtn.Enabled := False;
   SetLength(ClrSeq, GameCount);
   Randomize;
   ClrSeq[GameCount - 1] := Random(4);
   TmrComputer.Enabled := True;
end;

procedure TFColorGame.GameProcess(Sender: TObject); //������ ����
begin
   ComputerTurn(Sender);
end;

procedure TFColorGame.TmrCountdownTimer(Sender: TObject);
begin
   Dec(Countdown);
   LCountdown.Caption := IntToStr(Countdown);
   if Countdown = 0 then
   begin
      TmrCountdown.Enabled := False;
      LCountdown.Visible := False;
      LPointCnt.Visible := True;
      GameProcess(Sender);
   end;
end;

procedure TFColorGame.FormShow(Sender: TObject);
begin
   LPointCnt.Caption := '0';
   Count := 0;
   GameCount := 1;
   LCountdown.Visible := True;
   FColorGame.Enabled := True;
   BlueBtn.Enabled := False;
   GreenBtn.Enabled := False;
   OrangeBtn.Enabled := False;
   RedBtn.Enabled := False;
   Countdown := 3;
   LCountdown.Caption := IntToStr(Countdown);
   TmrCountdown.Enabled := True;
end;

end.
