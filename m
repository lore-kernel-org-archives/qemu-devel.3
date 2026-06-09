Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBC5ECD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:32:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudt-00032k-EE; Tue, 09 Jun 2026 07:29:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudq-0002ix-AH; Tue, 09 Jun 2026 07:29:10 -0400
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudo-0004Po-1i; Tue, 09 Jun 2026 07:29:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCI4PgPctTFTD18gHzVPW5acL/h8op7SW1dz3ewiKLitj3v7kkwUBxmvDNqCZLDv2Izby2lvXavZ1GOKclkRjkmEb0mZFW+AHyoXBTs9yN/aggJJERtvuygcplqJ5c4HiAfAJjKSQxRfc3Ms4j+gUQCRah1Relb2ju/1sPQIYDjJOo9j7lpFxB5f6p1MLVzMtkcCHae2u7IZGWStZciQQEhih3N22aIVemdCRDOPu81Fonm5xDyVWqR0RaSNMNHqYA2wbiD/qUk5Nq9dwUj6/hdmwZnuRcUR88FUTy6wuN2VTuvPra5A0eSYVT0hKkjBol53zCg/nvGa9Le7Pwl8vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F2Nc+Z54WA8oDnpDbBCI8A/dPTL8yyzuvr1Z0tMF4zY=;
 b=Fh2Vp1MzqZ5S1XOQuqAUpARyfh0+HoXHJE5JPL3rVlOO2Fl5wcJ9cMuK1iNCwvmoDXaTRjvMraO+x7PK23FNDoa8/GOBrkasfKNI/hWsRgSChngvQGcWFpnPZixiwm1mR0Dk+D3OayQOdkHbIg1CB8uLlWGezu7cuykOgpXySSE7SwN3vTuMMvcT8Z1C1tfsm0tT87+vBv8FU1ru8rrO1QU12uVKS8Dq5ruwjTZHQjSUFCcvLb2unS5uDBeZ0Oxcm3TR9CfPjqrX27l8yFtCUJvFPw+imB8b9jbSaES/cWAc9fAQnh/PiAXtpu1ERf0PKIROiYtvsr5XXBjRDcrcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F2Nc+Z54WA8oDnpDbBCI8A/dPTL8yyzuvr1Z0tMF4zY=;
 b=LT45ZrxvaRWdLgNmB1CqaIlQ8YVBUy0tXYJho3soO+rPPCLpVXWhGnX6oiovaMpTIyficba60Tno/6jAa2i9lFhK8Q4R+4sOL+ovvMSpOR7cDd0plvuuTXm6kvxFBXZt+pMDZl/FZ/W23n3Kv864Z99YwcRSh/ZYmSnw/X9PwGdBaY3ifwmk3aKe+wyebvRxljvFwgUwNqgMD+EGfghM55zjCO4Zyprxor52YAEAXXQJ/lT1g3GWUgoLN204gGBcDpKe+TFB9b26T53A+bIPtn3mSiVEwVaFdUKmTgsM5C7ykRx4ZVZUVw1EnCP96hpNktz8M/E5/Qwg6Cb+d5bM7Q==
Received: from BY3PR10CA0029.namprd10.prod.outlook.com (2603:10b6:a03:255::34)
 by PH7PR12MB5620.namprd12.prod.outlook.com (2603:10b6:510:137::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 11:29:01 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::94) by BY3PR10CA0029.outlook.office365.com
 (2603:10b6:a03:255::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:29:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:45 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:41 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 30/31] hw/arm/tegra241-cmdqv: Document the CMDQV design and
 lifecycle
