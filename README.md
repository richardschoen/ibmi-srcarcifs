# Copy/Archive IBM i Source Physical File Members to IFS 
This repo contains self-contained IBM i CL commands for copying source members from a source physical file to a selected IFS structure for backup/archive purposes or for committing to a git repository you may be using.

It has the unique feature of being able to:
- Place each library source member a user takes a snaphost of into the user's home directory under a subdirectory structure as follows: ```/home/user/archivesource/library/file/member```
- Optionally place all source members in a single directory with member name of: ```library_file_member_date_time.srctype```
- Timestamp the IFS output files. This is the default option for those who want to snapshot code to the IFS but don't use Git yet.
- Capture source physical file member metadata info for each member to an IFS file ending with ```.mbrinfo```
  

