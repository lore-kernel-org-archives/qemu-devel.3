Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D30CD5BA4
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHrI-0008SW-Oz; Tue, 19 May 2026 06:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrE-0008IH-HE; Tue, 19 May 2026 06:39:28 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHrC-0006T2-RI; Tue, 19 May 2026 06:39:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4TN0VI8H9nRWIwJ9vmTbr8P6vSZ2MW8rdQxV+25LJ5RjSW/wMG3Gs8FdUpxe43Ln3vQm7MG1fQ+uUanO3TtziAk+ArOrB8kErJtxBczRVF3Pbww8esDp52bdrxss7LkdfT8WdCtAioDQmWyQbR80A2C2I4q/0Mg+CCorpanEie1C/kc9odh/odMbaME/SeRHNxTU6yOZAPC4rhkweyevLZD4fBJCEQJp1a7Pez1MgwMya2QFRyNI3nnH3mf/Ibb5F10BQvfN94mmtWFmmy9NcF82njN7kDQjoDIT+P2jiUqt+oZc5t7/KgOyjGp5g7fqgWlDFYq1ib0tz1Y4k8Z2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbERKWR323EwSXNMs/LzmHmvRZGslLcH5WfYwbtkN50=;
 b=ocU1/G7ii/NPx0jB2sAuX1QFTdn4RHZ77AOG1o/rLkzQA1MmP73o3NV3LrXHOYqdKNuPEL+gQk3ZHKFDkOEZ1MxK3uYI9FqBqsCqwr/95LMEqerjc93sLHZXA14E7zLFaFmwF4oFM59g+xmBUJdLVVs/N9nFloVXho8Yz9ywx+XbR3bgf2VRwF1mvL17bTzIHjU8kpU/pvknxwIVfKcQI/+wth2hbiQEzWq/92ZkbVI83nS5RgvxEibq8Gn7CK1YiGkG8FYqd+pHG/QSLHVspWg3IDSKsVP2iV1M00nmy4dyB0HsaVPAvoHlwM+X4hdqbiOWPkeZbn4J+DbT0Jfxfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zbERKWR323EwSXNMs/LzmHmvRZGslLcH5WfYwbtkN50=;
 b=QZ9mC40w16v2Ch6mLJQfMmj7QqmbpIzI2bp7p4rjUYOIscsny5nw5+FEwGlbYZYDL59FVuzPNobTFo4f5woN2qzr1cj6wJ9w8K9Y5tHcnXjUXW3WZ45JIkAmxcFwsZODPbREfrEQ+9UX0orAQGxSUiuARyIIXyjOHcxyinHKuIu9MrWgS5RTqkkS2PkoTJnYZMLt/A+zD/qkGSkvV6Ri5XDHK0A3OMLxSkYWXMmoAAL2Mg0LxYHir3GsN0uFwb+go1G07/4WYx6czD3uHiuGgDAzkZcWQYAztOqup1YhGnn0yXFeow5Oh+IdcsvpXAwKJRPQELQZWiqQn50g65LLOA==
Received: from PH8P221CA0055.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:349::8)
 by DS0PR12MB8813.namprd12.prod.outlook.com (2603:10b6:8:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 10:39:18 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:510:349:cafe::c6) by PH8P221CA0055.outlook.office365.com
 (2603:10b6:510:349::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:39:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:58 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:38:55 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 11/32] hw/arm/tegra241-cmdqv: Implement CMDQV init
