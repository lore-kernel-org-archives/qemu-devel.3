Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9223EE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:51:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNAM-0000t8-LW; Fri, 06 Feb 2026 09:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9v-0000U1-Es; Fri, 06 Feb 2026 09:50:12 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voN9t-0007Kg-Md; Fri, 06 Feb 2026 09:50:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=otoVTnNwohThxelS8pf2RFssBPy5cQQmRt4/ggZ9IL5IjG1T1AEWix4hQEyZOlELs+NoS42P/tBX5D8uHKvQjCTqjCcr19ZOI6mv064EQK9TdE6BrstfIT1knJKIusWVH3DwVJ9znJEpA+7ssKniTv06etv9raBcjfj/WUjptZAY7nZzKX3cqPrx0CbgdJW+8VzNPBlLVUTeh+sscADsQjg2AiuOOXu8RMJyLP22aOpfwyjUfYIQNSth2efQxTywExmLs+FP10rkSksqBPCG2v8mWtJqSqcnpBmtAe4huKe04e+phbNbYlo0Xy6p2SG9eU+xHpK7FgWAjXGVVkqozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ck2z3pNvra8qRLbPVc1NZrCt04OqM2Z8iKMBuTjs784=;
 b=EhYA1v4f+/gTw1gKfL+rzyxFi604b0zatw3+5dxN1IhIUGdjY3WILx3nnNxcoPHtixHhCXGdIoLBNdErr7CnODw7fhLj5iHWF9CzTMwrN1jxYe9U9ljGVR2qf5DezmrmT+w7wmvv5HKZTrMnzvm9RKVBDpPTR8o8YKbiXoXDBZnz++S3X1gj5wJjYneOgstISXDl15AyRyygrr3frhT8RXp5v/Tn6QUOgvCiS2y7E2D9LRhuuVgD5a6n+eXD70mYSbjvQwFTu4ej7jQaziyyZqGqF4+4dEXFD8LoNgKws//0+2J5r2fsMiJF+QsAP47/3fmr5zwHBXkTTcYaFy/xbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ck2z3pNvra8qRLbPVc1NZrCt04OqM2Z8iKMBuTjs784=;
 b=ojpDFQljwTBP4eZUrNoT2gNOpQmYCUw7OXQrUuS3xZBBQtC8cCtwxV2zJczvXX1axOXnChiVf7aUYyhKA0klvi44R+DrHhbmqIMATn0AxnCBruZY4/2Sc8yP5gkARmSIcW19pA5aUO0t1HHesqW7jPd37Pg41tsmOxZ3yQax/i8V9ENBzGhCRaEP44AZBj+FlZsV3JsH2RQGc2k4WrRJ5JTP7/JjJxEQ+koUHuzDNNfn5xm3aPI6i3nz1PbicFsH38PIhiDtyoBDZzofGK1n7zDcgVqCLcWkHYqukN1c4UmB40I8qkCtMgTt16164SGGVb9gLkTdKxQZ8iMoYvPQUQ==
Received: from CYZPR12CA0005.namprd12.prod.outlook.com (2603:10b6:930:8b::11)
 by LV2PR12MB5846.namprd12.prod.outlook.com (2603:10b6:408:175::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Fri, 6 Feb
 2026 14:50:04 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:930:8b:cafe::3f) by CYZPR12CA0005.outlook.office365.com
 (2603:10b6:930:8b::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 14:50:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:50:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:40 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:49:37 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 09/24] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Date: Fri, 6 Feb 2026 14:48:08 +0000
