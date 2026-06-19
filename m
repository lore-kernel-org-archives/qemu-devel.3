Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF800CD98F6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2026 11:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waX8s-0004hK-65; Fri, 19 Jun 2026 07:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8r-0004h3-8y
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:09 -0400
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1waX8p-0001r0-Ac
 for qemu-devel@nongnu.org; Fri, 19 Jun 2026 07:12:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1aD14EaVOqP7QeOZjtbXLw7oT8X9JyZoPiToOaAvZpZxey3rPABap9hGONzFdv33iFK4lYhKtQYq9vJLMw3ZUufhLODC5fcf1btrSkRzIZTiekF0buFfzZzZdTjOFIqWCVKcISnDSNVsfkrhXc9pvdXdXgm75GA1MmuXiI8UJueRj0m/L+sMNt/aO8157sO/dUARpqFSU8kes9Bx2MGWWazmHe9YNgUGOzbpCmTYongvWhuMKEBmnIDel2yfm+qzelbkPmAKdIgupXOvMGTMEI2u3ohLRfTT6C411dBSTRKGfglxkM1VRCTeQ4KHObhXamM5YSYBep7ETUBOcI1Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+KjiEYTq7erG3vowZH3jNUk29SVAoXUz+Fu47PzG4FM=;
 b=O7EWv2qk1jYe2QvSZhcJ/WBIFRu2gs1P852BO6qOrH+SS/ooRi5Up85XfCfW9gD3CLmmKUmtloNzrHm/7SEb5XdBCLiqKbVlV8Fa+9CCE7fbsJKN4qWqyWN8yPrFhLEHjcncGpYzTYnCNkFsBUWcekYIXrnul+uVpbd3DXGnQc+BPEooRLR0Xptj+Xn+ov/OtY7KrEDkC24ShCELENWSnPoiKGQ1j1BCtaXrR2CBNQ0UUrybfzzjIPrjbBCBMD7FRCha4aBeXcZuMoI0pps9qh3mwg9eOvgA40OFmHUEHcC4Z69wL9+cUiKvtrjO8AvoC/hQB13HEgeJB6i1pWgSEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+KjiEYTq7erG3vowZH3jNUk29SVAoXUz+Fu47PzG4FM=;
 b=z///XkcMpp8bdGO9+1F6M0cn2ttxg04RoWJOqNgavNaSS3TpHlqLYeqm5steblGKCmDPfT6icOTLFQ7//ER6WUVWCo/TZbULdcwTDyW1UQzUoMlCyvX1uAiA1o2/A8gXK6NoR/mlrv4VShkiYAeOJOX3wiPcXJIB660zYueoKKA=
