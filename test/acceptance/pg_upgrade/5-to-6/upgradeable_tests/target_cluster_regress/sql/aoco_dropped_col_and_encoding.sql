-- Copyright (c) 2017-2023 VMware, Inc. or its affiliates
-- SPDX-License-Identifier: Apache-2.0

-- Test to ensure that AOCO tables with a dropped column that has a non-default ENCODING can be COPY'd/ANALYZE'd after upgrade.

COPY aoco_dropped_col_and_encoding (a,c) TO '/dev/null';

COPY (SELECT a,c FROM aoco_dropped_col_and_encoding) TO '/dev/null';

COPY aoco_dropped_col_and_encoding_partitioned (a,c) TO '/dev/null';

COPY (SELECT a,c FROM aoco_dropped_col_and_encoding_partitioned) TO '/dev/null';

COPY aoco_dropped_col_and_encoding (a, c) FROM PROGRAM 'for i in `seq 1 3`; do echo $i,$i; done' DELIMITER ',';

COPY aoco_dropped_col_and_encoding_partitioned (a, c) FROM PROGRAM 'for i in `seq 1 3`; do echo $i,$i; done' DELIMITER ',';

ANALYZE aoco_dropped_col_and_encoding;

ANALYZE aoco_dropped_col_and_encoding_partitioned;
