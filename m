Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A703CCA470
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 18:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5pzc-0002Dn-Ew; Mon, 06 Oct 2025 14:31:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v5pzZ-0002DX-PO; Mon, 06 Oct 2025 14:31:25 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v5pzX-0003B8-KM; Mon, 06 Oct 2025 14:31:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ik12bln1dfHgwKmS9NZh6rlSSOQPkSroXwgxfXFIqIuo2bcEXXYieWHNlzhF/8F2RRmMIGDPnITcmMfM7dy/yKuldJFP/40gX5DERkWHy7aXeDVTYgq1kJOkEoA7HX6zGBgGGBT7BW9ioeql6eQUoWGcG57WNY652HRUrKEme0oxnj1b6ik4d/32stdkuYmU6GuKvk1/yy1uLP/mngd43HIOtFoZjDGtPMxU+YVJxhyK/zKcnS/zuSnHxZtQTJ3ZtLblA4zYHGlW6moRRVPdJXYncNwOzpN6iSYJB8Q2+H2NeZ+tkoXJIZRd/cE+xLxbH5zj39sxRQTNMrLhs1KP/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6pWpqTH6QPxkLbSgzKihJgC1BNSU5TJX2l541CL+/Oc=;
 b=iwxAm9ktREKyqekie2wY2L6M9FmIC5H8O+ebOfMZOD4QeOnoPb1rDJYz7QNiFCXnfvXJnjkMXnAGlMG4hNXJ4+TcLi6XhDRU6mA2okrbEZhr0iCYrdTwG1cBal7w1Za5mlGE38AB821RfnhSPhYJ3Wk5qglWrIcplUFxTfdNmsE0AWC5IQB4kWZ106CKutC+zw7HIYgihBTmRFPoQoWJ2bd4ipAPijLLBb+cC1IrFaFtKTGDiwQhvBDY4KP15XHQBRXmLV5W3Gd6GA/aDw1pF17lZafH5bzaXdfZyWrbuptM/i8VQBmY9tAT2SLTrCVHRUiNXins24zb6owy283PmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6pWpqTH6QPxkLbSgzKihJgC1BNSU5TJX2l541CL+/Oc=;
 b=GBjlC86vZE/cYhrI89Xcl2qpjKfZRyd+L+c8k2cTCi/7dJP1x640qVKSzbnQSjUWkGju1yA5vp7FJ2Q83achYidBia8ZWXrybU4nzRwginOid2w0IW2D0zhV2DGEpMLF9xibTgeHlVfprGxdr7IAB7jOHVnityeV3Y5WkB0hKvOGoT9JflUWUUyrykw9b8QIbH5bOfsU5aaLOcIKiptlhss4qA3kUUJTW1KSOacxNz/M5o8MvsFBKKxjuya9hihejWV7gecJWLmix6xzfHSFJ1ZQL9zJl8V23aBWLuo7JQygxf78QmaX4E2ulT2AhbJq1oKNT/ZzEidalUellLDQWg==