Date: Tue, 19 May 2026 11:36:49 +0100
Message-ID: <20260519103727.899332-12-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|DS0PR12MB8813:EE_
X-MS-Office365-Filtering-Correlation-Id: 05d36f67-2bfe-4685-6e35-08deb592e0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|11063799006|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: AmAkBgkigcEtLNTWn+2C9YEGdBwJpzbgtyZNrUjuyXr2K7vZlR0zN6itqt0X/0jZPSdAn3CNSiVzJxn0ai8SHghjlVv2gBmZDo7OrJBXUre0/UAPuVGynnWGdVAjQX7lt01llr/5x70uag7m7SjyBN95NbPzQUqYnGV7RNYQQ6ZJeuVINmEeIkSSMqyVnfDuO6bLXR7Q1dcz+4aLwc60yTfxB6f1zWzx2bVzfgM0RXzkj2PFpmmJZotCNEW89BkiuUDKfy62ulJVH+pAVIR7xjWjKi8unsByd4rdBqcblapaV2J3i5iTBWMRgaC1aE1eeA24C+zB4SnRnDhQzKKthrOCfTNq9uREz8GLkmFPbYwWogYadSQpZwqNUN5EOip0/e1CZKiFbQRr0D/VwbuWGE1kHiFsDdSnfDCxNjQA8X0gSRZAx5tgxpq6eVbQuAMyT2uSs4Gu9KsSqXKiWyHVPu71envCy1BEMkkdV2JeXz0yOPcLukuSRIM7A2DIg3dQuYPoN5ktWfZyqYigHS0EuTAHmO94DoKJSgUi1y1H+qOm80kyy3/RUPia8OinBVvN8Voy4oGa+SFy0nhuvWv6/X0Mct8CPtpjIL1m5qwQlao/3DZwrgeacH9m0kaPFVsHAtpBBQRc12ZnDl1Nl42r/oS4+AGwqwJ1n92hR8x4iEKneOtJ8NhY8xt32k9jKYfleLnH6NUTskkTZ5FXEiVZNwBSBnBFe3L1zHrmEbUcy8k=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(11063799006)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RUuFCDBgk3saib6wgn8n64bcKYdJhY6E2wcqZ43dLqKbD6RVnzxIQOhR+c1Wgkhy69Ho553Ag8LRvdNmNTnr4f8RVKCJPF1rMyBVQmbkmnIflzkyL7fdEb4HEQRXXAh3Loo2gA4zkpkgF4AI2iOI+oUKOmzsqojeeB7Z16R0XjAhPhzfvZBeK9pMw8aqH44qmBRQrmq0nioXP1LLP4XyvhAVI+GsbIhoKXtW+vU3hqhwaI0D8knayGwSEEPDK5IswRDhgH4EZ8s0ONtJ8zi5zZsYF9RpkqcWPFs6uwYjY11sNa7NpV+EUuki09+9IoTyAcAFjmz5ACRIulKznvnZKZmKiDn2m2UJ5QtMCMil3gNq4FcTSxY46P14IaYP35mB4ARAsDt9iSrYXMyGHP807NKMV48MKTOzxg2+QfjrfDIqstu6tEAOTCnlfdkkxrTw
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:39:17.3126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05d36f67-2bfe-4685-6e35-08deb592e0ca
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8813
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Tegra241 CMDQV extends SMMUv3 with support for virtual command queues
(VCMDQs) exposed via a CMDQV MMIO region. The CMDQV MMIO space is split
into 64KB pages:

0x00000  (CMDQ-V Config page)
0x10000  (CMDQ-V CMDQ Page0)
0x20000  (CMDQ-V CMDQ Page1)
0x30000  (Virtual Interface Page0)
0x40000  (Virtual Interface Page1)

This patch wires up the Tegra241 CMDQV init callback and allocates
vendor-specific CMDQV state. The state pointer is stored in
SMMUv3AccelState for use by subsequent CMDQV operations.

The CMDQV MMIO region and a dedicated IRQ line are registered with the
SMMUv3 device. The MMIO read/write handlers are currently stubs and will
be implemented in later patches.

The CMDQV interrupt is edge-triggered and indicates VCMDQ or VINTF
error conditions. This patch only registers the IRQ line. Interrupt
generation and propagation to the guest will be added in a subsequent
patch.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmuv3-accel.h   |  1 +
 hw/arm/tegra241-cmdqv.h | 18 ++++++++++++++++++
 hw/arm/tegra241-cmdqv.c | 38 ++++++++++++++++++++++++++++++++++++--
 3 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/hw/arm/smmuv3-accel.h b/hw/arm/smmuv3-accel.h
