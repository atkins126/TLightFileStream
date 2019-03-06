program LightFileStreamExample;

{$mode Delphi}{$H+}{$J-}{$I-}

uses SysUtils, LightFileStream;

const
  DAA: array[0..5] of Double = (1.11, 2.22, 3.33, 4.44, 5.55, 6.66);

var
  DAB: array of Double;
  D: Double;
  SA: Ansistring = 'hello';
  SB: AnsiString = '     ';

begin
  SetLength(DAB, 28);
  //If using the library in a {$mode ObjFPC} project, you can still use {$modeswitch AutoDeref}
  //to avoid having to manually dereference the function calls.
  TLightFileStream.Create('Example.txt')
                  .WriteTypedBuffer<Double>(DAA[0], 6)
                  .AppendTypedBuffer<Double>(DAA[0], 6)
                  .AppendTypedBuffer<Double>(DAA[0], 6)
                  .AppendTypedBuffer<Double>(DAA[0], 6)
                  .AppendDouble(99.99)
                  .AppendDouble(128.12)
                  .AppendDouble(77.77)
                  .AppendDouble(345.34)
                  .ChangeFileStateTo(fsReading)
                  .ReadPointerBuffer(@DAB[0], SizeOf(Double) * 28)
                  .Close();
  for D in DAB do WriteLn(D : 0 : 2);
  TLightFileStream.Create('Example2.txt')
                  .WriteAnsiString(SA)
                  .ChangeFileStateTo(fsReading)
                  .Seek(0)
                  .ReadAnsiString(SB, 5)
                  .Close();
  WriteLn(SB);
  DeleteFile('Example.txt');
  DeleteFile('Example2.txt');
end.

