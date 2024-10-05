# Simple PowerShell HTTP Server
A crude and simple HTTP File Server PowerShell Script

* Listens on port 8081 by default
* Use url endpoint /stop - to stop the script/http listener
* Use url endpoint / - to list the directories and files in the webroot (this will be where the PowerShell script is stored)
* Use url endpoint /filename.ext - to download files, display text content in the web browser, etc. (works with Invoke-WebRequest/wget)

# Simple PowerShell File Transfer
Transfer the raw bytes of a file on a remote host to your local host with tcpclient

* Default port is 2121 if -RPort flag is not used
* Example:
*   Local host: nc -nvlp 2121 > myfile.sqlite
*   Remote host: Invoke-FileTransfer -Path a/path/to/a/file/to/transfer.txt -RHost 10.10.10.10 -RPort 4445
