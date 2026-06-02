Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484FDC5DF71
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 08:47:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUKlI-00039N-64; Tue, 02 Jun 2026 04:46:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKlD-00037a-Mw
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:07 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wUKlA-0004PP-Ox
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 04:46:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xpgi5uzwsygKAz7un1s+HSdDXCL0DvmngLjTExZLx7N5xgEC8MlIZhBvpNp+e4XcTw69KI8kFdZaqgj0ZgQ1/b0086Zx0wOolIgKleIC79DmGzZsqkieyu4BLh/PRz6+PIktCgE03O0HzYy/Y0jXEKjRAJPQWGEcqfe67AP+9VEBXhey9lmJFZrzOAPSYXkhB3c8dKLBFK9SwfG+JSoPkIFpv7+0hyT6hGjnaX0uEYXA5PNjrcay7R3XVCQlTGLH/h8eo8IZWHc2o479q04vrP9pEmdHUFi6W19KYHsD0To04g01XMk/gjI72TPUYkaNh5rhPOlds79/X2OetKc13w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2lc5FhLKbu/2VxPAZyW9yLxXpW9Yfxv4ezY11W468g=;
 b=UHzt3/h3uwY4agLgvx7SeqbtAGqH4qgIu3ur2uV2gLjKv8M2+rKWtEUF8US9Dbz8CuQ6ulFeZUYcqSPoqoSjyCVRohdwUtL+6X50/Bq+ZYffF6Yy8RQp299EJo+E7JmE3HKAy6nTNv8IFsj2sM9zo+ilPeI7OI5R6VGJ8L+jrWmPv/Bgp4ndfE4LMB4CVXr6g2A/X7scVAHZM/0IQGscZm4HSKopovcavcNfmK921C2pdkaE1qudu3BwoRjQvJ/lw81mWRZULT70ieg2G4B2JD4SYfpFmKTUzuCBXjQGWdgaenhPABPJy45GepQnqjdl45RFJhNRxdV7/KinTznfrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2lc5FhLKbu/2VxPAZyW9yLxXpW9Yfxv4ezY11W468g=;
 b=fp9gD/vzV4XM3a4topaofVT7q9er4hsR0wxdF5x3CEvq0d2utEmm1CTu1GqQ2X9dTxMwXw2kU7/Ew+zvFA2vAA3xCyfuh2oo6dz9DJ7t+dIGTnGku+TmSJzQYNwdFnyccZ2FeMFhjQ9pWAeLfYkBUeP26xYIdzCbDmr0z2sFifk=
Received: from DS7PR05CA0055.namprd05.prod.outlook.com (2603:10b6:8:2f::15) by
 CH0PR12MB8506.namprd12.prod.outlook.com (2603:10b6:610:18a::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.12; Tue, 2 Jun 2026 08:45:55 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::b) by DS7PR05CA0055.outlook.office365.com
 (2603:10b6:8:2f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 08:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 08:45:55 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 03:45:52 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <david@kernel.org>,
 <gourry@gourry.net>
CC: <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v9 3/4] hw/i386: integrate spm-memory into the pc machine plug
 path
