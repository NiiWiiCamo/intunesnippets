Function Set-WallPaper($Image) {
<#
 
    .SYNOPSIS
    Applies a specified wallpaper to the current user's desktop
    
    .PARAMETER Image
    Provide the exact path to the image
  
    .EXAMPLE
    Set-WallPaper -Image "C:\Wallpaper\Default.jpg"
  
#>
  
Add-Type -TypeDefinition @" 
using System; 
using System.Runtime.InteropServices;
  
public class Params
{ 
    [DllImport("User32.dll",CharSet=CharSet.Unicode)] 
    public static extern int SystemParametersInfo (Int32 uAction, 
                                                   Int32 uParam, 
                                                   String lpvParam, 
                                                   Int32 fuWinIni);
}
"@ 
  
    $SPI_SETDESKWALLPAPER = 0x0014
    $UpdateIniFile = 0x01
    $SendChangeEvent = 0x02
  
    $fWinIni = $UpdateIniFile -bor $SendChangeEvent
  
    $ret = [Params]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Image, $fWinIni)
 
}


Function Generate-Randomfilename($Url) {

    $Random = $(Get-Random -Minimum 10000).ToString()
    $Extension = [System.IO.Path]::GetExtension($Url)
    $FileName = $Random + $Extension

    return $FileName

}


Function Wallpaper-Me {
    
    param(
        [string]$Url = "https://wallpapercave.com/wp/wp3805220.jpg"
    )

    $FileName = Generate-Randomfilename -Url $Url
    Invoke-WebRequest -Uri $Url -OutFile $FileName
    Set-WallPaper -Image $FileName
    Remove-Item $FileName
    Write-Host "done."
}


Wallpaper-Me
