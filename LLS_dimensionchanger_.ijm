print("\\Clear")

//	MIT License

//	Copyright (c) 2019 Nicholas Condon n.condon@uq.edu.au

//	Permission is hereby granted, free of charge, to any person obtaining a copy
//	of this software and associated documentation files (the "Software"), to deal
//	in the Software without restriction, including without limitation the rights
//	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//	copies of the Software, and to permit persons to whom the Software is
//	furnished to do so, subject to the following conditions:

//	The above copyright notice and this permission notice shall be included in all
//	copies or substantial portions of the Software.

//	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//	SOFTWARE.


//IMB Macro Splash screen (Do not remove this acknowledgement)
scripttitle="LLSM - Time-Point Dimension Changer";
version="1.2";
versiondate="10/03/2019";
description="This script takes LLSM files that have been split into individual timepoints using the UQ-RCC generated SButility.exe and updates the pixel size information for deskewing."
  

    showMessage("Institute for Molecular Biosciences ImageJ Script", "<html>" 
    +"<h1><font size=6 color=Teal>ACRF: Cancer Biology Imaging Facility</h1>
    +"<h1><font size=5 color=Purple><i>The Institute for Molecular Bioscience <br> The University of Queensland</i></h1>
    +"<h4><a href=http://imb.uq.edu.au/Microscopy/>ACRF: Cancer Biology Imaging Facility</a><\h4>"
    +"<h1><font color=black>ImageJ Script Macro: "+scripttitle+"</h1> "
    +"<p1>Version: "+version+" ("+versiondate+")</p1>"
    +"<H2><font size=3>Created by Nicholas Condon</H2>"	
    +"<p1><font size=2> contact n.condon@uq.edu.au \n </p1>" 
    +"<P4><font size=2> Available for use/modification/sharing under the "+"<p4><a href=https://opensource.org/licenses/MIT/>MIT License</a><\h4> </P4>"
    +"<h3>   <\h3>"    
    +"<p1><font size=3 \b i>"+description+"</p1>"
   	+"<h1><font size=2> </h1>"  
	+"<h0><font size=5> </h0>"
    +"");


//Log Window Title and Acknowledgement
print("");
print("FIJI Macro: "+scripttitle);
print("Version: "+version+" ("+versiondate+")");
print("ACRF: Cancer Biology Imaging Facility");
print("By Nicholas Condon (2018) n.condon@uq.edu.au")
print("");
getDateAndTime(year, month, week, day, hour, min, sec, msec);
print("Script Run Date: "+day+"/"+(month+1)+"/"+year+"  Time: " +hour+":"+min+":"+sec);
print("");


//Directory Warning panel     
Dialog.create("Choosing your image location");
 	Dialog.addMessage("Use the next window to navigate to your directory of images.");
  	Dialog.addMessage("(Note a sub-directory will be made for each input image within this fodler) ");
  	Dialog.addMessage("Take note of your file extension (eg .tif, .czi)");
 Dialog.show();

setBatchMode(true);

path = getDirectory("Choose Source Directory ");
list = getFileList(path);

ext = ".tiff";
  Dialog.create("Pixel Size Information");
  	Dialog.addString("File Extension:", ext);
 	Dialog.addMessage("(For example .czi  .lsm  .nd2  .lif  .ims)");
  	Dialog.addMessage(" ");
  	Dialog.addMessage("Input your pixel sizes below");
  	Dialog.addNumber("XY =", 0.104);
  	Dialog.addNumber("Voxel Depth= ", 0.495);
 	Dialog.addString("Unit", "microns");
 	Dialog.show();
	ext = Dialog.getString();
	XY=Dialog.getNumber();
	depth = Dialog.getNumber();
	Unit = Dialog.getString();

print("File Extension = "+ext);
print("XY Pixel Size = "+XY);
print("Z Pixel Size = "+depth);
print("Units = "+Unit);
start = getTime();

for (z=0; z<list.length; z++) {
	print("Opening file = "+(z+1)+"of "+list.length);
	if (endsWith(list[z],ext)){
	open(path+list[z]);

		getDimensions(width, height, channels, slices, frames);
		run("Properties...", "channels="+channels+" slices="+slices+" frames="+frames+" unit="+Unit+" pixel_width="+XY+" pixel_height="+XY+" voxel_depth="+depth);
		run("Save");
	}}


print("");
print("Batch Completed");
print("Total Runtime was:");
print((getTime()-start)/1000); 

//saving log file loop
selectWindow("Log");
saveAs("Text", path+"Log.txt");

title = "Batch Completed";
msg = "Put down that coffee! Your analysis is finished";
waitForUser(title, msg); 
