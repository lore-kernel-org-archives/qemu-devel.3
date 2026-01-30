Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E6FD73EBA
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 04:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlfrf-00023M-KK; Thu, 29 Jan 2026 23:12:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vlfrd-0001zq-Ux
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 23:12:10 -0500
Received: from mail-westus3azon11011045.outbound.protection.outlook.com
 ([40.107.208.45] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>) id 1vlfrc-0003Oh-4v
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 23:12:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j0OnA8iWGXgfgSbhquiUQ4uYDBJ4ZeSum7bJs3rqEcEnFsmeEh695UIM/i1Q5eVFNzR7LsrugDApNmrArVi0rFsFhSfMfx7JPTnGTGZgO/yi/I4i5DO7IoujOHUyMCaOdRIqC4xzwt3WApH9xw+pOfNIu0L1eFJ2F988V0k3bYTY0t19jd5+JFhl89GYHBmWpedviwqO5XXkNpzkpdSQnWnyWyAaPxRUufq1AULdHnZg3bL2c2Mg/JFNKnPwLJurTVAxmt6QNGElqgiUurxJoKGNLWswjm4nQbwujsu/JmQspnFs9XHTUZfibNAir/o2dj+NQZIhKquibfsAothYzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mVelI0owxiPUdx5tFBGcQ683JAyyxDhxb9qoq21lM2Q=;
 b=ux+K+nZ1ParXdbvKsUdKi96WvWo6thV6M8JS/floLpwd3IIvF8lB/75AhGSMmwHHRxJGNEKtMFzSFf1fzxvirMT5CXx13KSzZdyTQ3Ry/gFomAMQZUhl0AjaUnS3fQOmlfyncrdq/lulc1UrnFucqHZFCPNE+6cyeDD97CVrnL4Qps4+ifNeCtIhWz/gKf2cwYjKTwipRVypIdiH89MXTY0o7V0UZfxVrZINs+nuksftcGgs315TRT5FE0670KMd0Ci+57XWO1dY2jYLanKncQZD32OLRzNNB6CM2EUmv+ZYRTy5814dzzshMFt5vR6qZF/b76j/BLA9WPvLNFSACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=shazbot.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mVelI0owxiPUdx5tFBGcQ683JAyyxDhxb9qoq21lM2Q=;
 b=eJHLvISrSOSVThFt1l0LurGeK99R9MIoQp6QXndCyZQSBRcIYc/Xi5Pf7JBMRMX4+HA8RT7p5SQLX/wgfVvJyv93EF0bLBi9D9Pf2zcCYGa+2Se9zvDGAp6TL5zjacuNSBKu1QAgKV3sh+0cOwmDn+TRD4j1mhpVNaXvViqtXFiMvIne00brvTq3Bpd+/qHHfIZJXg2k+80b1R/NZtW5WsvRv0RtE9wdVp/FNYiWO/rOokYiEwoOiYlj28vl9wlKIhkCq/30yalTVxYsC/CijcOjeW/BCOmfsAh8nCcdchgtD7T6Apvla3dp+LtMAjni3/vk8sBl1NCEv3VwBaCj9g==
Received: from DS7P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::15) by
 LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Fri, 30 Jan
 2026 04:07:01 +0000
