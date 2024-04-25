//   TbtString = {$IFDEF DELPHI2009UP}AnsiString{$ELSE}String{$ENDIF};
// Should just be AnsiString

library GenerateExec;
uses 
uPSUtil in '.\include\pascalscript\uPSRuntime.pas', {TbtString}
uPSRuntime in '.\include\pascalscript\uPSRuntime.pas', {TPSExec}

function GenerateExec(ByteCode: TbtString): TPSExec; cdecl;
	var Exec: TPSExec;
begin
	Exec := TPSExec.Create;
	Exec.LoadData(ByteCode);
	return Exec;
end;

function TPSExec_RunProcPN(Exec: TPSExec; Params: array of Variant; ProcName: TbtString): Variant; cdecl;
begin
	return Exec.RunProcPN(Params, ProcName);
end;

exports GenerateExec, TPSExec_RunProcPN;
end.
