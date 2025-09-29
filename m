Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2CBCAC5BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 13:41:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3E7B-0002jP-5K; Mon, 29 Sep 2025 09:40:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6u-0002g2-LL; Mon, 29 Sep 2025 09:40:12 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1v3E6n-0003JB-0B; Mon, 29 Sep 2025 09:40:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjaQ1564tivTTvbAbY2x32sV+T9kzlMJP2/1AxpNFQRDOKVOFGtd6xjsgG7ZaeEhezZFD5hIWd7iLGU34o+3fvjdVusZZsSGQcurXFgm5EhddEb4G1z9Cge6syq5qGpCyYnlFQDw57mX+uAYt50QX7/sM9K+NoGpS7ivVxKJTaTrpxPzvbPtLfvbmU0vH1b65j9RDA/7eavibcpbNbfzzcje81OO4hI7bO8iYUrDDe04dDvaqhvtuwyQZIiJ3gTv7JulSvdMvCLFktvc59P0NEsgYWM1cBVvyc61KAraaosrC+PRLcEum+HKWAXtAYIxPKzOzKL4OCnPBExyZr+Rog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eF74edredyDpekIcARPozw++gkqczaskGeco2CzSg9M=;
 b=h4obPQShYctA2OE8tBgSHwxt9jpATMQnD3K0zvfUvZOUrJtvwFu0q9qXjjKodu0HAU8GyExosZMUU96ps56D7dXqSs9d3ej2lSg22WUxSafztsoayweag+s4mkJ0L5UsvRAtumzDL5nDY+EEhTkjJq6EdYrZb3145xetlyQMA1a4BNLWCBzGCKpf/d/8tCli6CM7m1mrBCwr0RDBIAhyd11EnNJ1KfOeFKijp1EoKbos1moNHpwJemWYYll0c4KQAJ9fHDfPR8aHzMN++rW06OkfI9JltdV2yykdqqJA0Wtl5R0V3uOG3QewUyOxxP8oWJp7YEv1oOzKEXqUExuJZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF74edredyDpekIcARPozw++gkqczaskGeco2CzSg9M=;
 b=tT+trxIWPBbuHqiwB+bARbEeCYK25w4x5sTA6hGlzUh/c2ObhFPf8OXVmCbriPBuAnr3BBgNwU8anoUvdmklml2nnzfYWDJ9TOy7yEBndYwFxFS9gqjCm9FPA9gaemGerKjBtP8JSxqFTt2MimolrIVTRQ/WD19y94g8M8WzbJLVYHR6YpZAiLp4FgUPnjGMj4C4bhRE0zb9iZJL9MO5SZOzVlz14aBnwDZ/mUuCWXlyFrlb3h6uRSJvQsz1mm4W3SyQFFxdueh8PrFP9D2MAj/ZC1sd7nhT6Z6ujs9s+0WZs34WU/5gQSvkIvO3didmhS5T2DnO03pR5BdjU5Fibw==
