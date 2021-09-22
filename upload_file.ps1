Add-Type -AssemblyName System.Net.Http

try{
    $multipartContent = [System.Net.Http.MultipartFormDataContent]::new()

    $FilePath = 'C:\Users\princ\Downloads\file.txt';
    $URL = 'https://localhost:44363/WeatherForecast';

    $fileBytes = [System.IO.File]::ReadAllBytes($FilePath);
    $fileEnc = [System.Text.Encoding]::GetEncoding('UTF-8').GetString($fileBytes);
    $boundary = [System.Guid]::NewGuid().ToString(); 
    $LF = "`r`n";

    $bodyLines = ( 
        "--$boundary",
        "Content-Disposition: form-data; name=`"file`"; filename=`"temp.txt`"",
        "Content-Type: application/octet-stream$LF",
        $fileEnc,
        "--$boundary--$LF" 
    ) -join $LF

    Invoke-RestMethod -Uri $URL -Method Post -ContentType "multipart/form-data; boundary=`"$boundary`"" -Body $bodyLines
    
    echo "fin"
} 
catch{}

finally{
    
}
