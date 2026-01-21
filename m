Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 505B6D46961
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:56:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vicQh-0008Dp-Jb; Wed, 21 Jan 2026 12:55:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQb-0008AT-3a; Wed, 21 Jan 2026 12:55:37 -0500
Received: from mail-westcentralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c112::5] helo=CY7PR03CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vicQZ-00012N-Fo; Wed, 21 Jan 2026 12:55:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tha95kaVPUdlmXIQcJFt5tjWV8ic+9cTVHdEnpV4fFWKnAK5ioscWvtWbp406bLlVLYhU5ELNrDliFv0mMLj6ldqhPXvOLMrlxUnJhg0rQI6trz50sFY4+7Wx2/XeqIg06Rs/0VETUOXjte7D73ezeJWEodeE323c1LlZdP4j3KO4tjps2E6S9K5zOFT65qZ0x70cj/1Y5y8vsio0OJMOHIL5jIkr9Jw5PyszGbRUEcdiRXjgG3A6LTCH7cSi6UrtvoVPBKdFKD0PFpSDtlOKLgi5ivn1uv2RlW4FTMwQ9hBN37Ate/XdzgAXqGXoK+SBxMmcd3eboMcLp3s+tC9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBqMcbOHB9k23ifT++u+ZZdOfbwDumy71Od+aJ01uEM=;
 b=FFL8RCRPMizWLLVJ2jqpcAoujPesSuWccxukypOABTdbKK1pmBdlwx6AaOITNrU+CJdfpQ73bhUUwQi+Qf9+x8a+8OIqhqnx1v4MP242xNTTlxXrn5/1UyD+9vpqArgSkicdiI05hqPKiOV0kjPECdbkmTZaaG9hv+ger8jl1qLcLlbVNIhUD9n+OElVriVkSdqxpTkBMZlQelrp2s/8oPAAn7kJ2bcDpsysxLm3zGiMZRs2WDHhrwci4H9oIb2tTAbb/awnc8bOJzQ5GkE5YxOGlgr4wSxN58YtpF+BQcOkani68QbVsdAU6IUg6XnL/8yzrjoSBUI0gSUgPzr4Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBqMcbOHB9k23ifT++u+ZZdOfbwDumy71Od+aJ01uEM=;
 b=rj4AptkYlfyhhoOWY1AoxfZ7c82rVlN88g+4CfHmNTbQodwmUHsZi8IOCe+Ba6+XR9hSBgrMLEzYpnnmTIZqtvo3/iM4mZye+cwdZrrDQ5sCRPa/aEOIVS7XHxhekl+LPWi3ptDVHuYvMsYRB2BywM20OBx3LyjmHX4okbuZ9c9wEkwaaBmZuHrguyU1yWmKJD9GL15YxMbi/HKlJ3G1c9kavj+Ot2OONDNKpoXPh9d1eUtHfC57sdMTh1hxsXYkNcKkKQMnYyZrElNtHTO0F7QtkQmUv5rGEP1BQ3XKhyGZ7LZZv3jsQO7yVTnladkfa61IPub187Yoc3pIiRJveA==
Received: from BL1PR13CA0160.namprd13.prod.outlook.com (2603:10b6:208:2bd::15)
 by DM4PR12MB6376.namprd12.prod.outlook.com (2603:10b6:8:a0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Wed, 21 Jan
 2026 17:55:28 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::23) by BL1PR13CA0160.outlook.office365.com
 (2603:10b6:208:2bd::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via Frontend Transport; Wed,
 21 Jan 2026 17:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 17:55:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:08 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 21 Jan
 2026 09:55:02 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v8 03/37] hw/arm/smmu-common: Factor out common helper
 functions and export
