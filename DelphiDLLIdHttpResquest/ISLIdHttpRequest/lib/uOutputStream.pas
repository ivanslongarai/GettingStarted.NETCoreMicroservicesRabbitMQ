// Fit4Delphi Copyright (C) 2008. Sabre Inc.
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software Foundation;
// either version 2 of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
// without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
// See the GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License along with this program;
// if not, write to the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
//
// Ported to Delphi by Michal Wojcik.
//
{$H+}
unit uOutputStream;

interface

uses
  classes;

type
  TOutputStream = class(TObject)
  protected
  public
    Stream: TStream;
    destructor Destroy; override;
    procedure Write(Value: string);
    procedure Close; virtual;
    procedure Flush;
  end;

implementation

uses
  Windows;

{ TOutputStream }

procedure TOutputStream.Close;
begin
  inherited;
end;

destructor TOutputStream.Destroy;
begin
  Stream.Free;
  inherited;
end;

procedure TOutputStream.Flush;
begin
  inherited;
end;

procedure TOutputStream.Write(Value: string);
begin
  Stream.Write(Value[1], Length(Value));
end;

end.
