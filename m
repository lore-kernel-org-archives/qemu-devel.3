Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6684F41990
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:01:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxxM-0003Ss-6x; Wed, 15 Apr 2026 06:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxK-0003Nn-AC; Wed, 15 Apr 2026 06:58:50 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxxI-0004Fu-PM; Wed, 15 Apr 2026 06:58:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xJmJIwwuuOisgCk156l7g1v6eJtO1pQI3BdMIvyLXiM4TLxaYDj9JKQECQC2Mxcg/St1R32Vk6jX6bEQX2xs3LeQienbnzQnyuKm+4s9Rxs90Ojy/BA/7JvdkHWSzPYMiIXIoTbqygmIfXYT8ZzkMCFWICWmYblHMz/pj35eRclkbeiI1iYJoGv86Xj8C3EIVKodyd+w/eMno97f/EwaCq/0CRgQctj3u1EZ1C8fvbx0cCEDU3DNo3UKJ+vcnndDwHcBSED7sKiRDNW/eWPJP8NTVZuTBTzlKaR/LON07qB57V7Gjdd0KLM6HxunKjjgKctDANEkFyM/rS24hnSynw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ZxOb16qzKISke/IP9Xa4ip3IdCjXtPBCv/5Whf5QLo=;
 b=s9vLQki1wwXLaUhUWqxmSY1T5owv6znH3UR31ExDm5026PEAl9iNao5NCWAv3xvP8dRORRN6shJTm3F2RxNv7FfWXFNCmV+3maAvwUISsXLSES4inZE6IpWAAbkaBf3O6Njj64ef/3WBHaUw8glRC+28ip0AbeABigfjqedDHJ+H5xgcdjV8E0JSmNAGpLihYMoaaIgYQunOYN23yDLZA20Ds2GUBtIbA1cfWhbTXtGIM968JuFaA+xjHlhxDXmlMZ5NQzQAYjmgiGHLZdhnqajezsN+WNmTr3rkGJEtwsvnY00b740LDacSX68ZOe0BK0NS/+BT/yzQHy9mYmOhdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZxOb16qzKISke/IP9Xa4ip3IdCjXtPBCv/5Whf5QLo=;
 b=kB8Ob2Dp86Jlf42ZDQgsYOx9SGHaf0eYh4gbnz75/hC4HqTNMZ2RFwVt/YKQiN2uC5Ra8de2CYq2GJjB0O1lSBRg4DTmpB1UqyWpYBL+rUnVpICDz7sNS8H+5jKDypsk9oSxVptdMQUfUzdLLTpTjr6zatlWQhH2sTwG011eMH2fZRSOykWOut3xuV51d07YIw1hzUbsC2n7RnVNnBMP24IxPY08r3hkGREG4AuwRAtV10aZ9oIIldV84BFM7CI9681h5nL7TJpSghH32dEBycRvqgC4bE0gMcqdDUm4YDHfOQMSVfwRaH/pnuWpevDx8mGFitTFFQuzuWfaSIwA6w==
Received: from MN0P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::9)
 by DSSPR12MB999211.namprd12.prod.outlook.com (2603:10b6:8:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:42 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::ce) by MN0P223CA0015.outlook.office365.com
 (2603:10b6:208:52b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.49 via Frontend Transport; Wed,
 15 Apr 2026 10:58:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:24 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:20 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 29/31] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in
 DSDT
