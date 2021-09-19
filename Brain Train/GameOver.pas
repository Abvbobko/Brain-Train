unit GameOver;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
   Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.jpeg,
   Vcl.ExtCtrls;

type
   TFGameOver = class(TForm)
      ImgBackground: TImage;
      BtnOk: TLabel;
      procedure BtnOkClick(Sender: TObject);
   private
      { Private declarations }
   public
      { Public declarations }
   end;

var
   FGameOver: TFGameOver;

implementation

{$R *.dfm}

uses
   FruitGame, ColorGame;

procedure TFGameOver.BtnOkClick(Sender: TObject);
begin
   FGameOver.Close;
   FFruitGame.Close;
   FColorGame.Close;
end;

end.