Message-ID: <20260206144823.80655-10-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206144823.80655-1-skolothumtho@nvidia.com>
References: <20260206144823.80655-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|LV2PR12MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: d2584368-05ab-49f2-531c-08de658f0313
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3nwyLx155yBbli2x+bYmvJYt9zKRScA43hX/obXRbty6q0qCj8BpgaqPD39B?=
 =?us-ascii?Q?cTUsF1rEDjE8vL/cECdMOTTpo51v7jiLak5nDqdu4iD2LE4LlXXzGwicwxlP?=
 =?us-ascii?Q?20AyW4lyAfOGTlLn0BrvOtCb/JeSyz5FcSmMU1z8FI044ZS+L0l46ibWNwx3?=
 =?us-ascii?Q?mDi4lULRsDSeumzDdkvtnZ6I2BJ2eIM0xlNWB363nmbDUURv7VEkGaMWeQ+e?=
 =?us-ascii?Q?r8g3Xzlw0o60lmhi0tIkKopKuFqGGAyL01e4r5vL8uQOsuXdkBWjAXVY++/G?=
 =?us-ascii?Q?ZUsfM42kkPBV7o/+ZxRMc33bQ/Vihb7fqmGdpjlrOrRRXScnGdGmyAXWeK6W?=
 =?us-ascii?Q?xEPGM97ZvZgMFbf50XE45E8iN7FhleCWIE3BGZqJvgzd3KFijjw7bbQtiaR/?=
 =?us-ascii?Q?1opQUmHLZ5ePu3URzg3L0/Zkfi+K3VmtPgXlzGl30+0AoW+uGprXok1QIuCe?=
 =?us-ascii?Q?4UDKC5fWkVGD/iB1DtflHS+YMM6G5yF7l9sFRNOeTSwoXsO+pm+XQZzKawOX?=
 =?us-ascii?Q?4E26sEXe6f9Y6KOqcT9jc6V6Da/UhCP2SYVcUPYS8lyMt/J+WCWd5vq08zHY?=
 =?us-ascii?Q?n9EOKmkw5idAQWBs359j/X9s2S/yTcEiFRfgvbr5ZBgtB5aPPqCpXMTZiMP/?=
 =?us-ascii?Q?HA0onIkT/W9csauuiS5g9WTY3X+OShmr80f/Ps+YO/tiiN6ZVAnBd6yPG6jx?=
 =?us-ascii?Q?uyVvS/IqcDteJPxjMTLDEeRC24hVnqaPUSeD2ioFDOFOLSi9kUuOwgyLKHOt?=
 =?us-ascii?Q?xG6kW5ZE2zeHsM3vGw+Pcs9LlbrzbJlevlHYOKrVi2vVmW6Qpwy5gl0fcSGv?=
 =?us-ascii?Q?6jB5ykUS4oCmBiPPN2KZ2E/L+gRMQ9pNvCQbfORMhNoBNp1hazDQU0uJqz9J?=
 =?us-ascii?Q?hqwcz7wW4MykvLID5Ijl741ABkdFbv1e1Up417SwJAMv8HR2skx2Aj5tOzwf?=
 =?us-ascii?Q?vY27lQLfbmc5wNdEZ7dONY8+iAzHkNbKgaHC3eroEOYX1aIHr3/P7551/Npm?=
 =?us-ascii?Q?v3tdG1iU/TYud08gB6Mq7FG25KhktLseemJURuAu1RAwSCCnllpRb6zTPzrW?=
 =?us-ascii?Q?bN7808tg//bsW4/W/tyoO5y9cEnp7FAakeBT+gBhY+M9yaJs20INGQuRKR6z?=
 =?us-ascii?Q?e2HEEg9j1UXglxzVlp4iKeq69KP54PIlh+AEKZN6tYJm65SQ8M34RAnkBOc3?=
 =?us-ascii?Q?34jm8Slav7PHXzHh1jRT1DYAchS6AXIxC1XjmUg6c2RGJk6ZecShk8k2oIsV?=
 =?us-ascii?Q?llx/Kd0quOc0z0rN3NW9bvuNTz1phNB3Kpa+ughuzhfqRSEyrxDeswQnzWFz?=
 =?us-ascii?Q?N4HG/mCbWy6+mT7sQ05b6IyYV3Ai93NCzsVuMAo7YFR0FhKl3okXL0poYhj4?=
 =?us-ascii?Q?ZZ1IVKdBR7StI1NhqC0l7ercGl8BEOIrTvj2k8bh3n1B+7EHTWDYoZ/XjRtk?=
 =?us-ascii?Q?3DkVNR0X7HMd7g+J20E3QqFXDNjcIkx3y8lSkavOCZbhdFuBPv4jiF+pbYHy?=
 =?us-ascii?Q?tTKrv+vvkeJQrPmuiL+m+C4vJnoZLh4PBJUzjIBO8ouIRcJZ7jkIElk8Y6FX?=
 =?us-ascii?Q?qIGm7mBliWKnxXs3zqhBp/2l/YCoPQ+Fp6aG/H4NiwBRC3cz5k+QUFLsSUcc?=
 =?us-ascii?Q?SlWOmvKMxyIPVLOLs8hL0dE3byIanR5G67oosMsL2Ia0fBcKBQS+EZZhrmNp?=
 =?us-ascii?Q?Wd4KbQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mvdoQNgRZu8YM2zQNEJrKVQRNTD6Ot6VDhUF/kKwIuoEaHkgG+0PyxS8BqpTpo9Xy7ONWHIKqpIZe46BDZglHW+AR3pWK0uwdAKbAIfx9xIUeDPlqgrfmuo61B2bqQXU5Zp0f9oEDKV217yXvM959lshaajSBuJPSlmd3wD8uyShmLJO6VER8MEqlcD3zgDXUjxKqDk/pnw9Kqpypnwc3FFvRgnVgRtbB7ZaBHzoqAB6pLMzLDl7kQnAje7I4aqJ3U05E4/VnVDvvdpnotfOmJvDz1RcXAwEselavZnXGVnUoTU/j7nEfovAqlw8HaKbGmBo7VqextbJT1dozMve74rSbzYqlkRml7qBrMcEvZsok0e808LF6HMnVWElYUv0tc3EssX/DQHBBqFnuEKASXROYgOqZvN2823InnXMQWHZtfVmq+n8pKMp6WYHf4kC
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:50:03.8036 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2584368-05ab-49f2-531c-08de658f0313
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5846
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Nicolin Chen <nicolinc@nvidia.com>

Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
(VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
into 64KB pages as follows:

  0x00000: Global CMDQV registers
  0x10000: Global VCMDQ registers, Page0 (control/status)
  0x20000: Global VCMDQ registers, Page1 (configuration)
  0x30000: VINTF0 logical VCMDQ registers, Page0 (control/status)
  0x40000: VINTF0 logical VCMDQ registers, Page1 (configuration)

Global VCMDQ pages provide a VM wide view of all VCMDQs, while the
VINTF pages expose a logical view local to a given VINTF. Although real
hardware may support multiple VINTFs, the kernel currently exposes a
single VINTF per VM.

The kernel provides an mmap offset for the VINTF Page0 region during
vIOMMU allocation. However, the logical-to-physical association between
VCMDQs and a VINTF is only established after HW_QUEUE allocation. Prior
to that, the mapped Page0 does not back any real VCMDQ state.

Prepare the VINTF0 Page0 mapping by mmapping the kernel provided region
when CMDQV is accessed, while keeping all CMDQV MMIO accesses trapped
in QEMU. The mapping is not yet exposed to the guest address space.
A subsequent patch will install the RAM backed MMIO subregion for VINTF
page0 once HW_QUEUE allocation completes.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 38 ++++++++++++++++++++++++++++++++++++++
 hw/arm/tegra241-cmdqv.h |  3 +++
 2 files changed, 41 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 596b1c5595..97c9b9c8dc 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -13,14 +13,52 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
+
+    if (!viommu) {
+        return true;
+    }
+
+    g_assert(!cmdqv->vintf_page0);
+    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
+                                     VINTF_REG_PAGE_SIZE,
+                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
+                                     &cmdqv->vintf_page0, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
 {
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    Error *local_err = NULL;
+
+    if (!cmdqv->vintf_page0) {
+        if (!tegra241_cmdqv_mmap_vintf_page0(cmdqv, &local_err)) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+    }
+
     return 0;
 }
 
 static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
                                  unsigned size)
 {
+    Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    Error *local_err = NULL;
+
+    if (!cmdqv->vintf_page0) {
+        if (!tegra241_cmdqv_mmap_vintf_page0(cmdqv, &local_err)) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+    }
 }
 
 static void tegra241_cmdqv_free_veventq(SMMUv3State *s)
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 6ea0087f61..94bef8c978 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -29,8 +29,11 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    void *vintf_page0;
 } Tegra241CMDQV;
 
+#define VINTF_REG_PAGE_SIZE 0x10000
+
 #ifdef CONFIG_TEGRA241_CMDQV
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_ops(void);
 #else
-- 
2.43.0