Received: from CH0PR03CA0425.namprd03.prod.outlook.com (2603:10b6:610:10e::27)
 by IA1PR12MB8553.namprd12.prod.outlook.com (2603:10b6:208:44e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Mon, 29 Sep
 2025 13:39:46 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::6d) by CH0PR03CA0425.outlook.office365.com
 (2603:10b6:610:10e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Mon,
 29 Sep 2025 13:39:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Mon, 29 Sep 2025 13:39:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 29 Sep
 2025 06:39:30 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Sep
 2025 06:39:27 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <shameerkolothum@gmail.com>
Subject: [PATCH v4 07/27] hw/arm/smmuv3: Implement get_viommu_cap() callback
Date: Mon, 29 Sep 2025 14:36:23 +0100
Message-ID: <20250929133643.38961-8-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250929133643.38961-1-skolothumtho@nvidia.com>
References: <20250929133643.38961-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB8553:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a537197-d64e-4f26-6808-08ddff5da789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|7416014|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9OTo2Bc0CL0r5gNT2Qg6C0kjvwYc5z0oVkZcgZKEHE5fBO1j4oicZHcfTqVy?=
 =?us-ascii?Q?TvdP1KQs1g26vQpY+hkHqqHNkYYFUudPp47qBWrK0jNZS81Gni62LKL/EB5k?=
 =?us-ascii?Q?zmdC5741PoWLXqMWtWsGHDrHR4+I1d5+ZLQ/faTfw9gmkt4hn81HMnSMspr0?=
 =?us-ascii?Q?le5fJfi8hKp3uCIbNgSNZqOSw85rrAJzRyQBkavkF8KTscl+U5rFkhQri/sC?=
 =?us-ascii?Q?hhEgrMvgUBKbEcRuBNPiSYXSmLV1+ClRobTGhAyXheaCEH27xjyaq7iIf5s6?=
 =?us-ascii?Q?nMlTL3TPF6/TydTp+gmKT3rThZ8jE2rE/4jMOKGasxX6FvPAij8lSGqIMUqF?=
 =?us-ascii?Q?MsiqYEgirTeUw3zIoV6Zr0zwV5BaQ2y5F0LO8BagMMI+isJ0AfD7PSri9r5j?=
 =?us-ascii?Q?1se0hmu04VbL/rtrP3hWyOEn58E/EVzpVpHWcFGgjee38vtJn6zi6vnMnwhZ?=
 =?us-ascii?Q?WpF6gb1nk7gOykMN/XQndahwQdgA+B7QCbH58QtBkUFVyJTOoVFek2iOrNYZ?=
 =?us-ascii?Q?IfRgU21n51YeJMUL8iHJdzJqW7QzPdHV8Csp5VheBmyXxJQIUaGts6XTisaG?=
 =?us-ascii?Q?xAe5GCOMb6UPUhJ2iEQMrcrsE5gY3KqX7tqMiPaZa5GeyICGNrFAu1gWYJxb?=
 =?us-ascii?Q?7IVyR94WjbDjK/VI9qm1r40mCsQFjbgQzLqDrbvIxqbUkfeczQ5r87vUOOl6?=
 =?us-ascii?Q?u8EvrcgnoHmfhyqrsD30AQ231EPDMVmscLDT2/2t+B0lY6NWrTc/erFdkikh?=
 =?us-ascii?Q?CF6nTxCU5KuD4lXEdmCefrzuNzLo0pmgfPMeIFR3NBbR2HJLPOQHJonMCrGY?=
 =?us-ascii?Q?FznAWxhVB1OPwkHRHDTqZNecF/bwRstUZwGVpmgtQseXki5yeKo8IESQwjW3?=
 =?us-ascii?Q?QVBmV0AXIXsZ07gZiXuoBXY0F+cZ2TTfeEsh0eSaX6Zaz1HXI3s63GlVAHtH?=
 =?us-ascii?Q?PIGGIrgrx1hyYNFszizeQelnRk06AUibS6vmCwGEymCQY3Z3N2xAsJRVwJ1g?=
 =?us-ascii?Q?91yW8ZEw+52Ck6HG0iLmmVlU2NrppBhdD/cR9HwB2rNOOh8FMRmFiAmxJ3dk?=
 =?us-ascii?Q?ec4mcjSxEUax+kTVci16VmS1UM6qDpxTfBd65k6acD19PcBNiNs2b8e5X+j1?=
 =?us-ascii?Q?uX2tRwwWpCQEUVd55PxDcOr1nXa1EpsKh+nXgzFVXMR63BtP847ZjKEBUhaE?=
 =?us-ascii?Q?1wKO4aOdmZnnQNNs/eQJBP5+ONT7mhFVPSHvhVkasAd4zzCId44JztDHDQhx?=
 =?us-ascii?Q?Wu5GO8HDeF7+EUXKc37byw8bl1fNlWvm2anYkiesOMJqAZR9SUtZ6RwY1c/C?=
 =?us-ascii?Q?c49MjeRYbGvou37McGuaWj/SRkdqpr34RkKd9gc7247aqd+eBK9N98DKDSxj?=
 =?us-ascii?Q?7YRhvXhahU6Sv8Gs7ZdV8wgwpbtidZcBK5/Juubx9sCFU9vhOszZsElb6rsC?=
 =?us-ascii?Q?krvpaEBfww6fPR8gJt28KSYNUyB0OnpI63VG46oOSxocXbqvjt31cPUTSAyF?=
 =?us-ascii?Q?qlej45sEZIGWXCmwyFhuJi+6KlI6jIn1hEbH38T68GepfKzYkL5MzIag1BNH?=
 =?us-ascii?Q?lipVAqkNEmyYxdKrxmw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2025 13:39:46.3282 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a537197-d64e-4f26-6808-08ddff5da789
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8553
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
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

For accelerated SMMUv3, we need nested parent domain creation. Add the
callback support so that VFIO can create a nested parent.

In the accelerated SMMUv3 case, the host SMMUv3 is configured in nested
mode (S1 + S2), and the guest owns the Stage-1 page table. Therefore, we
expose only Stage-1 to the guest to ensure it uses the correct page-table
format.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.c | 13 +++++++++++++
 hw/arm/virt.c         | 13 +++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/hw/arm/smmuv3-accel.c b/hw/arm/smmuv3-accel.c
index 44410cfb2a..6b0e512d86 100644
--- a/hw/arm/smmuv3-accel.c
+++ b/hw/arm/smmuv3-accel.c
@@ -10,6 +10,7 @@
 #include "qemu/error-report.h"
 
 #include "hw/arm/smmuv3.h"
+#include "hw/iommu.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/vfio/pci.h"
@@ -106,8 +107,20 @@ static AddressSpace *smmuv3_accel_find_add_as(PCIBus *bus, void *opaque,
     }
 }
 
+static uint64_t smmuv3_accel_get_viommu_flags(void *opaque)
+{
+    /*
+     * We return VIOMMU_FLAG_WANT_NESTING_PARENT to inform VFIO core to create a
+     * nesting parent which is required for accelerated SMMUv3 support.
+     * The real HW nested support should be reported from host SMMUv3 and if
+     * it doesn't, the nesting parent allocation will fail anyway in VFIO core.
+     */
+    return VIOMMU_FLAG_WANT_NESTING_PARENT;
+}
+
 static const PCIIOMMUOps smmuv3_accel_ops = {
     .get_address_space = smmuv3_accel_find_add_as,
+    .get_viommu_flags = smmuv3_accel_get_viommu_flags,
 };
 
 void smmuv3_accel_init(SMMUv3State *s)
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 02209fadcf..b533b0556e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3073,6 +3073,19 @@ static void virt_machine_device_plug_cb(HotplugHandler *hotplug_dev,
                 return;
             }
 
+            if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
+                char *stage;
+
+                stage = object_property_get_str(OBJECT(dev), "stage",
+                                                &error_fatal);
+                /* If no stage specified, SMMUv3 will default to stage 1 */
+                if (*stage && strcmp("1", stage)) {
+                    error_setg(errp, "Only stage1 is supported for SMMUV3 with "
+                               "accel=on");
+                    return;
+                }
+            }
+
             create_smmuv3_dev_dtb(vms, dev, bus);
         }
     }
-- 
2.43.0


