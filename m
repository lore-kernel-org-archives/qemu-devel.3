Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465B0FC592C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYzO-0005Yt-0c; Thu, 26 Feb 2026 05:53:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzL-0005Fa-Rt; Thu, 26 Feb 2026 05:52:59 -0500
Received: from mail-northcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c105::7] helo=CH4PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvYzJ-0000uu-UG; Thu, 26 Feb 2026 05:52:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggJrU0qVJpQM+6Ie/HBuXFe5gQzJtMy6UMzWfaBK72QIOo1COJF9fUwqzZkxGkjnKnbO7tpW9rHMT4I/LsWWbVQtsSFxCA4DXAeWmTuoUCFRTaMlno7aY+YHvzcR6Sh/5tbO8rNslU5mo9hz7DhwA5pZoRrjE9LXapeSSrIA5CdZ2kGlu6jDbiS5804xYuK3VUI3zR7LIuGFJcLXmJAQJy+Dx6c9B6zcDpJ+23O4JY8YE0m29Z4eBUKzLhQzyUsKp1KDQt5D9XymbbRsjaGnTKu/lJ9UJFx0lCq6RqjpXEUk7QLGeJuNMWkB5qENs6TiPHQ9Jo7Bak1JC2PQGOc/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0eBYB9DjCuAcJN1rBCIML8TGP8xxIFS6LFbGu+oTI8=;
 b=yljO1+LIuF+IJu/bUHtMYY0dmm+umFu6dGk168guJqUSo5anXmQv/vjRJ5+TMWX7LAtwsrD1t82cl6/SjO9VX+Dha4K0jrmncC1s1NsGRkr6AySGXHBdegFkpyZikB88GZduJJgc26x0zbtCkm9/pL/4Mnhts3HGlsxROFv4RGfD0VozAk5nevhhn2LJOByYCOHdsclgWRSratwCqSqUB2kovG9mfshfzJtNUvh8gS6wACFh0zzdwX7EuHrPhCAoQWQtMSbHubTp+mNqX7uq0hWygeI6tFavVandXoo+kOuR9Zg9drfRmhKkgbxdohYOtIwtFu+f1fZWtvU8FXnY6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0eBYB9DjCuAcJN1rBCIML8TGP8xxIFS6LFbGu+oTI8=;
 b=DsJrmLkG8Un35VAl1Vl0AbvARG6KKdU07CzGDKAjjJvrqM/4OQWhytTSsondQr0RhiVtaRLVIBaJBn+KOWBYGf2UQ0ICfl0PySjJFkRym9K04UP4psc2v2ThsMVGYqohJ0k8e6qh5roHO+G1BfJdb8Jfxb8eQI1nxfKE1HrQaVGuYimz8qjjTLC7OM9Wl2Xu8Wj2rw4LqEN8HzRmcmmjVZyxlHDAdH585GyrgO3lIoUBLf8UqK1Wayq/W9JeOsYXZjo/P4PoNuqbuXbO3jnnSkGpivDzGlZayLD3KaF2UvxFM9P9q1VqpDVv+FwK4WuE/4lfe45WtCHv21FBzmHq8w==
Received: from SA9P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::10)
 by CY3PR12MB9677.namprd12.prod.outlook.com (2603:10b6:930:101::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 10:52:53 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::56) by SA9P223CA0005.outlook.office365.com
 (2603:10b6:806:26::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:52:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:52:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:52:29 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 17/32] hw/arm/tegra241-cmdqv: mmap VINTF Page0 for CMDQV
Date: Thu, 26 Feb 2026 10:50:41 +0000
Message-ID: <20260226105056.897-18-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260226105056.897-1-skolothumtho@nvidia.com>
References: <20260226105056.897-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY3PR12MB9677:EE_
X-MS-Office365-Filtering-Correlation-Id: be140546-1e86-4ec3-8d58-08de7525317d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: qBSnYCzhMtoiXyCKszezUuZgDxNY9NimfIYbMgi5L+yU7OFKMxI1L4BVG1pDKM9BHpvisGId66eAyvQpHUbCg+t4T4wLYJitBkuCyGxMN7T72sk/padHPWZHLFmBi3ASs8AwWqBjJ9w/jgcYQzhGffJI2QFbkdEVBmHHMkeKrdT40m8gkboJvASTJWFeinuU3ZhMWWZYgZxvspiPtUNVGlFYuSljW5s77GlcW/+TJVyaVmJCgFS2g0cJYKdhi+Nk6zxzw7qtf2d5DWTDBUJVmlxAh/T56deFE9t5tQUH8wF6hksF+mXB/La5pubQQKOQroBwfSYbVVwPwuMPZ4LIxhbf+wdOZCwr8aKCHTmGhhBQhgfHii9UTDMOQ5ZxOokIBjNV8h0V9M34a08TKuebdYGn4tAEheG562eydxj1wIDwa/ghLAz3g7sOO0G74tOWnVI3vNPe3hOm5aXUJKpDlqr+vGv/nTn5dtZuanncDmpqSMHJUxperdZyvjaIWp761i2LGerJfGmi47gVzt8xoVA6o9Ud7Q14EPOi55Tfq1T7osBbGkoYM+kPI4vNzeBtYp6L0B6G6D7QEgwlz9nkDQMcpP6wAxVGZDFdILLXPMNuak5Ptaq2+XYNcTFkaa3GllnEAo4xbfDp2i4QtmhHRZ2hHRh2uiIUhOFcqbz8NSRUEJUxF+P05rmrmvtugGhurMFX+MEnaHE7nraekKDOWTEtnojluMA0oAW2ycryI0Alpf1CIdinvLgv7Bk/KEYQ6Whdqdm1W1bJgeFm7iNcpVZKzNPikUyqqUMh1nTgL0Hnr7qpJyG9mKYKjTk+VOHby+q5fu1Sd4NbbstOco+zkw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 35ZVvKgvkw3OF4UqddqD5zODJaGv5T+yedVcz/yMvklppJeHVWw5ZfrHOCkOkLwKRYdoWwSkW5+tusSHeF6reizKBGJ8hOt14dGCqyVH3+SjNCDpNMSyjP8Q/rMKL3PNDxi6gKxyJmtTcLau+lqldhRapU7CcP8H39mHo4vDU7FUGHcyLqtmkTtyK9SJyz8iqDlcKr0kuaGam4Z/mA8c16tQtw5mPDCdqoU7u/lWXjUN1qGLHFYja9TViQlxUMKkqMu/hQNoT/Q/l3qNc3cLW0GSL0efArQ53djA7TnUUnAHHQkFNLssk9h0JYQvx7xTsnzZCFhM6G+e22PIekpSZ8yClZOxdqz5No1MOy+kIBCeYj/ub8VoX9WzpdVt5tkL5Nhdn+Mf7inVDZD6IY3egZuGDgMNaNUvttNTUy8Pd4vF34ge4ZxJcSEvJlSTrZW6
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:52:53.3649 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be140546-1e86-4ec3-8d58-08de7525317d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9677
Received-SPF: permerror client-ip=2a01:111:f403:c105::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH4PR04CU002.outbound.protection.outlook.com
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

