Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52496CF65DC
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Jan 2026 10:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkK5i-00072N-7M; Mon, 26 Jan 2026 05:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5e-00071J-2k; Mon, 26 Jan 2026 05:45:03 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vkK5a-0005JY-4o; Mon, 26 Jan 2026 05:45:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmrloygs2ZG5SBIW6cdDn+4ZbE8wpRTNlYfJUYOd6B0gWoZYJZmV/9g0GK8d0orcJ9PocvAio6elMqjUBnvWiIbOfkKTcfmsBnm7ZicC4mnF7qUP92eXLUXtaN9KnQNKIWjC694VyWhL4YnsvTM8m/4LKk85hnWXw+rgN6oJIBFGKOiH3nzIQ1zbwrbFqu2TfaNj+GQVf4hNpn6KoU5Y/3xlwiPkOKtqP5k7iYmIKQRwQsJygt+DELezRS1u+Y7S6k2YN6M46cYvTyl7pkz/7ha/GS8K49vJQ4dcswEK0O+dYZThZVtO/UbzKIdEoWBHMsIfHXrri79/BYH1fIRuIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hBqMcbOHB9k23ifT++u+ZZdOfbwDumy71Od+aJ01uEM=;
 b=JY8+zQV+3DBamLMLDKAVzhzt2EM2jgnbV4BUZs4iKJ7Ww8lXM1PWGMgZOZA8EPGiH42juegSwjL1HQbyN6d+HbdVf0gDI4uDRQZlZvUj8THnCVFktgwkH2SAGw0RM0jfNhPDtnyDXs0DyxIEtN33SMiHL1A3WPMvVwiDjMl2dYseVw0bDaVB7+d8+VXCkvza5Tvz7cuRj8fCFNQuCFBwthBx4Ky6AdCIVcLuFDu7qpzygtPi2zk0QFoaexwcVbHAYKo9K6W7NDtwzFqnZptlc7wFbAoMb7cqQb2HjP083K4ltZSOiSOp/DsKNmWA0OPXb1VtpQbN/LokW6hYxddUiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hBqMcbOHB9k23ifT++u+ZZdOfbwDumy71Od+aJ01uEM=;
 b=Jd0PdLu7heiw84gp8cxTWb71UF+3XEinlWITfNaJ23mvZfU4PQESdhTJNIV9ZV/9e1opAQqdThjZmXq4WlxaPex+dISDngNJu+KJ5brbaMccWj9bbakQXTQbMoygkLyMQ4dDXW0/ISTOf3QuUjyNZaFT3JuI5H/K757ftOtXIo66wnRaIROKSIuQijr9E2kCR5puO+zWVJqzN8hMFvq0jlCk0QolLiXu1rNQ9GVTMf3+OgFN3O+M75CfAWpPTX+roxIB9AvVAj3ApJaFsi6BTl7Hyma9umIx3v0H5re85fKbPccTcBe7jO2bWvI3xKcTAOAJn28kBwdcv/XH/hVQQA==
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by IA0PPFD7DCFAC03.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 10:44:52 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3a) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.15 via Frontend Transport; Mon,
 26 Jan 2026 10:44:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Mon, 26 Jan 2026 10:44:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:39 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 26 Jan
 2026 02:44:35 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <clg@redhat.com>, <alex@shazbot.org>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <smostafa@google.com>, <wangzhou1@hisilicon.com>,
 <jiangkunkun@huawei.com>, <jonathan.cameron@huawei.com>,
 <zhangfei.gao@linaro.org>, <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>,
 <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v9 03/37] hw/arm/smmu-common: Factor out common helper
 functions and export
