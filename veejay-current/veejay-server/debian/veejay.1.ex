.TH "veejay" 1
.SH NAME
veejay - a visual (video) instrument and video sampler for GNU/Linux
.SH SYNOPSIS
.B veejay [options] Videofile1 [Videofile2 ... VideofileN]
.SH DESCRIPTION
.B veejay
Veejay is a visual instrument and realtime video sampler. It allos you
to "play" the video like you would play a Piano and it allows you to
record the resulting video directly to disk for immediate playback (video sampling).

Veejay can be operated live by using the keyboard (which is 100% user definable)
and remotely over network (both unicast and multicast) using an inhouse message
system that allows mapping of various protocols on top of it, including OSC.

Veejay is beeing developed in the hope it will be usefull for VJ's , media artists
theathers and other interested users that want to use Free Software for their
performances and/or video installations.

.TP
.SH Supported video codecs
.TP
MJPEG (either jpeg 4:2:0 or jpeg 4:2:2), YUV 4:2:0 i420/yv12 AVI, Quasar DV codec (only I-frames), MPEG4 (only I-frames)
.TP
.SH Supported video containers
AVI , QuickTime 
.TP
.SH Audio
.TP
Veejay uses Jack , a low latency audio server, to transport (playback) audio in sync with video. This allows you to process veejay's audio output in another sound processing application.
.TP
.SH General Usage (How to work with veejay)
.TP
Veejay has a console- and a video window ; the console is used for displaying messages only. If the mouse is moved over to the video window, you can use the keyboard like a piano to play/manipulate the video.
.TP
You can start veejay with multiple files , video files and/or Mjpegtools' EditList files. Upon startup, veejay creates a new EditList in memory containing all the files you have loaded. As a result, all files will appear as a single large video file.Next you can start making selections (samples) of your EditList. These samples will be placed in so called 'sample banks' and they can be triggered for playback by pressing the F-keys (1 to 12). You can select a bank by pressing a number 1 to 9.
.TP
Note that if you change the EditList (for example , when deleting portions of your editlist) you should save your editlist as well as your samplelist.
.TP
You can select effects to put on your samples by pressing the cursor keys up and down, once you have found an effect you would like to use, press ENTER and it will be added to the current chain entry. The current chain entry can be changed with the PLUG and MINUS key on your numeric keyboard. Look at the KEYBINDS in this manual page to see what other possibilities you could have. 
.TP
.SH Interactive camera/projection system
.TP
You can use veejay to calibrate a camera (or another input source) against a projector screen to map a physical position to veejay's projection. To use this feature, you can press CTRL\-s to activate the projection/camera calibration setup. This will render a graphical OSD on top of the video.Next, you need to play the live input source in order to find veejay's projection in the camera image. Set the points to the edges of the screen and right-click. Now press CTRL\-s or the middle mouse button to leave setup. Press CTRL-i to enable transforming the camera input and press CTRL-p to bring the projection screen in front.
.TP
.SH Interoperability
.TP
Veejay can be used with PD (PureData) by using sendVIMS, a small commandline utility that translates PD's symbols to veejay and vice versa.Look at the REFERENCES to find out where to download this utility. Also, by using the OpenSoundControl veejay can be used with a great number of sound and video processing applications.Also veejay can stream video data to STDOUT (-o stdout -O3) in yuv4mpeg format, or stream uncompressed video over the network (uni - and multicast)
.SH OPTIONS
.TP
.B \-w/--projection-width
Specify video output width for projection / on screen purposes
.TP
.B \-h/--projection-height
Specify video output height for projection / on screen purposes
.TP
.B \-p/--portoffset <num>
TCP port offset for communication with clients like 'reloaded' , 'sayVIMS' or sendVIMS for PD (default 3490)
.TP
.B \-h/--host
Start as client of another veejay session (default is server)
.TP
.B \-o/--outstream <filename>
write video in YCbCr (YUV 4:2:0) format to specified file. Use this with -O3.
If you use 'stdout' here, veejay will be silent and write yuv4mpeg streams to STDOUT
.TP
.B \-O/--output [012345]
specify video output 0 = SDL (default) 1 = DirectFB 2 = SDL and DirectFB 3 = YUV4MPEG stream , 4 = Open GL (required ARB fragment shader), 5 = Silent (no visual output)
.TP
.B \-s/--size NxN
Scaled video dimensions for SDL video output
.TP
.B \-a/--audio [01]
Play audio 0 = off , 1 = on (default)
.TP
.B \-c/--synchronization [01]
Sync correction off/on (default on)
.TP
.B \-P/--preverse-pathnames
Do not 'canonicalise' pathnames in editlists
.TP
.B \-v/--verbose 
verbosity on/off    
.TP
.B \-t/--timer [012]
timer to use ( none, normal, rtc )
.TP
.B \-f/--fps <num>
Override framerate of video 
.TP
.B \-x/--geometryx <num>
Geometry x offset for SDL video window
.TP
.B \-y/--geometryy <num>
Geometry y offset for SDL video window
.TP
.B \-l/--action-file <filename>
Configuration File to load at initialization.
The configuration file stores custom keybindings, custom bundles, available VIMS events, editlist,samplelist,streamlist
and commandline options.
.TP
.B \-b/--bezerk
Bezerk mode, if enabled it allows you to change input channels on the fly (without restarting the samples)      
.TP
.B \-g/--clip-as-sample
Load every file on the commandline as a new sample
.TP
.B \-q/--quit
Quit at end of video 
.TP
.B \-n/--no-color
Dont use colored text.
.TP
.B \-m/--memory [0-100]
Frame cache size in percentage of total system RAM 
.TP
.B \-j/--max_cache [0-100]
Maximum number of samples to cache 
.TP
.B \-F/--features
Show compiled in options
.TP
.B \-Y/--yuv [0123]
Force pixel format if you get a corrupted image. Its recommanded to load
only one videofile and re-record it.
.TP
.B \-d/--dummy
Start veejay with no video files (dummy mode). By default it will play black video (Stream 1 [F1])
.TP
.B \-W/--width
Specify width of dummy video.
.TP
.B \-H/--height
Specify height of dummy video
.TP
.B \-R/--framerate
Specify framerate of dummy video
.TP
.B \-N [01]
Specify norm of dummy video (0=PAL, 1=NTSC). defaults to PAL
.TP
.B \-M/--multicast-osc <address>
Starts OSC receiver in multicast mode
.TP
.B \-T/--multicast-vims <address>
Setup additional multicast frame sender / command receiver.
The frame sender transmits on port offset + 3, send commands to port offset + 4, 
.TP
.B \  /--map-from-file <num frames>
To reduce transfers between memory and disk, you can set a number
of frames to be cached in memory from file (only valid for rawDV and AVI)
Use smaller values for better performance (mapping several hundreds of
megabytes can become a problem)
.TP
.B \-V/--viewport
Start with source viewport enabled. Use this if you have previously setup
a viewport. Use CTRL+v to enable the viewport setup.
.TP
.B \-A/--all
Start with all capture devices active as streams
.TP
.B \-D/--composite
Do not start with projection enabled. 
.TP
.SH Environment variables
.TP
.B VEEJAY_SET_CPU
Tell veejay which CPU to use (and lock) for rendering. By default
veejay will lock CPU #1 if running on a SMP machine. 
Use "0" to disable this behaviour. Use 1 for CPU#1, etc. 
.TP
.SH Home directory
.TP
Veejay creates a new directory in your HOME , ".veejay".
.TP
.B .veejay/recovery
If veejay stops unexpectedly, it will try to save your samplelist and editlist before aborting. 
.TP
.B .veejay/theme 
Theme directory for GVeejayReloaded. 
.TP
.B .veejay/plugins.cfg
If you want to load frei0r or freeframe plugins , set the paths
to the .so files in the plugins.cfg file. Only support for single
channel plugins.  
.TP
.SH EXAMPLES
.TP
.B veejay -u |less
Startup veejay and list all events (VIMS/OSC) and effect descriptions 
.TP
.B veejay -p 4000 ~/my_video1.avi
Startup veejay listening on port 4000 (use this to use multiple veejays)
.TP
.B veejay -d -W 352 -H 288 -R 25 -N 0
Startup veejay using dummy video at 25 frames per second, dimensions 352x288
and using PAL.
.TP
.B veejay movie1.avi -V 224.0.0.50 -p 5000 -n -v -L
Startup veejay, using multicast protocol on port 5000 , with autolooping
and no colored verbose output
.TP
.B veejay -O4 ~/my_video1.avi
Startup veejay with openGL video window
.TP
.SH INTERFACE COMMANDS (STDIN)
When you are running veejay with a SDL window you can use keybindings for
realtime interaction. See 
.B KEYBINDINGS
for details.
.TP