index f82a7112d8..49c10535cf 100644
--- a/hw/arm/smmuv3-accel.h
+++ b/hw/arm/smmuv3-accel.h
@@ -62,6 +62,7 @@ typedef struct SMMUv3AccelState {
     bool auto_mode;
     bool auto_finalised;
     const SMMUv3AccelCmdqvOps *cmdqv_ops;
+    void *cmdqv;  /* vendor specific CMDQV state */
 } SMMUv3AccelState;
 
 typedef struct SMMUS1Hwpt {
diff --git a/hw/arm/tegra241-cmdqv.h b/hw/arm/tegra241-cmdqv.h
index 38c8b27b4d..030f5758d5 100644
--- a/hw/arm/tegra241-cmdqv.h
+++ b/hw/arm/tegra241-cmdqv.h
@@ -14,6 +14,24 @@
 #define CMDQV_NUM_CMDQ_LOG2       1
 #define CMDQV_NUM_SID_PER_VI_LOG2 4
 
+/*
+ * Tegra241 CMDQV MMIO layout (64KB pages)
+ *
+ * 0x00000  (CMDQ-V Config page)
+ * 0x10000  (CMDQ-V CMDQ Page0)
+ * 0x20000  (CMDQ-V CMDQ Page1)
+ * 0x30000  (Virtual Interface Page0)
+ * 0x40000  (Virtual Interface Page1)
+ */
+#define TEGRA241_CMDQV_IO_LEN 0x50000
+
+typedef struct Tegra241CMDQV {
+    struct iommu_viommu_tegra241_cmdqv cmdqv_data;
+    SMMUv3AccelState *s_accel;
+    MemoryRegion mmio_cmdqv;
+    qemu_irq irq;
+} Tegra241CMDQV;
+
 const SMMUv3AccelCmdqvOps *tegra241_cmdqv_get_ops(void);
 
 #endif /* HW_ARM_TEGRA241_CMDQV_H */
diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 3a19a1af56..298671e0ce 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -13,6 +13,16 @@
 #include "smmuv3-accel.h"
 #include "tegra241-cmdqv.h"
 
+static uint64_t tegra241_cmdqv_read_mmio(void *opaque, hwaddr offset, unsigned size)
+{
+    return 0;
+}
+
+static void tegra241_cmdqv_write_mmio(void *opaque, hwaddr offset, uint64_t value,
+                                 unsigned size)
+{
+}
+
 static void tegra241_cmdqv_free_viommu(SMMUv3State *s)
 {
 }
@@ -29,10 +39,34 @@ static void tegra241_cmdqv_reset(SMMUv3State *s)
 {
 }
 
+static const MemoryRegionOps mmio_cmdqv_ops = {
+    .read = tegra241_cmdqv_read_mmio,
+    .write = tegra241_cmdqv_write_mmio,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
 static bool tegra241_cmdqv_init(SMMUv3State *s, Error **errp)
 {
-    error_setg(errp, "NVIDIA Tegra241 CMDQV is unsupported");
-    return false;
+    SysBusDevice *sbd = SYS_BUS_DEVICE(OBJECT(s));
+    SMMUv3AccelState *accel = s->s_accel;
+    Tegra241CMDQV *cmdqv;
+
+    cmdqv = g_new0(Tegra241CMDQV, 1);
+    memory_region_init_io(&cmdqv->mmio_cmdqv, OBJECT(s), &mmio_cmdqv_ops, cmdqv,
+                          "tegra241-cmdqv", TEGRA241_CMDQV_IO_LEN);
+    sysbus_init_mmio(sbd, &cmdqv->mmio_cmdqv);
+    sysbus_init_irq(sbd, &cmdqv->irq);
+    cmdqv->s_accel = accel;
+    accel->cmdqv = cmdqv;
+    return true;
 }
 
 static bool tegra241_cmdqv_probe(SMMUv3State *s, HostIOMMUDeviceIOMMUFD *idev,
-- 
2.43.0


