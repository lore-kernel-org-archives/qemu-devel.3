Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38EDBCDB471
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 07:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbvvD-0006GC-8l; Tue, 23 Jun 2026 03:51:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvv1-0006Dr-TP
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:40 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <FangSheng.Huang@amd.com>)
 id 1wbvv0-0000h1-20
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 03:51:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sxOIxQZ4GzNfVGV/fCG4hzAQ49S1M+77Cbe0Bbb/u7O49pZimPVEV73FHo9aG22WaI+sFnyCK4e/OK6iBv9WOd/BSGgieRsJTSuTT6JEGl5Isb+E9V+p00T+rBrt5NnjtIWXIb9Feen0OFthNnzB8RYe2YrnSf+eIZa+KX8pS22+lhj4EweZpdpZhETZqNXQ6lnJfnXyMauHutJ6f4peM2OfkAMkWbpw43gPlQRiY6oLOYfZaBk33Mg9lrn6qNmjHhoKS5gIqvpOaTAQHjMSfW5JnFuOp7OsrWvJNV5rjkekja0eW5OjesjrMTHBYrXvCUPMOty4EM+SXlWMlRQHLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OPnV5VBFNRIoOCemhNZA4bHn41Nd2GErZtYJq5CobTI=;
 b=jOLxK2kfLixA4hqsDNBsHMBNZEVLd//Cnr+mXsaBVGKKuvD+lztsWxgZGLThKyIzCD95HCFS2BZPhHy+Jg7QrZtl0BQLNrCXhIaBKi/SM00qmPcBt0hf6h63qBZkj95S0P+m8QdtYqC09yzgLXgsENdwKybflytcAAJWpUcSazM8kY+jA3Ponauw0d5zE8NoRgGFCikvcJFe9dYfamJssCnUac5tRjbMCOXiS9LDO6trgFlCYJIR41edrx0mTNDgyMUdHi1XjcJctlIR1IadIheCjgmdm8XzLIWFVTxg5SW0Dh8iRxcj98aOhyWnFsKulhqzOlj+qXQcAiDxoTRD4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OPnV5VBFNRIoOCemhNZA4bHn41Nd2GErZtYJq5CobTI=;
 b=fT6f8Wttk46aCx25wqctu0nqlgLXoa6XgBz8en5SRz/3u7Kqt0c5PB9lpffxfAvdVoDkqCQYEFhudinRIfKkgDdOQ0fWKrql+RkvO/UmbWxAjFYI1J8rar2qpMFQGiWnDNqTbWfcZv1/vk5WIIrMJ5x7L1vbEpmaPag10jVH0fo=
Received: from SJ0PR03CA0074.namprd03.prod.outlook.com (2603:10b6:a03:331::19)
 by DM4PR12MB5795.namprd12.prod.outlook.com (2603:10b6:8:62::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 07:51:32 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::a4) by SJ0PR03CA0074.outlook.office365.com
 (2603:10b6:a03:331::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.20 via Frontend Transport; Tue,
 23 Jun 2026 07:51:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 07:51:31 +0000
Received: from k-Super-Server.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 23 Jun
 2026 02:51:28 -0500
From: fanhuang <FangSheng.Huang@amd.com>
To: <qemu-devel@nongnu.org>, <imammedo@redhat.com>, <mst@redhat.com>,
 <david@kernel.org>, <gourry@gourry.net>
CC: <philmd@mailo.com>, <berrange@redhat.com>, <peterx@redhat.com>,
 <Zhigang.Luo@amd.com>, <Lianjie.Shi@amd.com>, fanhuang
 <FangSheng.Huang@amd.com>
Subject: [PATCH v14 02/10] qapi, hmp: introspection for the sp-mem device
Date: Tue, 23 Jun 2026 15:50:43 +0800
Message-ID: <20260623075051.3797975-3-FangSheng.Huang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
References: <20260623075051.3797975-1-FangSheng.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|DM4PR12MB5795:EE_
X-MS-Office365-Filtering-Correlation-Id: 4553c76a-39b6-4d03-1d1f-08ded0fc3db7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|18002099003|22082099003|56012099006|11063799006|43062017;
X-Microsoft-Antispam-Message-Info: xZVZuDJ/EtFPiQUpyBDYuBnskI9y+BKCUeg+/6vl8Y2hQhaKJ4+3kJoL075Fq2wAH4kU70SVczmHJyW56mkYu3rnwzIrlxanPGMAWD91T7fpAyCxFZoJ8vDmEWrImVcCKS/7T4jwfcZkTRBHa79SY9COr5nikD60+u2cFRtFqdg4+qf/WejS7ImEcEF7o4f0khoS5bnCmecfWqZWVWmNu3rG3+pNk4PgRt3bn/O3qfMME2p2xabCfH7DxVs0cq9bm/PBUU8FYW7r+4aMkQKbPaz5zdAk3113OjHMnqeuOLUxoK9aUexALdNwgecRWUKtTtVA3Pcf5tlBq+AT29Ai1nfdvj594MjtjCqgmoW1nIqUaJyTSn1MjMJkCV5bOIuXu60g3CxSINBgvK0ZJ4ja3RQu87kvyz25QrHbk+uVZkIj+XHzEI/pcPb2WjiE23aj1LluOCODhuSqBHoIWOf+cehYyxrd4DOIE8+xNmuyYIuE1RAcyPNqctAMHB99Y9Qg6z8pIeoP5NC1CzG1pEmKaCqInot2KfsoQgIIByuqIpqXJF/Ie1PcLEKG0W66CCndDLcQVBFZbVhSSQZXK1Wa0xPcL7tEUOSstEMzVjwgHD1obeyVeWGJup0dAckmllNaTAeipX03GfuBA14wwQf1fPtOMLhg70rWtBlCmbUOkqodUuwSLZ7eBGetjd2RKLDLKoMXc35IXArdlFONTuz9BVEcSr0tg7i+2Vn0XBKg9XuT8If86cXzImVQSxDwsrLn
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(56012099006)(11063799006)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x7wafrrwBsavGJYAUpZqBgDi6j02azIIyNoRzK3SYexVDQoFu9SDq8/ef9GyvlC02/O7hX9iEseIatNt1xS+AiJe7ZLZoqGfO9/7EzbE/1N32Sxa2wWnlpS0JVvplnkEEaQrqWFDK5uNhJKT65iZcRDx9Iw8EngxP9eyiLHm7lTVZqL2boPKuZLTY+ogMdOZkuBKoLcrCjRtbnOXIMWaVuO3NRlw7hssugsdMeD2SHtyqZxuCH6m3LmsHtZJuURkbFHXpP7YlCn4V1AItH6WiCOS+Y3eiruyVJ8ALFmMs66+gILc1tYjtAZWIJLUp4xnomIIb+A6OzBGccel9JPK1cUkNvHghBuPlsN+AZlm7ChFYyRGrVt0OMq3Qcx3Uaid7ZFV6bl8PE8+KoHPWXiuLVWEbhXQB3skqg9u2C6DQxpXM0lq3z/qhE7VJQIU05kl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 07:51:31.8233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4553c76a-39b6-4d03-1d1f-08ded0fc3db7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5795
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=FangSheng.Huang@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
---
 qapi/machine.json          | 43 ++++++++++++++++++++++++++++++++++++--
 hw/core/machine-hmp-cmds.c | 11 ++++++++++
 hw/mem/sp-mem.c            | 19 +++++++++++++++++
 3 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index 685e4e29b8..9b2248038f 100644
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
+# @size: size of memory that the device provides, in bytes
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


