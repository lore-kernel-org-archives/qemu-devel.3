Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5EB3EDF152
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Feb 2026 10:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqqdk-000847-UU; Fri, 13 Feb 2026 05:43:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdh-00083R-Nj; Fri, 13 Feb 2026 05:43:09 -0500
Received: from mail-westus2azlp170120002.outbound.protection.outlook.com
 ([2a01:111:f403:c007::2] helo=MW6PR02CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vqqdf-0006Nz-Ro; Fri, 13 Feb 2026 05:43:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SxZFMZvMcgnxJM7N3EirbUwmVYXKWCfdMFiRQvDUICel14iSvlk/m/okaq6dshIfSq5jTCgE4T3o/WA49kIFYjaMm59P0A3q+GvZmTLGM/1B2h7BbR+wBbBIVbyHRjoaSLMcdyIjYSWbPazSiNco69452s9ZjrMn7R/fpMlRuj3H8aa0U+gS6Izo/GGu/OAT2Eo0iXqc2mKaSzUNFMEry/gfJ0cVr0ALgI+34fsI+/Dzt3aVNORFuVvHfF0NyhoGJF/1yEqOKUpKD1rCaSa2J1p1P1Z1MbJwT9ignW3aGfr3mEq2YtziH4zPyGMOoR81q1pjPIa3J2A+eZzylddV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=77J4DTsyZSKaeHSBA5b+/gEJknnctOOIOkUAzMsbuHQ=;
 b=ESKSPHq5PMX0uMhgVXZIxpl7E7cTp9OFkGOpMnDXFqj/SUnf7W9KcyTHnRV5gp29WQKYT3x88o2tB+dl75mov16+POpUKRndjSTUIXD5WvyB0ph2d+rQBQo7UqU+lLKoWAx+EbDgE9s1DqBYYCGNlIgDwr+RmnPO1oQwYlJffMc0828QAa2Nn8OTxk1XMxHU0wSHvNiwsRu+hHeUkgZI6d9itnPaFIY4QpSwceofgV1p9E8xrYOyp+INAKrfXnjsR9GqiJtTWsIhdH+TpviVqMCTNP0s7ECUJgpL+WvJ3OlFgIGiXltNEpg5ojnQ3Oss5od54aoeoZJaI8MAAxrHeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=77J4DTsyZSKaeHSBA5b+/gEJknnctOOIOkUAzMsbuHQ=;
 b=RWDk/nwDYVXEwE9O+why4OGmGoP9WqiVwDrEnhffOU5LyuKOVttfy+ymV90uikaivcjh+V0Hlz716Im2xcKhzIzub21h6OJh8wpNwiFMwF+SSw0ii0i6YLRWELvsl/nbWeJRK5emCDxQ24Y2uuW71lAEXMEQ5N5gbMF1FxFSWtbp9EbhEfxLMWwrm31FL+eDLcVS70Pm1dx7d0Ww9Ah+DRfq3FCORlHJe2esjzZ+lnNDSc921C3FbqKsKmhtARUSK8mJnYSpfT51mnPjrZEfUAegB+8gMAAnmf5ij3UhVoxZDN594k1qrvgcbl+EVPZFVcE0YizRd8LChbv5JQ8gJw==
Received: from CH0PR03CA0332.namprd03.prod.outlook.com (2603:10b6:610:11a::9)
 by LV8PR12MB9270.namprd12.prod.outlook.com (2603:10b6:408:205::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.13; Fri, 13 Feb
 2026 10:43:01 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:11a:cafe::6) by CH0PR03CA0332.outlook.office365.com
 (2603:10b6:610:11a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.13 via Frontend Transport; Fri,
 13 Feb 2026 10:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Fri, 13 Feb 2026 10:43:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:42:47 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Feb
 2026 02:42:44 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
 <jan@nvidia.com>, <jgg@nvidia.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 0/5] vEVENTQ support for accelerated SMMUv3 devices
Date: Fri, 13 Feb 2026 10:39:37 +0000
Message-ID: <20260213103942.142823-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|LV8PR12MB9270:EE_
X-MS-Office365-Filtering-Correlation-Id: 804f8f25-9d98-4303-1ba4-08de6aeca8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q05GaPAVZ7ZGIcNcBy9bNNvoVTsc3NbYXbaKMr/gF+Bi74FC3NXMUtIS5LVo?=
 =?us-ascii?Q?QZXmhSzoZ3Ka68IwOvWxfwKvLQo4Oxm4NcdT7zs50Xec/fXbDKiZtcq1E5UI?=
 =?us-ascii?Q?mv0G/1td7ecEMxKhfuSOb8pIp3umoQxnzg+y4bhBSC1KPz8yfNYWm5etK1oR?=
 =?us-ascii?Q?9IwIQzvjK5DLzF+QsycsRkZwtYFQ0YppbaDK3R0zJEyq1XPtWkFsw1oJKG0H?=
 =?us-ascii?Q?YI/IxkvMuO5ah9sTEnO98B0YHTJOXwChQMwXHtnA9zna7RqgrX9cOSgtitMC?=
 =?us-ascii?Q?HVkCpKMbzCrFyvFxJ7hx5EkRApogoY0FgPdJMJa6GV8DLHxbMERE6AEYrr1K?=
 =?us-ascii?Q?P1+Srq9Y2mxR33zmJP2JXebRXJmkSVOVT5Lj641iVgfEJQYeSXSsx5TpdZ4Q?=
 =?us-ascii?Q?KpQwy+K5bjUKAFYT8gLBaz2DbRcxsIV9FXHzXX13dDxJspCF+gaWFUWylaeU?=
 =?us-ascii?Q?STNUt/yTN2/892S+AWYVPqe7jfGncmNIToIjW4Gi2e2wOKydbQ2PPoz+Pxjp?=
 =?us-ascii?Q?tB+OSNu9hq/I+zMp853E6ZJxZa/OW1l5ClhskauHOKxAAeKWmmTYUA/hOuiF?=
 =?us-ascii?Q?k/ZUeMummFzVH5Lsb0+Q5WWb7vSDRLhqplzXlQ8fcOv72a6her2S8SN9tElu?=
 =?us-ascii?Q?j9uq13XtcXa2gTpMJ51yGCS4GWtzD1Uk5PyEcMm7oxBjsh6VZCrylHG5Ldoy?=
 =?us-ascii?Q?94uKryDkD9LQvmfZ3ZnEwjVCVPwIIUXAKG4+MOOZfEquS2bt/WogUJYcKsLo?=
 =?us-ascii?Q?bXIJha2GpOQL1cbjHnQOYH1w2Y50hU2QNVK0yiyA1+cGa7eiokDz4BAVAkQy?=
 =?us-ascii?Q?zDOaQAAzdJGhBmg1TOOd4YLiKNOG2gzfbM79ULnGpOObbUwFd8R2Z1skav7e?=
 =?us-ascii?Q?cfUQcVeUn/RpT4kd8G5ErbUqWo9Zvl+YbEJTNQeV5e171dXTHSERy1JwgWBP?=
 =?us-ascii?Q?vRnG5p117l4wycHnScsFvx2Q1tIzz1irxChQRasTZm+xAG2TXuO6tmxcJ3L+?=
 =?us-ascii?Q?6I1CRHJj+atCjHHHdi14ZqmA/1hw1el1RLxkq2fkqatyjTuEorIMhxKeX9zs?=
 =?us-ascii?Q?3GmVisScu1fz8F+s0TaOVT6JDimQQqdqJfbdh5ccVHj24SHJsjgSN/9Oivq4?=
 =?us-ascii?Q?LFMuFyjAgjfwaB7QTezbYQndr86az711QZhdERnehJmhZEIpVOC4kkc8M6hE?=
 =?us-ascii?Q?vafrQmsN+eejGZ1F4Z1Gy2zdW8ZUym+IO8uTIehyDOTMhpyr8XNopWbWGNfG?=
 =?us-ascii?Q?8WcWoPcSZpPMjvQrmaC1ZCT3kQf8tQRpt7xWVPfTSVvXXluSfj9vW/+jQ2xS?=
 =?us-ascii?Q?sxPRGvE4Z3zyYRbhndep1vfNlFP6/NP+OFVIeW252f8m79HtDVPGSZ43PR0I?=
 =?us-ascii?Q?DU+c/32Wjgte3OyvFDfi9flAECGn9kkf+Ug+WnlJR+ddSFcRuuOr1cwEs/SM?=
 =?us-ascii?Q?0wwT4YHSFO7EuzImraDxyOQjKH1Q+PVggxY7+HdX67fpoSrztOyqpPvWkrqL?=
 =?us-ascii?Q?nsi9m+0GVMWPUL2V2goxXh/BdCiV38AwqM05ptLe21CmaTZrw557k8m8nDW5?=
 =?us-ascii?Q?8clp4rW7cvqXI51gTvze0rBVrxAb9EFQ7LZ53fMq64nXiPU+H+IeFGm/idHA?=
 =?us-ascii?Q?/HfYxufRj/KRBmm9UQCPvHBHm37S74z9Q3zDHxLFPDlW0dNmOcSmYRdk65gB?=
 =?us-ascii?Q?KyVxOQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8RD1KjuYLuwurjuvNB5fEgzY2DOzawddWiByRDsm/IwW6Oh5HWRPfIVDT76qDNkwpbS6aNS0kyfRYDs1jJmgrrDIJOKmmXKBfUydEzX1J2u05bQ7xgkxaM95yhbb4iUgfDEgOPE9t/r/ZsKSf426xZL7kUXjn3QjVajOvgxuEmKNo02QFYyuf3/Fr8FlSYNtapCooaBLjw2c0C9TVE+uYMS1OeE52uuSH+VJ5JCJ/lAoIamdJLODAwgcSH/MHAWdYMMu0GAkR5P6/EjUdrR9sCij+4UNdjXrIOIJjS86HFJq/l1EZSlXCGszah/JC2T9fHDW1jyvDwZnxW4oRjvSCUbRcDvovoP77EkcPBirx60Md8HNxOXfRZG1oy2aHtQ3gGZKqPOjoNv875VMTjCPUvMSQRzyYRXR0jAlzzO/a/pV0yLDrBoD+H+5k7ZrErVm
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2026 10:43:01.1468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 804f8f25-9d98-4303-1ba4-08de6aeca8fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9270
Received-SPF: permerror client-ip=2a01:111:f403:c007::2;
 envelope-from=skolothumtho@nvidia.com;
 helo=MW6PR02CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Hi,

Changes from v5:
 https://lore.kernel.org/qemu-devel/20260211083415.133534-1-skolothumtho@nvidia.com/
 
 -Addressed feedback and picked up tags. Thanks!
 -Decoupled alloc_veventq on smmuv3_cmdq_consume() (patch  #3)
 -Updated error messages (patch #5)

Please take a look and let me know.

Thanks,
Shameer

---
Background(From v2):

When accel=on is enabled for an SMMUv3 instance, the host hardware SMMUv3
may generate Stage-1 (S1) event notifications that are intended for the
vIOMMU instance in userspace.

This series adds QEMU support for receiving such host events through the
vEVENTQ interface and propagating them to the guest. The implementation
uses the vEVENTQ support provided by the IOMMUFD subsystem in the kernel.

I have tested this on a Grace platform using some hacks to generate
events. Further testing and feedback are welcome.
---

Nicolin Chen (2):
  backends/iommufd: Introduce iommufd_backend_alloc_veventq
  hw/arm/smmuv3-accel: Allocate vEVENTQ for accelerated SMMUv3 devices

Shameer Kolothum (3):
  hw/arm/smmuv3-accel: Add viommu free helper
  hw/arm/smmuv3: Introduce a helper function for event propagation
  hw/arm/smmuv3-accel: Read and propagate host vIOMMU events

 backends/iommufd.c       |  31 +++++++++
 backends/trace-events    |   1 +
 hw/arm/smmuv3-accel.c    | 146 ++++++++++++++++++++++++++++++++++++---
 hw/arm/smmuv3-accel.h    |   8 +++
 hw/arm/smmuv3-internal.h |   4 ++
 hw/arm/smmuv3.c          |  38 ++++++----
 hw/arm/trace-events      |   2 +-
 include/system/iommufd.h |  12 ++++
 8 files changed, 220 insertions(+), 22 deletions(-)

-- 
2.43.0