Date: Wed, 15 Apr 2026 11:55:50 +0100
Message-ID: <20260415105552.622421-30-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DSSPR12MB999211:EE_
X-MS-Office365-Filtering-Correlation-Id: 863a11a1-791c-4408-6a43-08de9addf4db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Faenl6VGC/YQ/M6hqfBRlZ6Whhibh/BKOTiaE0TeS4hVr5aMOYsjBUyos+eQrUdvIITHcc34Tm12j9xztzj+99Zut1gPdpxQ1/AkrFuH8EQXZOXXgf/rBPIy2vTO61rZ5RgJ9HntmoVtYJQuGIEgrtqn6PgVFiUrmpp7s3/uWA5M2uDvgl8Dy0130ZBmlstsBpAkCW9HGsbfy9HqX878TaqNM6ZjSF7XwH0Bpv/bxpNqGekUHYLmuXc+sw/njT3I5MRRdv9oxzwq/Cu2DUYxShHiMTb6jTht3996Q6fND96r9C30TGMIiQPSNx7BLQ9UrMrBoVV3x9ceV1mnxNH0c6frGuqz1tLa9Ie7vkfpsFXnZsaWC3XhCUjUrGFO1G5MbSIp1eonLWSjDzGdLdfIvy7vX81KmC3EpD9HDkJN7DAby9c0u5Dy1a9KHxEztfGwEVwzrYfB+zOmFUYByellSCPJEDtM1zu8UlJY11x0rFWjiLxpHJGNpFSnqexaKhl+ecDDzQmkv5RLp5FWTtyarE2yUOGbdFI3UG4zcDx9nvBf4j8YiTA0/iNOYxpWXQT7pc0gJyLX5srJmAt3Ww98dfNMNAdQMLZWdO9OHQApwDicby56xMqe1AeauM2sO1G35mtedE/6SJ6aO12Dmuv49oxZ8gLOsuHMA6xJ408bpdRmiJysoLSTJM34nsiF0BEWqQFfhzMVJpLDEa8ccmyRh4D0LjvyT3N5ds1nhsUMH1sOP+GAgvU0uDfAJF5wpu+Nxt5jlf5E5qJ/utQJ5jSSqg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7VUpbsw446BKa3rJl0fPqoB/gvK2bBoYqj/m7OJeIZN/bMdhHoFyiePAK9rjwpxcy4vS8yvEAnC8jLOxWsOC2e3sFoKv/qum0FCNOMfPt1T7K/iEL7wzD93narwoB7dnv3TPtHlFShoxLeHOChvvrTeMNsHPslkXyosASr4tJs7d+jSSJgrEpbuTzN50rhJv68ViXUOwa7NhpI2mUO50ect/lZGgptzv3ZzprbzouLvpBejsKgueCVsfMDl24fyjE40CmvYJkkDCwYYZKEIVmD21QPT1v9PmXWvjCRkW/JmrxA8+EzttUqYAiHnqdb7O2unDnibQxQGHYbKps70koWBbpwW1I2gzD0szC8NWMCKot/ANOy0EP4xi4Ta5ybvcyijMpPrU52MQCE8/RHjSWEv3aK31sC2o/x4cD5R5dk742WJKBK/DLKcZ//TjLVEc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:41.7856 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 863a11a1-791c-4408-6a43-08de9addf4db
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR12MB999211
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

Add ACPI DSDT support for Tegra241 CMDQV when the SMMUv3 instance is
created with tegra241-cmdqv.

The SMMUv3 device identifier is used as the ACPI _UID. This matches
the Identifier field of the corresponding SMMUv3 IORT node, allowing
the CMDQV DSDT device to be correctly associated with its SMMU.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Co-developed-by: Shameer Kolothum <skolothumtho@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/virt-acpi-build.c | 52 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/trace-events      |  1 +
 2 files changed, 53 insertions(+)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 65ccc96349..fbc793d06e 100644
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
@@ -1114,6 +1117,51 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
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
@@ -1178,6 +1226,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_tpm(scope, vms);
 #endif
 
+    if (!vms->legacy_smmuv3_present) {
+        acpi_dsdt_add_tegra241_cmdqv(scope, vms);
+    }
+
     aml_append(dsdt, scope);
 
     pci0_scope = aml_scope("\\_SB.PCI0");
diff --git a/hw/arm/trace-events b/hw/arm/trace-events
index 6f602b9eda..e5e4e93324 100644
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


