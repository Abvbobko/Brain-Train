unit GameLib;

interface

uses
   Vcl.ExtCtrls;

type
   TPlayer = record
      Name: string[15];
      Points: Integer;
   end;

   TTable = array of array of Integer;

   TTurn = (Player, Computer);

   TGame = (GColor, GFruit);

   TStopPoint = (SPCountdown, SPGameProcess);

implementation

end.
