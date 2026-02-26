Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071B6FC592E
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:57:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ0N-00080j-Bn; Thu, 26 Feb 2026 05:54:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ0L-00080F-Lg; Thu, 26 Feb 2026 05:54:01 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ0K-00017I-19; Thu, 26 Feb 2026 05:54:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdmF9DaFZi1/ZqV0epWl8gD+6BFFxyCkhxrPF9lNYZBB3JRCwbMwlV79RpTyGE/hH7+loARSMNGKjbBUwFvfRDeSu4izN2uPU+QAwOAGVjZrLFGIfOnNbMZHUIZlskj7tg7/CWy8DwvAAt+LD5F4zW2TytIVU06/E+G5zHeBMcIAowq2CCCcHPC3fJxE+/MV8TkIwdlqd5Brm9mHiAhz10kKIIrS/fDcbaG6zxL1MijTvdz98JL8/YLe38fXgP1U65L41RAZxJQWeEibJO2OLG/xZ4lHIFCkZ+fmDB56q9UCk6/y1yrzJUh0mYc/G4VL52gVxB9sry/DuaRTBAZIag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxoSTmn0IdwEHqvVNyPghOQkMLMIdfnmmlyncbAej8Y=;
 b=dCZiOVbgDxPtYT/3DwTjOV6HfGJEkLwgUqXQMUDGk4nsnrwIfKTtlzeVPNSO71bOsPDnC/5N+TS+cQsSDrUNQ7aSgozFyygvASfKm8Sa8k9uUyMXnxtLd1GOcKRjcxpGifgdpXBkAgq0NTIoY9O+d4JAoUOVlnjGqErjtXeREuFCBnj3AXxrBewSIGzLSeuB7DV48QjQa7ZJo21/9p88fXXGI4b+X7bLHd8ZAhT/Z5X4prApQsX8Fe8DfbFrssCGeO8JKxozpRPtx654dEQNwwcwJQPSQ/ZtKPTwe2nQEmYe62/yKjmxcW0B/EOKzEhjJ8oKineBj5cgsU9wdvbpHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxoSTmn0IdwEHqvVNyPghOQkMLMIdfnmmlyncbAej8Y=;
 b=kZoqG6gjfxc6/SAx9G/AfMpzW86FBYYmXpn/5XxV1iSmcxkB/niInecP78/tFtsfFbwHaUa/Z50JYGWTfkVr1vfsoh7dJIvN/O+9U5L+NFLVh+snEdknioLSlUPgeTvqI35uBgxocT021Ag2cL1+11TybNirwtsucDTpw/FHspvg8BGYFwUk7ALCIFbqXEHy+jg+TGj+lyYxbMrdsQws9u2hNzqBxvJY7Yz8l6TKvNlXtW4yq+WPBDbdrDKRItUzg+g8/Anwub3y6anV0qaHkh5rwHHdYSeqj8TGK9px8YKqRpNdr1u8XzMWvPIegJUTePH0i2xO7y0QDjGtgFpdtA==
