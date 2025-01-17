# Copy, Extract or Archive IBM i Source Physical File Members to IFS Source Members
This repo contains source for a self-contained IBM i CL command (```SRCARCIFS```) for copying source members from a source physical file to a selected IFS directory structure for backup or archive purposes. The code gets built into a library named: ```MBSRCARC```.  
You might also think of this command as a **poor man's IBM i source control** because you may not use Git yet. Or if you are a Git expert and will be manually committing your changes to a Git repository you may use this command to stage source code changes to the desired output directory and then command them to Git by running the git command in PASE.    
There is not currently a mechanism to restore source members. For that you will need to use your editor of choice oe take a look at a Git source management tool such as iForGit. https://www.iforgit.com

## The main use case for the SRCARCIFS command would be for:
- Poor man's source management. Teams that don't have ANY source control system in place but need a way to quickly make backup copies of source members to the IFS.   
- Consultants or developers who need to export a group of source members to the IFS for archiving, moving to another system or manually placing into their own Git development repositories.    
- When working on a source member, instead of going through source member copy hell, just create a timestamped archive copy as a quick backup before and after changes are made to the source members.     
**What is source member copy hell:** Making a backup copy of a source member with naming limited to 10 characters. Ex: ```SRC001.CLP``` becomes ```SRC001S2.CLP``` or ```SRC001V2.CLP```. Which version is the correct one ? 

## The SRCARCIFS command has the unique ability to:
- Place each library source member that a user takes a snaphost of into the user's home IFS directory under a subdirectory structure as follows: ```/home/user/archivesource/library/file/member.srctype```. Each developer's changes can be archived in their own home directory by specifying an archive output directory of *HOMEDIR. Or a generic root level archive output directory such as: ```/archivedsource``` can be specified and will write the source to the selected IFS directory. Use this output format: ```*LIBFILEDIR```. This is the default output format.   
This output format is nice if you want a single top level directory with subdirectories nested by library, file and member name.  

- Optionally place all source members within a single directory with combined member info in the file names unique across libraries with naming pattern of: ```/home/user/library_file_member_date_time.srctype```. Use this output format: ```*LIBFILEMBR```.  
This method  is nice if you want a single level directory to contain all your archived source members.  
- Timestamp the IFS output files. This is the default option for those who want to take snapshots of source members to the IFS but don't use Git yet and don't want to worry about accidentally overwriting archived source members. ```(Append timestamp to file names: *YES)```   
- Capture source physical file member metadata info **(Originating Source Library,File,Member,Type,Text)** for each member to a pipe delimited IFS file starting with the source member name and ending with ```.metainfo```. ```(Output .metainfo IFS file: *YES)```    
Ex source member:     
```/home/user/archivesource/qclsrc/mbr01c.clp```     
Ex source member metadata:     
```/home/user/archivesource/qclsrc/mbr01c.metainfo```   

## Ready for Affordable Git Source Code Management  
```iForgit helps IBM i developers eliminate Awkward Git Integration```  
When you're ready to manage your source with Git integrated to SEU/PDM, RDi and VS Code.   
❗If you want an affordable and easy to implement Git source management tool, check out iForGit: https://www.iforgit.com

## Installing and Building MBSRCARC via getrepo-mbsrcarc.sh script   
***(Important to change SRCCCSID variable in build.sh to your local CCSID before running build.sh. Default=37)***

Use the following install script if you want to run a single shell script to clone the repo and build the library.  
https://github.com/richardschoen/ibmi-srcarcifs/blob/main/getrepo-mbsrcarc.sh   

## Download and run the getrepo-mbsrcarc.sh script in one step, using wget
❗This is the easiest way to install MBSRCARC. Run the following wget command to download, build and install MBSRCARC quickly in a single step.   
Make sure a temporary dir named /tmp/ibmi-srcarcifs doesn't already exist before running the script or the git clone may fail to get current files from the repository.  
```
rm -r /tmp/ibmi-srcarcifs  
wget https://raw.githubusercontent.com/richardschoen/ibmi-srcarcifs/refs/heads/main/getrepo-mbsrcarc.sh -O - | bash
```

## Manually download getrepo-mbsrcarc.sh and run it
- Download the raw getrepo-mbsrcarc.sh script or create it manually in your IFS. https://github.com/richardschoen/ibmi-srcarcifs/blob/main/getrepo-mbsrcarc.sh     
- Then run the getrepo-mbsrcarc.sh script to automatically clone the repo and auto-run the build.sh to create the MBSRCARC library and associated objects.   
```
bash getrepo-mbsrcarc.sh
```
## Installing and Building MBSRCARC via Git clone and build.sh 

