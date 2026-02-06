Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1995CEE20A6
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 14:55:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voNCY-0004iA-Tz; Fri, 06 Feb 2026 09:52:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAw-0001QC-DG; Fri, 06 Feb 2026 09:51:15 -0500
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1voNAu-0007Y3-Lo; Fri, 06 Feb 2026 09:51:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u12RQ6G/oJWmDARIcok3P3EK/cJ4ob9sHK4p+VhEHP8sOUbhNT1QzYI2N+mvAtlBKKZGggqjb4xF7gpHQbhYO0qf5iyE9+YdaGAjS3cPE8e/syrQK6jrxCrj2I4jUUCoq+9r3NvzeHE9yJ0VwIC1fhA3U2dsQNzSV3cpH35mtLon9TUU8a/QRhAwuBQ8Dh8uoJWmMbjkMcmb2d3ceE4sbo02mLnOhzJiIN1uGJaaPo/JXwX0FQfkOHiLMqWpZTGLfehGm18UrjsvTrQgJE3rX2jWpgB6mfoGL10Cq+2Bc9dLaL0fwEKCJXLwlDsn48Xlho+oZoZ7rQT5Z4pHIHEiiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRm1pblEIZS+PVQt6AzCZGCgR3UD0tQo83o8QXTe71M=;
 b=G9CvMha2x/jjS0YwmaR0p1GYB3/HRdnl9FMo52PlaxddPhyO9ZOU6dcimJWnxraKZguwULy4lBIlESev1L1SAIs6hAfTXFR8GFzkuijkbK45fucC3aTXGfuH7A/r7GWv9sl+77B5wEeUUEuytvqMdmTtYhp+AmBLLG6Qbknr0ryf1AjyQlG7Vo1m4iY2D59FqLhvcrg70YI/POVDPgoe8Aq6zqNhJNU7wWgr2WIYn7YES4wgn6xd8iOZeJLto8Ipn32JWeVPuSrX7chXXQBNUu1xANFhdp/JpwYwSjerQDnRo+hwZv+5jVZ9tK+v2A8crKUsIggXBZ09+BbG5SanYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRm1pblEIZS+PVQt6AzCZGCgR3UD0tQo83o8QXTe71M=;
 b=tXqbOYKVSArRt7xUjycUbD/ISPPKhp9M6+fTfqVKraC5E5PA2SdGj94rqcUV9xgklA24Q6lSC2YSW5lqeI6SqHv3beQJbqe/xDc2fZFE+8FdWb34SewNIW7E6cW431OR7sBxBVuM0uie4mXdA4toESCUna9E4OK0ASb6bB0hAOZPXDpx9gAA5oEWIGw0wCjOqFY4g3Lg4+7AsMn1MzkNpAiGPlwJKdXL+g4XEVli3/l3WkSBiva5xUtLkvcIdSiIfrlvVse1+ih85eE6l7DyBwUCLQ3/LbzbAokjQx1GYVytlR9DXdp+KHnCO7ABDpM1Wm+9da3a0jcKqEWp1ZWq/w==
Received: from SJ0PR03CA0367.namprd03.prod.outlook.com (2603:10b6:a03:3a1::12)
 by LV3PR12MB9329.namprd12.prod.outlook.com (2603:10b6:408:21c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Fri, 6 Feb
 2026 14:51:05 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::12) by SJ0PR03CA0367.outlook.office365.com
 (2603:10b6:a03:3a1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.14 via Frontend Transport; Fri,
 6 Feb 2026 14:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 14:51:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:38 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 6 Feb
 2026 06:50:34 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v2 23/24] hw/arm/virt-acpi: Advertise Tegra241 CMDQV nodes in
 DSDT
