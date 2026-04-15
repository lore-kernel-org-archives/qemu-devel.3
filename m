Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E2ABF4198B
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 10:58:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxwX-0001KC-LA; Wed, 15 Apr 2026 06:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwT-0001CA-N9; Wed, 15 Apr 2026 06:57:58 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxwR-00046L-Uu; Wed, 15 Apr 2026 06:57:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bOqG/IiK+dSU4yv8o4iTadunESkuKFAT6UkDL3IXSCYI+bx5uauYkXH2o4pCWp/QXqeRpJQODLVQoI6HUPlCasyM6GMXhsyX9xgoqqBg+y0PA7vPApQC0tkcz+5BCQVMypE7XWTZYzHOOqHCYTE3N/CRtUyHxMRRE4jF0/FawUYIcKphtQbkB6fMbEAF93/TYC8SYEDXBaIoSXMjqB/jiJYv0nmciFqJZZhdZOGHdjc2b/+cSoAzdS21KB8bux9wJWm4saysTGkzTlT7jKFogflqdZEjqB4Ql89lG37U06/2aHggVMy+AnHurLpo5SJb6Y/ArWHXZAsL4KCuTIkyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Te/0XjktDMR8XmnQ+TH0yCPDRBpENHTYEk1GG9jys2U=;
 b=NwXsKpMKN6zGwGoZIDdJlocVINT3bulHcLkEXJ84E1HLVjaMK0F3JxNMHl8xYbWQf4ivCjuH/2u86FuJw5fywhlyWTSiWD/xfawlEx81cOGTs61D3zkpBDz6W8e6LXXZGN5yZZTw53irT1i/5DNKKOwCJeP/APEjd+QFm0Ro+xZWIxwhNxRXfa9jC3vt1ns4t0Tmyu2YGOhKnmQxMv7o3PXRNeDe5bWw03Q+ubHqvGV2SxVe3SkjXx086M3uSk67PRgAt9pdFdYBu6zRYhecMUNWfXRKB1gdafAZ62zH72nf/6JL7SZe/5xQpfvIl2uIFd1ddOfVAXeKoJDpF7RESQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Te/0XjktDMR8XmnQ+TH0yCPDRBpENHTYEk1GG9jys2U=;
 b=T2ofGS+ZpVqgrwe+51yQgorLMH2i9/el1/c128U1XA24je04xP+WehE/So+e3OxRtfCTPDYBjpgtyAGqBcOq9DUseRTtiSXnC0LD+5crjiGrD3MC4n9nNTKvkBFD9mNK6JpsIQDZKr3q76PjZ9aMPb/S6aYdpa7VgttVSBduAWYGntAKUU1Us3ofYlZIPi4fqc0xRqKQAHjUfrNBSroei4ytdKcXJTNWQPro5Otzd+OzTSyw89C0y6XkCKwZEq9waI5yH4r9Kse9tPG+grISmrTsiCVrfCTLfEPVD0fIVIqniWg9JBvTuXApJczrnrQ5ckK+OdOWcTqfM0xG7nlBMw==
Received: from DM6PR01CA0030.prod.exchangelabs.com (2603:10b6:5:296::35) by
 LV2PR12MB5941.namprd12.prod.outlook.com (2603:10b6:408:172::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:57:49 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::f9) by DM6PR01CA0030.outlook.office365.com
 (2603:10b6:5:296::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:57:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:57:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:33 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:57:29 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 16/31] hw/arm/tegra241-cmdqv: Emulate VCMDQ register writes
