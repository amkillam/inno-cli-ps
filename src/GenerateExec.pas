unit GenerateExec;

interface 

uses 
uPSUtils, {TbtString}
uPSRuntime; {TPSExec}

function GenerateExec(ByteCode: TbtString): TPSExec; cdecl;
function TPSExecRunProcPN(Exec: TPSExec; Params: array of Variant; ProcName: TbtString): Variant; stdcall;

implementation
function GenerateExec(ByteCode: TbtString): TPSExec; cdecl;
begin
	GenerateExec := TPSExec.Create;
	GenerateExec.LoadData(ByteCode);
end;

function TPSExecRunProcPN(Exec: TPSExec; Params: array of Variant; ProcName: TbtString): Variant; stdcall;
begin
	TPSExecRunProcPN := Exec.RunProcPN(Params, ProcName);
end;

end.
