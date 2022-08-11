## UA Updater
This bash script compares the sha256 sum of the currently installed UA .jar file to the current version. If the local .jar is outdated, the script will rename and move the old version, and download the current version to take its place.

## Prerequisites
A machine with a `bash` or `zsh` shell, e.g. a Mac or Linux box. I assume this would work on Windows Subsystem for Linux, although it has not yet been tested.

## Instructions
Download the update-ua.sh file, then run `chmod +x update-ua.sh` to make it executable.

Open the script in a text editor and change the `UAPATH` variable to point to the location you currently keep your wss-unified-agent.jar file.

If you'd also like to set a custom location for the old Unified Agent versions, go ahead and put that path into the `OLDUA` variable.

To run the script, run `./update-ua.sh`

## Bonus: schedule with cron
You can run the script manually whenever you want, but if you want to get fancy, you can set it up to run weekly (or whatever) using a custom cron job. There are probably easier ways to accomplish this, but the old-fashioned way is to run the following in your terminal:

`crontab -e`

Then hit 'i' to enter insert mode, and paste the following string on a new line:

`0 18 * * 5 ~/.update-ua.sh >/dev/null 2>&1`

This will run the script every Friday at 6pm, and won't send you any emails about what it's doing.

To save and quit, hit 'escape' then type `ZZ` (make sure it's capital Z's!)

The script should run every Friday! 

Note: if you are on a Mac, you may need to give access to cron as follows: https://osxdaily.com/2020/04/27/fix-cron-permissions-macos-full-disk-access/
