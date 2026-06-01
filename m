Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7906CD6E5D
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1B4-0001Yh-De; Mon, 01 Jun 2026 07:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19m-0007HC-Kt; Mon, 01 Jun 2026 07:50:13 -0400
Received: from mail-westus2azlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c005::5] helo=CO1PR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wU19k-0005Ee-SJ; Mon, 01 Jun 2026 07:50:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hj7hAr7S6O0ZvyV2WDaWIgsDUFdDHSScEZLi7Zf4GsgcAZPZX+EuhHA1nH5+uat3/8mSnsgJXiICXyLdUQbWoCU10liEV4vo+dG5drEnOQmxvrMbcz70ll7yd3WuQbn39lO0ZdixjELoKRkEWTr6vVwvWG9RoslfN5WrRRHpprDNm2ItsfEhDEZPHxJdlP7ZVafQIzKMv4JOvNWtVOiZK749qJOMJkvCUiDU2RmyCcu23U4NnsZSExXdC4SXmrONxSjGlWssam4bkr16+2lmbRr0v1/DmrhZUocazZxpaCwGahrn1ZK/GwM90XeXljQLyqTg0m6jkSWub9rYiKV5jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hg39hGx6Z7k4sx3v6fX2GDqWQ+t8NUQoKLYzUnVxdXA=;
 b=b7zZb53I6Y46WYKWtjZ6CofrYvihOOblspHMcJNuzANAJ5PD/ZtW3BwRTTrqZxE0/fLdd4lFTMblGikcfPwHkaF8oybxPo78yy9Q4nym4FE0DJ6djWBAfzTXZwOmKc69S7N22K4csg16nTUTcuub6/PFrDdimLvt6qDPFxshbBZKF6PwrcDL47Cogwi8RW19sKqZidmn+em/umz/yLCFzrW6GKHhSFGGQlr/cLkNq3zNz1QGKGRfT6qzpjl+QU+oSDQ9/dnktnzYN99T+Ky5fEzzK4nsBNerm9RfNTbq6Y0OjtUor6Wfmzn0x6PNoab++8BbcWL20LAZnN35Gybmuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hg39hGx6Z7k4sx3v6fX2GDqWQ+t8NUQoKLYzUnVxdXA=;
 b=Dw850Yby6M8rRwH1zdiPCtqYLszWKJc1e7/5eEGnzwuGzxakVnIQ1kyyDBXcG52MxzakUyDqi8SAbdYyePCXAxKd/GKLCr9Yz/FXLu1D6aYEM/E/+gh3E9LhWQmsf8UroLBH2PrP7p3acI24LKsO4CDEFHokVEmyx/Z5gru0kxNQSDfYTxfLwllfRYH9WK8z5qKqsGSsPCJ3/rs6ay0csE0jiDtd8BSKctQX4fVGN7A5Nj4eSND18gtU7YN2it6PpMigiq6QnmSJWlBGoemMgVE8fc66kF0iwKv6vbmpVTxF3OCFmYGqZIQwEKjWzJxow5ubrkxk124wjR6lCGdFLA==
Received: from BN0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:408:e5::7)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Mon, 1 Jun 2026
 11:50:02 +0000
