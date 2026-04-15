Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45441F41990
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 11:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCxxC-00037g-1m; Wed, 15 Apr 2026 06:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx9-00034y-Uj; Wed, 15 Apr 2026 06:58:39 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wCxx8-0004Ep-9v; Wed, 15 Apr 2026 06:58:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9dgzeQLB3RPrCSHzXFb/pYSZsZUAgyLpn1ntGFffazTxLQVQK3COmGuyuFsVP78cHnS2hoSDPUNkXhPlU+/VUOamwuXIszRVILEZSGl8VpNmV+kqoP+4J0PCxf3AeS/lxGAjhhtWK67Adgsq3AnjvCex6jwf44wDn+9X7JyUUGgzMq0z9d8n4YHQv6+I1hEum63GEApOCBQNdxm06puZ1xpTSJ67GC2PgkjqOZc2hbtS310GvtV5Lf2wdH0APLvasD6DZIMWDfo6ILSPqi238jGUOFresHYXIvK2uIJVMJx3VVxD8n21XMjON8xIlXYcXHxbGO6xo4IYL/yyMmLJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cCw8BM35YFhvylX34pbDGnrdrIHLxqy2N+OgIzol90Y=;
 b=gd4PwM8RFhHKHF+gWwcvLskK6wIW+MHkZtu7VUrYnrHR2T0pzYtLquRc+LYfwAF3wCRrw/o3BiGmpP2+OJPEwCkSn+Xle1Vz8TGGWI3UQRqzEYqqiPJLPRla6YdCOyS2UUpMSnnDhgtpVgb/yND2+5PXQXR9DYDqCinl9O7WySdhlKMB3RgW9bFyFZr2xNls9yiWuEGXvxL6n2pUmENgMDOtBZs5POK9eanJFDOuytP+qIEEPQCvNPqMD9MphqkNAESBYMh62MRKm8RNmzYanEN2c5t+jiQ5U/9lENgo8TFwIH0hHV6vQ6VAhUPVr65jvGvz52o2D6djvmZnEEd2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cCw8BM35YFhvylX34pbDGnrdrIHLxqy2N+OgIzol90Y=;
 b=aUZGyc+tJ409Z8cfe8B12spUdTShuQzthVJOCcjEmJkO2FpJzrQLXbIQ8ZhnMcyBoOk37Rba/0xnTPjVYmxEmCKuvOPXrnPlM5sICFFtPiMXgZmcte5vSkz3iK5nOBgcOyopbqdm25HOzDk3f0DyrcOTk9VaWd8Hd5R+kg4W204blYvyLyjTxxePZu4QvNc8BqJXmFBt4TI1TZBmLHFv73daUcH3uASqvGAohfwHRy7ZptkNX3pB2P2xKVtkyO0xd3EOArRqU7w2KEjH1HK46D26gW5vgVHaZ4IJqGhDJ8dQGA8cFtVOEfq59cW8MHKrgytDKHvGDz6HfRsACa+Z7g==