Received: from DS1PEPF0001709B.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::10) by DS7P220CA0008.outlook.office365.com
 (2603:10b6:8:1ca::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Fri,
 30 Jan 2026 04:07:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS1PEPF0001709B.mail.protection.outlook.com (10.167.18.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 04:07:00 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 29 Jan
 2026 20:06:50 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 29 Jan 2026 20:06:49 -0800
Received: from localhost.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 29 Jan 2026 20:06:49 -0800
From: <ankita@nvidia.com>
To: <ankita@nvidia.com>, <vsethi@nvidia.com>, <jgg@nvidia.com>,
 <skolothumtho@nvidia.com>, <alex@shazbot.org>, <clg@redhat.com>
CC: <aniketa@nvidia.com>, <cjia@nvidia.com>, <kwankhede@nvidia.com>,
 <targupta@nvidia.com>, <zhiw@nvidia.com>, <mochs@nvidia.com>,
 <kjaju@nvidia.com>, <qemu-devel@nongnu.org>
Subject: [PATCH v1 0/2] hw/vfio: Enable hugepfnmap for non-power-of-2 device
 memory regions
Date: Fri, 30 Jan 2026 04:06:47 +0000
Message-ID: <20260130040649.42485-1-ankita@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709B:EE_|LV2PR12MB5871:EE_
X-MS-Office365-Filtering-Correlation-Id: 061e72ca-72ed-44c8-230e-08de5fb504f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5cxTbybg3k6SHFZnfBO55mdTwaZqZnRvOjmpO0AFElpfVRttI1mAUd86Hix5?=
 =?us-ascii?Q?V5eU50hSS2cuRuBtSgMZBLf2F7jaiiYDxwVH6CSYirfZaN/UQ6QBm0hHVcLk?=
 =?us-ascii?Q?FsTeMRlY/ORRjnmyC4yKQxY62PlvIVI2ZZUmxpvXRj/uiOwJexvJYlcE75Z5?=
 =?us-ascii?Q?sFxqNbRjqbGOoLhBkH/Os+4+7rE135GxdB3QpqwgUMySHdf/kW4Rc7zh1Ihf?=
 =?us-ascii?Q?r/RD1oYZQuA2LkMGjv9YsRU15PEYjVkL6DLA8oPmD4pHGVJ8PyKMbL3SvsXp?=
 =?us-ascii?Q?Qapa6wHUJKVDx7DYkibcE7rf/5jqBFgk7Ik1Im0S4P12bBf2zGcepbDO/MRS?=
 =?us-ascii?Q?aciu8sv9OkRdsBbZUP1dx06lOqpKGhgbLsBz1RZ2whrcvU6uDvO7KMd50Vgt?=
 =?us-ascii?Q?DtRrMrQRlwHouWSAvdYyAJnyzJGn4AJWXKP3KRXlHVvlyV3Jn5Jfi1YjChKU?=
 =?us-ascii?Q?XhquaEGyLikSvy0TM6NtUgufsDmypSWgnVZLLzVvy7SpInAHjGVSJPT5WBar?=
 =?us-ascii?Q?ELJ1U3u+4BagNKgz7Patoq87Thi6eePqq4cRJzM5qJtmmYTT/ZLxT/HcHVQk?=
 =?us-ascii?Q?yCesZkokQMUl53EiQT8siWdNXsY5lGoT+j23I1pzVYUqPUilB9dJ1SKmyVsP?=
 =?us-ascii?Q?1kM3C/u2Pulwk7RtHstbAaGxTS8UfgVyUwaLQ9ADtJb3vRjuTMso0sugSthu?=
 =?us-ascii?Q?QMHI/zsx+kIlNj3r6W9zSqJ5n/JEs9U8BJhLiZOoP1dI6blEWpWik3Jibirx?=
 =?us-ascii?Q?gs0HuVOpN6Gw95ZwCu27qa6kQ+E+NR7GRERoPtAZNApAVDeq8Q7KsD++Eze+?=
 =?us-ascii?Q?ym3J2UKvDz7XL2lRDepP8ZRefIamGi/DQS7lXIPZalZmLjRLl7j2zgPGs++g?=
 =?us-ascii?Q?8a1+1VcsHbvfccVcsYgyGEaIPXAM8QkZtnsV+UfMNAGgVYr9cvYuKgyREjbU?=
 =?us-ascii?Q?WRjzNMKJJmjaEHML2Pe8Xgi9TOc3/h/raKdnZSSY4CKu0e4G7nwTPBWmVpdA?=
 =?us-ascii?Q?cIS6xglqwrH25rEwJVfBV/3+hOMVgTZAqlXbmnS8X8ieXY+NOYO2y8psVR/2?=
 =?us-ascii?Q?vPGEm4T80PAHiihin8o4oJEEtqYGhYnmemkJxI4FaJ5R2nhnOlqQaj8XfOnd?=
 =?us-ascii?Q?uF0v4iDSnP/X8ZD5wzwSStYCA13OYYzaZv3ernFKYpFzLWnLqY4xrQUHoP5B?=
 =?us-ascii?Q?8eV1GOkHL7PRJcH2Q0B/VNC+vP33upZz9oSJ8qZ5bSYVk0hHpXSnxyfQ4rQr?=
 =?us-ascii?Q?VWNCG/1qaPBAHifFxW+y4eOpGZnFIoecr03mnF2+D8iKC5NnDYUUOG5Y7lAX?=
 =?us-ascii?Q?g2UertXAcESZqIFIh+rtJ14QnRTXN+1+ZRA6x9zmVryaImC45+g2stH3oITN?=
 =?us-ascii?Q?7m/+wQE7bM/GVQ9avk8WdzW5ajLpigMQDCGg5/jwQ6A/Vo6MI2vwrUh1YgWJ?=
 =?us-ascii?Q?0r/IZPaLkCFfPIZWGlEMJWn2yzJeq1ewTAO/aQraERlHU1fnJwqQbt70fmm3?=
 =?us-ascii?Q?y2+mSL3ZjA/u/qOf0z3lmzu2f4VXQ7nlllvKqNPOt4NOp8KxkL8jvc96VCXQ?=
 =?us-ascii?Q?GP03s4Ocj7Vtjr0WkEJoGWaibccBsHgVK0kKs+x7vY/5K9occQrfTlTtAwUq?=
 =?us-ascii?Q?PyBW8BnNeJuouLB71vHa/37DvC4K4wRR4urEvHpIrVVN1cPJ07JP2MDuP95L?=
 =?us-ascii?Q?Syh0ZA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jWT8Mmf0dVPOrCBW802i7xSJIGR9CQlgTZ3ia5iTHHCb0hKjxedg5PJXPyIOdgfs2J0zilcxgdWqmjIE9gfG6MH3AiusARb4spHR7kwQezO8jLU9djj9FKMBIhb8mwLClHVrAlp/T1Fvceg8bjHjEOQdvhAXW0HWlGSx36Y4WmcIQZ+xQLzKomva8M424Zw2N9gimtl2GodcdQ0rJJzFJBcioYMZkNL5aHGwUxf7012s7SPqbZ45HrT2eA6ptRfZvVcHCfqlVmDTCnYgDM0liYkF/si/N6p8TIdCxtHXa3rFmSS2U3dHLPXk7A8s5H1UdITd1W/wP3mS5PPjV5xywomRChAVBXAvnpZfz6HFOO6v2GpkV96Rvyqijr54TeGH4BG8Oj5uLVQTN1maQlFtW5JfzcMGLvKStjTJCMLW/qWTAuZ2hnUzSxvmiv7BsYXV
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 04:07:00.8854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 061e72ca-72ed-44c8-230e-08de5fb504f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
Received-SPF: permerror client-ip=40.107.208.45;
 envelope-from=ankita@nvidia.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Patch 2: Change the alignment strategy from per-sparse-region to
         whole-region alignment using pow2ceil(region->size). Create
         a single aligned base mapping for the entire region, then
         overlay sparse areas with MAP_FIXED. Gaps between sparse
         regions are explicitly unmapped.

Ankit Agrawal (2):
  hw/vfio: sort and validate sparse mmap regions by offset
  hw/vfio: align mmap to power-of-2 of region size for hugepfnmap

 hw/vfio/region.c | 126 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 98 insertions(+), 28 deletions(-)

-- 
2.34.1


