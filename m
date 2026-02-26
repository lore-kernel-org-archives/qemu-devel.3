Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AC0BFC592B
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:56:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvZ08-0007Pz-DC; Thu, 26 Feb 2026 05:53:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ06-0007E4-TD; Thu, 26 Feb 2026 05:53:46 -0500
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vvZ05-00015d-B3; Thu, 26 Feb 2026 05:53:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tB3U/RbwYl6Nbo5/E5jkMPXhcLEHH2cetDR+CHYIMAuK34+T9t0DqMqR0v3jQBe8l4H6z7G2XEgAoR6bTXwOLdvByIjO4ZQE40TZkri8m56+sS2bjqtuwKglCHYFCRXIsHCoRA+98nOd5f0vBD14nEzhI0uzEijn6AeUU3UMqj/KU4eE2w0HTxmF/Bc3t64gP/N00SXB+duJS1gSO20y8fbznpdpWdixQCk1iMzShW88HFw6m/LHexGBhHvKMgw8dZw86sLnJAUYlReiXEvZP9NuQV+WhCqB5gfWeh7NPAMXP6T3aT/aSAAG3QvcLdrrQuN0XIsp4Ux8IUNqayXJbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXRl+XfEVLGSXf9AyNCdXjp7dIVPuoCktsrlsKHZbgk=;
 b=sDmB721/5Uqc5nfIGmvdnrvUUnK1uO6Fy7uRY6sc5ETgau4ipWauWM858Rld9xBu2cDCdd3ZEdipJ56OYlG/a3Hwo/6FQ7px1z0MRbbodk38nDBH1u+NzNM4rJH6NjO1w/FfkHPcGBTQ4tuELDbYelfAXgpM4MN2ZSZXwIx3bwmCJ/CJCenUOVaTB+smx9LBj9gMvmQVt/kYBW/sQaSUsjiSoXz4Fd6+WMGDxRwHAi4EtVxpQ+Q5Uu/gMiBc1s3uRVXUmEbBHMtiZRZ+Ge+7CxiBM9wcOS9Mmf28+wcbzY1lrhZAJ9oaUIePq+Dn0FaGEJITzfphbcTBWnXTJwwBKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXRl+XfEVLGSXf9AyNCdXjp7dIVPuoCktsrlsKHZbgk=;
 b=U/Zqkiv/mDIQ/CLrhjXnyuA3tQL8Bcpd21WZ8pbC6kodNdTasBjVZQf9MXycPAm2Z3VGGNzZYHJLfznVtPJi6rVdPJjXitG1oUySpxBVWjTeg2Mmm0RoE4vVOhwm1vfJDeY1sqaA6rpeVben5gITTHeclByayoyHgoFhdr1Bagez8jUIIlcvKh5V88jcX6Wgg9DPvGyXCnCpDsQ/sTAe78D+nUSmhcpG/mhQ0jXz7v7WSMFW98F9AU7k2yKtAhnQR3JZoGBM1xaymZEsRmupRTfcESm1lz6PCz0uhCbAxBwK7HkY3MFexBse3BVxCHn1PBkr1++1vS1yhTSGcRrWJw==
