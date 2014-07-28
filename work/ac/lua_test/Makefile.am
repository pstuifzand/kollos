ACTIVE_TESTS = \
  all.lua \
  api.lua \
  attrib.lua \
  big.lua \
  bitwise.lua \
  calls.lua \
  checktable.lua \
  closure.lua \
  code.lua \
  constructs.lua \
  coroutine.lua \
  db.lua \
  errors.lua \
  events.lua \
  files.lua \
  gc.lua \
  goto.lua \
  literals.lua \
  locals.lua \
  main.lua \
  math.lua \
  nextvar.lua \
  pm.lua \
  sort.lua \
  strings.lua \
  vararg.lua \
  verybig.lua

# Tests that fail on purpose or expect user input
# INACTIVE_TESTS = \
	# globals.lua \
	# luac.lua \
	# readonly.lua \
	# table.lua \
	# xd.lua

TESTS = $(ACTIVE_TESTS)
TESTS_ENVIRONMENT = $(srcdir)/run-test.sh $(top_builddir)/src/lua

EXTRA_DIST = $(TESTS) README run-test.sh