Date: Tue, 9 Jun 2026 12:25:51 +0100
Message-ID: <20260609112552.378999-31-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609112552.378999-1-skolothumtho@nvidia.com>
References: <20260609112552.378999-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|PH7PR12MB5620:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a2f7a5-ebc3-4f35-63b2-08dec61a4e22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|18002099003|6133799003|22082099003|3023799007|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: appfKqIowVZQ+MHG5couOlkzPI+YXOS2bI56GnJASrY15CFJhrN13JNdlPGe3rumsHMnUfWsQKmIgWNg4CmBgKvMms1uYl6RshJp/I+K1isDVHG6wa43v7+P1uTVdBNOlYvCgTmSADSBhI/AgMjZ+wmXWBHJde81h2AzfmeWljmS9Ffm/xxOvMaopjJZ78A1yrbWnQmblVtdS/LCtvxE1vN02z0aRwVu3KRaMNCaOI9Zf2aVvcNtucMPqPF0gMQ4DeAITmX9l3iZJlhDJHEKrNbYKKt7tSMbb6nFF6ZIkX77LDIzdn6kyXEYpEx8OJX6B1EA8lLOcL4qZXFgs1r9pT9GoxeWlGPoCxuv46TLwuCsQcvX/o3xafxPWMRb6u4dMA8Vd3IAKfs3In/Ra1DTvCuyzOwG/HvZ8ksfmTA5lbg3VCMYBqZ6qjMJRMEm5/T/1ZlL3wtIzdwDb2tfSdxxgIf5mXcfjl6/vOUXxycrcTc6Oqrl/e63l9tln0P6FkEI/iCSQK3eXACQMLeXFdAscK//vlOq08ImQvLCLWZMhkjWFs8dpksKt/bqNPnfVjRuld5ovoeX50W2FHyOBjM6Tf8zlIhTqgmE7lT5uaTet5Lx3WZ+f+72+bJTxj2vv/JQyNszlgQNnm9rTcl0lDPAuUI5jnxCr8dhWIz2lMgyCx8/wvgt6IKoSoEsZu2HBtGkwBE6uiHw5E4d99R2zSefRArFtyx1bJ8gvmQiLWcw+cc=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(18002099003)(6133799003)(22082099003)(3023799007)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kpD5wX4LDkJeP9AJjGp23V54YmyEL5SIgDP9ckNhtx8j+gg02T9vyheLIU68hFE58RrcEf/s0vaBFzQ9qyRdqMdsOjsfLKBRZBYb2ja9OSTA1v2Nax91ZepUKAn7Fg0imOvvxtVg0KOqyqzPO8g42h1GpVjUcgWCqfqk6t5NL9tckrmNdjcbDVwiCv2B1oG1vEZlRuSbi6Ttq0f8IY62iLXIFA4V1xApDPyCGzQHloEz78WDoCfxbFGgNcB4K1yazbxRVHi6RjaTS0UNRR1RsgSSxFEpJ2hy+gI/e4nvcyaQ/ML4P3+y6mqHGILwEr4qSdh0hfIN7IesIii8uTh69lSK0MvWRDzSdNMm+XmguxjaxUia9HQRYCeYwKzLizEXS4KXtjXbagnTmJk0tRRjtVEUIa8LgyEGtJ6TEldoDgmzIZ/ZjfZH0in0s/O6nZiT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:29:01.3979 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a2f7a5-ebc3-4f35-63b2-08dec61a4e22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5620
Received-SPF: permerror client-ip=2a01:111:f403:c110::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BN1PR04CU002.outbound.protection.outlook.com
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

Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/tegra241-cmdqv.c | 100 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/hw/arm/tegra241-cmdqv.c b/hw/arm/tegra241-cmdqv.c
index d821eafca1..29c488e0e4 100644
--- a/hw/arm/tegra241-cmdqv.c
+++ b/hw/arm/tegra241-cmdqv.c
@@ -7,6 +7,106 @@
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
 
