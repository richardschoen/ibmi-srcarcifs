# Copy, Extract or Archive IBM i Source Physical File Members to IFS 
This repo contains self-contained IBM i CL commands for copying source members from a source physical file to a selected IFS structure for backup or archive purposes or for manually committing to a Git repository you may be using in your IFS home directory (```/home/userid```). The main source copy/extraction/archive CL command is named: ```SRCSRCIFS```.         

## The main use case for SRCARCIFS would be for:
- Poor man's source management. Teams that don't have ANY source control system in place but need a way to quickly make backup copies of source members to the IFS.   
- Consultants or developers who need to export a group of source members to the IFS for archiving, moving to another system or manually placing into their own Git development repositories.    
- When working on a source member, instead of going through member copy hell, just create a timestamped archive copy as a quick backup before and after changes are made to the source members.     
**Source member copy hell is:** Making a backup copy of a source member with naming limited to 10 characters. Ex: SRC001.CLP becomes SRC001S2.CLP or SRC001V2.CLP. Which version is the correct one ?   

## The SRCARCIFS command has the unique ability to:
- Place each library source member that a user takes a snaphost of into the user's home IFS directory under a subdirectory structure as follows: ```/home/user/archivesource/library/file/member```. Each developer's changes can be archived in their home directory by specifying an archive output directory of *HOMEDIR. Or a generic specified archive output directory such as: ```/archivedsource``` can be specified and will write the source to the selected IFS directory. ```(Output format: *LIBFILEDIR)```   
- Optionally place all source members in a single directory with combined member names unique across libraries with naming pattern of: ```/home/user/library_file_member_date_time.srctype```. ```(Output format: *LIBFILEMBR)```.   
- Timestamp the IFS output files. This is the default option for those who want to take snapshots of code to the IFS but don't use Git yet and don't want to worry about accidentally overwriting archived source members. ```(Append timestamp to file names: *YES)```   
- Capture source physical file member metadata info (Originating Source Library,File,Member,Type,Text) for each member to a pipe delimited IFS file ending with ```.metainfo```. ```(Output .metainfo IFS file)```    
Ex source member:     
```/home/user/archivesource/qclsrc/mbr01c.clp```     
Ex source member metadata:     
```/home/user/archivesource/qclsrc/mbr01c.metainfo```   

## Ready for Affordable Git Source Code Management  
```iForgit helps IBM i developers eliminate Awkward Git Integration```    
❗If you want an affordable and easy to implement Git source management tool, check out iForGit: https://www.iforgit.com

## Installing and Building MBSRCARC via getrepo-mbsrcarc.sh script   

***(Important to change SRCCCSID variable in build.sh to your local CCSID before running build.sh. Default=37)***

Use the following install script if you want to run a single shell script to clone the repo and build the library.  
https://github.com/richardschoen/ibmi-srcarcifs/refs/heads/master/getrepo-mbsrcarc.sh   

## Download and run the getrepo-qshoni.sh script in one step, using wget
❗This is the easiest way to install MBSRCARC. Run the following wget command to download, build and install MBSRCARC quickly in a single step.   
Make sure a temporary dir named /tmp/MBSRCARC doesn't already exist before running the script or the git clone may fail to get current files from the repository.  
```
rm -r /tmp/MBSRCARC
wget https://github.com/richardschoen/ibmi-srcarcifs/raw/refs/heads/master/getrepo-mbsrcarc.sh -O - | bash
```

## Manually download getrepo-mbsrcarc.sh and run it
- Download the raw getrepo-mbsrcarc.sh script or create it manually in your IFS. https://github.com/richardschoen/ibmi-srcarcifs/refs/heads/master/getrepo-mbsrcarc.sh    
- Then run the getrepo-mbsrcarc.sh script to automatically clone the repo and auto-run the build.sh to create the MBSRCARC library and associated objects.   
```
bash getrepo-mbsrcarc.sh
```
## Installing and Building MBSRCARC via Git clone and build.sh 

***(Important to change SRCCCSID variable in build.sh to your local CCSID before running build.sh. Default=37)***

```
# Use this install method if you want to manually run each command from a QSH/PASE/SSH shell.
mkdir /mbsrcarc
cd /mbsrcarc 
git -c http.sslVerify=false clone --recurse-submodules https://github.com/richardschoen/ibmi-srcarcifs.git
cd mbsrcarc
build.sh  
```
After building the MBSRCARC library the commands should be ready to use.
  
## Sample Command with all command parameters

This example copies the selected source member TEST001C to the current user's home directory under the archivesource subdirectory.  Subdirectories will be auto-created if they don't exist. We use the top level home directory authority when creating directories. 
Ex output directory: ```/home/userid/archivesoruce/qgpl/qclsrc/

Ex output files created: 
Source member TEST001 captured to TEST001.CLP   
```/home/userid/archivesoruce/qgpl/qclsrc/test001.clp```
Source member TEST001 source file metadata info captured to TEST001.mbrinfo. (Pipe delimited file)   
```/home/userid/archivesoruce/qgpl/qclsrc/test001.mbrinfo```

```
SRCARCIFS SRCFILE(QGPL/QCLSRC            
          SRCMBR(TEST001C)               
          ARCIFSDIR(*HOMEDIR)          
          HOMESUBDIR('archivesource')  
          OUTPUTFMT(*LIBFILEDIR)       
          APPENDTS(*YES)               
          METAINFO(*YES)               
          REPLACE(*NO)                 
          PROMPTSQL(*NO)               
```

## SRCARCIFS command parameters
From source file - SRCFILE - This is the source file where the source members originate from.  

From source member - SRCMBR - This is the source member to be copied/exported/snapshotted to the IFS.   

Archive output IFS directory - ARCIFSDIR - This is the root IFS subdirectory where members will be written to.    

Home subdir if *HOMEDIR set - HOMESUBDIR - If the user specified *HOMEDIR on the ARCIFSDIR parm, this is the subdirectory within the users home directory that gets created. You can name it anything you want.Default value:   Ex: ```/home/userid/archivesource```

Output format - OUTPUTFMT - This is the directory structure and member naming format that will be used when copying source members to the IFS. The subdirectories will get auto-created.

*LIBFILEDIR - Subdirectories are auto-create within the ARCIFSDIR directory for each source library, source file and member name. This structure is similar to the directory structure for source files in the QSYS.LIB file system which is: QSYS.LIB/LIBNAME.LIB/FILENAME.FILE.MEMBER.MBR

*LIBEFILEMBR - All members are written to the single directory name specified in the ARCIFSDIR parameter. Ex: ```/home/user/archivesource```. Each member is named uniquely as follows: ```LIBRARY_FILE_MEMBER.SRCTYPE```. Metadata info name would be like:  ```LIBRARY_FILE_MEMBER.METAINFO``` This should insure each source member across one or more libraries is uniquely named so there should be no naming collisions. Also by default the members are timestamped so the actual file name might be something like: ```LIBRARY_FILE_MEMBER_DATE_TIME.SRCTYPE``` Metadata info name would be like: ```LIBRARY_FILE_MEMBER_DATE_TIME.METAINFO```

Append timestamp to file names

Output .metainfo IFS file - METAINFO - Output a metadata IFS file for the source member. This is a great way to keep Metadata info for each source member exported to the IFS without having to put the metadata info into the source member itself.

Replace existing IFS file - Set this option if you want to overwrite a source member. If you have APPENDTS set to *YES, you can always set this to *NO because a new timestamped IFS file will be written for each member that gets output to the IFS.

Prompt SQL - PROMPTSQL - If you have issues with the metadata export, you can prompt and see the SQL used to create the delimited record output for the source member metadata info.