Received: from DM5PR07CA0083.namprd07.prod.outlook.com (2603:10b6:4:ad::48) by
 SJ2PR12MB7821.namprd12.prod.outlook.com (2603:10b6:a03:4d2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 10:53:52 +0000
Received: from DM2PEPF00003FC4.namprd04.prod.outlook.com
 (2603:10b6:4:ad:cafe::70) by DM5PR07CA0083.outlook.office365.com
 (2603:10b6:4:ad::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 10:53:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM2PEPF00003FC4.mail.protection.outlook.com (10.167.23.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:28 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:24 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 31/32] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in
 DSDT
Date: Thu, 26 Feb 2026 10:50:55 +0000
Message-ID: <20260226105056.897-32-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC4:EE_|SJ2PR12MB7821:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c074a3d-e00a-4a49-fc2b-08de75255433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|7416014|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: vqgCBiG/lhy6Wdzt4U3VBa0KLy2dY4CCa5crUJiM5yBX8HxYVz8mzt2lgWyzHtsIzGItK3d8paVw8AVHBI+dlDmVhQrP5blXuS0Hb4Beag5m33ne1LMAdK+IkFS/vYfPAJ/NE2DprBYMS2r0qtZalG/jlQkl/5FeyWiOBzjqlZiz/LHFr5+cJAfxQ8TxKG8GGuu9vocePPcM1XrzIHv4vdmy46bNi6tCaFDm3c9S5S+LHbO577OKDIH8PKVMKG36A+xgacMr6E8dVtvGJQn26oMqvWZJgZrSXsGveEcLbnBYaAEnhJ6Ys43UFhEIevh4VCvO+sUYW6D5l5jpHkDmw/DdUNVW2AvHQl0C9luXLMs/W29MECeSXNNWIbsXuB880uPAFpRA22vZYiamJbOhILJgPMETRv8LVMXWZalHCB0sNJkP2WQPEjnovO/Hgc3Xs00++IdOnzwkG7ENH32v3pC8YdCBxDduI1FdMzAqU25BL4lifLTNdh+zLBXd7X73m7YwDOe65h/99JxsTMUPn9IhJSh1DczO+eK7i4rgs6SW+Ryr4Bcl6N5iMmt7sRsp6ySV4jr5BG3NCghgtC0aDvAogCWPCLrfa7zgQBPzkcp/nw3lEM4onhAP5bppVHHCdYYGorsGd7TwYjItWjBtP3wP4TW+aG5TWjJEri4XrJh7klR3SBjNW7Cl5fY07IabLmTeN1fjCRgKKIvq3P1Dzm9uaabGfZHjEpzWa9dYUbo385+geq5PaZnkxA6WSvPyxpDhrHHj4pMBb0HXA51Y/gxmSUZX6vKnsWNhC/c3AGqbkST/1eQRyczAOaLp+vEwxGZTtuk6XZmpze1H7q5O9w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0QNbrugAT1e0FQqkY2k2uPaCRUNH0T5WPLwAHlzdG9zp1iS2zVSMf/Jy+QiIAs1Fb2SuPyHtdQNLjgJ40gEzr8G1OSCVVCRji3SrzVzCCYWrB4JnCIj7JpV3crgFdLtYi0W5OzzgzE5BUB3qjX4S9vHvjqHO9TJxA55SUcNh6wDdlztWN7EkkumLhbl6gwsg440cUkVdhOpxpf6GUo6eBVLsWzBnrmTACO5ABdYnSBrRzbGLDYkYIR7Rrwl/t+JEMF9haAVDDaOO1y1If0nukMSknlS+ye25JiIHbzbimEIuT8UABxQUX2dXSY4VsOrVlMVibfL0CeOG1nvvk4+umz4Ctikqn5sXpbq8M82JujwLQfru7ugicy5jK+2Ybn2wHi8n1LMXnF9pBwd8wVdYLpXeCGAbIutaxhHdxpKbSui6adz0dQNtHzj0VbNSPU0J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:51.6860 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c074a3d-e00a-4a49-fc2b-08de75255433
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7821
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=skolothumtho@nvidia.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
created with tegra241-cmdqv.

The SMMUv3 device identifier is used as the ACPI _UID. This matches
the Identifier field of the corresponding SMMUv3 IORT node, allowing
the CMDQV DSDT device to be correctly associated with its SMMU.

Because virt-acpi-build.c now includes CONFIG_DEVICES via the Tegra241
CMDQV header, the Meson file entry is updated to build it as part of
arm_ss instead of arm_common_ss

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |  1 +
 2 files changed, 53 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 20605185c5..462faa6a2b 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -65,6 +65,9 @@
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 
+#include "smmuv3-accel.h"
+#include "tegra241-cmdqv.h"
+
 #define ARM_SPI_BASE 32
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -1113,6 +1116,51 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
+{
+    for (int i = 0; i < vms->smmuv3_devices->len; i++) {
+        Object *obj = OBJECT(g_ptr_array_index(vms->smmuv3_devices, i));
+        PlatformBusDevice *pbus;
+        Aml *dev, *crs, *addr;
+        SysBusDevice *sbdev;
+        hwaddr base;
+        uint32_t id;
+        int irq;
+
+        if (smmuv3_accel_cmdqv_type(obj) != SMMUV3_CMDQV_TEGRA241) {
+            continue;
+        }
+        id = object_property_get_uint(obj, "identifier", &error_abort);
+        pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+        sbdev = SYS_BUS_DEVICE(obj);
+        base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
+        base += vms->memmap[VIRT_PLATFORM_BUS].base;
+        irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
+        irq += vms->irqmap[VIRT_PLATFORM_BUS];
+        irq += ARM_SPI_BASE;
+
+        dev = aml_device("CV%.02u", id);
+        aml_append(dev, aml_name_decl("_HID", aml_string("NVDA200C")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(id)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+        crs = aml_resource_template();
+        addr = aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                AML_CACHEABLE, AML_READ_WRITE, 0x0, base,
+                                base + TEGRA241_CMDQV_IO_LEN - 0x1, 0x0,
+                                TEGRA241_CMDQV_IO_LEN);
+        aml_append(crs, addr);
+        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE,
+                                      AML_ACTIVE_HIGH, AML_EXCLUSIVE,
+                                      (uint32_t *)&irq, 1));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+
+        aml_append(scope, dev);
+
+        trace_virt_acpi_dsdt_tegra241_cmdqv(id, base, irq);
+    }
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -1177,6 +1225,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_tpm(scope, vms);
 #endif
 
+    if (!vms->legacy_smmuv3_present) {
+        acpi_dsdt_add_tegra241_cmdqv(scope, vms);
+    }
+
     aml_append(dsdt, scope);
 
     pci0_scope = aml_scope("\\_SB.PCI0");
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index ef495c040c..e7e3ccfe9f 100644
--- a/hw/arm/trace-events
+++ b/hw/arm/trace-events
@@ -9,6 +9,7 @@ omap1_lpg_led(const char *onoff) "omap1 LPG: LED is %s"
 
 # virt-acpi-build.c
 virt_acpi_setup(void) "No fw cfg or ACPI disabled. Bailing out."
+virt_acpi_dsdt_tegra241_cmdqv(int smmu_id, uint64_t base, uint32_t irq) "DSDT: add cmdqv node for (id=%d), base=0x%" PRIx64 ", irq=%d"
 
 # smmu-common.c
 smmu_add_mr(const char *name) "%s"
-- 
2.43.0


