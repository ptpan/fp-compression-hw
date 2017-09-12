//
// Vivado(TM)
// rundef.js: a Vivado-generated Runs Script for WSH 5.1/5.6
// Copyright 1986-2014 Xilinx, Inc. All Rights Reserved.
//

echo "This script was generated under a different operating system."
echo "Please update the PATH variable below, before executing this script"
exit

var WshShell = new ActiveXObject( "WScript.Shell" );
var ProcEnv = WshShell.Environment( "Process" );
var PathVal = ProcEnv("PATH");
if ( PathVal.length == 0 ) {
  PathVal = "/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/SDK/2014.3.1/bin:/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/Vivado/2014.3.1/ids_lite/ISE/bin/lin64;/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/Vivado/2014.3.1/ids_lite/ISE/lib/lin64;/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/Vivado/2014.3.1/bin;";
} else {
  PathVal = "/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/SDK/2014.3.1/bin:/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/Vivado/2014.3.1/ids_lite/ISE/bin/lin64;/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/Vivado/2014.3.1/ids_lite/ISE/lib/lin64;/media/frankqz/c35fb864-558a-4c20-ae81-7faa0c86f8e4/Xilinx/Vivado/2014.3.1/bin;" + PathVal;
}

ProcEnv("PATH") = PathVal;

var RDScrFP = WScript.ScriptFullName;
var RDScrN = WScript.ScriptName;
var RDScrDir = RDScrFP.substr( 0, RDScrFP.length - RDScrN.length - 1 );
var ISEJScriptLib = RDScrDir + "/ISEWrap.js";
eval( EAInclude(ISEJScriptLib) );


ISEStep( "vivado",
         "-log dout_bram.vds -m64 -mode batch -messageDb vivado.pb -source dout_bram.tcl" );



function EAInclude( EAInclFilename ) {
  var EAFso = new ActiveXObject( "Scripting.FileSystemObject" );
  var EAInclFile = EAFso.OpenTextFile( EAInclFilename );
  var EAIFContents = EAInclFile.ReadAll();
  EAInclFile.Close();
  return EAIFContents;
}
