Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EBDBE909BA
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 15:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsN7D-0007QC-Mz; Tue, 17 Feb 2026 10:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN7B-0007Pb-Rb
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:35:53 -0500
Received: from mail-westus3azon11011013.outbound.protection.outlook.com
 ([40.107.208.13] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vsN76-0000p3-G5
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 10:35:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hi5m37fUC+Bko6qYc3zEq/QMyRM37EOhmwx5tWjefPbmKiollf9f0t+4miF2NKNJLeEaPSl6FdIm3F5XC+99T3DjIBRAt9JkwMqYZulvgZ5/leeAFDloHxu/J1zD86QvQTxpO4mmKGPQ8m9sBLe2kQ6Zv8SNYg0eGi4EFEe4cG3/oBwXi5CLoJm8fA0woItKA0KSOQqJzq4eoHc2mkbulqOl4v4JATlBC5BmHMOG6jtg30KmwXWPw611S9ZJXc2kl4oC16alcyNsPgceI0aDsRi0gmNnJGAc1pJh3d7WM/aYrD/+tfUChpltuCMXa1S6IZ7z5LAzqvD/2Gh99qPjug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgvAXyJ+aJR8OYsLOtl912kEYb15h1DIPJuMl5F9ZyA=;
 b=BCi2zmJPz2hKzqr8yUamMITtL3KVdRtxtkSADY5Wisjh/M+tmLTCgFk8SnyHlL/cSDq0Cni6GoH23N1s7ehJIydBXi78rezq54sRlQMjgihQvpXybV+U8pbX9hszt/5jSeUcxcdF5gFHzFeGRfu0Lqx+OWqYuHI9qI5Rw8Pt4uUiVdJPLo9dNRuybiIdOpDp89Bx5PcKBLxRojg6tj7fbPALwAmDENkxhUBZaU7+AQm1vE3AnCuX1RGuYQ3MupmqoC0w6I0rCbkRv6H2HTExlAhfSpnf/iegvpWfu7WegJPg87InJmm7KbgBhC7Eg6+sY0F3CnhhjefAdFSvK6/3cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgvAXyJ+aJR8OYsLOtl912kEYb15h1DIPJuMl5F9ZyA=;
 b=WBdpOtzFBIa+pZ+ZvmOHGpHemBV733eNTihZ+ZuVlVKfC+LL9rZbvtvIwiyajakPiGC2DBUjXlCMG4GREkoyS6k2L5FY68aM7luNTUvbw0HZgA9Jz16tkUi/9JJhTtA2D5PL8y46Ep6zoaoeHF0y8txJ92/eirvmGUc+Eh3gZexABtUCYDBh3hGyH3+I7H5JNrd3gjUPiNGcjGwdHiv9lbHmPtAin4NC5PfpVsZslIgfwiyJDenR35s+fHjCKpVb51ti/d0v2vqO4W+uZSN3ugFQOD/Fi9GJ9fCv/UDPf7n4MBUybOrYLiJ0II3KqBQhr0SzTaJs8fNA0ToVJORpig==
Received: from BN9PR03CA0794.namprd03.prod.outlook.com (2603:10b6:408:13f::19)
 by IA1PR12MB9740.namprd12.prod.outlook.com (2603:10b6:208:465::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 15:30:40 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:13f:cafe::f4) by BN9PR03CA0794.outlook.office365.com
 (2603:10b6:408:13f::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 15:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.0 via Frontend Transport; Tue, 17 Feb 2026 15:30:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:11 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 07:30:11 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 07:30:11 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v4 0/3] hw/vfio: Enable hugepfnmap for non-power-of-2 device
 memory regions
Date: Tue, 17 Feb 2026 15:30:07 +0000
Message-ID: <20260217153010.408739-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|IA1PR12MB9740:EE_
X-MS-Office365-Filtering-Correlation-Id: 3675c30f-631c-436c-865f-08de6e398195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCgftY25iGyae2c3EGR+jLOnnu5XsCqkkMWoG5Y1f7c4djnyUHKF4Uw+/Lb1?=
 =?us-ascii?Q?IG6k7DSv8EZpFnkKKPwtPPRCNhbp6gSO6QJQj3yVGJmk5aDL2s5sqDMQYPzs?=
 =?us-ascii?Q?rkMRW7SqnwieCxF/FlmiUt1HaCY+pw7GArR9FeK4xMXwmt/fG6ERkyYiK7Zt?=
 =?us-ascii?Q?gfK7Smx9pzJ+3wJ+q6KTIG11nOZvFFBUY5bRdYYfR7iU6ed3kX5/DVZGNKYs?=
 =?us-ascii?Q?xoqF7d3tiG07Jru5qhSaaXklRxKb9kghz9mgSER7z4AJLrKrXjAjteiuOhad?=
 =?us-ascii?Q?LZwgQXxGzzrVuhPlHT3q6Fub5cqBw8XJ+nvz8za3+feX4fs2FkeyuVHKedFF?=
 =?us-ascii?Q?iDwEOsGm7GRk2EsdtH8zIOKyrTMYq6yWRap9L3W/4y1c7FhQfVegPzn8e1xf?=
 =?us-ascii?Q?mtxSmQq1DwNVo6Fmp1Q7ZVWdOq3XH3nDEYFN2MMb5CYeWOQQ43BzCwuOocqf?=
 =?us-ascii?Q?HCGQ8Gw7zZT2xzwiIsfY9+wLzp1PlF4TVrdgYIauRc8ydpwtpZaGZVD1jrxU?=
 =?us-ascii?Q?qhgHTWwCi5B51DfGJh0PwXgnEtFKkcswwpZERjMmMvJdfRLlCsAsUQXNuAub?=
 =?us-ascii?Q?oFlXoW2tjyd3ZCh29ZjqSXIcZg7QEG5nRTk2m/FC7Ka6CCeuNdYCqfxPi4CY?=
 =?us-ascii?Q?AvUC4L8ciMA95AUbFlydH4zyEm+PtjVZ1jI9VOMYvTk92rMqSrbw9pOiiquL?=
 =?us-ascii?Q?7EsXVDMeLTtkPsl2DdNwgCIbX0rUsGHLCsXH5g+nXG+jHyLsRLkx9IigZ3Ic?=
 =?us-ascii?Q?eVdK7fgbkbtbx/LtryhioFZePikvgs7sseJbM7++/a/mNqyXShKi0/CAsLSk?=
 =?us-ascii?Q?taIpag+jP/m8slDsym25GcoHKD40TK5m7mmfef5XmysaKUZTDwKcy26kFpOv?=
 =?us-ascii?Q?6khNLKSFoANgxb64doH2LMgXzuyKVxIapOp8SPaTexe8sZHX+ImUP5FO2cjD?=
 =?us-ascii?Q?VoL5CoS4U84MjXKnX1CDUikdeoweC1QMqR/xnKuzeVpL9aLZGS5p02pvqxdl?=
 =?us-ascii?Q?hDW7E94fh9jENNsFQ5BWjWkxCc7Gwu2NNbuBNF2AwbErglnuMtDLPDFpR8MP?=
 =?us-ascii?Q?hueo48394iKTu4sImC7ulbXhu5r17M5vFxl411XVr1AqVpK8u3OUfvL/8ENK?=
 =?us-ascii?Q?Uf+vL248AhlAiCgQB46sJEwCG3uYukDyfOqWX/7yaHQ557fTQUr0M5ztXPYr?=
 =?us-ascii?Q?LkYyLPRsqcjeqm0Znv71gezVd7gOyQi9yakk7djyDI9+Ox3+aQ01MjHdKik1?=
 =?us-ascii?Q?I4I+6ladjEKh/LxyMqhfrl+RYlgHzoYqh9nsv+acVxK0W5StN2OT80X1Wr5U?=
 =?us-ascii?Q?ijjfni6FEnNEGXpABfRuwEgExMtPtKzmDJt8J+coGRzZ6G0xxm7x9sFJ6A3G?=
 =?us-ascii?Q?p9qIOPzmuHyJsexdVrU5DSsuE2RQcVgTqrQ5RN7dwQL1OnOq3iz2Y1f70e42?=
 =?us-ascii?Q?R9turslf1dNw/tPlcL0qNvMmWOop0iqBNmbbEtT6C/LxiJNL7ahxwkvv3Wf/?=
 =?us-ascii?Q?KN+eQOh9dxWlx2SSinM2OIQyHE/SMFNYDrxvexYH7/9gK9SlfwxgiTVilf92?=
 =?us-ascii?Q?JmYjdoqfHXxbG7GCUCmmEJcXJCNcynTsUMG9yGfWdj4LNEdfN4xqm1YkQWPh?=
 =?us-ascii?Q?FjgoVq2k7lcnGHIgzJ5wwC/1E9ogjU6gCrA/wg3hdsKXcEWPwmQtItgTsxro?=
 =?us-ascii?Q?BTbuxw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PONoplbE+DEs2O4rGjElBBCjifEiba3uCH5IGpCQ5emOR3Xq7gnedS+4DMuc2yPwXPM734eZsxcXwIN/ZYCyh2zFBuVIzh3s7dzydKCMYJLJEjTvGmvbpaEhxj7kefSK/sVUOoy5eAtZUHx+m/NyTR9UUU2JJDMWPTIVN5Lw4lPLY3cYdr1/0oRpHC9nDHhHaMb8E2EKZMDyT3qNR4U0/oTMNoE5CFToifxoWrwKCizuCTATpupRrU7VWxsNgGM+rT0iMm6IOoIrsHd6KoXBlien8efGh5ZfIG7/t8lzSvcrNtpbptBBORyaw4I0D3jd/Fmf1MyEWLFdkotewLEKZkUvd7KyE0iV6e8b1+AFsBBXfLXuKTRkrRD+KFVMWwiOcj/XbhUqotv7uMyD7uWn+E5mS5EWNMD59DDi0q7dWMKmkq3MdOotO8tSN8/xOFqn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 15:30:39.7505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3675c30f-631c-436c-865f-08de6e398195
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9740
Received-SPF: permerror client-ip=40.107.208.13;
 envelope-from=ankita@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Patch 2: Adds Error parameter to vfio_region_setup() for better error
         handling and reporting.

Patch 3: Change the alignment strategy from per-sparse-region to
         whole-region alignment using pow2ceil(region->size). Create
         a single aligned base mapping for the entire region, then
         overlay sparse areas with MAP_FIXED. Gaps between sparse
         regions are explicitly unmapped.

v4
* Replace lx with PRIx64 in the error in 1/3 (Cedric)
* Error** param for vfio_setup_region_sparse_mmaps in 2/3 (Cedric)
* Comment to notify that the mapping algorithm expect sorted offset.
  (Cedric)

v3: https://lore.kernel.org/all/20260215084950.4657-1-ankita@nvidia.com/
* New patch 2/3 to add Error **param in vfio_region_setup (Cedric)

v2: https://lore.kernel.org/all/20260211030615.3202-1-ankita@nvidia.com/
* Fixed the code returning early without trace (Shameer, Alex)

v1: https://lore.kernel.org/all/20260130040649.42485-1-ankita@nvidia.com/

Ankit Agrawal (3):
  hw/vfio: sort and validate sparse mmap regions by offset
  vfio: Add Error ** parameter to vfio_region_setup()
  hw/vfio: align mmap to power-of-2 of region size for hugepfnmap

 hw/vfio/display.c     |   6 +-
 hw/vfio/pci.c         |   3 +-
 hw/vfio/region.c      | 140 ++++++++++++++++++++++++++++++++----------
 hw/vfio/vfio-region.h |   2 +-
 4 files changed, 114 insertions(+), 37 deletions(-)

-- 
2.34.1


