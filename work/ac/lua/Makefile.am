AM_CFLAGS = -Wall

include_HEADERS = lua.h lualib.h lauxlib.h
nodist_include_HEADERS = luaconf.h 

lib_LTLIBRARIES = liblua.la
liblua_la_LDFLAGS = -release 5.1
liblua_la_SOURCES = \
	lapi.c lcode.c ldebug.c ldo.c ldump.c lfunc.c lgc.c llex.c lmem.c \
	lobject.c lopcodes.c lparser.c lstate.c lstring.c ltable.c ltm.c  \
	lundump.c lvm.c lzio.c \
	lauxlib.c lbaselib.c ldblib.c liolib.c lmathlib.c loslib.c ltablib.c \
	lstrlib.c loadlib.c linit.c \
	lapi.h ldebug.h lgc.h lmem.h lparser.h ltable.h lzio.h ldo.h llex.h \
	lobject.h lstate.h ltm.h lundump.h lcode.h lfunc.h llimits.h lopcodes.h \
	lstring.h lvm.h \
	lbitlib.c lcorolib.c lctype.c lctype.h

bin_PROGRAMS = lua luac

lua_SOURCES = lua.c
lua_LDADD = liblua.la @MARPA_LUA_LIBS@ @READLINE_LIBS@
lua_DEPENDENCIES = liblua.la


luac_SOURCES = luac.c
luac_LDADD = liblua.la @MARPA_LUA_LIBS@
luac_DEPENDENCIES = liblua.la

# luac must be linked statically because it uses functions that
# don't get exported to the shared object
luac_LDFLAGS = -static

EXTRA_DIST = luaconf.h.template.in
BUILT_SOURCES = luaconf.h
CLEANFILES = luaconf.h

readline_defs = @READLINE_DEFS@

edit = 	sed \
	  -e 's,%lua_datadir%,$(datadir),g' \
	  -e 's,%lua_libdir%,$(libdir),g'

luaconf.h : $(builddir)/luaconf.h.template
	rm -f luaconf.h luaconf.h.tmp
	$(edit) $(builddir)/luaconf.h.template > luaconf.h.tmp
	mv luaconf.h.tmp luaconf.h