Date: Wed, 15 Apr 2026 11:55:37 +0100
Message-ID: <20260415105552.622421-17-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260415105552.622421-1-skolothumtho@nvidia.com>
References: <20260415105552.622421-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|LV2PR12MB5941:EE_
X-MS-Office365-Filtering-Correlation-Id: f4740af8-16e1-4c84-9c15-08de9addd56c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: usKKRnCpa548y9jgfLS8sa8mRS3Qff6pCQ4OH68dYjcR4kxjGELGQtAY/C2h5GYCRqAvnWKmIlAcMQEv0NndaD5Ve7aIM2YFCTm+TlqTEsREwUmtHF1WPZPl/YvFrApA5CvdyTy5ek2IHB+uXrQaFm7K+lj+SS5v+vk4duXeZcXHiSG9i+tvmE6Mpw/a+G073ESXMMv4Zy74zugeHWqYgxhjuhzHSV+pACLruC5A4sK2s42VqWtBINib8SzUHHogI7s5+c725VkYdp37Yys7QOAicErENaMYPwHzI6x+KEhzJBsFWvCpANFe3Feu+6BU1wvgt1NMQJmkcPNPHQVlerqkfbFwH/MB9w7Jy2JDvWHXG+9JM72k0TYKjvjU01o2GVo7fa4wjkrhuPJIGIyLn59SmYBsXuBGRHk51L5ngUYnzU4XNBindLJdaRsckDRHRrtPJTn2tQGlL4P4Zxf2tEtfKj63+hTwGU9nZfXa7Y84lgRtyGfQoHdjdwebmDuYmdFJG/Vbo7jK8tubyLttcBwdXG4n5YziU21FyB5uc0snKs2HF022S1RhJjYF5p/QuAUlQeS7xswsO3q/KkuP99mgn5Nwpv5a4OqIIEOUFUbKMQmVRz3jSFTJ005Qffqy1MlfhYC0qIxpNZ7My1fOyuwJM8/F42k3Wg3MkgcwkKc2VFdsOZkHhxsbOM+rjfXpE5NzAQojvSrZ7nDV12F9FBjj/8l9WqKaT9tqFefR+3wMF1fFAR68nZsxToxuujQUw7yKxCmaDU/Ioe9OmQLqNw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: e744lZ+WgyHXEqVywTjlfiPu9ScItBiRSFb+epN60jhMWBF3jFvhAw5FRaME3MwQtZIHEaBodmRRb9Wnc4bpammGjHobWRq5YLxCYqxcQmzWxacsTv5cf7OuzMxcgMKa9ENBNutN23KtYzNQ+j4As4CJpDbJJKyD/P3Vy7a4Q0QfZdboVUhi/LexN8VyaW9zezivOqgcOn+RTFmHrpqdT3VkRPJM+Vba9aKFKP4kKSTATd2u8eVKetIo/2RjQK1FOXdquKU1QAr418ajWb+cLpkBfNo5n06Dtazb+ofRQodCzl9HA3Bp8DQ2l9IKjNjBa0sX0BRNAFc68rQLbVqN/Sd/m+3MYDrbdK84eRCJP90hgIQxvYBoKlRWSBEbc+BoFkCWJt4IxH0fQZ5Fuwth8yB3rRrZnXJ3sf6ynXgooMm2N38gFQnOfxGZ6oB2pQMN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:57:49.0844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4740af8-16e1-4c84-9c15-08de9addd56c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5941
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

From: Nicolin Chen <nicolinc@nvidia.com>

This is the write side counterpart of the VCMDQ read emulation. Add write
handling for both CMDQV_CMDQ_BASE and CMDQV_VI_CMDQ_BASE apertures using
the same index decoding and VINTF-to-VCMDQ translation logic as the read
path.

VINTF aperture writes are translated to their CMDQV_CMDQ_BASE equivalent
and update the same cached state. Page1 registers (BASE, CONS_INDX_BASE)
always update the cache. Once IOMMU_HW_QUEUE_ALLOC and viommu_mmap are
wired up in a subsequent patch, Page0 register writes will be forwarded
to the hardware-backed mmap'd page.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 99 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 35e6f0bbd6..d4ba2ada92 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -55,6 +55,70 @@ static uint64_t tegra241_cmdqv_read_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
     }
 }
 