Received: from BY3PR10CA0009.namprd10.prod.outlook.com (2603:10b6:a03:255::14)
 by SA3PR12MB7829.namprd12.prod.outlook.com (2603:10b6:806:316::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 11:12:01 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::44) by BY3PR10CA0009.outlook.office365.com
 (2603:10b6:a03:255::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 11:12:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 11:12:01 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 19 Jun
 2026 06:11:58 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <david@kernel.org>, <imammedo@redhat.com>,
 <mst@redhat.com>, <gourry@gourry.net>, <philmd@mailo.com>
CC: <peterx@redhat.com>, <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>,
 fanhuang <FangSheng.Huang@amd.com>
Subject: [PATCH v13 02/10] qapi, hmp: introspection for the sp-mem device
Date: Fri, 19 Jun 2026 19:11:28 +0800
Message-ID: <20260619111136.3481329-3-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
References: <20260619111136.3481329-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|SA3PR12MB7829:EE_
X-MS-Office365-Filtering-Correlation-Id: e39939b5-95f9-44ad-55da-08decdf39629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|22082099003|18002099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: 6EKR9JcRp6VKRhtIOOV8GG+H1P4cQWJLQ7xe9Rhh/BtYKXnd3JoLjKeylGJTEuqewONDLxgAbP/MtITV+zYskLYIdfUK8cB/CHUR1fG+aLTb4gDu4cwKbUy5Af7Rj1tVx2c3XJkWItQxPtvr6xzC1R+aJDsDQMKsK1Z3u4wMGutgT+gNWHrF3J6BVvJankdg9ex2ih0i03q2V0zNXENMf7pK6ofQ/ZAqSEYfBi/iIBa3K5AxpbwCpgOXF0kgCMcwWvkrPJ+KauWzJSqt1KaUrhlh62EXbYe3J4lzTtPYbxVqOr1utVkHm66daXNW4/zrGZdG1B+O1WWzd5JN64FK1t0N3+2DtpLar+4+2Jk96SFY8vavHoVpPBUIkeYy/wGE6uUDDu67AOtRZecd0V2TKeZGawuTexWjjuds3+bFdd6Carc7fEWE42d68xvMfkS4uXVyW4Fwc9ZOYRcLsGNik5QqcwI7QS6QCxCbT7xLhpIS1yy45AsIHrGNc36cW0yeYf+RMSL+2aDvu2zhpiIN0vEAYNs+vdUP5FxR+yVx+WC7fIF3pSBvvHJpN5PFmey7HwvcdwDPRPkt3Qt5Vn2BspLioveOJOibT813bjUZYCG36CEuO6gKjJcgUW4q9U2sIZmwuyf/aZPXJFtxhI46CWXI2Tba3RE8KYCrqy3r/gWMnhzzUwYSJFyz+yIip9l8LzOdJ06qn92+W0rC1GJuOLaM6JmhHdrBYB1I61I5YLNP92aiNCkDmYL4hNBZrKPP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5WnPftL4M/oiYTqA/KWJeWJQR718GZk+Wv3NMldp0aVnTZFbFGfOru808A1N7FbNRLa2bKZXJE7Z5dzPqZf/zRlWltBUaBQRU2M09ACLCDJfZ1hqA/Dq2siqiKWdly8AiO3A2piIlwGMB4DqrZkYiHy8BjD2Ua+zpYQxrKHULtAT5BVXH2age3TGQjhcydb8kLAbg+mG1k7/AAHTRwSmLaTaz5iCHLX56iYUwpOh0tf/MwUnSJArOzrGNYp6nocQREXCev1uEOieE8zGk6M8d+qzirZcBjhFZ3FqJ+LN/IsHXxaZmFD1ezlvLUjd5Al5CyR3fobEfVeDsRSkEshfLuDx5IBAfg1OgJ5OBKC4ZKmYe9k82X0Tj0J9I1XjUjB2z2Sg0CF0RH+gi8OHPJlmEQWxwUgyYtwIe1ko5anvT8AkjrqI3UzhE14E8U7DQAEI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 11:12:01.2495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e39939b5-95f9-44ad-55da-08decdf39629
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7829
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

Add a SpMemDeviceInfo variant to MemoryDeviceInfo so `query-memory-devices`
reports each sp-mem instance (id, addr, size, node, memdev), and print it
from HMP `info memory-devices`.

Signed-off-by: FangSheng Huang <FangSheng.Huang@amd.com>
---
 qapi/machine.json          | 43 ++++++++++++++++++++++++++++++++++++--
 hw/core/machine-hmp-cmds.c | 11 ++++++++++
 hw/mem/sp-mem.c            | 19 +++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..777cfc81e1 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1413,6 +1413,32 @@
           }
 }
 
+##
+# @SpMemDeviceInfo:
+#
+# sp-mem device state information
+#
+# @id: device's ID
+#
+# @addr: physical address, where device is mapped
+#
+# @size: size of memory that the device provides
+#
+# @node: NUMA proximity domain to which the device is assigned
+#
+# @memdev: memory backend linked with device
+#
+# Since: 11.1
+##
+{ 'struct': 'SpMemDeviceInfo',
+  'data': { '*id': 'str',
+            'addr': 'size',
+            'size': 'size',
+            'node': 'int',
+            'memdev': 'str'
+          }
+}
+
 ##
 # @MemoryDeviceInfoKind:
 #
@@ -1426,11 +1452,13 @@
 #
 # @hv-balloon: since 8.2.
 #
