Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16077CD5BA3
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsE-0002CA-Px; Tue, 19 May 2026 06:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrn-0001Ba-Gc; Tue, 19 May 2026 06:40:09 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrl-0006Z1-2K; Tue, 19 May 2026 06:40:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UQ3nJvpNG0JntQi/CB7hAtQD7uDFdNRFoFxTvPWVfM48lfClgMkHkxGPTlir5jIcQ+Y965i/x5tEc+r+joon8abdpUoy37/hFBz8D28PMlHl/XRD8jS9Wfe19qg9reYbhClLwTPSQex2tBD4IFXXxtIIgQOKjyXYpPGMKp/vc5OtbtCtl/bA81Dhgn4KW124Ah3uvMpFuToSqqh/0DDtgfxa7KaDFOmhYAh/VE/f0+IbVrFE8Ei7y384+y8zfNs6H3XG3ZZWtPIufY4RNJEchM1Nj9hToN1EWYqTUTqitcJYKhhQqIBPM82fH3S1GVhPwQ0rQJNpVL+qrLSFFjRGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wUR2lS78GUxpYMKWHRg+EZzYom5CedXG3O4P2ADPmeo=;
 b=mkfQGBIaSBYkj91uTp53PkAFGb25kZ8wpQtdrKF7Khq1J8nMjWNWeE/eqmTDc33mVo4QoB6+NqmUGuV1p0fB1yY6KRPD9YgDzGFpY8YyR2BGWGg4b/99/wVmF5Z/IKMgJtz773rmTisdx/Gz0VoNSCdTE0/HhJcr0X4LsT6d8h9V8ools17X54363I3/G6zkxNuuktzOT0mhRyS5TFruwGGBHiGk9rDx6a1BQS5EF1eI3wDCmJd57b8TaCn6Zh35JrOny5JZWiqYUVERodBxUK1tqNPH5bdbR4qBEu+lJmPautjiRVOHV1CeLIbUX/8Z1AzPFaicWk8L6DnLSDgFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wUR2lS78GUxpYMKWHRg+EZzYom5CedXG3O4P2ADPmeo=;
 b=uP6k6GF89D1cEn4Bh3Cz+5RH5D866Hix6M1tg3rzXJKywSjArsoDkfD5PtQOfkcNGP0D7cKZdmJx7dNBH8fBIygX4QTjukp5MfOOPCmaCoyc01/gR0Zm987BQVa7SXP6oUYX9lFciLIsoNEY5q+uXiW63U9hqB8STeZ3QRUIpK6OgMhgBBrHROBHL2DBhrRH5lEVfF6J0zFtYYwgII2lRa4OAnga8I1YoWWB6kbI8v7LeLnl0Zvh2VJLGbbTyrG47Z3p6xk3kxQrGKYf/XB60ydtE22OJZMs0PY+oxaOARdh/dW1sXvKK2i23chmRlP7XlM9fIkdnb/TjUt3pO+Qtw==
Received: from BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::12)
 by SJ5PPF0170DF9F2.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::985) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.20; Tue, 19 May
 2026 10:39:53 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::f3) by BL1P222CA0007.outlook.office365.com
 (2603:10b6:208:2c7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.23 via Frontend Transport; Tue, 19
 May 2026 10:39:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:35 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:39:32 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 20/32] hw/arm/tegra241-cmdqv: Use mmap'd VINTF page0 as
 VCMDQ backing