Date: Mon, 26 Jan 2026 10:43:00 +0000
Message-ID: <20260126104342.253965-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126104342.253965-1-skolothumtho@nvidia.com>
References: <20260126104342.253965-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|IA0PPFD7DCFAC03:EE_
X-MS-Office365-Filtering-Correlation-Id: 433329f7-6128-4121-70b7-08de5cc7efa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|7416014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YOJZ3ZZSIeXE2SLiwBYNJXrt7EfNURbctzMi13NHcionddcKCZoGU4IkQwDW?=
 =?us-ascii?Q?LCxron8Nel0r63uACPK8gl968zdyjiBJApkgRJw5nFgm4/vgYxyJkYpN05cv?=
 =?us-ascii?Q?K+ABQ+H4vCo1LsB9zyFPSYhZaFd/DTitEhzjz7zwHLdom8C6neW4ULrCLz5z?=
 =?us-ascii?Q?dBos5NCT1jWUddXVmQqf7fSoPtyO2faHDa4CxPmZGpfSkPKX8Qmk52Vj+0iQ?=
 =?us-ascii?Q?uu3MnMeA4RP23DtE0jauIWaFsyoqr6pvLWr4AQ0YR43ZxKiQlxVRy46TrRp7?=
 =?us-ascii?Q?nLwZoXoeVqyn369xHuyKyDvSYXMLHAONuPzvGCYYDBBq4f7T5ht7IqAzz6g6?=
 =?us-ascii?Q?X2dCHRRPwDfr7AtfOv18BG8Vi3o/tZO573dKRdURSG/z2PlVVTsv5jkuBlhK?=
 =?us-ascii?Q?lY0Dkt6IKty73lHOPCUdzooebAyYwoLaAUHqKMdOjHyxlpxSB0ymArsLCypw?=
 =?us-ascii?Q?eKbMrdjCJmHTU0sZbe9pt9bdY7TxlHwubx9BUjMSeFzw7ygdwAlNQqJfiYud?=
 =?us-ascii?Q?AhIckTt6kU8YB4vd6SEmXxe7zNFU16b0rsndkgdsWnbQvwtTOj6zwFRAzsxs?=
 =?us-ascii?Q?IoYrg4GJD75oWRt/WBmzCufmsg/0CW+Qhqh9e3K5velgP2Y0BQFJHKe5Mfw7?=
 =?us-ascii?Q?bonCKvnzOsm3vpg4qrricfBEHCV21XGQ5BBcab5fpWGbfROqATCFJ9yS6GSf?=
 =?us-ascii?Q?/Ql+aWcqwUaoqKldOuRTKy23z27+8KORXh72ByBH73938yZhT2rAR0e5GYP5?=
 =?us-ascii?Q?jthQu8xtGDnc0ZY6+GnCTFcnB16SXY6b90+1unoDIaGtE8Tiz/yUB09OH55j?=
 =?us-ascii?Q?U+Sz2jLvO6yiNn6Og2rSlSdvC4D7IsrKVmJXPKl1fmAewhgBzSTCHQQkMUqD?=
 =?us-ascii?Q?8DF/Gh5jvctKRjEspp5uAACaC11V2TmAfX8Kq8p13MIbFaKtuLJsYRkiWI2s?=
 =?us-ascii?Q?uZy9f0PJUWS1XK6H/mMpB5ylRW82y9yS+QRAm+yv6OcHv+2SPB/s+q0cRmmv?=
 =?us-ascii?Q?19/hSpqttqfchpWXndTMOsx2G9pLHSX3x8JaRB8+wsR3U7xC1mUbFWf6D6mp?=
 =?us-ascii?Q?iIO4kcpctlh7HtXxmEA9GEPnrcwx+m+Jmb0gRh7WQ0oQe50+wRqj0vICJDqv?=
 =?us-ascii?Q?khc2yIH/BMCXAOGf3HBuTnJxUp4YKgTqocqLksZCX2rLiilRMWxtVsPcTXoi?=
 =?us-ascii?Q?giN30h/g5i4qLYMkcwEdb36A82WtUJ4ymdv5kx0sCnV00S+qpZMAJBkjhs87?=
 =?us-ascii?Q?VHsPEu/qKIKtuSrKuuKNYTANeuxSBk1LiUHdUkf0Tgf7qgWfsrFd3Op77s9z?=
 =?us-ascii?Q?BJy1HD+W+M/WOF/lKN7Acn4UrB0tUE8vpNlSMgUcg5epeehTfk/ec4aXGX18?=
 =?us-ascii?Q?319/2j9VaguOoW6auR9GZERkkxzEdmR7A9BS9i8+ufg2JL0dxlvHp+qMSpyF?=
 =?us-ascii?Q?bvd7Tny50Zz1/ApkLdsE5qMsTas2SFeZeT5ZPrqUnbmnMtRJfvu0wigalrz5?=
 =?us-ascii?Q?n7mT8cu318LccYqm9z7DHtGcIIn0RXoIMvUX4H8MNU1jC4qXOl0z23SUE+1G?=
 =?us-ascii?Q?usdDdoCu6rNGt8DJB3WVtdM2QWZ0dIgHyx5vqpvHh8SwFBT44naYpTIzHFHM?=
 =?us-ascii?Q?mENuDWzEIgzWfPQkmS/e+f2Dyq9uJ0mb+hhja8frR5rkLEiwPISqu1wz+4OK?=
 =?us-ascii?Q?tdrPyQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 10:44:52.1836 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433329f7-6128-4121-70b7-08de5cc7efa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD7DCFAC03
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=0.587, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
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