+/*
+ * Tegra241 CMDQV - overview
+ * =========================
+ *
+ * NVIDIA Tegra241 extends SMMUv3 with a Command Queue Virtualization (CMDQ-V)
+ * block. It lets a guest issue SMMU invalidation commands directly to
+ * dedicated hardware queues (vCMDQs) without trapping into the hypervisor on
+ * the fast path. vCMDQs are exclusively allocated to Virtual Interfaces
+ * (VINTFs); the host kernel allocates one VINTF per emulated SMMUv3 instance
+ * via iommufd. QEMU emulates the CMDQV MMIO region and drives the host kernel
+ * calls (VIOMMU_ALLOC, HW_QUEUE_ALLOC, mmap); the actual command processing
+ * happens on real hardware.
+ *
+ * A vCMDQ becomes functional only once allocated to the host VINTF; until then
+ * no command processing happens, and trapped register accesses fall back to a
+ * QEMU-side cache. After allocation, the cached register state is migrated to
+ * the hardware and command processing runs on the host; guest accesses to the
+ * live control/status registers then bypass QEMU and reach the host directly.
+ *
+ * MMIO layout (64KB pages, total TEGRA241_CMDQV_IO_LEN)
+ * -----------------------------------------------------
+ *   0x00000  CMDQV Config page: QEMU-trapped.
+ *   0x10000  Direct vCMDQ Page 0 (control/status): QEMU-trapped and routed
+ *            to either the mmap'd host VINTF Page 0 (if the vCMDQ has been
+ *            allocated to a VINTF) or a per-vCMDQ register cache (otherwise).
+ *   0x20000  Direct vCMDQ Page 1 (BASE / DRAM addresses): QEMU-trapped.
+ *   0x30000  VINTF Page 0 (per-VINTF control/status): the guest's virtual
+ *            VINTF Page 0 aperture, backed by the host VINTF Page 0 (mmap'd
+ *            via iommufd) and installed into guest MMIO as a RAM-device
+ *            subregion when VINTF is enabled; subsequent accesses bypass QEMU.
+ *   0x40000  VINTF Page 1 (per-VINTF BASE): QEMU-trapped. Although this is
+ *            a HW alias of the direct Page 1, the kernel only exposes mmap
+ *            for the host VINTF Page 0; the host VINTF Page 1 is not mmap'd
+ *            and stays trapped.
+ *
+ * The direct vCMDQ apertures (0x10000/0x20000) are HW aliases of the VINTF
+ * apertures (0x30000/0x40000); they expose the same per-vCMDQ register slots
+ * under different addressing.
+ *
+ * The direct vCMDQ Page 0 stays trapped rather than aliased to the host VINTF
+ * Page 0 mmap. The CMDQV architecture allows software to program a vCMDQ
+ * through the direct aperture before allocating it to a VINTF; aliasing to
+ * the host VINTF Page 0 mmap would route those accesses into unallocated
+ * logical slots where the hardware silently drops them, so trapping keeps
+ * accesses well-defined for an unallocated vCMDQ.
+ *
+ * Lifecycle (driven by guest events)
+ * ----------------------------------
+ * 1. First vfio-pci device attach (.set_iommu_device) triggers:
+ *    - tegra241_cmdqv_probe(): IOMMU_GET_HW_INFO confirms host CMDQV support.
+ *    - IOMMU_VIOMMU_ALLOC: the kernel allocates and enables a VINTF for this
+ *      VM, configures the VM's VMID (from its stage-2 HWPT) in VINTF_CONFIG,
+ *      forces HYP_OWN=0, and returns the mmap offset/length for the host
+ *      VINTF Page 0, which QEMU then mmap()s.
+ *
+ * 2. Guest writes VINTF_CONFIG.ENABLE = 1:
+ *    QEMU installs the mmap'd host VINTF Page 0 into guest MMIO as the guest's
+ *    virtual VINTF Page 0 aperture (a RAM-device subregion) and reports
+ *    STATUS.ENABLE_OK = 1. The aperture is now a direct window onto the host
+ *    page, so accesses no longer trap into QEMU; a vCMDQ within it operates as
+ *    a real command queue only once it has been allocated (step 3).
+ *
+ * 3. Guest completes vCMDQ setup (BASE, CMDQ_ALLOC_MAP.ALLOC, CMDQV_EN,
+ *    VINTF.ENABLE, in any order; each precondition write retries the HW queue
+ *    allocation):
+ *    IOMMU_HW_QUEUE_ALLOC grants the guest a new host vCMDQ in this VM's
+ *    VINTF, binding the guest BASE GPA (translated through stage-2 and pinned
+ *    by the kernel) to it.
+ *
+ * 4. Guest SMMU driver programs a Stream Table Entry for a passthrough
+ *    device: IOMMU_VDEVICE_ALLOC programs SID_MATCH/SID_REPLACE in this VM's
+ *    VINTF so that the HW translates the device's guest vSID into its host
+ *    pSID. Commands referencing unmapped SIDs are rejected by HW.
+ *
+ *    This reflects the current accel SMMUv3 design, which allocates the
+ *    vDEVICE when the guest programs the STE.
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
+ *   only reach the host StreamIDs assigned to this VM (see step 4).
+ * - IOMMU_HW_QUEUE_ALLOC binds each vCMDQ to a single VINTF, so a guest
+ *   cannot reach a vCMDQ that belongs to another VM.
+ *
+ * Limits exposed to the guest
+ * ---------------------------
+ * One VINTF per emulated SMMUv3 and two vCMDQs per VINTF. The HW maximum
+ * vCMDQ size is 8MiB, but the size QEMU exposes to the guest may be smaller.
+ * The queue must be physically contiguous in host memory, so QEMU caps the
+ * exposed size to the host memory-backend page size. Use hugepage backing to
+ * reach the 8MiB maximum.
+ */
+
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 
-- 
2.43.0


