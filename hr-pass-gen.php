<?php
function randomPassword($len = 10){
    /* Programmed by Christian Haensel
    ** christian@chftp.com
    ** http://www.chftp.com
    **
    ** Exclusively published on weberdev.com.
    ** If you like my scripts, please let me know or link to me.
    ** You may copy, redistribute, change and alter my scripts as
    ** long as this information remains intact.
    **
    ** Modified by Josh Hartman on 12/30/2010.
    ** Modified by Joseph Kreifels II on 07/30/2019.  - Now with compound letters, special characters, capital letters. Passwords can now be lengths not divisible by 2.
    */
    //	if(($len%2)!==0){ // Length paramenter must be a multiple of 2
    //		$len=8;
    //	}
    $length=$len-2; // Makes room for the two-digit number on the end
    $conso=array('b','c','d','f','g','h','j','k','l','m','n','p','r','s','t','v','w','x','y','z',"sh","sn","tr","th","ch");
    $vocal=array('a','e','i','o','u',"ee","oo","ie","au");
    $speci=array('!','@','#','$','%');
    $password='';
    srand ((double)microtime()*1000000);
    $max = $length/2;
    for($i=1; $i<=$max; $i++){
        $password.=$conso[rand(0,24)];
        $password.=$vocal[rand(0,8)];
    }
    $password = substr($password,0,$len-3);
    $password.=rand(10,99);
    $password.=$speci[rand(0,4)];
    //$newpass = $password;
    $newpass = strtoupper(substr($password,0,1)) . substr($password,1,strlen($password));
    return $newpass;
}
echo "<table>";
for ($i = 0; $i < 100; $i++)
    echo "<tr><th>" . randomPassword() . "</th></tr>" ;
echo "</table>";
?>