Received: from BN2PEPF000055DA.namprd21.prod.outlook.com
 (2603:10b6:408:e5:cafe::7f) by BN0PR02CA0032.outlook.office365.com
 (2603:10b6:408:e5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 11:50:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DA.mail.protection.outlook.com (10.167.245.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Mon, 1 Jun 2026 11:50:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:51 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 1 Jun
 2026 04:49:47 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v6 26/31] hw/arm/smmuv3: Add per-device identifier property
Date: Mon, 1 Jun 2026 12:42:16 +0100
Message-ID: <20260601114221.457995-27-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DA:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 9745510a-0c0e-47c9-feeb-08debfd3ea15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: xVLB3iNFPTJCL8j4qfGQY36JZlN6G/p0G/pnQcwzYrAj/l9mKsdGewT9LTnCQI6VjT7O2VTdX5tVvmETebikjlMZD860d7UgAE4Po5L7VZjKrUSJeBzbJ/Os8sZ8xoIDCEdiwdyqyaWu7jLqSUDSEhIaXDB24fNXVkIAyDgKV4qpDg6LKKaNJNNo+5VXVvlwLPd7MZMortGWjn9hwjUQPmEQ+2/pKfop6FbgEI3pji6r5px9HTN5v5pbeCiL8VUzu5jzNntTxQqaeJoO90PAVxp5FEGNeU3Sl3QjPHnUtpVTPTh81zs1rcPPyx+eHyq5aofixonpoXKqlN7OdzW1bf+OKYflQl8B3kT+MyGNdTCtmH7O2tkNJ9/9WnhvVjAfxXZ/sroI0skhIfzpN1jeVD8E25857q6e8C/hwdmpxWZiapFi2kieSf6iPBmebEY0mxWsD2JFLDCfdlg2dLUKx1u58qchArnBgh/tXIchQ88Vsz+2yk2A+DUBLQdxjL6Lw+RTjTKzY3jf/7eQx431+sptiSYvYRABQPX+/ZF9S8xq9Dxe0C4o6GMsuGUFaLMyS6sOAvAUCUHwhTLchw/kn5CFeUwcNLfZxyaFqr8q5eUg5lo91JKOX28dtSU5FJZ6zb6JsqoovomEnI2V3JB0gKtgcffpVTDi25/z8rlqIzEsLdllzmlEIAdlbK9K7e8UH0OqGdoNZfW/zvtG6pJ4v9/X8DPw2Fipe+qJujqOARM=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i4xDwVx0j7RRhRvhgkNAjIHb0tiVdPHDU4cPRf1C143DKmHSEFkJtO5N4PSLzZp7GJMM++1cp0rtfZtrtNJGyzMr0AQaKMsLiA30Khlu3Rq3hktW1yrZotVESwjfIuUfr/i2OR1a5P4SVfCEodqzOiY3+B12t7Tpr3N+LK3nnilCtonyjSkMoYJET2C0aY0ahLAjcFhJsvgI45CjCn9wMrl3l5Tjr+Kw6CXRfRiEoli6rkS984+YbtdtZkgORu3b3JU78UWOaMGVsIrL3A3+u1RHAp15XNLYhynQRw7u7wIXk/xx8/DAaC887emgdwCLmQ7QChyQ4GcHYQaODJwQV6KKCOYVgFWYcg4uzIlvAvdip90GrugqyPJfyqbZKgnEK8HcsqSnvUIL288yAFv5hxFPJ5/hrEIj3C5twW3Q3IVpNPkZsxI0LbSd9LE05K2R
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 11:50:01.7711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9745510a-0c0e-47c9-feeb-08debfd3ea15
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
Received-SPF: permerror client-ip=2a01:111:f403:c005::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CO1PR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FORGED_SPF_HELO=1, SPF_HELO_PASS=-0.001,
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
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/smmuv3.h  |  1 +
 hw/arm/smmuv3.c          |  2 ++
 hw/arm/virt-acpi-build.c |  5 ++++-
 hw/arm/virt.c            | 12 ++++++++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 34d0f65eaa..d39fe8850b 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -65,6 +65,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    uint8_t identifier;
 
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 4e630b6403..0d111d638b 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2126,6 +2126,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
+    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b00f3477ca..9d05982137 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -349,6 +349,7 @@ static int iort_idmap_compare(gconstpointer a, gconstpointer b)
 typedef struct AcpiIortSMMUv3Dev {
     int irq;
     hwaddr base;
+    uint8_t id;
     GArray *rc_smmu_idmaps;
     /* Offset of the SMMUv3 IORT Node relative to the start of the IORT */
     size_t offset;
@@ -411,6 +412,7 @@ static int populate_smmuv3_dev(VirtMachineState *vms, GArray *sdev_blob)
                                                &error_abort));
         sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
         sdev.ats = smmuv3_ats_enabled(ARM_SMMUV3(obj));
+        sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
         pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
         sbdev = SYS_BUS_DEVICE(obj);
         sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -637,7 +639,8 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
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
index 2add7401a1..d8d27f2ef6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -254,6 +254,9 @@ static MemMapEntry extended_memmap[] = {
     /* Any CXL Fixed memory windows come here */
 };
 
+/* Counts SMMUv3 devices plugged; used to assign stable IORT identifiers */
+static uint8_t smmuv3_dev_id;
+
 static const int a15irqmap[] = {
     [VIRT_UART0] = 1,
     [VIRT_RTC] = 2,
@@ -3830,6 +3833,15 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
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


