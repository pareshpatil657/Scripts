<?php

function ExecScript()
{ 
$core=$_POST['Core_branch'];
$plugin=$_POST['plug_branch'];
$tag=$_POST['Tag'];
$email=$_POST['email']; 
	#echo "Please wait build script in the process";
        shell_exec("path/to/build_script.sh '$core' '$plugin' '$tag' '$email'");
	#echo "script executed";
        $message1 = " Build Created."; 
         echo "<script type='text/javascript'>window.alert('$message1');</script>";

}

function SendEmail()
{
  shell_exec('path/to/email.sh')
}
function UpgradeTest()
{
 shell_exec("/path/to/upgrade_test.sh")
}



if(isset($_POST['submit'])) 
{
    $pass=$_POST['password'];
     if($pass=='paresh')
        	 
      {    
           $upgrade_val=$_POST['option'];

	   if($upgrade_val=='Yes')
             {
               echo "Test server will be upgraded once build is created";
                  SendEmail();
                  ExecSript();
                  UpgradeTest(); 
               
             }    
           
          else   
      
              {
                  echo "Test server will not be upgraded";
                   ExecScript();
              }
  
      }
     
      
      else
      {
       $message = " Password incorrect.\\nTry again."; echo "<script type='text/javascript'>window.alert('$message');</script>";


      }       
}


?>