Received: from PH8P220CA0003.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::27)
 by DS2PR12MB9822.namprd12.prod.outlook.com (2603:10b6:8:2ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.11; Thu, 26 Feb
 2026 10:53:38 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:345:cafe::f) by PH8P220CA0003.outlook.office365.com
 (2603:10b6:510:345::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.25 via Frontend Transport; Thu,
 26 Feb 2026 10:53:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 10:53:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:16 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 02:53:12 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <clg@redhat.com>,
 <alex@shazbot.org>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
 <mochs@nvidia.com>, <jan@nvidia.com>, <jgg@nvidia.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <kjaju@nvidia.com>, <phrdina@redhat.com>,
 <skolothumtho@nvidia.com>
Subject: [PATCH v3 28/32] hw/arm/smmuv3: Add per-device identifier property
Date: Thu, 26 Feb 2026 10:50:52 +0000
Message-ID: <20260226105056.897-29-skolothumtho@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS2PR12MB9822:EE_
X-MS-Office365-Filtering-Correlation-Id: 250e055e-5dc9-497d-528f-08de75254bee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7416014; 
X-Microsoft-Antispam-Message-Info: i3tt5DOByRExznmwCH/EBA9rkCva47G7Pc7BkVkg/3g6CVAc13/Gjgt4sNoDJWuDVzkDJ1ZAA/sxbub564F9P/6OG3GPMHI5VL5uoHNmrnEGgyj4CyAf+yTsbGam+eawMWjq53HH0aIR2lenEaoaGjIyC/tD9fG6gjBfffiNZzI99AED2cxsPlCNudPRmi2PIEXomrRvr9M3CdzDy98ga/W/xCAMrJIczDhYIXhw8t1JBwA+Og9pf5nGkiQaYCoyWnvcU4P+dyi83Hrog2WsizdQiw1nm3ck9iR/oR2An4VsLuFy3EAZ+LhP8Vg0VhlCPu4yz1kdMkZMo0T7KbbqqCsCFxmdokOEpKQ9BQComkk9Y06YTv75dCfac8sQmRPZjylNTUsUM3ROS6NaDoUQJwL+fLIOiCrh0sAR+XXSQYcaUdUVu7vWNgua747RbbfPkzmxtE6eJwmp9+GENwtOkNtK37PNzP8bETJxl5F1gt5UWpocV1yJ6gtI28p2D8GqCYbZoW047QpD0dmmSar947TwHVfOhjVRPEp7ZQ/qbntlPjzqKi73PZQe5DzoN0peK0hSFCRhGsLmx6K7KgwHJP/z6U24aS8eOKur0fVC35vjl3G/4HsE+GokpYEco7Jbrck3LgyBmWi/CHD6qDQutoTjeyR1q8y3w0o5/3WuZM5g6vPvLtR7zRGbuJ2Ngu8YQSKXZuBkQwV9Ld6erxtyQrtJCYJYvE346XgQQY8V6fR8VCxsB0A7rPWzVmjqP5OxFloyagkG5cbAIex/qdUYZCp5066XxhBu3r4naTuQRD7bu150rd5FQ7PeVW9mtDRZuoMBIoERssyqeVSmhn/xtw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jPGlsW9rbnluDXgx4GCdPcvItFXW7nk8MIdGMN4kYpfweHTt3qtXPitJ3S/n231G91BWspJe266D12szro7xrJCGaeVtzZRzk/Aen82Aw5Dpi9fwpKwF5/yXuc4g+vP9v3ds7k6XOPmyy6lQedLbMhf0NMdHgCKLCkS6a5Q+0/dFVJNH3LxoGsf9J7hvpcwABvKezfNbf0GdtVARCisf+wftCAc/4ammn9GW8CzG/ccD2XQufYmJOkztKn+IUNDZDZG9tIuJa7B68s8TYV7kR3jeunMIJ/YAZEjc0Ah/iScEqjsjQOvSBE7yfpz/N5xMwq3ywUWRIF8s9C6u2Ad2aZNHaaHCc805FWPh6y6QY3+7BHIdXh+aDS9ZM9X+eAdoWXCSJCqqbXMUCGz1jflRwV6AApkgeI3/HcOHUpUxiKqem35eCTI8BBkCafIoxcxN
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 10:53:37.8348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250e055e-5dc9-497d-528f-08de75254bee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9822
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

No functional change intended.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/hw/arm/smmuv3.h  | 1 +
 hw/arm/smmuv3.c          | 2 ++
 hw/arm/virt-acpi-build.c | 4 +++-
 hw/arm/virt.c            | 3 +++
 4 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/hw/arm/smmuv3.h b/include/hw/arm/smmuv3.h
index 648412cafc..73b8f39aaa 100644
--- a/include/hw/arm/smmuv3.h
+++ b/include/hw/arm/smmuv3.h
@@ -63,6 +63,7 @@ struct SMMUv3State {
     qemu_irq     irq[4];
     QemuMutex mutex;
     char *stage;
+    uint8_t identifier;
 
     /* SMMU has HW accelerator support for nested S1 + s2 */
     bool accel;
diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
index 468135bb24..c1f84bedd4 100644
--- a/hw/arm/smmuv3.c
+++ b/hw/arm/smmuv3.c
@@ -2109,6 +2109,8 @@ static const Property smmuv3_properties[] = {
      * Defaults to stage 1
      */
     DEFINE_PROP_STRING("stage", SMMUv3State, stage),
+    /* Identifier used for ACPI IORT SMMUv3 (and DSDT for CMDQV) generation */
+    DEFINE_PROP_UINT8("identifier", SMMUv3State, identifier, 0),
     DEFINE_PROP_BOOL("accel", SMMUv3State, accel, false),
     /* GPA of MSI doorbell, for SMMUv3 accel use. */
     DEFINE_PROP_UINT64("msi-gpa", SMMUv3State, msi_gpa, 0),
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index ae78e9b9e0..20605185c5 100644
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
@@ -404,6 +405,7 @@ static int populate_smmuv3_dev(GArray *sdev_blob, VirtMachineState *vms)
                                                &error_abort));
         sdev.accel = object_property_get_bool(obj, "accel", &error_abort);
         sdev.ats = object_property_get_bool(obj, "ats", &error_abort);
+        sdev.id = object_property_get_uint(obj, "identifier", &error_abort);
         pbus = PLATFORM_BUS_DEVICE(vms->platform_bus_dev);
         sbdev = SYS_BUS_DEVICE(obj);
         sdev.base = platform_bus_get_mmio_addr(pbus, sbdev, 0);
@@ -630,7 +632,7 @@ build_iort(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
                      (ID_MAPPING_ENTRY_SIZE * smmu_mapping_count);
         build_append_int_noprefix(table_data, node_size, 2); /* Length */
         build_append_int_noprefix(table_data, 4, 1); /* Revision */
-        build_append_int_noprefix(table_data, id++, 4); /* Identifier */
+        build_append_int_noprefix(table_data, sdev->id, 4); /* Identifier */
         /* Number of ID mappings */
         build_append_int_noprefix(table_data, smmu_mapping_count, 4);
         /* Reference to ID Array */
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index c75a8d6e9e..44c6b99c96 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -3138,6 +3138,7 @@ static void virt_memory_plug(HotplugHandler *hotplug_dev,
     }
 }
 
+static uint8_t smmuv3_dev_id;
 static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                             DeviceState *dev, Error **errp)
 {
@@ -3196,6 +3197,8 @@ static void virt_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                      OBJECT(vms->sysmem), NULL);
             object_property_set_link(OBJECT(dev), "secure-memory",
                                      OBJECT(vms->secure_sysmem), NULL);
+            object_property_set_uint(OBJECT(dev), "identifier", smmuv3_dev_id++,
+                                     NULL);
         }
         if (object_property_get_bool(OBJECT(dev), "accel", &error_abort)) {
             hwaddr db_start = 0;
-- 
2.43.0