Received: from CH5PR04CA0005.namprd04.prod.outlook.com (2603:10b6:610:1f4::22)
 by MW4PR12MB6779.namprd12.prod.outlook.com (2603:10b6:303:20f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Mon, 6 Oct
 2025 18:31:10 +0000
Received: from CH1PEPF0000AD7D.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::d4) by CH5PR04CA0005.outlook.office365.com
 (2603:10b6:610:1f4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Mon,
 6 Oct 2025 18:31:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7D.mail.protection.outlook.com (10.167.244.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 18:31:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Mon, 6 Oct
 2025 11:30:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 6 Oct
 2025 11:30:42 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH] docs/system/arm/virt: Document user-creatable SMMUv3
Date: Mon, 6 Oct 2025 19:29:00 +0100
Message-ID: <20251006182900.100580-1-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7D:EE_|MW4PR12MB6779:EE_
X-MS-Office365-Filtering-Correlation-Id: be649c42-5f0c-4a47-2783-08de0506852f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oda6scgDqI1FeCwXXq1pVy6LUXzUpzZgxWvg8eJTPjcUzDG5WZAZIUC5V9+O?=
 =?us-ascii?Q?y3f91loRFjpPK7xzqV27H12dkJKn7CsHnSHWpKtIiMiJ47wnPyg06ey20bya?=
 =?us-ascii?Q?wYdm6VHwoi1BU4dajP98zJi2fXOTk+X7pr/VNlMyYpbQ92UutfwASx+HVWSq?=
 =?us-ascii?Q?xfrXMSvzXWKtp5dJdQ0uK4nDgHuDFZF3VA+uDEz/S12N39KixZ2pyQXFp+M/?=
 =?us-ascii?Q?oailI4mTm/7YTgticJ9EmZ3vkLnccsQ0yfa04EfAFfu3WFhgDW3ENvi9ThVb?=
 =?us-ascii?Q?kbPttCR0eyqLR6A6JdU8opogCVqNI+Pw/JQ9YjY6AoaYbODVIl5j7NbxQ/4R?=
 =?us-ascii?Q?pqLZa17Ph3lVzzGcRCpmMHwOdhbKNj5oVuok39A0jKqbZIYUFuC+4m6/tYoM?=
 =?us-ascii?Q?6hv/seuvLiBF3tPrEOP15nnNjZ3ygtUnleumPbK/Qgg3Pp92oVITVQDEhxyP?=
 =?us-ascii?Q?I/6i/TGkybLk7XR1gZ+Tx3MgFh622dLCHsxWMnoqnkkj4nePIfM4WPq4VYO/?=
 =?us-ascii?Q?/IehMkByUUOZZqmAVuRwKQhmaFKWqBRFeStmpv11V5zfg9RRUsGi3xvjoyCl?=
 =?us-ascii?Q?CCnC8ZLLb8E7dwV1Lems6/ADFinOGDD4GZelXbwMOMYpZ05IsvMfVWUVSobe?=
 =?us-ascii?Q?ug7f/l34KjZ8IXEUmMSvLcV3QrZk6a9UuJxjGXWy53MMpQk6HxebA4ifMZRw?=
 =?us-ascii?Q?1UdjbiLJHXhDBTz+kitzWU6ZMIrGnI3u81BooWgIZtdPnUs06EwrOV4WKgR3?=
 =?us-ascii?Q?Ec/nj/uUhT8WxkYBoZLwkH+4RkQDzYHc0IFdPHwZXZMFftQV+22ev6utgfqh?=
 =?us-ascii?Q?qGBPHSxny/cu/52xbKN0YCzPeyXlhsFBHvPR5TJTjhqoS/hR+iiUyovGEqyx?=
 =?us-ascii?Q?ZaXsz9zhI3bLOs19jG4YBQ4i7Jsz/F+GS6ay2umv0yTIN7OkDrpolhOiULVM?=
 =?us-ascii?Q?H+ymDCfTMjxDQ39VktFhXucpbC9ens1vy6ll+86D1BGZUoe4YfwJIy0t9Eas?=
 =?us-ascii?Q?H757eGGBeysJ3KJUlzdLQ7qNXR+W5lDPueAk5yK40tMEm3zrhV6pxmCQUGmt?=
 =?us-ascii?Q?YZFlchgoZ5Sdxgsz+4DuGU1tf5Z1hGIFNUdcrzDoxr4yKu9By0D5Bon3LJ5K?=
 =?us-ascii?Q?idjBGvffxCDygMeviVREOlEjOF03SqBI8SfIBYCfBY+F57cousv7BhDsITJZ?=
 =?us-ascii?Q?h3Rjnw0Al/MO0OulADAFGHvCn696wTu83GLz8VCcnMyzmSEzAJTBD6swEH7a?=
 =?us-ascii?Q?5lGe7T6J9Z/aEQ9JzpwnRemFns/MWQDjZiQwwZBFFY97ENWfViAeCFXp5RMn?=
 =?us-ascii?Q?t0CYBFBQ2QAUSh+vDxqLGr+XiMPYVUHysl3XnKrt0SGf+V2v5TnNYsr8Vzb7?=
 =?us-ascii?Q?xh7fwo98G+UOLjhkOqlAxqNODk7KoLiHT+oPMha79ExxcGKaBlzdztq1MVkQ?=
 =?us-ascii?Q?uwQxIP11/MeTAkce6Jsj2YOvzm+QFqDIM02Gx32YtCkc3ZCyGYjzQaqUXQFs?=
 =?us-ascii?Q?woWtwCwAFaixZE2gi/juRGR6Wfrn3ZBHShhikAz+UgldncBDSOh5RT3E5fRc?=
 =?us-ascii?Q?cLWmN7qLzuGpY/GgvD0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 18:31:09.3977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be649c42-5f0c-4a47-2783-08de0506852f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6779
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.441,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The virt machine now supports creating multiple SMMUv3 instances, each
associated with a separate PCIe root complex.

Update the documentation with an example.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 docs/system/arm/virt.rst | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
index 10cbffc8a7..2e0e8196be 100644
--- a/docs/system/arm/virt.rst
+++ b/docs/system/arm/virt.rst
@@ -37,7 +37,19 @@ The virt board supports:
 - An RTC
 - The fw_cfg device that allows a guest to obtain data from QEMU
 - A PL061 GPIO controller
-- An optional SMMUv3 IOMMU
+- An optional machine-wide SMMUv3 IOMMU
+- User-creatable SMMUv3 devices
+
+  Allows instantiating multiple SMMUv3 devices, each associated with
+  a separate PCIe root complex. This is only allowed if the machine-wide
+  SMMUv3(``iommu=smmuv3``) is not used.
+
+  Example::
+
+      -device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0
+      ...
+      -device pxb-pcie,id=pcie.1
+      -device arm-smmuv3,primary-bus=pcie.1,id=smmuv3.1
 - hotpluggable DIMMs
 - hotpluggable NVDIMMs
 - An MSI controller (GICv2M or ITS). GICv2M is selected by default along
@@ -176,7 +188,8 @@ iommu
   ``none``
     Don't create an IOMMU (the default)
   ``smmuv3``
-    Create an SMMUv3
+    Create a machine-wide SMMUv3. Alternatively, SMMUv3 devices can be
+    instantiated directly using the ``-device`` option (see example above).
 
 default-bus-bypass-iommu
   Set ``on``/``off`` to enable/disable `bypass_iommu
-- 
2.43.0


