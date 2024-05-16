-- Copyright (c) 2017-2023 VMware, Inc. or its affiliates
-- SPDX-License-Identifier: Apache-2.0

-- Test to ensure that AOCO tables with a dropped column that had a non-default ENCODING can be COPY'd after upgrade.

CREATE TABLE aoco_dropped_col_and_encoding(
    a int,
    b int ENCODING (compresstype=zlib,compresslevel=1),
    c int
) WITH (appendonly=true, orientation=column) DISTRIBUTED BY (a);

INSERT INTO aoco_dropped_col_and_encoding VALUES (1, 2, 3), (4, 5, 6), (7, 8, 9);

ALTER TABLE aoco_dropped_col_and_encoding DROP COLUMN b;

CREATE TABLE aoco_dropped_col_and_encoding_partitioned (
    a int,
    b int ENCODING (compresstype=zlib,compresslevel=1),
    c int
) WITH (appendonly=true, orientation=column) DISTRIBUTED BY (a)
PARTITION BY RANGE (c)
(
    PARTITION p1 START(1) END(4)
);

INSERT INTO aoco_dropped_col_and_encoding_partitioned VALUES (1,1,1), (2, 2, 2), (3, 3, 3);

ALTER TABLE aoco_dropped_col_and_encoding_partitioned DROP COLUMN b;
