Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A97C0CD5BA6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 10:41:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPHsf-0004QV-LW; Tue, 19 May 2026 06:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsT-0003cQ-A1; Tue, 19 May 2026 06:40:47 -0400
Received: from mail-centralusazlp170100005.outbound.protection.outlook.com
 ([2a01:111:f403:c111::5] helo=DM1PR04CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wPHsQ-00079D-OW; Tue, 19 May 2026 06:40:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STLJDIzIG3LpbWooWBTVExxx/+R7f63uvZ2u+USiP2ruREAEL5NfqO2Guyc6d2t/iem4syhiIQ2FY9bcDjgAonM3Uh7BiyZzkbfEq7PUc0Bpd8JSusnh8lHRrRB+kPzwcsNfj1bm91TjUM60hzv+2KUK/oN+3niZNAItV3/rKjYuYjB+sFhRxFuzl/L2qwfuAp+JDseVPpxD6LW4hJB+kc/QGXoK47qaanc56DRPOsdpqQfEWNk2T8sFtrz8AE8GljNNM8vtCuXdkBSmRE6Sen/zc2hyXdWtAFqp1NVT5cK7Au742ngZpalh9NaXURt6JdvWY8Sj3m9QlSz73nq/Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FPth/J5ZGFeEsP4pYdNaqbTjB3ZaQrOotMzkOox/HM=;
 b=h958LBvhBMsCOAOeJxy/NYIjlkwtG2v1SVyMhI7942vz3fyotsk3xQup+odx+EyVHMLefiVs5HGpM7oNvR9t7rImZHoduGRxjWyTqOmrwh9E74KpNESXMnR2AqPsXVlGYiyEaVoNexOGX+7lgYEa9+HqoheD9C0wfedqEkBd9E4ULmv/fyPFBPq6/n4QhDe6ctUH+XYKMfZ5REyZ+o2tkEBZyA61jll2Pi4/+e63pG1RqQvLpX4zh+Ojt6m50vawE4n3oyATS82FeBLTM+YXg31uCvXDPlWBRN63ZaUNa/pA7WNgaSp1RIbNcFZ9fiasJV4mi/mVLV5QQUrRHGmMmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FPth/J5ZGFeEsP4pYdNaqbTjB3ZaQrOotMzkOox/HM=;
 b=ZML+9sAbjKfn7C8j/2lgLwdQS9ua9tR0jf6SdT5POeu81YXvBrbvm2mX9Y7OOkYRImI/GJxEqZV5R95gFjJmmkxDbe8ZBHm5ags9BhxYhz9kUvUhdjVIYMl0giixxmJV2ozaiD3dmIcCdDjs+c8EstpKeTLH7xEZnPQR6NIreBADcj75b4owGr4gRcBOH2WuDtfVEInaI5p0zWbKCDuCGRUzK8bX8Bo3txJ3YywMDE4yhioNChl4v1kKqPvI3ie4TEWOKT3Q4ub5SjcKTs6rEyuy0LCod6KSLZY4D+3T4Dfs/x7CbzILj7a4BQOScnS/lNJ309KBrdF2pV6u3qE/zw==
Received: from BL0PR0102CA0062.prod.exchangelabs.com (2603:10b6:208:25::39) by
 DS0PR12MB8573.namprd12.prod.outlook.com (2603:10b6:8:162::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.14; Tue, 19 May 2026 10:40:35 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:25:cafe::6) by BL0PR0102CA0062.outlook.office365.com
 (2603:10b6:208:25::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Tue, 19
 May 2026 10:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 10:40:34 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:17 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 19 May
 2026 03:40:14 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v5 28/32] hw/arm/smmuv3: Add per-device identifier property
Date: Tue, 19 May 2026 11:37:06 +0100
Message-ID: <20260519103727.899332-29-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|DS0PR12MB8573:EE_
X-MS-Office365-Filtering-Correlation-Id: edc90e19-a1c8-4697-c3bd-08deb5930ee5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|22082099003|56012099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: XCkpE2dx+wIt2SeP7kibASjOkn2X2yuEMwU+biz9kkmC/hZj7lW81XReBsWpuDY00KQYQn+zqjV3GdbwFPOGAa6bP4gL3Crpp48SqbJltFWHJ5+87IB2KtgX0izFJaM8GVow+8YY/wwwufNqbXm3aK3rWcaWYUOLER272WKMkiviVBNTfqSUS9qjqA5bGRee9CqSTHew0ljfBHJ2tCgrLa9xfJ45cva0eAzwEWzLnDi2MZEzqtrWjDP/cwW9RphmYxKT3WAfdEP9oxOepJRo8zpGchpTbPu60FvMcuyOGn5ZdlrSm0QGR4XlFgAWkqKf1Hg76WYNxMLdqMxPzbYoDQjZmbrjSw9zZhzh3pzFK//Cof3tgm3Rp2cn+1L08eD8fPh6zdI3ezoJ3BEOj90OK7ZdTx1t7eiMLQm8gcZUa/XRdYShWe7X+vk9a1lBnHQppboIfaSZVKGXsVrvdU2HaqMyRef0mLawJ1eJLYMo/fXVDjdo2a2Y23+5RTeCRcekMi4rJmtrXtK2qMAb51Mz3CfDJLXHw8IknU23R2c84l4lcWPwVL4yuLu0yenkJ24yZBXNWUVJYb3PIZsrzjl87oI9gC5MHNsI+p90719CbFX0M2jCgFpRAP/TD0JbxcdH8Go6lW+RB6gMFc0EBt5TmnfXdiV4AyLSGZu/i37cT57Jff9UJQ7kHS74ejNKjxfk34AvVlypGTU+rFlJ0VgJi6NVFB1CDksnMu4SXObUKSw=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(22082099003)(56012099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +wyBYbA0dFFHNPij81zFfMMNR8emOldaQqg49Y+zmX+Hs5P0rBVrJBj+eBhLpDogdy+xkVxajPdFmH8ba/ZJZgWRfj/Krd1RCC40agnXdLAiN4OYwdr70/Z2shnUVoc/rBn7UA+kw5jGPHrFlW3EcsQ09G+bltXwx0M86Gk/mzQqKNPoU6lb3Q6K4ybio5qJ2tSsk3jWq6DRpCZLY+MqZZ/GrOa98hkH7XppGyjSb2M480c0JZQDcavnpA+Dnp6+UTeVVdmF7+qNHgRharUeUj6m0WcmUEgGPfx0Wy7s3cxeNtrRu5AH07aD1Zc/5M+jqyOH7VTR+aeAWVCTbJ79hRFaiehMAMKpYSc6qMBTEJehW2ZCTQoeIupVy9usKu7mfxozwVdOzTQLwQrndSj7z1fdKCHSOPUMhm0qNouD1X0Lo+lHMLUaMj8L7iBmUP3v
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:40:34.6049 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc90e19-a1c8-4697-c3bd-08deb5930ee5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8573
Received-SPF: permerror client-ip=2a01:111:f403:c111::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=DM1PR04CU001.outbound.protection.outlook.com
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
index 665e6a2538..763b86c417 100644
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


