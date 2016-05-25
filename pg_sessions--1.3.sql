/* contrib/pg_sessions/pg_sessions--1.3.sql */

-- complain if script is sourced in psql, rather than via CREATE EXTENSION
\echo Use "CREATE EXTENSION pg_sessions" to load this file. \quit

-- Register functions.
CREATE FUNCTION pg_sessions_reset()
RETURNS void
AS 'MODULE_PATHNAME'
LANGUAGE C;

CREATE FUNCTION pg_sessions(IN showtext boolean,
    OUT userid oid,
    OUT dbid oid,
    OUT pid bigint,
    OUT queryid bigint,
    OUT query text,
    OUT calls int8,
    OUT last_executed_timestamp timestamp,
    OUT	state bigint,
    OUT total_time float8,
    OUT min_time float8,
    OUT max_time float8,
    OUT mean_time float8,
    OUT stddev_time float8,
    OUT rows int8,
    OUT shared_blks_hit int8,
    OUT shared_blks_read int8,
    OUT shared_blks_dirtied int8,
    OUT shared_blks_written int8,
    OUT local_blks_hit int8,
    OUT local_blks_read int8,
    OUT local_blks_dirtied int8,
    OUT local_blks_written int8,
    OUT temp_blks_read int8,
    OUT temp_blks_written int8,
    OUT blk_read_time float8,
    OUT blk_write_time float8
)
RETURNS SETOF record
AS 'MODULE_PATHNAME', 'pg_sessions_1_3'
LANGUAGE C STRICT VOLATILE;

-- Register a view on the function for ease of use.
CREATE VIEW pg_sessions AS
  select u.usename, d.datname,  s.pid, s.queryid, s.query, s.calls, s.last_executed_timestamp,
  	CASE 
  		WHEN state=0 THEN 'PARSING'
  		WHEN state=1 THEN 'STARTED'
  		WHEN state=2 THEN 'RUNNING'
  		WHEN state=3 THEN 'ENDING'
  		WHEN state=4 THEN 'COMPLETED'
  	END as status,
  	s.total_time, s.min_time, s.max_time, s.mean_time, s.stddev_time, s.rows, s.shared_blks_hit,
	s.shared_blks_read, s.shared_blks_dirtied, s.shared_blks_written, s.local_blks_hit, s.local_blks_read,
	s.local_blks_dirtied, s.local_blks_written, s.temp_blks_read, s.temp_blks_written, s.blk_read_time,
	s.blk_write_time 
	FROM pg_sessions(true) s, pg_user u, pg_database d 
	WHERE s.userid::oid=u.usesysid and s.dbid::oid=d.oid;

GRANT SELECT ON pg_sessions TO PUBLIC;

-- Don't want this to be available to non-superusers.
REVOKE ALL ON FUNCTION pg_sessions_reset() FROM PUBLIC;