.SH KEYBINDINGS
.TP
.B [Keypad *]
Set sample looptype
.TP
.B [Keypad -]
Decrease chain index pointer
.TP
.B [Keypad +]
Increase chain index pointer
.TP
.B [Keypad 1]
Goto start of sample
.TP
.B [Keypad 2]
Go back 25 frames 
.TP
.B [Keypad 3]
Goto end of sample
.TP
.B [Keypad 4]
Play backward
.TP
.B [Keypad 5]
Pause
.TP
.B [Keypad 6]
Play forward
.TP
.B [Keypad 7]
Goto previous frame
.TP
.B [Keypad 8]
Go forward 25 frames
.TP
.B [Keypad 9]
Goto next frame
.TP
.B [Keypad /]
Switch to Plain video playback mode (from Sample or Tag mode)
.TP
.B [LEFT BRACKET]
Set sample start
.TP
.B [RIGHT BRACKET]
Set sample end and create new sample
.TP
.B [ALT] + [LEFT BRACKET]
Set marker start
.TP
.B [ALT] + [LEFT BRACKET]
Set marker end and activate marker
.TP
.B [Backspace]
Delete current marker 
.TP
.B [a,s,d,f,g,h,j,k,l]
Set playback speed to 1,2,3,4,5,6,7,8, or 9
.TP
.B [ALT] + [a|s|d|f|g|h|j|k|l]
Set frame duplicator to 1,2,3,4,5,6,7,8 or 9. Interpolates missing frames.
.TP
.B [1..9]
Set sample range 0-12, 12-24, 24-36 etc.
.TP
.B ALT + [1..9]
Set channel ID 1-9, depending on sample range
.TP
.B [F1..F12]
Select and play sample 1 .. 12
.TP
.B [DELETE]
Delete selected effect
.TP
.B [Home]
Print sample/tag information
.TP
.B [ESC]
Switch between Plain -> Tag or Sample playback mode
.TP
.B [CURSOR RIGHT]
Go up 5 positions in the effect list
.TP
.B [CURSOR LEFT]
Go back 5 positions in the effect list
.TP
.B [UP]
Go up 1 position in the effect list
.TP
.B [DOWN]
Go down 1 position in the effect list
.TP
.B [RETURN | ENTER]
Add selected effect from list to sample
.TP
.B [v]
Toggle sample's playlist
.TP
.B [-]
Decrease mixing channel ID
.TP
.B [=]
Increase mixing channel ID
.TP
.B SLASH
Toggle mixing source between Clips and Streams
.TP
.B [z]
Audio Fade in decrease (*)
.TP
.B [x]
Audio Fade in increase (*)
.TP
.B [b]
Toggle a selected effect on/off
.TP
.B [END]
Enable/Disable Effect Chain
.TP
.B [Left ALT] + [END]
Enable/Disable Video on selected Entry
.TP
.B [Right ALT] + [END]
Enable/Disable Audio on selected Entry
.TP
.B [LCTRL] + [END]
Enable/Disable Video on selected Entry
.TP
.B [RCTRL] + [END]
Enable/Disable Audio on selected Entry
.TP
.B [NUMLOCK]
Auto increment/decrement of a parameter-key
.TP
.B [n]
Decrease trimmer value of selected effect
.TP
.B [m]
Increase trimmer value of selected effect
.TP
.B [x]
Decrease audio volume (not functional)
.TP
.B [c]
Increase audio volume (not functional)
.TP
.B [0]
Capture frame to jpeg file
.TP
.B [PgUp]
Increase parameter 0 of selected effect
.TP
.B [PgDn]
Decrease parameter 0 of selected effect
.TP
.B [Keypad 0]
Decrease parameter 1 of selected effect
.TP
.B [Keypad .]
Increase parameter 1 of selected effect
.TP
.B [.]
Increase parameter 2 of selected effect
.TP
.B [,]
Decrease parameter 2 of selected effect
.TP
.B [QUOTE]
Increase parameter 3 of selected effect
.TP
.B [SEMICOLON]
Decrease parameter 3 of selected effect
.TP
.B [q]
Decrease parameter 4 of selected effect
.TP
.B [w]
Increase parameter 4 of selected effect
.TP
.B [e]
Decrease parameter 5 of selected effect
.TP
.B [r]
Increase parameter 5 of selected effect
.TP
.B [t]
Decrease parameter 6 of selected effect
.TP
.B [y]
Increase parameter 6 of selected effect
.TP
.B [u]
Decrease parameter 7 of selected effect
.TP
.B [i]
Increase parameter 7 of selected effect
.TP

