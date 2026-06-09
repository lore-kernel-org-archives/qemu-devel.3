Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF0CCD8CA8
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 11:31:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWudj-0001wz-Qa; Tue, 09 Jun 2026 07:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudf-0001XI-Bj; Tue, 09 Jun 2026 07:28:59 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1wWudc-0003qr-Qa; Tue, 09 Jun 2026 07:28:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tkq2pmRiugDQl4VsfPTvxv3D7oFebqxhsyoE18Por5JMF4T86+jyaZjXd3Vnjm9oo/ElX0goQCZYP6WZti6tlxElW5SLQZ5mHicdLVkjMfhD8A0njTwe77olUJ8RkfLxRoaWbsXhK6I+pZSzWBWZUUQFRIscFNApo1nmeWlHjOlJ0Fh9AARhpEOP+ZL3sOZjJKBRIkO02aoRamewhuOFkeHCzccMyeJSFQf3/k0m3avUJ1R0IYy70UbEe7NCavJFEbzrmD0R6/XEXIKswg8BiRbQKZh7IKNIRcVjgCAPb9/SJkoevikw1WN2uIWFDVJjaPeSVKWPQbamYyXUREHlCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wb/WypMQbdb8KtRoyLHakmlqnqlI9HpAU490gubGyJQ=;
 b=K2agFdyH/gWQAGUpVmPLN/QaLVrQA+4dMiiuVv7qLuSH9uvL5jFU/ThiZNhVe/n4guYz1ctTnbm2LPfXfBlUrkTsLspLYefd4Pd5o4k+EDNFLBFdRNyYMOatl+G3kn/a7DV1B10ms1kk4yNmf2nIKJ2pntHYhRqmudJ0xzwuYkklgrc0wOSbMa66MsoW2vrihsS12aOpCz9FEsTZR+CE/2nZKDdTt7avsuJVm/X6hawSoupaBdupRfAmLjv0X2Mn2jByCegablNIDTuydEBS0vKujjxFS0XOWcTJu2qfmzc3Dt/X1IwRAbW2aUjbHycqXc9zn4M0NEFmZQ/+4p2/Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wb/WypMQbdb8KtRoyLHakmlqnqlI9HpAU490gubGyJQ=;
 b=ia2516eKMHxHSV9gB4x6zqdrlawK6ZY78aYtltKj03iX70hF6NbRXySsN34QFNUytBul4/oSmlT70OSwV92qcPHpzJezgA4zXQ8ioiD1snVEl6OLzgWHX73nvxu4R+QY6pPa48BZ0RiYAbrQvwyn9r8mZ7HmEh0mjvWjIPcmtcNJ6zBbyvIKS1PeihncxPJ2cWzCFhSDW83Hqf6Mk6tqUlnQ6eCI24/Hwhe3zU9bV0iTrDUQXQPImOl2EAQgks9BVJmh/qqzuuGd0wpDunEC20ZvzK22sSyzQbXMPK+yc5jLdN61xaG2VxMEj2vENgAT/gM39cygHjvV4HK97nZJwg==
Received: from SJ0PR05CA0029.namprd05.prod.outlook.com (2603:10b6:a03:33b::34)
 by SN7PR12MB7418.namprd12.prod.outlook.com (2603:10b6:806:2a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Tue, 9 Jun 2026
 11:28:46 +0000
Received: from MWH0EPF000C6184.namprd02.prod.outlook.com
 (2603:10b6:a03:33b:cafe::1a) by SJ0PR05CA0029.outlook.office365.com
 (2603:10b6:a03:33b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Tue, 9
 Jun 2026 11:28:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000C6184.mail.protection.outlook.com (10.167.249.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 11:28:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 04:28:25 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v7 26/31] hw/arm/smmuv3: Add per-device identifier property
Date: Tue, 9 Jun 2026 12:25:47 +0100
Message-ID: <20260609112552.378999-27-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6184:EE_|SN7PR12MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 713a8a12-c2fa-4c68-be02-08dec61a4523
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OfxcEbKqVfxdFCOdLUeaORCtEPsiBXzbRZZCzemTTLa9wWcro3ca944n97XhjbRD8xWWWNn/Qa3hFpsMwr6o2BBWtfB2jGFV3g9HekhRpDwXIocpcOcZJY4C3AyrW6/mAm8cMQW6BTbVFVFhX8/IcGhzHYN7jDimXh5E0xKdJ+hmpeKCcdKaH1++riXiQOv0qQBJ85nbDYMZ4SlgKyPT9mqxVZ6ivlcC+WitiFUkeXh3pNEdf9LYnXQDUTe9+Ceqra6lKJh2G2+L9RuXb6SroYeEL/OtheWSO8csHX58d0U72zn6VhK4Kkp4XNxi/MZlrTDFZy/KR1aV2pi3+kqhJKdMPZ2iop0Yh7HzdZSa4FosFcuQxLUATiJptGpd1XB7/f6XZ4FFwim9qug1mWrBysLPiFkbOHXVt1XRk8C7gXoMy9kTUS7gs+cMakOgKOL9EGtq8819tsLI/4gUNIJmfpEHBO91R71eI5MkbHR225ZvNM5QH0pilqlJ0drXo5lxpvjhLUlCtZmCXMDOlje5xiXScZAbJS5C4jl1NImo0e6+9krF6q+wbQWK6ICGe/9GNe/wYSQa69/ZALeRjbCUNoET5bJlLJUVcCRJYKkNaX/URL5r9IGUI4yuMSxBvcOA+I/SmQC9Ur6dgSB5P+0/rRc/NnMaKewwkeBeGNXiy+NqOvpJZD/57Lw2WxIaD4vS4/1ham5JzSvxIs/hUy2AN4CQ8cquKFcb08BGxQxkJ34=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0PasG4YOd+0+DpIe0nZvIy2a1ZIvN2qt+Cvev9sE0w5Jw7rovNkgylBYLvq++6KIArdKDRZL/LbV/9yS30F+lXUhziSv7kmQIdzWxr806DyJkz8RlV0X2RLkiVpVLjskGhHqOovTASI8ULPXP1ls/jqQxmoMWqjYFF+254hZ1IaPiW/v4YqgkYOadQuU+PWnAVpZyUTJaVTcRDvyDv6gmBGWsNgIsQKDgVtgJfkEzo8cSiiD+kXKgMoZCAoLD1DBT6PIz+kq0FqLw9a2mqZ3eCPyYJuSpYHQulDgusyTwx/3rzcMv2om8YP24sQQhm5RarvNzrZBG5qKvBohfIWJDOHx7TdCTvaApgnlUTs0I/Uxo9yNmHq9EAU2zojcAyJnpvxDWLUukNkz9s7gJVgGOISBD0jNHxwIbdu+oxxjyLkITVYfN9OZ01lMhMypziI2
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 11:28:46.3203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 713a8a12-c2fa-4c68-be02-08dec61a4523
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6184.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7418
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=skolothumtho@nvidia.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
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
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
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
index 83fa6468fd..a8fb10e531 100644
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


