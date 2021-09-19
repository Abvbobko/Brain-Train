program BrainTrain;

uses
  Vcl.Forms,
  GameScreen in 'GameScreen.pas' {FMainMenu},
  GameLib in 'GameLib.pas',
  ColorGame in 'ColorGame.pas' {FColorGame},
  TopPlayers in 'TopPlayers.pas' {FTop},
  FruitGame in 'FruitGame.pas' {FFruitGame},
  Question in 'Question.pas' {FQuestion},
  EnterName in 'EnterName.pas' {FEnterName},
  GameOver in 'GameOver.pas' {FGameOver},
  Help in 'Help.pas' {FHelp};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFMainMenu, FMainMenu);
  Application.CreateForm(TFColorGame, FColorGame);
  Application.CreateForm(TFTop, FTop);
  Application.CreateForm(TFFruitGame, FFruitGame);
  Application.CreateForm(TFQuestion, FQuestion);
  Application.CreateForm(TFEnterName, FEnterName);
  Application.CreateForm(TFGameOver, FGameOver);
  Application.CreateForm(TFHelp, FHelp);
  Application.Run;
end.