.B SHIFT + spacebar
Start keystroke recorder. The keystroke recorder
records most of the received VIMS messages and plays them
back in order and on the position you have pressed them.
Instead of using the keyboard, you can also use 'Reloaded',
and record the buttons pressed. However, some VIMS messages
are excluded from the keystroke recorder for safety reasons. 
.TP
.B spacebar
(re)play recorded VIMS messages. The keystroke recorder
will jump to the starting position and replay all
recorded VIMS messages. 
.TP
.B CTRL + spacebar
Clear recorded keystrokes. This clears all VIMS messages
in the current selected macro slot.
.TP
.B CTRL + [ F1 - F12 ]
Select a slot to record keystrokes to (default=0)
Use this if you want to record multiple keystrokes. You
can switch slots while in keystroke playback.
.TP
.B ALT + B 
Take a snapshot of a video frame and put it in a seperate
buffer (used by some effects like Difference Overlay)
.TP
.B CTRL + s
Show/hide interactive camera/projector calibration setup
.TP
.B CTRL + p
Focus on front (primary output) or back (secundary input) projection
.TP
.B CTRL + i
Toggle current playing sample/stream as input source to be transformed
.TP
.B CTRL + v
Toggle grayscale/color mode for unicap streams
.TP
.B CTRL + h
Toggle OSD help for camera/projector setup
.TP
.B CTRL + o
Toggle OSD help for general status messages and mouse coordinates
.TP
.B CTRL + d
Toggle rendering of single source FX on underlying samples
.TP
.B CTRL + r
Start recording
.TP
.B CTRL + t
Stop recording
.TP
.SH REFERENCES
.TP
http://veejay.sourceforge.net
http://veejayhq.net
.SH BUGS
see BUGS in the source package
.SH AUTHOR
This man page was written by Niels Elburg.
If you have questions, remarks or you just want to
contact the developers, the main mailing list for this
project is: 
.I http://groups.google.com/group/veejay-discussion/post?hl=en
For more info see the website at
.I http://veejayhq.net
.I http://veejay.dyne.org
.SH "SEE ALSO"
.B veejay sayVIMS  