Date: Fri, 6 Feb 2026 14:48:22 +0000
Message-ID: <20260206144823.80655-24-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|LV3PR12MB9329:EE_
X-MS-Office365-Filtering-Correlation-Id: 732a4651-5bf3-4e2f-b0ae-08de658f2728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IxlcO07+Gco51fgeOwlZciyOpizW3oDmScUhMwU3DUdaM+w01/rxySWfNJDW?=
 =?us-ascii?Q?2/c/0SvmhOPPJfONt4Nl+G+gR/81DDQDBWN0BOYpENshMRle1dNYstDoynbh?=
 =?us-ascii?Q?hyiz0aE40cjJzF5QeAd4GyeUoWqVR6N55/kzy4TvRvQxicYkZLajDCIEe7O4?=
 =?us-ascii?Q?OeofPSdcOR9JccwjTKvgPx6qLR1Hq83EkDAIOqteEvVm4/apOUCTflCtEty8?=
 =?us-ascii?Q?xOYclbTEkxPRaWpnKUYEoPzrnk5yHsc5NOK0ieF3joh6nFpUznugqVkSeu6j?=
 =?us-ascii?Q?YjADDCZnSUN6asOWDBhfjUTSz1HoX55WE4PZ362HZiZwsteU7l9wyFogzTk4?=
 =?us-ascii?Q?FZcWXbbY3SmPk1UFPnuH+QKeDgcAFn+HRdrQpUv/GATOui3iME8pU+scTwFU?=
 =?us-ascii?Q?KlcBEp6Tx+Aoq86LFuKInrowTVmaan34/npH2fkjNKPAKpq6TCl6GHXnPbfJ?=
 =?us-ascii?Q?2LMj+fnDKHWBi6gZjj+AaqJ7759TRqtkMRw1Apk5WG9hCSSJNIwUh77eh1yv?=
 =?us-ascii?Q?yp+CD2K0H7JuCO847bhuS6w1oA9JYr24UE/FTMK/RAozLAZFKs0+xf/lNJuW?=
 =?us-ascii?Q?n0rQX9ILVa6ZHM41w48hD+kEpd7YYX3KrU3QMqBhO+wtia+lj/u5XVYpSjgT?=
 =?us-ascii?Q?Gvtl2OAjbH+gTmtOnjzBPWoErMEZNn647GMB9M+yyQuRbv7CETrsfdusO8mg?=
 =?us-ascii?Q?UFFfgW/DQuauF4N5q8PUnJHkjXqcGeioXBXFoLZnht9dzhMtdmv3BnmQ/D5A?=
 =?us-ascii?Q?IOOo52G0Qb+ngITzQNp+zRuCEqZ+tWwwVhuHTWZSPne9QS2YR3pXX90d4F4H?=
 =?us-ascii?Q?SV4qBiNz626MVVMe3lbSd12Ebof+R4Lks8aM0+s/8rN8UENIqZ3/SPCRoRES?=
 =?us-ascii?Q?qPMEnZ0s6rFA1xL2ItKxr1fO7SGapHjNI5QxGbZivFkDWBVNFPyeq3LmDbA+?=
 =?us-ascii?Q?8Xxvi5yMrlgQq0t0WGU9NWBWUMP8AiVcVaKvgwBzCWkwtO1WKjaSttT2vgTa?=
 =?us-ascii?Q?ngAEGEi6VQGzUL2qhfGEy/C+2J74Dm8k04yP6gABJ5F1knlzquOGxwj17EUD?=
 =?us-ascii?Q?kWcUQh7GMQMDXjo6DxuvslvVG1wDvFsH0stBpbvk8pnNQf2WZeQgfleBKHy/?=
 =?us-ascii?Q?Zc2dDloD9a6NVRkqqe42ASMSp3G8f5oChuiH7XlYhK/vskDLet6wQtRo5reI?=
 =?us-ascii?Q?oUh7usONfZk1uoDJjNkTyTowmpHLQKa370PWitQ7r24jWqXVDtg6GZN19/5S?=
 =?us-ascii?Q?0Pk8FzVcTz+dLSVJmsRSqIQn7WIDA2NXBld5DR8dGSujnEyqOaU9ELShifFq?=
 =?us-ascii?Q?AXFW0bmLx72IMVcR9IIvXTHT+E3i2KDnhn4zw1H4UUMI2lSeFQLsc3Ki76oV?=
 =?us-ascii?Q?Z9gpeNJYSPc1417zhNZCmof21hyp3K3xJ83L9K3B90yYlZ7pqsXrvkOmqlNN?=
 =?us-ascii?Q?qMU1GlI7Gva7WShyR1lPAwLKX1CEuxwCoxhjDWQBrhXPCHcL0ICLxjJOhObc?=
 =?us-ascii?Q?zrbF+QUIIRwZBJHgPMJ3dv0/aWogz66C1lhy+v5//f3MPyuQ1ACacX5LNapn?=
 =?us-ascii?Q?tnsgILA/SGZDhIYGFdEpOhB1MlfPGYIEZyfL2v+I8VShCO2bId1CgbQzmfbE?=
 =?us-ascii?Q?NtokjnC9N7FIkh7PbKOOSlDKquecEgutNzOionLoJoqELbHYTsW+ayxUupYg?=
 =?us-ascii?Q?RyCtLw=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: lZmCJHBHoJbYastMHwmiKv020RWnFhAYtporMKzk4hFKUbx4vxd2yaW6UIcIHSyM5wN8z+2F4nCa6TSz5TEtGkOAoM63eBzkt9lePGLKJJJF6dg3qh2oh3cwX8EhKa6Wv61sLtETlrui2veO+0f3OYycPlUFc9FF3jmMsrU/b0vKWFiQpsWsHfkgh5SAes4kmbNC4HTUuZOt1d8rCkL+fQcMJuZrFY33JpmXusvqmtzHu5d6bkrTVIEPo8oSWKhErQc0RhqFvptQOUfrYz4HUOudpnEV+4gUZrSP6GjlB+ZI2m6pjnTTX5+5GC4UTWx7Bt05wSFzZzoZ/IAqS2PWTInjlvb56uxh1xsidB5DChJOhz9cU+4zWxV83u6GtS8ZlsRcIdpbx55tGz+yhDFtJ6galDt8mqFp8zkYLYTXZaKSafoFToLn1zwN31U7rvql
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:51:04.3491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a4651-5bf3-4e2f-b0ae-08de658f2728
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9329
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
 hw/arm/meson.build       |  2 +-
 hw/arm/trace-events      |  1 +
 hw/arm/virt-acpi-build.c | 73 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/hw/arm/meson.build b/hw/arm/meson.build
