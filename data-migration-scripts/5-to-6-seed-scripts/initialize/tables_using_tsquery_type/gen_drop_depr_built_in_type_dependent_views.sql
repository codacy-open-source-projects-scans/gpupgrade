-- Copyright (c) 2017-2023 VMware, Inc. or its affiliates
-- SPDX-License-Identifier: Apache-2.0

SELECT 'DROP VIEW IF EXISTS '|| full_view_name || ';'
FROM  __gpupgrade_tmp_generator.__temp_views_list ORDER BY view_order;
