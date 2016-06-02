/* contrib/pg_sessions/pg_sessions--unpackaged--1.0.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_sessions FROM unpackaged" to load this file. \quit

ALTER EXTENSION pg_sessions ADD function pg_sessions_reset();
ALTER EXTENSION pg_sessions ADD function pg_sessions();
ALTER EXTENSION pg_sessions ADD view pg_sessions;