index 4ec91db50a..af0b516df1 100644
--- a/hw/arm/meson.build
+++ b/hw/arm/meson.build
@@ -1,7 +1,7 @@
 arm_ss = ss.source_set()
 arm_common_ss = ss.source_set()
 arm_common_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
-arm_common_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
 arm_common_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
 arm_common_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
 arm_common_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
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
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 046e930ca5..fe2925baaf 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -65,6 +65,8 @@
 #include "target/arm/cpu.h"
 #include "target/arm/multiprocessing.h"
 
+#include "tegra241-cmdqv.h"
+
 #define ARM_SPI_BASE 32
 
 #define ACPI_BUILD_TABLE_SIZE             0x20000
@@ -1121,6 +1123,75 @@ static void build_fadt_rev6(GArray *table_data, BIOSLinker *linker,
     build_fadt(table_data, linker, &fadt, vms->oem_id, vms->oem_table_id);
 }
 
+static int smmuv3_cmdqv_devices(Object *obj, void *opaque)
+{
+    VirtMachineState *vms = VIRT_MACHINE(qdev_get_machine());
+    GArray *sdev_blob = opaque;
+    PlatformBusDevice *pbus;
+    AcpiSMMUv3Dev sdev;
+    SysBusDevice *sbdev;
+
+    if (!object_dynamic_cast(obj, TYPE_ARM_SMMUV3)) {
+        return 0;
+    }
+
+    if (!object_property_get_bool(obj, "tegra241-cmdqv", NULL)) {
+        return 0;
+    }
+
+    sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
+    pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
+    sbdev = SYS_BUS_DEVICE(obj);
+    sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
+    sdev.base += vms->memmap[VIRT_PLATFORM_BUS].base;
+    sdev.irq = platform_bus_get_irqn(pbus, sbdev, NUM_SMMU_IRQS);
+    sdev.irq += vms->irqmap[VIRT_PLATFORM_BUS];
+    sdev.irq += ARM_SPI_BASE;
+    g_array_append_val(sdev_blob, sdev);
+    return 0;
+}
+
+static void acpi_dsdt_add_tegra241_cmdqv(Aml *scope, VirtMachineState *vms)
+{
+    GArray *smmuv3_devs = g_array_new(false, true, sizeof(AcpiSMMUv3Dev));
+    int i;
+
+    if (vms->legacy_smmuv3_present) {
+        return;
+    }
+
+    object_child_foreach_recursive(object_get_root(), smmuv3_cmdqv_devices,
+                                   smmuv3_devs);
+
+    for (i = 0; i < smmuv3_devs->len; i++) {
+        AcpiSMMUv3Dev *sdev;
+        Aml *dev, *crs, *addr;
+
+        sdev = &g_array_index(smmuv3_devs, AcpiSMMUv3Dev, i);
+
+        dev = aml_device("CV%.02u", sdev->id);
+        aml_append(dev, aml_name_decl("_HID", aml_string("NVDA200C")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(sdev->id)));
+        aml_append(dev, aml_name_decl("_CCA", aml_int(1)));
+
+        crs = aml_resource_template();
+        addr = aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED, AML_MAX_FIXED,
+                                AML_CACHEABLE, AML_READ_WRITE, 0x0, sdev->base,
+                                sdev->base + TEGRA241_CMDQV_IO_LEN - 0x1, 0x0,
+                                TEGRA241_CMDQV_IO_LEN);
+        aml_append(crs, addr);
+        aml_append(crs, aml_interrupt(AML_CONSUMER, AML_EDGE,
+                                      AML_ACTIVE_HIGH, AML_EXCLUSIVE,
+                                      (uint32_t *)&sdev->irq, 1));
+        aml_append(dev, aml_name_decl("_CRS", crs));
+
+        aml_append(scope, dev);
+
+        trace_virt_acpi_dsdt_tegra241_cmdqv(sdev->id, sdev->base, sdev->irq);
+    }
+    g_array_free(smmuv3_devs, true);
+}
+
 /* DSDT */
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
@@ -1185,6 +1256,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     acpi_dsdt_add_tpm(scope, vms);
 #endif
 
+    acpi_dsdt_add_tegra241_cmdqv(scope, vms);
+
     aml_append(dsdt, scope);
 
     pci0_scope = aml_scope("\\_SB.PCI0");
-- 
2.43.0


