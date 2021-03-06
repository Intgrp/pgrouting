/*PGR-GNU*****************************************************************
File: astar.sql

Generated with Template by:
Copyright (c) 2015 pgRouting developers
Mail: project@pgrouting.org

Function's developer:
Copyright (c) 2015 Celia Virginia Vergara Castillo
Mail:

------

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

********************************************************************PGR-GNU*/

CREATE OR REPLACE FUNCTION pgr_astar(
    edges_sql TEXT, -- XY edges sql
    start_vid BIGINT,
    end_vid BIGINT,
    directed BOOLEAN DEFAULT true,
    heuristic INTEGER DEFAULT 5,
    factor FLOAT DEFAULT 1.0,
    epsilon FLOAT DEFAULT 1.0,

    OUT seq INTEGER,
    OUT path_seq INTEGER,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)

RETURNS SETOF RECORD AS
$BODY$
    SELECT a.seq, a.path_seq, a.node, a.edge, a.cost, a.agg_cost
    FROM _pgr_astar(_pgr_get_statement($1), ARRAY[$2]::BIGINT[],  ARRAY[$3]::BIGINT[], $4, $5, $6::FLOAT, $7::FLOAT) AS a;
$BODY$
LANGUAGE sql VOLATILE STRICT
COST 100
ROWS 1000;

CREATE OR REPLACE FUNCTION pgr_astar(
    edges_sql TEXT, -- XY edges sql
    start_vid BIGINT,
    end_vids ANYARRAY,
    directed BOOLEAN DEFAULT true,
    heuristic INTEGER DEFAULT 5,
    factor FLOAT DEFAULT 1.0,
    epsilon FLOAT DEFAULT 1.0,
    OUT seq INTEGER,
    OUT path_seq INTEGER,
    OUT end_vid BIGINT,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)

RETURNS SETOF RECORD AS
$BODY$
    SELECT a.seq, a.path_seq, a.end_vid, a.node, a.edge, a.cost, a.agg_cost
    FROM _pgr_astar(_pgr_get_statement($1), ARRAY[$2]::BIGINT[],  $3::BIGINT[], $4, $5, $6::FLOAT, $7::FLOAT) AS a;
$BODY$
LANGUAGE sql VOLATILE STRICT
COST 100
ROWS 1000;

CREATE OR REPLACE FUNCTION pgr_astar(
    edges_sql TEXT, -- XY edges sql
    start_vids ANYARRAY,
    end_vid BIGINT,
    directed BOOLEAN DEFAULT true,
    heuristic INTEGER DEFAULT 5,
    factor FLOAT DEFAULT 1.0,
    epsilon FLOAT DEFAULT 1.0,
    OUT seq INTEGER,
    OUT path_seq INTEGER,
    OUT start_vid BIGINT,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)

RETURNS SETOF RECORD AS
$BODY$
    SELECT a.seq, a.path_seq, a.start_vid, a.node, a.edge, a.cost, a.agg_cost
    FROM _pgr_astar(_pgr_get_statement($1), $2::BIGINT[],  ARRAY[$3]::BIGINT[], $4, $5, $6::FLOAT, $7::FLOAT, normal:=false) AS a;
$BODY$
LANGUAGE sql VOLATILE STRICT
COST 100
ROWS 1000;

CREATE OR REPLACE FUNCTION pgr_astar(
    edges_sql TEXT, -- XY edges sql
    start_vids ANYARRAY,
    end_vids ANYARRAY,
    directed BOOLEAN DEFAULT true,
    heuristic INTEGER DEFAULT 5,
    factor FLOAT DEFAULT 1.0,
    epsilon FLOAT DEFAULT 1.0,
    OUT seq INTEGER,
    OUT path_seq INTEGER,
    OUT start_vid BIGINT,
    OUT end_vid BIGINT,
    OUT node BIGINT,
    OUT edge BIGINT,
    OUT cost FLOAT,
    OUT agg_cost FLOAT)

RETURNS SETOF RECORD AS
$BODY$
    SELECT *
    FROM _pgr_astar(_pgr_get_statement($1), $2::BIGINT[],  $3::BIGINT[], $4, $5, $6::FLOAT, $7::FLOAT) AS a;
$BODY$
LANGUAGE sql VOLATILE STRICT
COST 100
ROWS 1000;


-- COMMENTS

COMMENT ON FUNCTION pgr_astar(TEXT, BIGINT, BIGINT, BOOLEAN, INTEGER, FLOAT, FLOAT) IS 'pgr_astar(One to One)';
COMMENT ON FUNCTION pgr_astar(TEXT, BIGINT, ANYARRAY, BOOLEAN, INTEGER, FLOAT, FLOAT) IS 'pgr_astar(One to Many)';
COMMENT ON FUNCTION pgr_astar(TEXT, ANYARRAY, BIGINT, BOOLEAN, INTEGER, FLOAT, FLOAT) IS 'pgr_astar(Many to One)';
COMMENT ON FUNCTION pgr_astar(TEXT, ANYARRAY, ANYARRAY, BOOLEAN, INTEGER, FLOAT, FLOAT) IS 'pgr_astar(Many to Many)';
