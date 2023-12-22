# section
function GetRandomPassword () {
    <# 
        Programmed by Christian Haensel
        christian@chftp.com
        http://www.chftp.com
        Exclusively published on weberdev.com.
        If you like my scripts, please let me know or link to me.
        You may copy, redistribute, change and alter my scripts as
        long as this information remains intact.
        2010-12-30 Modified by Josh Hartman
        2019-07-30 Modified by Joseph Kreifels II  - Now with compound letters, special characters, capital letters. Passwords can now be lengths not divisible by 2.
        2023-12-20 Modified by Kyle Birch McKay
			- Converted to PowerShell
			- Added prompt for password Lengh
			- Generates 10 passwords at a time
     #>
    $conso=@('b','c','d','f','g','h','j','k','l','m','n','p','r','s','t','v','w','x','y','z',"sh","sn","tr","th","ch") #
    $vocal=@('a','e','i','o','u',"ee","oo","ie","au") #
    $speci=@('!','@','#','$','%')
    $password='';
    #srand ((double)microtime()*1000000);
    $max = $len/4
    for ($i = 1; $i -le $max; $i++) {
        # Fill half of password with text
        $tempConso = $conso | Get-Random
        $tempVocal = $vocal | Get-Random
        $password = $password + $tempConso + $tempVocal
        if ($password.Length -ge $len-2) {
            $i = 0
            $password = ''
        }

    }
    $max = $len - $password.Length
    for ($i = 1; $i -le $max; $i++) {
        #Fill last half of password with numbers
        if ($spec -and $i -eq $max) {
            # if special characters wanted, end password with special character
            $tempSpeci = $speci | Get-Random
            $password = $password + $tempSpeci
        }else{
            do {
                $tempNum = Get-Random -Minimum 0 -Maximum 9
            } until (
                $oldNum -ne $tempNum
            )
            $oldNum = $tempNum
            $password = $password + $tempNum
        }
    }
    $password = $password.substring(0,1).toupper()+$password.substring(1).tolower()  
    Write-Output $password
    }

    Clear-Host
    $hostInput = ''
    $repeatLoop = $true
    do {
        $hostInput = Read-Host "How many characters do you want your password to be? Minimum length is 8. Press enter while blank to default to 8."
        if ($hostInput -eq ''){
            $hostInput = 8
        }
        $test = $hostInput -is [Int] -and $hostInput -ge 8 -and $hostInput -ne ''
        if($test){$repeatLoop = $false}
        $len = $hostInput
    } while ($repeatLoop)

    $spec = $false
    for ($i = 1; $i -lt 10; $i++) {
        GetRandomPassword
    }
   Pause