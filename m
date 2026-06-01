Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EECABCD6E56
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1Au-0001RW-Vc; Mon, 01 Jun 2026 07:51:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1A6-0007y8-CF; Mon, 01 Jun 2026 07:50:33 -0400
Received: from mail-westus3azlp170120001.outbound.protection.outlook.com
 ([2a01:111:f403:c107::1] helo=PH8PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU1A2-0005Sr-LZ; Mon, 01 Jun 2026 07:50:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpHcHRXTllryZljJUJQI+3LPJLYCsDwBfBnidi2gLg6Asq3/NVs7KJDml7l0U7thXWe1lpi6F8rlSxMT7SVDmh7kl7WyjH1BoqaxMLk56zmNOS1dQeiUq+ljMal64mKGH9Je/33Bg5dQsOJQ6YfD3aPDoku2qM3rUWq46vUaCR7PT90RZmupJ2mt1tDzo5wwQT93DB7WM8PiLG9kKRGu77iqnWxmN6ucBq/5LDrSA+JcEnr+Mx9/iadvf+QbewSSyBgAfm6ay8zvp90zqwQidqJFf1r4TRPRi2aQ6+ipYTl2vSqjPRG2DvPqB6zmmlh+Qva7o5ZritTIv1YmpnZ60A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TJVi0qXUpSynhc9Xo1f4s6nzrSiItVXp5g62zMebwRs=;
 b=Q9uCK5XxPpgx1mzFfm94oAWGaI6e1rrfl9rXDRyXamXMTv32Sp6Ue6Qt5jZzmgcaPIugyy9x8AhH9uPOTfsRNfvRXEg1hvWqleTiR1g+kYv7XIlFfafzpj6+YEf5K3DwnJZDQ+zKv3e+mZtFP+RH2dHhFAGyNhUC/MN5QxINX7stXg1onm4ZN3IsMxkVjd3UDQEqCyqaUqHOs09hmDxKcGXhM/E+8cmnjfWMOTzNgusS/DVbygyIGEkb3QwW5aLesm/5HM9ZSF9f+Y8ytMfA46BzSClq1fI0uERdvdkuFHcgV6dvk35PW42LnK0EyRXgKwPnfpOKRuJq0rm4bNV7xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TJVi0qXUpSynhc9Xo1f4s6nzrSiItVXp5g62zMebwRs=;
 b=W5/08+bE4h6gF4JMDDFexa2iMm7HUSyP2fG7S+5Rmd4bIGSRjtTi6TOW06i5AeIjACnEeg6toAlqrPDtJBuohf7kAw5cys+yAtK9nkHPMLx8tUAUvMJA73oVqsyvpioxjZtL31KHYa831z131c2fTMZ0PJGu9xWCiY8rHk+x5rYjD2bjLZ78sdHIhOXUYQrJDVdMp+zKjsRwx+EDAJdQjj7vnYMEGbuq2yeY8iOMUd8UTvH4QrBCS0URapezjFTti67dHXAANcp2GqRP/xB5ZUMBxvu3Mz2k44BwAOWR/6Ot6dL8521YjbpDIhUGYGfi0ObTbECLaBkMeubrZblCSQ==
Received: from IA1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::17)
 by CY8PR12MB8412.namprd12.prod.outlook.com (2603:10b6:930:6f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.16; Mon, 1 Jun 2026
 11:50:13 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::4c) by IA1P220CA0007.outlook.office365.com
 (2603:10b6:208:461::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.17 via Frontend Transport; Mon, 1
 Jun 2026 11:50:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 11:50:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:50:00 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:57 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 28/31] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in
 DSDT
