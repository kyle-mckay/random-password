#region function
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
        2023-12-20 Modified by Kyle Birch McKay https://github.com/kyle-mckay/random-password
			- Converted to PowerShell
			- Added prompt for password Lengh
			- Generates $maxGen passwords at a time OR until prompted to stop
     #>
    $conso=@('b','c','d','f','g','h','j','k','l','m','n','p','r','s','t','v','w','x','y','z',"sh","sn","tr","th","ch") #
    $vocal=@('a','e','i','o','u',"ee","oo","ie","au") #
    $speci=@('!','@','#','$','%')
    $password='';
    #srand ((double)microtime()*1000000);
    $maxGen = $len/4
    for ($i = 1; $i -le $maxGen; $i++) {
        # Fill half of password with text
        $tempConso = $conso | Get-Random
        $tempVocal = $vocal | Get-Random
        $password = $password + $tempConso + $tempVocal
        if ($password.Length -ge $len-2) {
            $i = 0
            $password = ''
        }

    }
    $maxGen = $len - $password.Length
    for ($i = 1; $i -le $maxGen; $i++) {
        #Fill last half of password with numbers
        if ($spec -and $i -eq $maxGen) {
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
#endregion
    # passwordDelivery = 1 means it will generate $maxGen worth of passwords
    # passwordDelivery = 2 means it will generate passwords until prompted to stop
    $passwordDelivery = 1
    $maxGen = 10
    Clear-Host
    $hostInput = ''
    $repeatLoop = $true
    do {
        # prompt for password length
        $test = $true
        $hostInput = Read-Host "How many characters do you want your password to be? Minimum length is 8. Press enter while blank to default to 8."
        if ($hostInput -eq '' -or $null -eq $hostInput){
            $hostInput = 8
        }
        try {
            $hostinput = [int]$hostInput
        }
        catch {
            $test = $false
            Write-Host "ERROR: Unable to convert input '$hostinput' to INT."
        }
        
        if ($hostInput -lt 8) {
            $test = $false
            Write-Host "ERROR: Input of '$hostinput' is below the minimum length of 8."
        }
        if($test){$repeatLoop = $false}
        $len = $hostInput
    } while ($repeatLoop)

    $spec = $false
    if($passwordDelivery -eq 1){
        for ($i = 1; $i -lt $maxGen; $i++) {
            GetRandomPassword
        }
        Pause
    }
    if ($passwordDelivery -eq 2) {
        do{
            #Generate passwords until satisfied
            GetRandomPassword
            $hostInput = ''
            $hostInput = Read-Host "Another? Y/N"
            $hostInput = $hostInput.ToUpper()
        } 
        until($hostInput -eq 'N')
    }

   