Date: Tue, 19 May 2026 11:36:58 +0100
Message-ID: <20260519103727.899332-21-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519103727.899332-1-skolothumtho@nvidia.com>
References: <20260519103727.899332-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|SJ5PPF0170DF9F2:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0bef40-bf5b-4f71-1e88-08deb592f4e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: Xyfl6idzYMxowVXJk4OWeeQYtOduK5/MNkLaaUpfPF7X6aug3WffW54RhjN65TbMN+r4mQ8ls2wawp4nlgzz/f0b9xIV+4x6NqwmgnwyfnhX9/1MSBGjFSYo+a3L92rP13IV+nYxe/FqZaYY+8ZrZdEnyv2nGoFylsg4Q/yTv3/0hknMcWl+AuWQgLYnzrQ6FeesJZwgg0AUpq/hPVCj8X5Yl8BOniOYLhEsF/x4tARnvFMC7RBbGRZJXuN0zsAO3KpTTK5gydmsoo912VunPOgGtObleztSqqB/YEMHm44VJ9n9Jfyt5lMTTN8DiEGvqaM4Q6If7gma2F7VbYu0LhVEPNZ6iPABsFzhC66VMr5gxfjgssFMY6oZNkvViZvfPA/lUL8dvyYVgt+tcxmhWFkYouwDNnOEwPJLK7pO/0lmF0Cw/9Rr+dbkY1sivtinl5eqs+hY7fZjuC+kP/PX4hyQqTX3KBekeDtsskHR0gmjldax8VOZlhYilfcW7MT9S+ktWMwGrHTzOhCKifAozrG/hMYwB0OZhHSj5pDeTkhEXz7WILcDX5ykQ/CjBQTwTMj3dYf4ZBBgeEDrjZwKwboD7PaSFMP/UIVV0E667a4vRo1TMbAmEJt6SHhrHO6aC3HfBJPmqfILjPwfNa+ep/wf5RkaNp6/dHEg8avkuOSSWPUKdS3PHgCwGwbHKgpQ109rc6HqcwYwpu2PqL3mzoPzO+HN4CO82EEYffSigMQ=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /HODXMUE+dsUr3A+j658Hh2kMNANvaZ+r6464b3p5HBOFoxJT5wKygpyGQc7W6emXQAwFjWwuectsYr1jVrzXKGDnKg24wV6vGQyTRZO+UMZRD2W4cKRgnT/2o6B9uPaKkGoKJcRXpeVr2UVZorsYWiA1T7cwpay3xrkuUjWEKnP5QZjYB5TzPYe1992y6gW9U28VvLuG7Nw15qsgfCszLahwQBpPY5tAT+WU3DxUKgfzHQVaHXCk5LzUHBZazzcgxxUKo3Pzb6xFgkE/A9aFAJUPwNOxkqA/NFnR0Wr3pwaVJkjPJ7ghhuSlcoRa9Z5d2k6HSjZPDk1cY+fFPNNCFNNYtXbTTQYVnFyw7Y6grFrMoH7wv5mjnAiYVgoEhUDQgB82lEm4ZcvShewAO6v4fdvz0m42nmYfIZAwjYOZ4fTu72tkZ3QFkhtSnaAqPbg
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:50.9764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0bef40-bf5b-4f71-1e88-08deb592f4e3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0170DF9F2
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Introduce tegra241_cmdqv_vintf_ptr() to route VCMDQ Page0 register
accesses through the mmap'd VINTF page0 backing once a hardware
queue has been allocated.

There are two QEMU trapped MMIO apertures for VCMDQ Page0 registers:

  - Direct VCMDQ Page0 aperture (offset 0x10000)
  - VINTF Page0 (offset 0x30000)

These are hardware aliases: they address the same underlying
registers. A subsequent patch maps the VINTF aperture as a
guest-direct RAM region; in this patch both remain QEMU-trapped.

VCMDQ Page0 accesses operate in one of two mutually exclusive modes,
depending on whether a hardware queue (IOMMU_HW_QUEUE_ALLOC) has
been allocated for the VCMDQ:

  Pre-alloc:  vintf_ptr is NULL. Both apertures use QEMU's register
              cache. Hardware is not yet engaged.

  Post-alloc: vintf_ptr is valid. Both QEMU trapped apertures access
              registers directly via the mmap'd vintf_page0 pointer,
              bypassing the cache. Hardware is the single source of
              truth.

The pre-to-post-alloc transition is triggered by the IOMMUFD hardware
queue allocation. The tegra241_cmdqv_sync_vcmdq() copies any pre-alloc
cached writes (CONS_INDX, PROD_INDX, CONFIG, GERRORN) into the mmap'd
page so the guest's view survives the transition.

CMDQV acceleration only becomes active once the guest enables VINTF
and the corresponding HW QUEUE is allocated through IOMMUFD. Until
then, all VCMDQ accesses are served from the emulated register cache
with no real hardware command processing. This matches the CMDQV
hardware specification: if the logical CMDQ index does not map to any
allocated Virtual CMDQ, "the access is dropped with no Fault/Interrupt".

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 72 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 70 insertions(+), 2 deletions(-)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index f4968520f3..a7e89905df 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -39,6 +39,39 @@ static void tegra241_cmdqv_free_all_vcmdq(Tegra241CMDQV *cmdqv)
     }
 }
 