Date: Wed, 21 Jan 2026 17:52:08 +0000
Message-ID: <20260121175248.87649-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121175248.87649-1-skolothumtho@nvidia.com>
References: <20260121175248.87649-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|DM4PR12MB6376:EE_
X-MS-Office365-Filtering-Correlation-Id: b4565de9-dbcf-458c-76f9-08de59164340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7416014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dOsOwLLqkqokpE3ymILYJPOPTq7+DS9vN34hZReg7hYru9mb5PPYIHoqUtK2?=
 =?us-ascii?Q?CO845QtagFZr1r2UIxre4flM+tBp9sBq63NDQlQJIxtJhzYCSKQBhZIa4EpC?=
 =?us-ascii?Q?d4272tou3eBYGsoT8zZXFYuvvSCKLO+f9iVJt+0ICwZT05pp0MpvEBvXe+Ug?=
 =?us-ascii?Q?IGl0hYCOavQ/0KfC+l7sRqpoVKinISnzaNhCeq2csmd4AaSXavtgiIcKLAD3?=
 =?us-ascii?Q?QLT/WzMHX/Y8lScp5uvYFUH4xv863j4CvioBG0bVBtCqTba+eVS/AdFKZPnv?=
 =?us-ascii?Q?HzQvpCc0Ycg8om2nzc9BDKVTWM84Im2NfQfg+X+NRgYN9NcXJtWmkpMN7351?=
 =?us-ascii?Q?6dUW2T/Tk5M7Hkozipqti9krPBrR0ddMPX270s4zvuTuwKkzbcLVSRCV/IV7?=
 =?us-ascii?Q?VYPqACiyYCV+Vf1e+fpnWqQZ/shDNjvgCbiDmgxIbIzK3BIiOg7B4QaE/HQl?=
 =?us-ascii?Q?HUiBlAwQ/1mRxCKsI0i+sNoQlLC1f7DFTMfgnUj77t+Sh2dv2eGT+WBiA7hP?=
 =?us-ascii?Q?WrZZlmDQ4OAHTHp6v/lCexNXhGBXMXnxwYHRA6ap3OPddvY01qHPXPjGR60B?=
 =?us-ascii?Q?v0D+8v0s3+IcCuUXx0Xkf0veblzw3KJjmX3gzXg4rnNojE1CsjYXfbwFvlrK?=
 =?us-ascii?Q?14ic+di2eDavDo5ceADx9rCxQjtqNxJ11mrExlhNTJBG+0Q2ppAHcOWx4eed?=
 =?us-ascii?Q?YQqDQ+DEGg/opt35bi5ZucVt9vRIA/MRG2k0/ApO07Nxe0hvct1NW35Ec+iI?=
 =?us-ascii?Q?tBFgRtug9Gwev6eR7LyxaypLJyBleDAh8JLjfrfj6Y7yYpMgqGz/HQwdk7A8?=
 =?us-ascii?Q?zl36KavlcoimOSBVnmxYPGw4ULM6c5XY+sGtrnB4/yDk/Nbg/YF386mk5xTf?=
 =?us-ascii?Q?TGQjiOfu5FohX+AIB2ZS6Lke7RykHae05ISWWny60wTMUrWeGFomQ2AkDUBW?=
 =?us-ascii?Q?GCMzWWunalVXM3GYpM7VtwrfCIysGen8yup5sk6O3TsC8tuQKCS1HI6JgvUj?=
 =?us-ascii?Q?QipBDeDMiQjVEZs3YdEnJCP61MOzuFAn5a60s8un8+j3v4Jtvvc60I1AlTpV?=
 =?us-ascii?Q?pSni3mE66HTy3m8TLkkajrmf2OARd5JzQetWLNZA0cCjkz6jK5zTUKdeHISN?=
 =?us-ascii?Q?GIebG0N1qCSm4I/lGSEYM4j9ChGWofzowLGC6r/JzrkvFQnWI4nJNoi76mp1?=
 =?us-ascii?Q?x/Rsa4vLHVI2q/uDb7s3e2O43wFiBQKWf7iET3d7D/O8vAkbC2zrzFVw1H6O?=
 =?us-ascii?Q?M0/wpaVsFJJP3UUJf6gZn/726Qu4nAowU/8L30TMsmqJPSaZxihSv14HpIR1?=
 =?us-ascii?Q?zxRH5DlauZ7OBjCZwZcTT3nGjdp2jMuwXeqNEslnvX4MnrUd/NIKCkx4vrh4?=
 =?us-ascii?Q?gNGEepjThRnNcQSWgcy7VLwXzeAvSeqQ2OyeSAh0R8QfDvVVntjyoPyRr2Cy?=
 =?us-ascii?Q?+031UQQOOsAD5UkFifTpv0hgPAyRY9B3Q+XH5Dn2lkC0YLWp+tlhmUK37jOs?=
 =?us-ascii?Q?XiUV88EbyanXThRmoPMNUORKgjZyzkmcY/et3swwK1JmSA6ZL7pn2qizK+Jb?=
 =?us-ascii?Q?mrZ33U4j+dMzOTgNeNruHWLtMv2PyhlumYYutYcmyKlWnpIn728LThDrBR+V?=
 =?us-ascii?Q?z3jJx5tGbfBs8f4KoSrNE2/gWfoJCnSPZtw90hDa4bSYL44d7tUbhXTjifLx?=
 =?us-ascii?Q?z+AncA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 17:55:28.3737 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4565de9-dbcf-458c-76f9-08de59164340
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6376
Received-SPF: permerror client-ip=2a01:111:f403:c112::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY7PR03CU001.outbound.protection.outlook.com
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_NONE=0.001 autolearn=no autolearn_force=no
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

Factor out common helper functions and export. Subsequent patches for
smmuv3 accel support will make use of this.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 44 +++++++++++++++++++++---------------
 include/hw/arm/smmu-common.h |  6 +++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index cdcfb1343d..1492d7dd95 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -847,12 +847,24 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
-static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
 {
-    SMMUState *s = opaque;
-    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
-    SMMUDevice *sdev;
     static unsigned int index;
+    g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
+                                            index++);
+    sdev->smmu = s;
+    sdev->bus = bus;
+    sdev->devfn = devfn;
+
+    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                             s->mrtypename, OBJECT(s), name, UINT64_MAX);
+    address_space_init(&sdev->as, MEMORY_REGION(&sdev->iommu), name);
+    trace_smmu_add_mr(name);
+}
+
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus)
+{
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
 
     if (!sbus) {
         sbus = g_malloc0(sizeof(SMMUPciBus) +
@@ -861,23 +873,19 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
         g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
     }
 
+    return sbus;
+}
+
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *s = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
+    SMMUDevice *sdev;
+
     sdev = sbus->pbdev[devfn];
     if (!sdev) {
-        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
-
         sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
-
-        sdev->smmu = s;
-        sdev->bus = bus;
-        sdev->devfn = devfn;
-
-        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
-                                 s->mrtypename,
-                                 OBJECT(s), name, UINT64_MAX);
-        address_space_init(&sdev->as,
-                           MEMORY_REGION(&sdev->iommu), name);
-        trace_smmu_add_mr(name);
-        g_free(name);
+        smmu_init_sdev(s, sdev, bus, devfn);
     }
 
     return &sdev->as;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index b49b2f27fa..f5060cf36f 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -184,6 +184,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
+/* Return the SMMUPciBus handle associated to a PCI bus */
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
+
+/* Initialize SMMUDevice handle associated to a SMMUPciBus */
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
+
 /* Return the stream ID of an SMMU device */
 static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
-- 
2.43.0