+/*
+ * Write a VCMDQ register using VCMDQ0_* offsets.
+ *
+ * The caller normalizes the MMIO offset such that @offset0 always refers
+ * to a VCMDQ0_* register, while @index selects the VCMDQ instance.
+ */
+static void tegra241_cmdqv_write_vcmdq(Tegra241CMDQV *cmdqv, hwaddr offset0,
+                                       int index, uint64_t value,
+                                       unsigned size)
+{
+    switch (offset0) {
+    case A_VCMDQ0_CONS_INDX:
+        cmdqv->vcmdq_cons_indx[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_PROD_INDX:
+        cmdqv->vcmdq_prod_indx[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_CONFIG:
+        if (value & R_VCMDQ0_CONFIG_CMDQ_EN_MASK) {
+            cmdqv->vcmdq_status[index] |= R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        } else {
+            cmdqv->vcmdq_status[index] &= ~R_VCMDQ0_STATUS_CMDQ_EN_OK_MASK;
+        }
+        cmdqv->vcmdq_config[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_GERRORN:
+        cmdqv->vcmdq_gerrorn[index] = (uint32_t)value;
+        return;
+    case A_VCMDQ0_BASE_L:
+        if (size == 8) {
+            cmdqv->vcmdq_base[index] = value;
+        } else {
+            cmdqv->vcmdq_base[index] =
+                (cmdqv->vcmdq_base[index] & 0xffffffff00000000ULL) |
+                (value & 0xffffffffULL);
+        }
+        return;
+    case A_VCMDQ0_BASE_H:
+        cmdqv->vcmdq_base[index] =
+            (cmdqv->vcmdq_base[index] & 0xffffffffULL) |
+            ((uint64_t)value << 32);
+        return;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_L:
+        if (size == 8) {
+            cmdqv->vcmdq_cons_indx_base[index] = value;
+        } else {
+            cmdqv->vcmdq_cons_indx_base[index] =
+                (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffff00000000ULL) |
+                (value & 0xffffffffULL);
+        }
+        return;
+    case A_VCMDQ0_CONS_INDX_BASE_DRAM_H:
+        cmdqv->vcmdq_cons_indx_base[index] =
+            (cmdqv->vcmdq_cons_indx_base[index] & 0xffffffffULL) |
+            ((uint64_t)value << 32);
+        return;
+    default:
+        qemu_log_mask(LOG_UNIMP,
+                      "%s unhandled write access at 0x%" PRIx64 "\n",
+                      __func__, offset0);
+        return;
+    }
+}
+
 static uint64_t tegra241_cmdqv_config_vintf_read(Tegra241CMDQV *cmdqv,
                                                  hwaddr offset)
 {
@@ -212,6 +276,7 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
                                       uint64_t value, unsigned size)
 {
     Tegra241CMDQV *cmdqv = (Tegra241CMDQV *)opaque;
+    int index;
 
     if (offset >= TEGRA241_CMDQV_IO_LEN) {
         qemu_log_mask(LOG_UNIMP,
@@ -238,6 +303,40 @@ static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset,
     case A_VINTF0_CONFIG ... A_VINTF0_LVCMDQ_ERR_MAP_3:
         tegra241_cmdqv_config_vintf_write(cmdqv, offset, value);
         break;
+    case A_VI_VCMDQ0_CONS_INDX ... A_VI_VCMDQ1_GERRORN:
+        /*
+         * VINTF Page0 registers have the same per-VCMDQ layout as the
+         * VCMDQ Page0 registers. Translate the VINTF aperture offset to the
+         * equivalent VCMDQ aperture offset, then fall through to reuse the
+         * common VCMDQ decoding logic below.
+         */
+        offset -= CMDQV_VINTF_PAGE0_BASE - CMDQV_VCMDQ_PAGE0_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_CONS_INDX ... A_VCMDQ1_GERRORN:
+        /*
+         * Decode a per-VCMDQ register access.
+         *
+         * The hardware supports up to 128 identical VCMDQ instances; we
+         * currently expose TEGRA241_CMDQV_MAX_CMDQ (= 2). Each VCMDQ
+         * occupies a CMDQV_VCMDQ_STRIDE-byte window within the page.
+         *
+         * Extract the VCMDQ index and normalize to the VCMDQ0_* register
+         * offset. A single helper services all instances via @index.
+         */
+        index = (offset - CMDQV_VCMDQ_PAGE0_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
+                                   index, value, size);
+        break;
+    case A_VI_VCMDQ0_BASE_L ... A_VI_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same VINTF-to-VCMDQ translation as VINTF Page0 case above */
+        offset -= CMDQV_VINTF_PAGE1_BASE - CMDQV_VCMDQ_PAGE1_BASE;
+        QEMU_FALLTHROUGH;
+    case A_VCMDQ0_BASE_L ... A_VCMDQ1_CONS_INDX_BASE_DRAM_H:
+        /* Same decode logic as VCMDQ Page0 case above */
+        index = (offset - CMDQV_VCMDQ_PAGE1_BASE) / CMDQV_VCMDQ_STRIDE;
+        tegra241_cmdqv_write_vcmdq(cmdqv, offset - index * CMDQV_VCMDQ_STRIDE,
+                                   index, value, size);
+        break;
     default:
         qemu_log_mask(LOG_UNIMP, "%s unhandled write access at 0x%" PRIx64 "\n",
                       __func__, offset);
-- 
2.43.0