Date: Mon, 1 Jun 2026 12:42:18 +0100
Message-ID: <20260601114221.457995-29-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CY8PR12MB8412:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8a4e43-619b-418c-13f7-08debfd3f0da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|11063799006|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 2xJmNqHwtk0a6/UgOJiyx47NR6ufHHxIQMJjTwJfNotKMjzLX8EA2QV/e3hT8BZQufOIIdDjzy92oPv6LFnd15Q6751Ig4MZY/DlGi+ehXgCelM9f8SRfDvWsQvHV9PLcw5yW/TlrM9wTl5/2dc12CjHfQndk0/oUNSzUYY6LI8FzGl0BdwadNd2KXNbQIKOe1OmZLNmfakL/9mY66a/7+jkngq33HMdT6qsmqfvyE0BB5WTRKk0krWiGh69V/yJnU1HfRQ2nuEWdMBVk2Cafhr++rvG1PP6hOPbnT2AHlh01wezqHA6zDnPjBVjA8m7wbCfMZWBslS7G6Y2o/JjIfpKiwctftvMMW1R9Pnk+EsCMha8oAMceaBJJF89O+SCdVIPg0Wng8btPl/wYFF5xNFhtnLLWTvrgDmgDJepZ/YbfzTQrfXwWaPXkyzHHUbTPDehm192UiX0u6lhJISjbKT3wH4Cht8OHQPOJuC9WIkVcSNEyMV6AabpSiNWMKNrWfDa+jbPALJfzlhjLl1WoaBa0zVkkrpphpKBYE+Gic8lGiyomL1tW0B8kuhq+qGXr3ForEPgniIODU6efC/zvUiXAGlQ1BOnKA2EO9Q3T8ag8pwb8L/UgtTv4BqJt7bOo4+sWr/RHUzteEICr5rKsrUOPxILR4SYADsZ95B738kOYRxkuXd9PhEycbhaJdsBhXBAqm4cB6bnHOMXkS4/PqHS1VpyWUqT2f54i3PlcG4=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(11063799006)(6133799003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rs3yd8zJWpZcEQdRAZXnnycWzeKWcbySUVnCgS7xmAd9+tjm5r8zvWde5V7KiPbCRbcMjanZLJJjbo/UTy/CnUAwJK30NGoIGnJ4gtsvJHs4ms8HhfUiuOkIJGKjQQedZEh6IK8h0EppqnKCCrKRC9PBao1NgR0A4YqKUPCOhew7eUETUMAa6Lybl/PPxx0Ma6BttJ5MRwAro8D3uVaGBRuSBR74yrHVgGckdgDzV6OTN3K9kjLZGJtuZ3/1AEA2fytWg/gNnhAk9RZz2N5JYLS51oBHGBtQNBgpExCySydhwo/+Z6MPUmaCrCYeGC1ZhYXTd/apxsu3g8DbYcx8NYZCNOLLe6AUQ0UNCgAYtjEQg4DMtHdcEKKBMmB6e2pOchD2/7h0W6OvJ7mIp5Vl7X4jtBxpSHzF0qTC2ZYHUQjAHpADjoj4RJVlcB3hz+UM
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:50:13.1224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8a4e43-619b-418c-13f7-08debfd3f0da
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8412
Received-SPF: permerror client-ip=2a01:111:f403:c107::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=PH8PR06CU001.outbound.protection.outlook.com
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

Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
created with tegra241-cmdqv.

For each accelerated SMMUv3 instance, add a Tegra241 CMDQV device
object under the DSDT \_SB namespace, with HID "NVDA200C" and a UID
that matches the Identifier of the corresponding SMMUv3 IORT node, so
the guest OS can associate the DSDT device with the right SMMU. The
_CRS covers the CMDQV MMIO aperture plus its interrupt, and _CCA
declares I/O cache coherency.

See ACPI Specification 6.5, Section 6 (Device Configuration) for
_HID/_UID/_CCA/_CRS.

Generated DSDT entry for a CMDQV instance paired with SMMUv3 Identifier=1:
  ...
  Device (CV01)
  {
      Name (_HID, "NVDA200C")  // _HID: Hardware ID
      Name (_UID, One)  // _UID: Unique ID
      Name (_CCA, One)  // _CCA: Cache Coherency Attribute
      Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
      {
          QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, Cacheable, ReadWrite,
              0x0000000000000000, // Granularity
              0x000000000C080000, // Range Minimum
              0x000000000C0CFFFF, // Range Maximum
              0x0000000000000000, // Translation Offset
              0x0000000000050000, // Length
              ,, , AddressRangeMemory, TypeStatic)
          Interrupt (ResourceConsumer, Edge, ActiveHigh, Exclusive, ,, )
          {
              0x00000094,
          }
      })
  }
  ...
Generated IORT SMMUv3 node (Identifier = 1):

  ...
  [048h 0072 001h]                        Type : 04
  [049h 0073 002h]                      Length : 0058
  [04Bh 0075 001h]                    Revision : 04
  [04Ch 0076 004h]                  Identifier : 00000001
  [050h 0080 004h]               Mapping Count : 00000001
  [054h 0084 004h]              Mapping Offset : 00000044
  ...

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |  1 +
 2 files changed, 53 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 9d05982137..99490aa7b1 100644
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
@@ -1121,6 +1124,51 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
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
@@ -1185,6 +1233,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_tpm(scope, vms);
 #endif
 
+    if (!vms->legacy_smmuv3_present) {
+        acpi_dsdt_add_tegra241_cmdqv(scope, vms);
+    }
+
     aml_append(dsdt, scope);
 
     pci0_scope = aml_scope("\\_SB.PCI0");
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index e655b2e26e..1d5d8d1f6c 100644
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


