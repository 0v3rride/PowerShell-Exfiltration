function Invoke-FileTransfer{
    param(
        [string]$Path,
        [string]$RHost,
        [int]$RPort = 2121
    )

    $FileBytes = [System.IO.File]::ReadAllBytes($Path)
    $FileBytes.Count

    try{
        $socket = [System.Net.Sockets.TcpClient]::new($RHost, $RPort)
        $writer = [System.IO.StreamWriter]::new($socket.GetStream())
        
        if ($socket.Connected) {
            $writer.Write($FileBytes, 0, $FileBytes.Count)
            $writer.Close()
            $socket.Close()
        }

    }
    catch [System.Management.Automation.MethodInvocationException]{
        Write-Host $_
    }
    finally{
        if($socket.Connected){
            $writer.Close()
            $socket.Close() 
        }
    }
    
}