Received: from MN0P223CA0007.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::27)
 by DM4PR12MB5915.namprd12.prod.outlook.com (2603:10b6:8:68::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 10:58:29 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:52b:cafe::2c) by MN0P223CA0007.outlook.office365.com
 (2603:10b6:208:52b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.50 via Frontend Transport; Wed,
 15 Apr 2026 10:58:29 +0000
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
 15.20.9769.17 via Frontend Transport; Wed, 15 Apr 2026 10:58:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:16 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 15 Apr
 2026 03:58:12 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhenzhong.duan@intel.com>,
 <kjaju@nvidia.com>, <phrdina@redhat.com>, <skolothumtho@nvidia.com>
Subject: [PATCH v4 27/31] hw/arm/smmuv3: Add per-device identifier property
Date: Wed, 15 Apr 2026 11:55:48 +0100
Message-ID: <20260415105552.622421-28-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|DM4PR12MB5915:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bed5c0-ceca-44d9-e4f7-08de9added49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: +w2LH0tKBK0im6uTNFUmpmcjJK186gHeFuNs8Y4ocoxlDK48RQSP2PVkgL4N9jKkC75W3al7WBSJm/laFu6m0cO7VUvUYiD7ELc+xtOJvlaf68ddSLVWRGofQwV9DmkwS0BYoJNvk3vciiW0cjmxxRB2lqD5WQXV3wFWmwzAeg6w/HgBC4ouves0Azw8b6JJqX79xa8yCm51pBGHr205AAm4v22i8aX8Ae9BhoBgbQxpueXArXBBkEUlzUNC+uqpetfzSlt04oIF71igdbt24MObtyySNl9uLSW4Kci8XAIjKIjo30mTSmKxLadEr2A/BrQSLtPJZNdvOBfxnVl8u9pNyc8BiHpqU0hTWjosSk7V6EgV40jGkHjU2AQ3fZLecgDrVNYDAuktdrWagt2MpHnwqwQUWVNyI3ieX0U3vChoBIp71KD5Uk/74OOh4qladOX42dqN0SXvoC3quIVK8huBU1UT6iJUnVH4GSNpQbAad4yE1qnOXgmha4gmVSj0zbOWEbIw0BF5hIWr4qVb9cVYQkez68QEJU/x8bpzBV/VXFTG04EPrCm78AST5Y37XOLuUw2ZpmQ/WB/96Z1OPuOc9xiqLbiBlFXKCbAwPeW6BiOosBCLGcWCpLKPU8zza99hyV2bQIyZHH3MlVdSm1A+CGyQn3mABFhxnGea7ADVIDXz3b3JN+0sBzBXOkgpuZXZvRyv82T8If7WQGhEF4m0zwf0/PnFzyR6jvzeoX0jd50hodyTp/efxZhPaeOhHd7Y4qen5JweODA2M3pimw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YK4cjg1HW0hc02xqw84F5EJNc9yx7XgQbyk4cH6h5EBVu34Oax0sAr4+Vq1AnE1vK7p8psC1Osg1E/R9J3IXHMcnAgcXT8TmvgodPlYazWZuQyfi1vPXHJCTlc2ZuuMVomBTNAiB8XYsExw4TwaZ7isf+RnFb7eqfE2+QK8D6Sz7FvV9mHToPbfgV3udvdFIrEQzRFJFRQ26ORgoThmlci5cerj2Gm6S5QF8cv5sySyEQmdsqVgqm0k//8GAj1Bpj6JAQkuId1J6CsIquHYAqVx2VHq60qL5ETRCjjRuoBAfL0pXaDd1YsKZYaJyVfNbJfgwYJPOZV6j8xs5dVU16rsGo+MyzL8KLT6wQwZ4zmczKDACm775Oh7tGuRC8Fqs67o2kvuED7Ko7ipoC+evsHFxMLoUX1P9f/LFNxef7fsYjO41r5pX3Y0RxsQZiYgz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2026 10:58:29.0757 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bed5c0-ceca-44d9-e4f7-08de9added49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5915
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

Add an "identifier" property to the SMMUv3 device and use it when
building the ACPI IORT SMMUv3 node Identifier field.

This avoids relying on device enumeration order and provides a stable
per-device identifier. A subsequent patch will use the same identifier
when generating the DSDT description for Tegra241 CMDQV, ensuring that
the IORT and DSDT entries refer to the same SMMUv3 instance.

The identifier is assigned at pre-plug time, accounting for the ITS Group
node that build_iort() places before SMMUv3 nodes in the IORT table, so
that identifiers are globally unique across all IORT nodes.

No functional change: IORT blob content for bios-tables qtest is identical
to before.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/smmuv3.h  |  1 +
 hw/arm/smmuv3.c          |  2 ++
 hw/arm/virt-acpi-build.c |  5 ++++-
 hw/arm/virt.c            | 12 ++++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index aa6a79237a..0fce564619 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -64,6 +64,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    uint8_t identifier;
 
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 682d89c3ea..1d6fdd776c 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2144,6 +2144,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
+    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 521443de87..65ccc96349 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -342,6 +342,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 typedef struct AcpiIortSMMUv3Dev {
     int irq;
     hwaddr base;
+    uint8_t id;
     GArray *rc_smmu_idmaps;
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
@@ -404,6 +405,7 @@ static int populate_smmuv3_dev(VirtMachineState *vms, GArray *sdev_blob)
                                                &error_abort));
         sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
         sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
+        sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
         pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
         sbdev = SYS_BUS_DEVICE(obj);
         sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -630,7 +632,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                      (ID_MAPPING_ENTRY_SIZE * smmu_mapping_count);
         build_append_int_noprefix(table_data, node_size, 2); /* Length */
         build_append_int_noprefix(table_data, 4, 1); /* Revision */
-        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
+        build_append_int_noprefix(table_data, sdev->id, 4); /* Identifier */
+        id++;  /* advance shared counter for RC/RMR node uniqueness */
         /* Number of ID mappings */
         build_append_int_noprefix(table_data, smmu_mapping_count, 4);
         /* Reference to ID Array */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6c5e51af37..22d6b9eec9 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -240,6 +240,9 @@ static MemMapEntry extended_memmap[] = {
     /* Any CXL Fixed memory windows come here */
 };
 
+/* Counts SMMUv3 devices plugged; used to assign stable IORT identifiers */
+static uint8_t smmuv3_dev_id;
+
 static const int a15irqmap[] = {
     [VIRT_UART0] = 1,
     [VIRT_RTC] = 2,
@@ -3226,6 +3229,15 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                      OBJECT(vms->sysmem), NULL);
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
+            /*
+             * In build_iort(), the ITS node(id=0) precedes SMMUv3 nodes
+             * when present. Account for it so this SMMUv3's identifier
+             * is globally unique across all IORT nodes.
+             */
+            uint8_t its_offset = (vms->msi_controller == VIRT_MSI_CTRL_ITS)
+                                  ? 1 : 0;
+            object_property_set_uint(OBJECT(dev), "identifier",
+                                     its_offset + smmuv3_dev_id++, NULL);
         }
         if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             hwaddr db_start = 0;
-- 
2.43.0