Date: Tue, 2 Jun 2026 16:44:46 +0800
Message-ID: <20260602084447.1100554-4-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
References: <20260602084447.1100554-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|CH0PR12MB8506:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eafd943-92e0-433d-1af0-08dec0835c37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|82310400026|18002099003|22082099003|11063799006|56012099006|43062017;
X-Microsoft-Antispam-Message-Info: Nz5lllfTVkKHqITcrmsN0SXXK4JxlTvMQZHavCXaMmuEZsbDMAkoD1yS7z4aAXVlJGhvGSr5wowNQu+TrYmB/hb3SMbgN9URaSZ8pXnUy9tcpS3hs9LMPo+KlZIWoBOFAFBblCvnmiEQ8P7ULGfOsOxC9kxP2+O7Mn90ccAcluAR6DY4gY5BnSKIJylEsVGXizVMD2B1FanrQ4dd9Jem3HLywXrf0IySlIGdONyJ1INafsK0Gj/5IejsG5MHJ6V1VTB/lMr5THDym81SX8MXDvCTJn6bgINWT/Vu7kZCXFzv/N9DAQ0SezZXncyapR2h88fomaDTNR/AS8KuhmyD6mkO+C1l9fdfhtZo4BkOWosUsOLFe/HLyw68zIZKpSqUyOHJl+BRxJ9iV9iWiayDXsjyL1kXNONb/Gky4S0bFUFyPjsf5Q9udkioZxQ+sLmHJBTLkY9KgBBe/b26F9RxpPJYUvPXs7wT2NMNytCx2Z2l6gd2elxIfPzO6P4XhrA6jSHRsphIJlKHWjh519s8mIFuxuLmj7iPy/tzikymLJ/uL5vX49Ex5amUMMtPoJpyGmIeKFwNEjDx0xgxrnPFM4R5kdybL8EE1yWGcl94R8Lkgg/WTCLUIeGjefSMjH9wlpUS0mt6iskcg1HVc3P49Ru0f3pm8iYpFxAFG5BkogQUNg6fdRiTP+QaL9L9LT+DubmYGP+B/x+Vkx7SO1dkKinfHDITjJEfJMrCo4VAmFtajcsP14YdpBrtbr5TMJYKa0A3Kdi4DzQE6qpnpfeAhw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(11063799006)(56012099006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NGeISX7WhQT9sHvTDtapH/vbH2Hsu2u7oMQvD0yn+vUg3wwGAxU6TH3c3Bjlv3SBMKJSVmMcIMz4aF3GUEyOT4wHLj0R95/TGY2iueEpG1v2C5BrT6dLU1P5hnhLdFK4tp6o6vzP3xNSFdnkT5uR5Z3Eh8VZHwSs582VHcpdUV2TiX+nYfhKcUn4KwAkgLwatxwOAF0Aej75QQvG1uY7zzx1/JLImS6yWVTjwrWPefqc0X6MoOsYTmBp1MtFFjghyVotEkWe7b23/KbYBFehae4aDEdFZZ8pp0S6zEOO6CMAXyuIFGKNYeYA93gnOyXA/amU3x/pgh3LDdkSb06qPbhXTn+I840v1fYLOvi/nX8DW8P5j86TzIM8Td/nPhk9O3DT+YAOZxXzdMZH6VX/gQ0PxnoAPsxf6k7cFg+Ca+H+vdioGL++/mCV/XAk/g7O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 08:45:55.2804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eafd943-92e0-433d-1af0-08dec0835c37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8506
Received-SPF: permerror client-ip=2a01:111:f403:c10d::3;
 envelope-from=FangSheng.Huang@amd.com;
 helo=SN4PR0501CU005.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add the pc machine hookup for TYPE_SPM_MEMORY so each spm-memory
instance is placed by the memory-device framework and reported to
the guest as E820_SOFT_RESERVED.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 hw/i386/e820_memory_layout.h | 11 ++++++-----
 hw/i386/pc.c                 | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/hw/i386/e820_memory_layout.h b/hw/i386/e820_memory_layout.h
index b50acfa201..6ef169db9c 100644
--- a/hw/i386/e820_memory_layout.h
+++ b/hw/i386/e820_memory_layout.h
@@ -10,11 +10,12 @@
 #define HW_I386_E820_MEMORY_LAYOUT_H
 
 /* e820 types */
-#define E820_RAM        1
-#define E820_RESERVED   2
-#define E820_ACPI       3
-#define E820_NVS        4
-#define E820_UNUSABLE   5
+#define E820_RAM           1
+#define E820_RESERVED      2
+#define E820_ACPI          3
+#define E820_NVS           4
+#define E820_UNUSABLE      5
+#define E820_SOFT_RESERVED 0xefffffff
 
 struct e820_entry {
     uint64_t address;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 2ecad3c503..66d8a684c2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -63,6 +63,7 @@
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
 #include "hw/mem/memory-device.h"
+#include "hw/mem/spm-memory.h"
 #include "e820_memory_layout.h"
 #include "trace.h"
 #include "sev.h"
@@ -1283,11 +1284,42 @@ static void pc_hv_balloon_plug(HotplugHandler *hotplug_dev,
     memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
 }
 
+static void pc_spm_memory_pre_plug(HotplugHandler *hotplug_dev,
+                                   DeviceState *dev, Error **errp)
+{
+    SpmMemoryDevice *spm = SPM_MEMORY(dev);
+
+    if (host_memory_backend_is_mapped(spm->hostmem)) {
+        error_setg(errp, "memory backend '%s' is already in use",
+                   object_get_canonical_path_component(OBJECT(spm->hostmem)));
+        return;
+    }
+    memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev),
+                           errp);
+}
+
+static void pc_spm_memory_plug(HotplugHandler *hotplug_dev,
+                               DeviceState *dev, Error **errp)
+{
+    SpmMemoryDevice *spm = SPM_MEMORY(dev);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(MEMORY_DEVICE(dev));
+    uint64_t addr, size;
+
+    host_memory_backend_set_mapped(spm->hostmem, true);
+    memory_device_plug(MEMORY_DEVICE(dev), MACHINE(hotplug_dev));
+
+    addr = mdc->get_addr(MEMORY_DEVICE(dev));
+    size = memory_region_size(host_memory_backend_get_memory(spm->hostmem));
+    e820_add_entry(addr, size, E820_SOFT_RESERVED);
+}
+
 static void pc_machine_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                           DeviceState *dev, Error **errp)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_pre_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPM_MEMORY)) {
+        pc_spm_memory_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_pre_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1324,6 +1356,8 @@ static void pc_machine_device_plug_cb(HotplugHandler *hotplug_dev,
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         pc_memory_plug(hotplug_dev, dev, errp);
+    } else if (object_dynamic_cast(OBJECT(dev), TYPE_SPM_MEMORY)) {
+        pc_spm_memory_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         x86_cpu_plug(hotplug_dev, dev, errp);
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI)) {
@@ -1368,6 +1402,7 @@ static HotplugHandler *pc_get_hotplug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
+        object_dynamic_cast(OBJECT(dev), TYPE_SPM_MEMORY) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_MD_PCI) ||
         object_dynamic_cast(OBJECT(dev), TYPE_VIRTIO_IOMMU_PCI) ||
-- 
2.34.1


