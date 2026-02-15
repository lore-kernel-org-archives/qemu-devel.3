Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CADCEF586D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Feb 2026 08:56:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrXub-00024L-A9; Sun, 15 Feb 2026 03:55:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuK-0001yK-Pt
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:19 -0500
Received: from mail-northcentralusazon11010043.outbound.protection.outlook.com
 ([52.101.193.43] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vrXuI-0003Ks-Au
 for qemu-devel@nongnu.org; Sun, 15 Feb 2026 03:55:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tyVTHGgTfJXCmliHLh6PuaYEsjzAUfURXAdSeaF7otDdvjskblR/RTN45xmdLcCt2Z5oa4J0eafdw6D9zRFJut8FFx4wDays20LY0577urngvl8hkVwjvX1sIJr1uuCgLHH1zcai/zbcpmYExHDJwRUvmcLSuZVBVAUEKYWl1Gtd8r4gtNL36YHFSC/Be3hlurb0JwrCzil3w27HGVF00a8UP2Fw1eFUfArsVGfKsK3/NZaREKuxxEra1KeqjwkoMBdU0bSUAG5lfsGHVX8Pan559q/KthozD4jWAffwe0evmUwDTLR0g5KZw9i18WzE4xDV2HvgYgnB8Gi3GXYDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a1G65xMtL0z9mCjZOc5eb5n62NydXNTGMaX8RkF3oQM=;
 b=ZEvxSb1ryY2I7s+r1a09esq/oMMRMof6DqREgiAqSkmmYfKuz22l/LzYmH1vNO2sF0tzelDjg+kcBH+vrmEXvWkUgtqOIbUkKFLf7RO2005qCBOkPkH0e9eSl95GhLUr3Ez1JZgnnlTNIeXY9HfXh9HusK/t+p3QiYJd1Jn1omUDSbb582oGK0kr0S+xXScrQyEhSCaFdHg60ipBFKoV0ZNtE8LsohLfBg73NP9tW4J+rGHNsP0YxrjFVRtMe92u65IAK+Td4MeWaWhUY5s0lS9Bvzyad2bY/Gn/mX57gj+8AUZoGVjBiQ2YZgzS82th7H28mpcjR2Coaw6Ekcw9Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a1G65xMtL0z9mCjZOc5eb5n62NydXNTGMaX8RkF3oQM=;
 b=jD99eldlHHcLKgzKhqPEg9gGvDy+U4TsOKYO85JyuMPMQIeAJ7o0O7vbfmLcEQenLDb7AvG3IyMubiLXv3xkRENx4Qk5xk3GGGozVRLNCDaKWdYx3Md32yyP4HoNisk2dKljKn3e9PhYjtWvn0c3cBNehyLaXsTcqycxsz0bT3UBeGukxm5hmgQQGwn9RIElf1BrWU5aKCSJSqTA+2FnBJIeRZDaNHeE++60Og56Kx9FDhTzzTsf4pu4yB7HAn8YMK4rNd1O0bAD17yZ8AScfILEvIet59NTV8sWlTQzWAO7rM2tlr3DGQEiduVpbelHXD+I0iIovhN/h7YoXeWxNQ==
Received: from BYAPR21CA0026.namprd21.prod.outlook.com (2603:10b6:a03:114::36)
 by SJ1PR12MB6220.namprd12.prod.outlook.com (2603:10b6:a03:455::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.15; Sun, 15 Feb
 2026 08:50:00 +0000
Received: from MWH0EPF000C6185.namprd02.prod.outlook.com
 (2603:10b6:a03:114:cafe::62) by BYAPR21CA0026.outlook.office365.com
 (2603:10b6:a03:114::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.10 via Frontend Transport; Sun,
 15 Feb 2026 08:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6185.mail.protection.outlook.com (10.167.249.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sun, 15 Feb 2026 08:50:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:50 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 15 Feb
 2026 00:49:50 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 15 Feb 2026 00:49:50 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v3 0/3] hw/vfio: Enable hugepfnmap for non-power-of-2 device
 memory regions
Date: Sun, 15 Feb 2026 08:49:47 +0000
Message-ID: <20260215084950.4657-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6185:EE_|SJ1PR12MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 2983fc76-4156-4949-e0bf-08de6c6f33f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RC/585vrArbvxS5ckw3q5/BEGl5KYpZgyKLQcGOLNo7LPCeaDThss61/1bCc?=
 =?us-ascii?Q?i09z9rotUCgVZmuJ5Y6dYFvKcEhbfbGcN8TTbPB0pcDMoyMH99lytx9JwE7N?=
 =?us-ascii?Q?eT28Zl4gbh+86rJuSgyBx75Wrgw97+j4iaoz6L/Vk1OiX/hnkIPSdAdnJpCM?=
 =?us-ascii?Q?unE7pWecyI/YOYWqRHy/iJL0VAoD8kgitz8Jk77kz1mcjvNoXr8etyr6navZ?=
 =?us-ascii?Q?O+tldD+SYYffI9R8xLQN9VUKUjgYVMM1p6fcs2vW4nfMDO+eYm7t0UBp9Rpx?=
 =?us-ascii?Q?Y+nECUf0bTu8J3BjPYLwTCa/lt8hpsQeD+WgiL+cbrnjNsG1yde6gQF5kWKa?=
 =?us-ascii?Q?wpZjO3/W2LAe9Bkt0T4vafth+x9wDfb1Cr1na6Ug6hNm4+IkTiN/aJeJ0QAa?=
 =?us-ascii?Q?8Vna9yXnpYYgSjhGKbOGSPzFa1zku7mEb59dOumdcdpdfgk/QQJhi3QJgc9P?=
 =?us-ascii?Q?2Ky2h7XrEUjrdp9X9dvj8iRraMdPLu7M32uHrgf3ptH6DdVfgje6bLXpF7ji?=
 =?us-ascii?Q?lmzQpVvEmfvxOH7zdD5ZeSeLpwHu1PUM7uTdayQbBVuCx+3JuKucLLbKv0eo?=
 =?us-ascii?Q?Y5w+aOnTJlsoE3UoepzzWZJu2n1feiz3t1vQYuZg21HhfmnYvr2ttkq+kqgr?=
 =?us-ascii?Q?hXTdzcmBBsY7eEfVVusVMujATwWGciXudI9v2HlHh0oQMue8GH/XD1VY0iPD?=
 =?us-ascii?Q?/cshvL13REY99u9VBh0xzoB0zCQ8irDIjrdDOufYkJTfaFsQ8KXN+cQrIeV7?=
 =?us-ascii?Q?XH1RvMoOUxniRBHZJzAJbvW+Aj8VOkjEqTtDrb33NuQ+WIZz0EZSzEH4HZIA?=
 =?us-ascii?Q?VW/AYnyB7E3Yl+4aMfqC6pl6P/3TXnCuNyuAy2vML4sVlKFBt78a0i3MNpaN?=
 =?us-ascii?Q?YU3Mfjz+GvfJ7Mz7v+vvdQqHGelZN8IBthJj7LDdcNvNGqo29hj3z+H/QK/v?=
 =?us-ascii?Q?IzHqcLDja/zpLo/xe9MdTlY4CrEfThNNybC9oU37x16sTxCrQoXdT7rXCyHR?=
 =?us-ascii?Q?wk1Tk3PWuHRjdOqvBNqC8nFzdkvdeIYjCSVbtBN8MMqg0Ezu5D1zKE9cZdYE?=
 =?us-ascii?Q?V08CZRd02ip4IMXksoWc16DSCCob3yir6s7cB/hxPo0Z8CyUvJmgFgY60FRb?=
 =?us-ascii?Q?tDjnQ8G2ALLO5Ts1OcKm5WXSjXMOa0xgS5UURPnDUSeK3T+fjqyV4PLo/hgb?=
 =?us-ascii?Q?xCmVXFDPBF0E8VwVbFzkuZ6V9roLsyZSbT6leZ9bRFMK1uTpNCokSHgpmDPI?=
 =?us-ascii?Q?LlMa6qj7sC99OOikqFkXsgdgQqu//fX0M164Ri66sSLKku83SRtYw7SmfbIt?=
 =?us-ascii?Q?vMydGuBeFlo97CoB43Fq2u6RpfrZbLeU5m4OjNMrNE8x5LM5Y9YRfWXQlIFt?=
 =?us-ascii?Q?aLf4UxBx9dMue6jboCjbWuy93gwh/De6/VTSTOrEyNZg/rDDXkNXfewwzB0O?=
 =?us-ascii?Q?60qUaTwDUyRWNadTeV0e5wOJ5Nakejn7GHJz5CUcsN9QiO9Ri/9HO4iD4BnF?=
 =?us-ascii?Q?pHMNZwM9wuBgEuFXh3RTOspGkLxKNr3P6/RQG1TwMeEJKAKRDXwd+a+xxceR?=
 =?us-ascii?Q?GKnWB+h1eTl6Em+/Y16QSuksVVktB295D4fC/BRMgzoTAz0x6ijLFaLMoeXD?=
 =?us-ascii?Q?v1EgyhVW/rEPyYUkIrhspChzxVRJ3tAQSqMqnG3zEJRKa67vHdeRXetIZh4Z?=
 =?us-ascii?Q?z32phg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vdi4nxcYFR0QlXjledo7l98vtJ900GQ1NDn/p2YjUrBBWzvRBX3QyM+yAmBHQVZyr5jIlrY9PrNSpHYIcASs4EIZtxkdmxK40GCA341H6ZknwBondPstZwyuASD/q5y1YHdPZGZg7zF6gDhJ+TJW2h6EMvVnqAvIeXds06CC7GdDUUOJKibEWLt156Gjv7/wNF4UV6w4hUksdOIUavUghXA5E4Zr7scB9JDEmsLOGrHp3oMpSItejkY0EIVwvqIZ4VwLWJjETQFRddxXuS+wVzcsqp9yOI4xjKD9Y7hj9lAHF+OsS01Ei3qQnfP1HxWdCYipZvsRGqXAH48M3L/Z3Rp0pL7/yQZFcpFY03+l2b8hTaGYIlq+M55gf3RAnGJW8OVhxTDHOo+lTGY0+/RrwOPwCeCcBddJcJRYPe++B+UevR9egxtXNGxAGJTb0Uwh
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2026 08:50:00.0844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2983fc76-4156-4949-e0bf-08de6c6f33f9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6185.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6220
Received-SPF: permerror client-ip=52.101.193.43;
 envelope-from=ankita@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Ankit Agrawal <ankita@nvidia.com>

This series enables hugepfnmap support in QEMU for VFIO device memory
regions that have non-power-of-2 sizes. This specifically addresses the
needs of Grace-based systems (GB200) where device memory is exposed
as a BAR.

## Problem

On Grace-based systems, device memory regions can have sizes like
0x2F00F00000 (not power-of-2). The current QEMU VFIO mapping code
aligns each sparse mmap area independently using the trailing zeros
of its size (ctz64), which results in suboptimal alignment for the
overall VMA.

This prevents the kernel from using hugepfnmap that enables huge
page mappings for device memory. Without proper alignment, the
mapping falls back to PTE, significantly impacting performance
due to increased TLB pressure and page table overhead for large
memory regions.

## Solution

Patch 1: Sort sparse mmap regions by offset during setup and validate
         that they don't overlap. This ensures predictable mapping
         order and enables gap detection.

Patch 2: Change the alignment strategy from per-sparse-region to
         whole-region alignment using pow2ceil(region->size). Create
         a single aligned base mapping for the entire region, then
         overlay sparse areas with MAP_FIXED. Gaps between sparse
         regions are explicitly unmapped.

v3
* New patch 2/3 to add Error **param in vfio_region_setup (Cedric)

v2: https://lore.kernel.org/all/20260211030615.3202-1-ankita@nvidia.com/ [v2]
* Fixed the code returning early without trace (Shameer, Alex)

v1: https://lore.kernel.org/all/20260130040649.42485-1-ankita@nvidia.com/

Ankit Agrawal (3):
  hw/vfio: sort and validate sparse mmap regions by offset
  vfio: Add Error ** parameter to vfio_region_setup()
  hw/vfio: align mmap to power-of-2 of region size for hugepfnmap

 hw/vfio/display.c     |   2 +-
 hw/vfio/pci.c         |   3 +-
 hw/vfio/region.c      | 131 ++++++++++++++++++++++++++++++++----------
 hw/vfio/vfio-region.h |   2 +-
 4 files changed, 105 insertions(+), 33 deletions(-)

-- 
2.34.1