+# @sp-mem: since 11.1.
+#
 # Since: 2.1
 ##
 { 'enum': 'MemoryDeviceInfoKind',
   'data': [ 'dimm', 'nvdimm', 'virtio-pmem', 'virtio-mem', 'sgx-epc',
-            'hv-balloon' ] }
+            'hv-balloon', 'sp-mem' ] }
 
 ##
 # @PCDIMMDeviceInfoWrapper:
@@ -1482,6 +1510,16 @@
 { 'struct': 'HvBalloonDeviceInfoWrapper',
   'data': { 'data': 'HvBalloonDeviceInfo' } }
 
+##
+# @SpMemDeviceInfoWrapper:
+#
+# @data: sp-mem device state information
+#
+# Since: 11.1
+##
+{ 'struct': 'SpMemDeviceInfoWrapper',
+  'data': { 'data': 'SpMemDeviceInfo' } }
+
 ##
 # @MemoryDeviceInfo:
 #
@@ -1499,7 +1537,8 @@
             'virtio-pmem': 'VirtioPMEMDeviceInfoWrapper',
             'virtio-mem': 'VirtioMEMDeviceInfoWrapper',
             'sgx-epc': 'SgxEPCDeviceInfoWrapper',
-            'hv-balloon': 'HvBalloonDeviceInfoWrapper'
+            'hv-balloon': 'HvBalloonDeviceInfoWrapper',
+            'sp-mem': 'SpMemDeviceInfoWrapper'
           }
 }
 
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index 46846f741a..686304bafa 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -279,6 +279,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
     PCDIMMDeviceInfo *di;
     SgxEPCDeviceInfo *se;
     HvBalloonDeviceInfo *hi;
+    SpMemDeviceInfo *spmi;
 
     for (info = info_list; info; info = info->next) {
         value = info->value;
@@ -350,6 +351,16 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                     monitor_printf(mon, "  memdev: %s\n", hi->memdev);
                 }
                 break;
+            case MEMORY_DEVICE_INFO_KIND_SP_MEM:
+                spmi = value->u.sp_mem.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               spmi->id ? spmi->id : "");
+                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", spmi->addr);
+                monitor_printf(mon, "  node: %" PRId64 "\n", spmi->node);
+                monitor_printf(mon, "  size: %" PRIu64 "\n", spmi->size);
+                monitor_printf(mon, "  memdev: %s\n", spmi->memdev);
+                break;
             default:
                 g_assert_not_reached();
             }
diff --git a/hw/mem/sp-mem.c b/hw/mem/sp-mem.c
index d088222f54..962d0f937e 100644
--- a/hw/mem/sp-mem.c
+++ b/hw/mem/sp-mem.c
@@ -53,6 +53,24 @@ static MemoryRegion *sp_mem_get_memory_region(MemoryDeviceState *md,
     return host_memory_backend_get_memory(spm->hostmem);
 }
 
+static void sp_mem_fill_device_info(const MemoryDeviceState *md,
+                                    MemoryDeviceInfo *info)
+{
+    SpMemDeviceInfo *di = g_new0(SpMemDeviceInfo, 1);
+    SpMemDevice *spm = SP_MEM(md);
+    DeviceState *dev = DEVICE(md);
+
+    di->id = dev->id ? g_strdup(dev->id) : NULL;
+    di->addr = spm->addr;
+    di->size = memory_region_size(
+                   host_memory_backend_get_memory(spm->hostmem));
+    di->node = spm->node;
+    di->memdev = object_get_canonical_path(OBJECT(spm->hostmem));
+
+    info->u.sp_mem.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_SP_MEM;
+}
+
 static void sp_mem_realize(DeviceState *dev, Error **errp)
 {
     SpMemDevice *spm = SP_MEM(dev);
@@ -91,6 +109,7 @@ static void sp_mem_class_init(ObjectClass *oc, const void *data)
     mdc->set_addr            = sp_mem_set_addr;
     mdc->get_memory_region   = sp_mem_get_memory_region;
     mdc->get_plugged_size    = memory_device_get_region_size;
+    mdc->fill_device_info    = sp_mem_fill_device_info;
 }
 
 static const TypeInfo sp_mem_types[] = {
-- 
2.34.1


