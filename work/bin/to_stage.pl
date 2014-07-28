#!perl
# Copyright 2014 Jeffrey Kegler
# This file is part of Libmarpa.  Libmarpa is free software: you can
# redistribute it and/or modify it under the terms of the GNU Lesser
# General Public License as published by the Free Software Foundation,
# either version 3 of the License, or (at your option) any later version.
#
# Libmarpa is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser
# General Public License along with Libmarpa.  If not, see
# http://www.gnu.org/licenses/.

# Copy things into stage/
# It makes more sense to do this in Perl than in the Makefile

use 5.010;
use File::Spec;
use File::Copy;
use Getopt::Long;
use autodie;    # Portability not essential in this script

my $verbose;
GetOptions( "verbose|v" => \$verbose )
    or die("Error in command line arguments\n");

DIR:
for my $dir (
    File::Spec->catdir(qw(stage)),
    File::Spec->catdir(qw(stage lua)),
    File::Spec->catdir(qw(stage lua tests)),
    File::Spec->catdir(qw(stage lua tests ltests)),
    File::Spec->catdir(qw(stage lua tests libs)),
    File::Spec->catdir(qw(stage lua tests libs P1))
    )
{
    next DIR if -d $dir;
    mkdir $dir;
} ## end DIR: for my $dir ( File::Spec->catdir(qw(stage)), File::Spec...)

FILE: while ( my $copy = <DATA> ) {
    chomp $copy;
    my ( $to, $from ) = $copy =~ m/\A (.*) [:] \s+ (.*) \z/xms;
    die "Bad copy spec: $copy" if not defined $to;
    next FILE if -e $to and ( -M $to <= -M $from );
    my ( undef, $to_dirs, $to_file ) = File::Spec->splitpath($to);
    my @to_dirs = File::Spec->splitdir($to_dirs);
    my @dir_found_so_far = ();
    # Make the directories we do not find
    DIR_PIECE: for my $dir_piece (@to_dirs) {
	push @dir_found_so_far, $dir_piece;
	my $dir_so_far = File::Spec->catdir(@dir_found_so_far);
        next DIR_PIECE if -e $dir_so_far;
	mkdir $dir_so_far;
    }
    File::Copy::copy($from, $to) or die "Cannot copy $from -> $to";
    say "Copied $from -> $to" if $verbose;
} ## end FILE: while ( my $copy = <DATA> )

# Note that order DOES matter here -- the configure.ac files
# MUST be FIRST

