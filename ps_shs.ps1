$httpsrvlsnr = New-Object System.Net.HttpListener;
$httpsrvlsnr.Prefixes.Add("http://localhost:8081/");
$httpsrvlsnr.Start();
$webroot = New-PSDrive -Name webroot -PSProvider FileSystem -Root $PWD.Path
[byte[]]$buffer = $null

while ($httpsrvlsnr.IsListening) {
    try {
        $ctx = $httpsrvlsnr.GetContext();
        
        if ($ctx.Request.RawUrl -eq "/") {
            $buffer = [System.Text.Encoding]::UTF8.GetBytes("<html><pre>$(Get-ChildItem -Path $PWD.Path -Force | Out-String)</pre></html>");
            $ctx.Response.ContentLength64 = $buffer.Length;
            $ctx.Response.OutputStream.WriteAsync($buffer, 0, $buffer.Length)
        }
        elseif ($ctx.Request.RawUrl -eq "/stop"){
            $httpsrvlsnr.Stop();
            Remove-PSDrive -Name webroot -PSProvider FileSystem;
        }
        elseif ($ctx.Request.RawUrl -match "\/[A-Za-z0-9-\s.)(\[\]]") {
            if ([System.IO.File]::Exists((Join-Path -Path $PWD.Path -ChildPath $ctx.Request.RawUrl.Trim("/\")))) {
                $buffer = [System.Text.Encoding]::UTF8.GetBytes((Get-Content -Path (Join-Path -Path $PWD.Path -ChildPath $ctx.Request.RawUrl.Trim("/\"))));
                $ctx.Response.ContentLength64 = $buffer.Length;
                $ctx.Response.OutputStream.WriteAsync($buffer, 0, $buffer.Length)
            } 
        }

    }
    catch [System.Net.HttpListenerException] {
        Write-Host ($_);
    }
}