Global VCMDQ pages provide a VM wide view of all VCMDQs, while the
VINTF pages expose a logical view local to a given VINTF. Although real
hardware may support multiple VINTFs, the kernel currently exposes a
single VINTF per VM.

The kernel provides an mmap offset for the VINTF Page0 region during
vIOMMU allocation. However, the logical-to-physical association between
VCMDQs and a VINTF is only established after HW_QUEUE allocation. Prior
to that, the mapped Page0 does not back any real VCMDQ state.

When VINTF is enabled, mmap the kernel provided Page0 region and
unmap it when VINTF is disabled. This prepares the VINTF mapping
in advance of subsequent patches that add VCMDQ allocation support.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.h |  3 +++
 hw/arm/tegra241-cmdqv.c | 44 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index d379b8860c..3ce9f539ae 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -18,6 +18,8 @@
 #define TEGRA241_CMDQV_MAX_CMDQ            (1U << TEGRA241_CMDQV_NUM_CMDQ_LOG2)
 #define TEGRA241_CMDQV_NUM_SID_PER_VM_LOG2 4
 
+#define VINTF_PAGE_SIZE 0x10000
+
 /*
  * Tegra241 CMDQV MMIO layout (64KB pages)
  *
@@ -34,6 +36,7 @@ typedef struct Tegra241CMDQV {
     SMMUv3AccelState *s_accel;
     MemoryRegion mmio_cmdqv;
     qemu_irq irq;
+    void *vintf_page0;
 
     /* Register Cache */
     uint32_t config;
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index e1f1562c44..a3767a85a3 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -151,6 +151,39 @@ static uint64_t tegra241_cmdqv_read(void *opaque, hwaddr offset, unsigned size)
     }
 }
 
+static bool
+tegra241_cmdqv_munmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    if (!cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (munmap(cmdqv->vintf_page0, VINTF_PAGE_SIZE) < 0) {
+        error_setg_errno(errp, errno, "Failed to unmap VINTF page0");
+        return false;
+    }
+    cmdqv->vintf_page0 = NULL;
+    return true;
+}
+
+static bool tegra241_cmdqv_mmap_vintf_page0(Tegra241CMDQV *cmdqv, Error **errp)
+{
+    IOMMUFDViommu *viommu = cmdqv->s_accel->viommu;
+
+    if (cmdqv->vintf_page0) {
+        return true;
+    }
+
+    if (!iommufd_backend_viommu_mmap(viommu->iommufd, viommu->viommu_id,
+                                     VINTF_PAGE_SIZE,
+                                     cmdqv->cmdqv_data.out_vintf_mmap_offset,
+                                     &cmdqv->vintf_page0, errp)) {
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * Write a VCMDQ register using VCMDQ0_* offsets.
  *
@@ -216,7 +249,7 @@ tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0, int index,
 }
 
 static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
-                                       uint64_t value)
+                                       uint64_t value, Error **errp)
 {
     int i;
 
@@ -227,8 +260,10 @@ static void tegra241_cmdqv_write_vintf(Tegra241CMDQV *cmdqv, hwaddr offset,
 
         cmdqv->vintf_config = value;
         if (value & R_VINTF0_CONFIG_ENABLE_MASK) {
+            tegra241_cmdqv_mmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status |= R_VINTF0_STATUS_ENABLE_OK_MASK;
         } else {
+            tegra241_cmdqv_munmap_vintf_page0(cmdqv, errp);
             cmdqv->vintf_status &= ~R_VINTF0_STATUS_ENABLE_OK_MASK;
         }
         break;
@@ -251,6 +286,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
                                  unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    Error *local_err = NULL;
     int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
@@ -276,7 +312,7 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
         cmdqv->cmdq_alloc_map[(offset - A_CMDQ_ALLOC_MAP_0) / 4] = value;
         break;
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
-        tegra241_cmdqv_write_vintf(cmdqv, offset, value);
+        tegra241_cmdqv_write_vintf(cmdqv, offset, value, &local_err);
         break;
     case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
         /* Same decoding as read() case: See comments above */
@@ -300,6 +336,10 @@ static void tegra241_cmdqv_write(void *opaque, hwaddr offset, uint64_t value,
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
     }
+
+    if (local_err) {
+        error_report_err(local_err);
+    }
 }
 
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
-- 
2.43.0


