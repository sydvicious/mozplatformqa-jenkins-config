#!/usr/bin/tclsh

set fd [open email.snippet]
set snippet [read $fd]
close $fd

set job_files [glob jobs/*/config.xml]

foreach file $job_files {
    puts -nonewline "Processing $file..."
    flush stdout
    set fd [open $file]
    set contents [read $fd]
    close $fd

    set newcontents $contents
    if {[regsub -all {unzip} $newcontents gunzip newcontents]} {
        puts -nonewline "replaced"
    }

    if {![string equal $contents $newcontents]} {
        set fd [open $file w]
        puts -nonewline $fd $newcontents
        puts -nonewline "Replaced..."
        close $fd
    }

    puts "done"
}
