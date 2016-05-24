# contrib/pg_sessions/Makefile

MODULE_big = pg_sessions
OBJS = pg_sessions.o $(WIN32RES)

EXTENSION = pg_sessions
DATA = pg_sessions--1.3.sql pg_sessions--unpackaged--1.0.sql
PGFILEDESC = "pg_sessions - execution statistics of Sessions and SQL statements"

LDFLAGS_SL += $(filter -lm, $(LIBS))

ifdef USE_PGXS
PG_CONFIG = pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)
include $(PGXS)
else
subdir = contrib/pg_sessions
top_builddir = ../..
include $(top_builddir)/src/Makefile.global
include $(top_srcdir)/contrib/contrib-global.mk
endif