__DATA__
doc/configure.ac: ac_doc/configure.ac
stage/configure.ac: ac/configure.ac
doc/Makefile.am: ac_doc/Makefile.am
stage/Makefile.am: ac/Makefile.am
stage/lua/Makefile.am: ac/lua/Makefile.am
stage/lua_test/Makefile.am: ac/lua_test/Makefile.am
stage/Makefile.win32: win32/Makefile.win32
stage/win32/do_config_h.pl: win32/do_config_h.pl
stage/marpa.c: dev/marpa.c
stage/win32/marpa.def: dev/marpa.def
stage/marpa.h: public/marpa.h
stage/marpa_slif.h: public/marpa_slif.h
stage/marpa_obs.c: obs/marpa_obs.c
stage/marpa_obs.h: obs/marpa_obs.h
stage/marpa_ami.c: ami/marpa_ami.c
stage/marpa_codes.c: public/marpa_codes.c
stage/marpa_slif.c: slif/marpa_slif.c
stage/marpa_ami.h: ami/marpa_ami.h
stage/marpa_avl.c: avl/marpa_avl.c
stage/marpa_avl.h: avl/marpa_avl.h
stage/marpa_tavl.h: tavl/marpa_tavl.h
stage/marpa_tavl.c: tavl/marpa_tavl.c
stage/AUTHORS: ac/AUTHORS
stage/COPYING.LESSER: ac/COPYING.LESSER
stage/ChangeLog: ac/ChangeLog
stage/NEWS: ac/NEWS
stage/README: ac/README
stage/LIB_VERSION.in: public/LIB_VERSION.in
doc/README: ac_doc/README
doc/NEWS: ac_doc/NEWS
doc/AUTHORS: ac_doc/AUTHORS
doc/COPYING.LESSER: ac_doc/COPYING.LESSER
doc/ChangeLog: ac_doc/ChangeLog
doc/fdl-1.3.texi: ac_doc/fdl-1.3.texi
doc/lgpl-3.0.texi: ac_doc/lgpl-3.0.texi
doc/api.texi: dev/api.texi
doc/internal.texi: dev/internal.texi
stage/README.INSTALL: notes/README.INSTALL
stage/lua/luaconf.h.template.in: lua/base/src/luaconf.h.template.in
stage/lua/ldo.c: lua/gen/ldo.c
stage/lua/ldebug.h: lua/gen/ldebug.h
stage/lua/lzio.h: lua/gen/lzio.h
stage/lua/lualib.h: lua/gen/lualib.h
stage/lua/lbitlib.c: lua/gen/lbitlib.c
stage/lua/ldo.h: lua/gen/ldo.h
stage/lua/lvm.c: lua/gen/lvm.c
stage/lua/ltm.h: lua/gen/ltm.h
stage/lua/lua.h: lua/gen/lua.h
stage/lua/ltable.c: lua/gen/ltable.c
stage/lua/lstring.c: lua/gen/lstring.c
stage/lua/lstate.h: lua/gen/lstate.h
stage/lua/lauxlib.h: lua/gen/lauxlib.h
stage/lua/lcode.c: lua/gen/lcode.c
stage/lua/lgc.h: lua/gen/lgc.h
stage/lua/lopcodes.h: lua/gen/lopcodes.h
stage/lua/loadlib.c: lua/gen/loadlib.c
stage/lua/llimits.h: lua/gen/llimits.h
stage/lua/ldblib.c: lua/gen/ldblib.c
stage/lua/lobject.h: lua/gen/lobject.h
stage/lua/lstrlib.c: lua/gen/lstrlib.c
stage/lua/ltm.c: lua/gen/ltm.c
stage/lua/lauxlib.c: lua/gen/lauxlib.c
stage/lua/lparser.c: lua/gen/lparser.c
stage/lua/linit.c: lua/gen/linit.c
stage/lua/lfunc.c: lua/gen/lfunc.c
stage/lua/lstring.h: lua/gen/lstring.h
stage/lua/lopcodes.c: lua/gen/lopcodes.c
stage/lua/ltable.h: lua/gen/ltable.h
stage/lua/lmem.h: lua/gen/lmem.h
stage/lua/lbaselib.c: lua/gen/lbaselib.c
stage/lua/ldebug.c: lua/gen/ldebug.c
stage/lua/lparser.h: lua/gen/lparser.h
stage/lua/luac.c: lua/gen/luac.c
stage/lua/ltablib.c: lua/gen/ltablib.c
stage/lua/ldump.c: lua/gen/ldump.c
stage/lua/lfunc.h: lua/gen/lfunc.h
stage/lua/liolib.c: lua/gen/liolib.c
stage/lua/lua.c: lua/gen/lua.c
stage/lua/lobject.c: lua/gen/lobject.c
stage/lua/lmem.c: lua/gen/lmem.c
stage/lua/lctype.c: lua/gen/lctype.c
stage/lua/loslib.c: lua/gen/loslib.c
stage/lua/lundump.h: lua/gen/lundump.h
stage/lua/lgc.c: lua/gen/lgc.c
stage/lua/llex.c: lua/gen/llex.c
stage/lua/lmathlib.c: lua/gen/lmathlib.c
stage/lua/llex.h: lua/gen/llex.h
stage/lua/lapi.h: lua/gen/lapi.h
stage/lua/lapi.c: lua/gen/lapi.c
stage/lua/lstate.c: lua/gen/lstate.c
stage/lua/lctype.h: lua/gen/lctype.h
stage/lua/lcorolib.c: lua/gen/lcorolib.c
stage/lua/.gitignore: lua/gen/.gitignore
stage/lua/lcode.h: lua/gen/lcode.h
stage/lua/lvm.h: lua/gen/lvm.h
stage/lua/lzio.c: lua/gen/lzio.c
stage/lua/lundump.c: lua/gen/lundump.c
stage/lua_tests/strings.lua: lua/tests/strings.lua
stage/lua_tests/literals.lua: lua/tests/literals.lua
stage/lua_tests/constructs.lua: lua/tests/constructs.lua
stage/lua_tests/big.lua: lua/tests/big.lua
stage/lua_tests/errors.lua: lua/tests/errors.lua
stage/lua_tests/goto.lua: lua/tests/goto.lua
stage/lua_tests/nextvar.lua: lua/tests/nextvar.lua
stage/lua_tests/ltests/ltests.c: lua/tests/ltests/ltests.c
stage/lua_tests/ltests/ltests.h: lua/tests/ltests/ltests.h
stage/lua_tests/verybig.lua: lua/tests/verybig.lua
stage/lua_tests/bitwise.lua: lua/tests/bitwise.lua
stage/lua_tests/libs/lib2.c: lua/tests/libs/lib2.c
stage/lua_tests/libs/lib1.c: lua/tests/libs/lib1.c
stage/lua_tests/libs/lib11.c: lua/tests/libs/lib11.c
stage/lua_tests/libs/makefile: lua/tests/libs/makefile
stage/lua_tests/libs/lib21.c: lua/tests/libs/lib21.c
stage/lua_tests/events.lua: lua/tests/events.lua
stage/lua_tests/math.lua: lua/tests/math.lua
stage/lua_tests/calls.lua: lua/tests/calls.lua
stage/lua_tests/locals.lua: lua/tests/locals.lua
stage/lua_tests/all.lua: lua/tests/all.lua
stage/lua_tests/files.lua: lua/tests/files.lua
stage/lua_tests/attrib.lua: lua/tests/attrib.lua
stage/lua_tests/sort.lua: lua/tests/sort.lua
stage/lua_tests/db.lua: lua/tests/db.lua
stage/lua_tests/code.lua: lua/tests/code.lua
stage/lua_tests/gc.lua: lua/tests/gc.lua
stage/lua_tests/api.lua: lua/tests/api.lua
stage/lua_tests/closure.lua: lua/tests/closure.lua
stage/lua_tests/main.lua: lua/tests/main.lua
stage/lua_tests/pm.lua: lua/tests/pm.lua
stage/lua_tests/checktable.lua: lua/tests/checktable.lua
stage/lua_tests/coroutine.lua: lua/tests/coroutine.lua
stage/lua_tests/vararg.lua: lua/tests/vararg.lua