+/* Pointer into the mmap'd VINTF page0 slot for @index, or NULL. */
+static inline uint32_t *tegra241_cmdqv_vintf_ptr(Tegra241CMDQV *cmdqv,
+                                                 int index, hwaddr offset0)
+{
+    if (!cmdqv->vcmdq[index] || !cmdqv->vintf_page0) {
+        return NULL;
+    }
+    return (uint32_t *)(cmdqv->vintf_page0 +
+                        (index * CMDQV_VCMDQ_STRIDE) +
+                        (offset0 - CMDQV_VCMDQ_PAGE0_BASE));
+}
+
+/* Flush cached pre-alloc writes into the mmap'd VINTF page0 slot. */
+static void tegra241_cmdqv_sync_vcmdq(Tegra241CMDQV *cmdqv, int index)
+{
+    uint32_t *ptr;
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONS_INDX);
+    if (!ptr) {
+        return;
+    }
+    *ptr = cmdqv->vcmdq_cons_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_PROD_INDX);
+    *ptr = cmdqv->vcmdq_prod_indx[index];
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_CONFIG);
+    *ptr = cmdqv->vcmdq_config[index];
+
+    ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_GERRORN);
+    *ptr = cmdqv->vcmdq_gerrorn[index];
+}
+
 /*
  * Allocate a host HW VCMDQ from the current cached BASE / size for @index.
  *
@@ -94,6 +127,9 @@ static bool tegra241_cmdqv_setup_vcmdq(Tegra241CMDQV *cmdqv, int index,
     hw_queue->viommu = viommu;
     cmdqv->vcmdq[index] = hw_queue;
 
+    /* Pre-alloc cached writes survive the cache-to-hardware transition. */
+    tegra241_cmdqv_sync_vcmdq(cmdqv, index);
+
     return true;
 }
 
@@ -108,11 +144,14 @@ static void tegra241_cmdqv_setup_all_vcmdq(Tegra241CMDQV *cmdqv,
 }
 
 /*
- * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set.
+ * Returns true if the per-VCMDQ CMDQ_EN_OK bit is set. Reads from the
+ * mmap'd VINTF page0 when the VCMDQ is allocated (HW is the source of
+ * truth post-alloc); otherwise reads from the register cache.
  */
 static bool tegra241_vcmdq_enabled(Tegra241CMDQV *cmdqv, int index)
 {
-    uint32_t status = cmdqv->vcmdq_status[index];
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, A_VCMDQ0_STATUS);
+    uint32_t status = ptr ? *ptr : cmdqv->vcmdq_status[index];
 
     return status & R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
 }
@@ -122,12 +161,21 @@ static bool tegra241_vcmdq_enabled(Tegra241CMDQV *cmdqv, int index)
  *
  * The caller normalizes the MMIO offset such that @offset0 always refers
  * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ *
+ * If the VCMDQ is allocated and VINTF page0 is mmap'd, read directly
+ * from the VINTF page0 backing. Otherwise, fall back to the cache.
  */
 static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                                 hwaddr offset0, int index)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
     uint64_t val = 0;
 
+    if (ptr) {
+        val = *ptr;
+        goto out;
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         val = cmdqv->vcmdq_cons_indx[index];
@@ -152,6 +200,7 @@ static uint64_t tegra241_cmdqv_read_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled read access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_read_vcmdq_page0(index, offset0, val);
     return val;
 }
@@ -225,11 +274,29 @@ static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
  *
  * Page 0 registers are all 32-bit; this helper is only called for 4-byte
  * writes.
+ *
+ * If the VCMDQ is allocated and VINTF page0 is mmap'd, write directly
+ * to the VINTF page0 backing. Otherwise, update the cache.
  */
 static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                                              hwaddr offset0, int index,
                                              uint32_t value)
 {
+    uint32_t *ptr = tegra241_cmdqv_vintf_ptr(cmdqv, index, offset0);
+
+    if (ptr) {
+        switch (offset0) {
+        case A_VCMDQ0_CONS_INDX:
+        case A_VCMDQ0_PROD_INDX:
+        case A_VCMDQ0_CONFIG:
+        case A_VCMDQ0_GERRORN:
+            *ptr = value;
+            goto out;
+        default:
+            break;
+        }
+    }
+
     switch (offset0) {
     case A_VCMDQ0_CONS_INDX:
         cmdqv->vcmdq_cons_indx[index] = value;
@@ -253,6 +320,7 @@ static void tegra241_cmdqv_write_vcmdq_page0(Tegra241CMDQV *cmdqv,
                       "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset0);
     }
+out:
     trace_tegra241_cmdqv_write_vcmdq_page0(index, offset0, value);
 }
 
-- 
2.43.0


