Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCE63CD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:53:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1Bg-0002qX-Vk; Mon, 01 Jun 2026 07:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1AF-0008H1-In; Mon, 01 Jun 2026 07:50:41 -0400
Received: from mail-centralusazlp170110009.outbound.protection.outlook.com
 ([2a01:111:f403:c111::9] helo=DM5PR21CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1AA-0005V4-2h; Mon, 01 Jun 2026 07:50:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQ+VcAujZamJjzqqP19ZyUtgDwI6Ox1hJdtA6FHxUnwdHPAwtL2Yzg/iutuI1ATaPtZu07QFCICpzGOjmGhAooD1iAK9f4yuZXGs9b2jN05zMC9aFIeIf4ebuP8ZijuGMcqnOqgsQfFKfHDt2tNuccS1hHy/oGfbP6QKzyOR/pxMJgZi04I7KTdn35/BNQwRkK1mbBpm24srOZYatq7lEPiaq4nOBKOXlxy/eDzI4pMTLor2zx6tZqX9U0NLjvwFzWbOoe6B9THOReD8hMCKhxsc27ZzqZrucBnZ+ZtnFv7AXUkcJz1v/L3T0bv2rA+Q/yJWjANoLWN2/yZ29mecEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZjZ49CYieK+a677ItpTL6Dv6v1ttP763uerRFvrX9U=;
 b=ir4d6EqOKPCwKwA3t1upArdKQwJ5eFDLSuEK3pgozvpx+368pc66ZJ26qESgy6pDusoCmEpXqcDY8Aq82gkQvwWCf2YqOequRx8oWXYn4bjKkkvv2r8W4H2fLnV4znCe0ep2kt7aXz42g7bOxh/Iu5gQDmaGFXK1u5iqajLN6hHzlfiQZA0RmNdhH39kbf6GiY18wVZaZVX3+5EcMYoxBeheUckZAlQJLWXRnNEYxZlKy5Js4V5NoClqlJC1dTGjPfYmKUSliw37e938mUvv2nZPALpREbU+wH3BpXrrVC7VXmFRve2yHVdD2p17atmrqZz72iMhsU0xCcpF6EyHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZjZ49CYieK+a677ItpTL6Dv6v1ttP763uerRFvrX9U=;
 b=Yd+CHi2EBnNtiTckY5A16CG12aL4XTpko/sFRR5jCXu1aidIA50O+sTwIfcrEQymXt+DYmUWWRv71f/+ymxwYoHXDYL0bau0Dq70zjiqQam5wwO/YMKg/VXDSz/F9IJNArvRchr+DQ3N4x6BAnNtyrwCwYfWO4P+bA6F0+UWC1fCuFRPptnjlwTdb/LEAM1GUeD4aIP5uhpxPW5Z7iIwnWxConRMZlpEW47CxvO5cljj8Ryx8XGzSS+oNGIhF7LxD/yrteF3n4jX/sddUB1n8J/qUVg0U6y9FG6x913kZieiEmHEPpMfH7SfhlOZNYYN0HwBNbW1XkpY9zB6rIE2iw==
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by CY1PR12MB9698.namprd12.prod.outlook.com (2603:10b6:930:107::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:50:27 +0000
Received: from BN2PEPF000055DC.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::21) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DC.mail.protection.outlook.com (10.167.245.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:50:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:50:10 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:50:06 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV design and
 lifecycle
Date: Mon, 1 Jun 2026 12:42:20 +0100
Message-ID: <20260601114221.457995-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601114221.457995-1-skolothumtho@nvidia.com>
References: <20260601114221.457995-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DC:EE_|CY1PR12MB9698:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a7961f-fd42-4dcb-20a2-08debfd3f8fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: F+ONNbnbjTBhAhvcykCVI9eNk2vsEuFEsbP537WR/BWLGJkgFcLab5/VNgigeIVqNoz3G0RVR/l9hor+DUtMExOTIshyUBSd2Wj1cCTxXeucQ49eEGCLuE9pPEDSKjJReEh5PbqmCoOhG1oRK4OWL8WwnrCG0RudJauicoRU4pNNK+Jm1HMiGOtux3nO0m1Jh0C09dxd1Hvg5BdCvGvcFi3Ht3ZZ+S5O299q1v4wE3SLzEgXlp3lOzbhgxG7xNzYTODgbiwCJ1g/ayde8ow8NfLOeAyu1NnRRd2/RUkIRDSpcQ6yEFXCHxTTluPYaAEBpzJaZRrDF7bzDykjV7iLdsDP0VmQyehNA/16SmoxkKd71sIURPbeqdtajey+w5iBiYhAo0JHw3y/LlX3uJtBuHD8PqOiXp9yEdJGQffUThaKTgwoAotsRjDi9vW1tggaCEbO3fpNq/Nms5Z+SrLuHTanM0VVyOxTwHQjRSbnIPT/1kV8oyNo/uPZNcLnPRf/kOYoVCqUXfS52r/3DN01cc2YalNT1hrAlBagWswi3wgz4GlDPKrj6U/PCh49rjcr93hucPRX7F009vi2BRa8tK+CJwxlmID1hoT3yIotJo1w6AmYh6rBcYZamqogxWRpsadeYynAUmwidH7tia+SQ6ve6yeEfNlARB+C48wFWd/MVyf8F4yZBCvIZ4vtMmxHDRifHLSLvDXI30lD5xdJ1X1hh+CIFb4NnTX5s0MIYHI=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4z4C+NjRBp2LIklVVZFbqP9K7vmq5qFstvIyq3L/h3uySa5qf6UGrCTp8NuTV1zR09ql+lWetmR2LKeT5NCS8sLpC+cYVUriO7ugAwOyNfQ/a/bdNsDlGpM6J+O1sGS/VPabCioMkNFS3+LDhKs6UcvT+OaQVk3XORsQBUXCzIPv4oTOo9RNSb9q3NmkOA4uUwaTUzQMEXIheBFDgFgnoLt+QK8rKlno519BoDyWCcGKw9t7zuis290wp9XHIgC1R61rZ4TvMPJdy9mvNU48yjqVklyRtI16Sfnx+Q4R8uwqqZTx37EGPHXnIKpuQjgYa427giCJWzTImbXbPjuZw9MpvOVQAcXKfiXexvOIchE1d6Gh8+yLZSRyyPfQz66WIQfxt8cEt7+wW+lXm4k6PR++kM3UzdoZ8yl/UHfVOK9gFRBYLguG5iymIMT+qyQL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:50:26.7627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a7961f-fd42-4dcb-20a2-08debfd3f8fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9698
Received-SPF: permerror client-ip=2a01:111:f403:c111::9;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM5PR21CU001.outbound.protection.outlook.com
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

Add an overview describing the Tegra241 CMDQV passthrough model, MMIO
layout, guest-driven lifecycle, and per-VM isolation.

Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 93 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 93 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index 4dba1783fa..5dbf68b421 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -7,6 +7,99 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+/*
+ * Tegra241 CMDQV - overview
+ * =========================
+ *
+ * NVIDIA Tegra241 extends SMMUv3 with a Command Queue Virtualization (CMDQ-V)
+ * block. It lets a guest issue SMMU invalidation commands directly to
+ * dedicated hardware queues (vCMDQs) without trapping into the hypervisor on
+ * the fast path. vCMDQs are grouped into Virtual Interfaces (VINTFs); the
+ * host kernel allocates one VINTF per emulated SMMUv3 instance via iommufd.
+ * QEMU emulates the CMDQV MMIO region and drives the host kernel calls
+ * (VIOMMU_ALLOC, HW_QUEUE_ALLOC, mmap); the actual command processing
+ * happens on real hardware.
+ *
+ * A vCMDQ becomes functional only once allocated to a VINTF; until then,
+ * register accesses only touch the QEMU-side cache and no command
+ * processing happens. After allocation, command processing runs on the
+ * host hardware, and guest accesses to the live control/status registers
+ * bypass QEMU and reach the host directly.
+ *
+ * MMIO layout (64KB pages, total TEGRA241_CMDQV_IO_LEN)
+ * -----------------------------------------------------
+ * The direct vCMDQ apertures (0x10000/0x20000) are HW aliases of the VINTF
+ * apertures (0x30000/0x40000); they expose the same per-vCMDQ register slots
+ * under different addressing.
+ *
+ *   0x00000  CMDQV Config page: QEMU-trapped.
+ *   0x10000  Direct vCMDQ Page 0 (control/status): QEMU-trapped and routed
+ *            to either the mmap'd VINTF Page 0 (if the vCMDQ has been
+ *            allocated to a VINTF) or a per-vCMDQ register cache (otherwise).
+ *   0x20000  Direct vCMDQ Page 1 (BASE / DRAM addresses): QEMU-trapped.
+ *   0x30000  VINTF Page 0 (per-VINTF control/status): mmap'd from the host
+ *            via iommufd and installed into guest MMIO as a RAM-device
+ *            subregion after the first HW_QUEUE_ALLOC; subsequent accesses
+ *            bypass QEMU.
+ *   0x40000  VINTF Page 1 (per-VINTF BASE): QEMU-trapped. Although this is
+ *            a HW alias of the direct Page 1, the kernel only exposes mmap
+ *            for VINTF Page 0; VINTF Page 1 is not mmap'd and stays trapped.
+ *
+ * The direct vCMDQ Page 0 stays trapped rather than aliased to the VINTF
+ * Page 0 mmap. Direct aperture read/write is not an expected common usecase,
+ * but trapping keeps accesses well-defined for an unallocated vCMDQ.
+ *
+ * Lifecycle (driven by guest events)
+ * ----------------------------------
+ * 1. First vfio-pci device attach (.set_iommu_device) triggers:
+ *    - tegra241_cmdqv_probe(): IOMMU_GET_HW_INFO confirms host CMDQV support.
+ *    - IOMMU_VIOMMU_ALLOC: the kernel allocates a VINTF for this VM,
+ *      configures the VM's VMID (from its stage-2 HWPT) in VINTF_CONFIG,
+ *      forces HYP_OWN=0, and returns the mmap offset/length for VINTF Page 0.
+ *
+ * 2. Guest writes VINTF_CONFIG.ENABLE = 1:
+ *    QEMU mmap()s the offset from step 1 into its address space and reports
+ *    STATUS.ENABLE_OK = 1. The host VINTF was already enabled by
+ *    IOMMU_VIOMMU_ALLOC; QEMU only acks back.
+ *
+ * 3. Guest completes vCMDQ setup (BASE, CMDQ_ALLOC_MAP.ALLOC, CMDQV_EN,
+ *    VINTF.ENABLE, in any order; each precondition write retries the
+ *    allocation):
+ *    IOMMU_HW_QUEUE_ALLOC binds the guest BASE GPA (translated through
+ *    stage-2 and pinned by the kernel) to a host vCMDQ in this VM's VINTF.
+ *
+ * 4. After the first successful HW_QUEUE_ALLOC, the mmap'd VINTF Page 0 is
+ *    installed into guest MMIO as a RAM-device subregion. Guest VINTF Page 0
+ *    accesses (CMDQ_EN, PROD/CONS_INDX, STATUS, GERROR/GERRORN) thereafter
+ *    go straight to host hardware, bypassing QEMU.
+ *
+ * 5. Guest SMMU driver programs a Stream Table Entry for a passthrough
+ *    device: IOMMU_VDEVICE_ALLOC programs SID_MATCH/SID_REPLACE in this
+ *    VM's VINTF so the device's guest vSID translates to its host pSID.
+ *    Commands referencing unmapped SIDs are rejected by HW.
+ *
+ * Per-VM isolation
+ * ----------------
+ * - Each VM has its own iommufd FD; all iommufd objects (VINTF, vdevices,
+ *   hw_queues, mmap regions) belong to that FD. Cross-FD lookups fail, so
+ *   one VM cannot reach another VM's IDs.
+ * - IOMMU_VIOMMU_ALLOC configures the VM's VMID in VINTF_CONFIG; the CMDQV
+ *   hardware substitutes / checks VMID on every command the guest issues.
+ * - The kernel allocates the VINTF with HYP_OWN = 0, which restricts the
+ *   guest to a safe subset of commands.
+ * - IOMMU_VDEVICE_ALLOC populates SID_MATCH/SID_REPLACE so invalidations
+ *   only reach the host StreamIDs assigned to this VM (see step 5).
+ * - IOMMU_HW_QUEUE_ALLOC binds each vCMDQ to a single VINTF, so a guest
+ *   cannot reach a vCMDQ that belongs to another VM.
+ *
+ * Limits exposed to the guest
+ * ---------------------------
+ * One VINTF per emulated SMMUv3 and two vCMDQs per VINTF. Maximum vCMDQ
+ * size is 8MiB. The queue must be physically contiguous (the HW reads it
+ * via host PA), so QEMU caps it to the host memory-backend page size. Use
+ * hugepage backing large enough to keep CMDQS at the HW maximum.
+ */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
-- 
2.43.0