***(Important to change SRCCCSID variable in build.sh to your local CCSID before running build.sh. Default=37)***

```
# Use this install method if you want to manually run each command from a QSH/PASE/SSH shell.
cd /  
rm -r /tmp/ibmi-srcarcifs     (If not found you will see an error. That's OK.)
cd /tmp   
git -c http.sslVerify=false clone --recurse-submodules https://github.com/richardschoen/ibmi-srcarcifs.git
cd /tmp/ibmi-srcarcifs
build.sh  
```
❗After building the MBSRCARC library the commands should be ready to use.    

## SRCARCIFS Command Quick Start
```Copy and paste the following command example to a 5250 command line.``` 

This example command call uses the source file: SOURCE that got created in library MBSRCARC library to quickly export the SRCARCIFS CL command definition. The command copies the selected source member SRCARCIFS to the current user's home directory under the archivesource subdirectory.  Subdirectories will be auto-created if they don't exist. We use the top level home directory authority when creating directories. 
Ex output directory: ```/home/userid/archivesoruce/qgpl/qclsrc/

Ex output files created:   
Source member SRCARCIFS captured to SRCARCIFS   
```/home/userid/archivesoruce/mbsrcarc/source/srcarcifs.cmd```.  
Source member SRCARCIFS source file metadata info captured to SRCARCIFS.metainfo. (Pipe delimited file)   
```/home/userid/archivesoruce/mbsrcarc/source/srcarcifs.metainfo```

Sample CL command:  
```
MBSRCARC/SRCARCIFS SRCFILE(MBSRCARC/SOURCE            
          SRCMBR(SRCARCIFS)               
          ARCIFSDIR(*HOMEDIR)          
          HOMESUBDIR('archivesource')  
          OUTPUTFMT(*LIBFILEDIR)    
          APPENDTS(*YES)               
          METAINFO(*YES)               
          REPLACE(*NO)                 
          PROMPTSQL(*NO)               
```

If the command runs successfully the selected output source members should exist.

❗That's it !  Start playing with the command.

You can integrate this CL command with SEU/PDM, RDi or VS Code as desired. 


## Sample SRCARCIFS Command with All Command Parameters

This example copies the selected source member TEST001C to the current user's home directory under the archivesource subdirectory.  Subdirectories will be auto-created if they don't exist. We use the top level home directory authority when creating directories. 
Ex output directory: ```/home/userid/archivesoruce/qgpl/qclsrc/

Ex output files created: 
Source member TEST001 captured to TEST001.CLP   
```/home/userid/archivesoruce/qgpl/qclsrc/test001.clp```
Source member TEST001 source file metadata info captured to TEST001.metainfo. (Pipe delimited file)   
```/home/userid/archivesoruce/qgpl/qclsrc/test001.metainfo```

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
**From source file - SRCFILE** - This is the source file where the source members originate from.  Example: ```QGPL/QCLSRC```

**From source member - SRCMBR** - This is the source member to be copied/exported/snapshotted to the IFS. Example: ```SRC001R```

**Archive output IFS directory - ARCIFSDIR** - This is the root archive IFS subdirectory that will contain a specific subdirectory structure where members will be written to when exported. 

The default setting is ```*HOMEDIR``` so a directory system based on the parameter values specified on the ```HOMESUBDIR``` parameter will be created within the user's home directory. All subdirectories will be auto-created during export. The default value for ```HOMESUBDIR``` is: ```archivesource```.

Example dir structure created when utilizing a user's home directory for archives.
``` 
/home/userid
/home/userid/archivesource
/home/userid/archivesource/qgpl
/home/userid/archivesource/qgpl/qclsrc
```

If you don't use *HOMEDIR parameter and specify a top level IFS directory, that top level directory should already exist ideally. And then all the result of the directory structure should get auto-created. 

Example root dir structure created when NOT utilizing a user's home directory for archives. This example utilizes an existing top level directory name of: ```/sourcearchive```. 
``` 
/sourcearchive
/sourcearchive/qgpl
/sourcearchive/qgpl/qclsrc
```

**Home subdir if \*HOMEDIR set - HOMESUBDIR** - If the user specified *HOMEDIR on the ARCIFSDIR parm, this is the subdirectory within the users home directory that gets created and used for archive output. You can name it anything you want. Default value: ```archivesource```

Example automatic output path generated for export: ```/home/userid/archivesource```

**Output format - OUTPUTFMT** - This is the directory structure and member naming format that will be used when copying source members to the IFS. The subdirectories will get auto-created.

```*LIBFILEDIR``` - Subdirectories are auto-create within the ARCIFSDIR directory for each source library, source file and member name. This structure is similar to the directory structure for source files in the QSYS.LIB file system which is: ```/QSYS.LIB/LIBNAME.LIB/FILENAME.FILE.MEMBER.MBR```

Example dir structure created when utilizing a user's home directory for archives along with *LIBEFILEDIR format.
``` 
/home/userid
/home/userid/archivesource
/home/userid/archivesource/qgpl
/home/userid/archivesource/qgpl/qclsrc
/home/userid/archivesource/qgpl/qclsrc/src001.clp
/home/userid/archivesource/qgpl/qclsrc/src001.metainfo
/home/userid/archivesource/mylib1/qclsrc
/home/userid/archivesource/mylib1/qclsrc/src001.clp
/home/userid/archivesource/mylib1/qclsrc/src001.metainfo
```

```*LIBEFILEMBR``` - All members are written to the single directory name specified in the ARCIFSDIR parameter. Ex: ```/home/user/archivesource```. Each member is named uniquely as follows: ```LIBRARY_FILE_MEMBER.SRCTYPE```. Metadata info name would be like:  ```LIBRARY_FILE_MEMBER.METAINFO``` This should insure each source member across one or more libraries is uniquely named so there should be no naming collisions. Also by default the members are timestamped so the actual file name might be something like: ```LIBRARY_FILE_MEMBER_DATE_TIME.SRCTYPE``` Metadata info name would be like: ```LIBRARY_FILE_MEMBER_DATE_TIME.METAINFO```.   
This option is nice for making sure archived source members reside in a single level subdirectory.

Example dir structure created when utilizing a user's home directory for archives along with *LIBEFILEMBR format.
``` 
/home/userid
/home/userid/archivesource
/home/userid/archivesource/qgpl_qclsrc_src001.clp
/home/userid/archivesource/qgpl_qclsrc_src001.metainfo
/home/userid/archivesource/mylib1_qclsrc_src001.clp
/home/userid/archivesource/mylib1_qclsrc_src001.metainfo
```

**Append timestamp to file names - APPENDTS** - When creating output files for archived source members, always append a timestamp to the file path before the file extension. This is useful if you want to use the SRCARCIFS command as a pseudo-source control mechanism. Every source member will always be output with its name and a unique archive timestamp so you can create an archive without necessarilty needing to create a Git repository because the version history info is really the timestamp on the source meember file name when it's captured to sn IFS file. 

**Output .metainfo IFS file - METAINFO** - When exporting a source member, the metadata that SEU/PDM/VS Code/RDi use to identify a source member and it's original library, file, member, source type and text usually gets lost because it's not part of the actual source member data. Setting this parameter to *YES will output a separately named metadata info IFS file for the source member. This is a great way to keep metadata info intact for each source member exported to the IFS without having to put the metadata info into the actual source member itself. The metadata file will be created with the exact same name as rhe exported IFS source member, but it will have an extension of ```.metainfo```. If *NO specified, no metadata info gets captured during archive.

**Replace existing IFS file - REPLACE** - Set the replace option to *YES if you want to overwrite an existing source member in the IFS if found. If you have the ```APPENDTS``` parameter set to *YES, you can always leave this setting set to *NO because a new timestamped IFS file will always be written for each member that gets output to the IFS. Setting replace to *YES would be useful perhaps if you made your output folder in the IFS a Git repository folder. If Git is being used then it's OK to always replace because you will most likely manually run a ```Git add/commit/push``` command right after to send the source changes to your Git repo.

❗ SRCARCIFS only exports source to an IFS folder. It does not currently do any interaction directly with Git. You will need to create your own Git repo directory and commit processes.   
**Or you can purchase something like iForGit if you want more integrated IBM i source file control with Git.** 

**Prompt SQL - PROMPTSQL** - If you have issues or get an error with the source member metadata export process, you can prompt and see the SQL used to create the delimited record output for the source member metadata info. This is a convenience setting for handlling debugging errors. You should never usually need to turn this setting on, but it's here just in case. 

❗The pronpt SQL setting only works from an interactive 5250 session.


