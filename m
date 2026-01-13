Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C935D0C85A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 11:39:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfcjo-0002qi-32; Tue, 13 Jan 2026 06:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcjf-0002i6-Hq; Tue, 13 Jan 2026 06:38:55 -0500
Received: from mail-northcentralusazlp170120005.outbound.protection.outlook.com
 ([2a01:111:f403:c105::5] helo=CH5PR02CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vfcje-0003ni-03; Tue, 13 Jan 2026 06:38:55 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hspDe1EAzKFAqK21tlmHf6hXJOMWSkrcltF9rmA3e3U3wX3Xm9wGneECsfNJ1+1wBOq9KWHbiGICARnVfsa6M/noMsMd/zhXB51N+kWEEz4ivVbt+Bsba9X39aA0zgeuvwIbPhC9rKuy49eIEdgrGDsYP9ifTm/aFdvYwlOgRPuXmloBDavNygbfk5J/4cy/xPM3UPDwzeiphXgsZjceGMZtuWiPiza0B4QVrqaNTbI1Qa7454HBzuHfFen8VDU2KTN1aZ/V9BW0zcpLnBgzkpubYHziTuS91h4Rmu2fKHHUCqXL4W9ueXvBa+AI3SeTngXS6i6lkP46m899NdISQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqB8IyAlkBDWVjvaT5c8d3vVcsk0RCwu7uELeV1YC80=;
 b=FtPaqpZ1fsFlfxMUrR9GFsQmtFaiObBICB1/vUlmekQLzg79KBDaWs1AGgKkFNkdDlU2I8XBMN68AoUyhNbSvVIjZEFAn9RITYzohHavjijbTwyvF8lj9zx7Z+PXz2lz/X5fd6DYrfdo1z2i66w58w7OBMbq7a/JqY2Tl0pKMj+3ErOi4sJ/F4oqCVx4J8GSG6Zpldyud0eyxyUANh/9IroHn6foMtAedHsKLZZ0Q+XXF6M8B2rqKXhIwbQc7zWOnHuTxIOwH1linMjGxKiB6LV4KnaPUzJmOWUj0EvlLhiH5wu53plsJ/1WA4K2Hebf2rGn88S01ea50HoxnhmoTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqB8IyAlkBDWVjvaT5c8d3vVcsk0RCwu7uELeV1YC80=;
 b=Gw6zuHxbCwIw3wJ3McvFVYhmqahyaOKgl+1XBRzUGoZ/Us9XJdpMVzmfd320RJW2UvtSkd7UD2aDxSkDKxr3Eguy0GPdZK/eLQ6m8rJOkPcohk6Xd714bp34jGnkOykHt+mjzrw3TvoP+7/eaVl9a1pr1kFuca4mtZZLR9//gtCcdwCPbOy+cT0t4N6kbhsvGU/NTgk4rq5j75DptoMsvkZU0awr/tivNzEiBFFFUAOvsIrXy/UMqFTt99TqtWZGV18UR0zp0wZxVQgvIPrOj1myU+Hg0SN6sXqc5RkpDKRXuostybQSY3qxdeVKuK8MNIXvfOjC2bnbzXHQCM/+4w==
Received: from BL1PR13CA0329.namprd13.prod.outlook.com (2603:10b6:208:2c1::34)
 by IA0PR12MB8277.namprd12.prod.outlook.com (2603:10b6:208:3de::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 11:38:45 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a9) by BL1PR13CA0329.outlook.office365.com
 (2603:10b6:208:2c1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Tue,
 13 Jan 2026 11:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 11:38:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:32 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 03:38:29 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <alex@shazbot.org>, <clg@redhat.com>,
 <cohuck@redhat.com>, <mst@redhat.com>, <nicolinc@nvidia.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <jgg@nvidia.com>,
 <kjaju@nvidia.com>
Subject: [PATCH v2 4/4] hw/vfio/region: Create dmabuf for PCI BAR per region
Date: Tue, 13 Jan 2026 11:37:54 +0000
Message-ID: <20260113113754.1189-5-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260113113754.1189-1-skolothumtho@nvidia.com>
References: <20260113113754.1189-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|IA0PR12MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d81d63-1c45-4367-a957-08de52984f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a00yejZXeGgyYnFWNDFKNDV1Si9pSGcwMElnUGQzNHFLWFR5OTVYaWVNU1pQ?=
 =?utf-8?B?bTQrSTlUdDFqRjI2bGJkT1NWV3VDN2I3MHJSbktRUFpmYmFZZzlJU3hDYm1o?=
 =?utf-8?B?S2RpRU0xa2JKdVIzbFpxV1dqb1VrVW5HZG9IQnV3cmdWaEpOUzBLSlFLVEZr?=
 =?utf-8?B?QnRlTTg4czBrcXZ5UDI0WVRGOG54WTdvalFWM1JyZUZWTFR2RnROUWUwWHE2?=
 =?utf-8?B?bGpkckc4UVJlS2crQ1lTZUpaQTdDOXQ4bG1IYkkvYmtxMnYwM2dORnlCSllC?=
 =?utf-8?B?VjJNUnB0WDluak0xRUlFVmIrUkFkU3JYQXFBVWx5WUl5WGw3NTVpbEM0M0U0?=
 =?utf-8?B?cUR4T3p3a24wY1pRTVVRQWM1b3RnS0NHVVhPM3FvYzZDdjVGaXJXVE8zU3Rt?=
 =?utf-8?B?NXp2VCt0SGc5RS9ZUzBDUlU4UGFmTUZGK0VQZU5JMDhORy94U09iZUU0MS9F?=
 =?utf-8?B?RFJ1U0t0VERraHR0S0tDRFYzbzA5a2ZWalJBMyt0Q3VpVTZHT3hxUEduN0lW?=
 =?utf-8?B?cVAzdVJNcHM5R3hTd09IU1VWcGFYS2F3ZlRGeEEvNUJvd1lRdm5sMGJsS1cx?=
 =?utf-8?B?dlliWm1tNXhvV2tyOWRiUmpaUVdjTDFNdlUwaFFEK2hzVytMbWhpRG83UGpy?=
 =?utf-8?B?WkwzTmgrTzdqL1Z6VUtuWEhtdmF4aUo0cm1BT1NqYzd5Y3RrTDBlaVhvdTl6?=
 =?utf-8?B?WTVxSVl5eW5PS1JFdGhvZk5kaW82Vk4wTDk3NS9Va0hBeXFsV1BiamkxNG5N?=
 =?utf-8?B?OWUxeERNVFp4NWdOQmVOSjg3M2ZPaTdaanFzRmZYNjlYblgrYjMzNTdJbmVW?=
 =?utf-8?B?WFAvOTZHbUxFeXMwM1ZzeGFFNG95cDV2bzY3cGYwbDkzN3pob1haTnhMNDdH?=
 =?utf-8?B?eGhGMS9UQjJBeVBFR2g2R1RuNDVTTTNjcDYrMjlRNEpQS3Fqemhjb2lTMFU2?=
 =?utf-8?B?WVQ1SjhFMGZrQU84Q21hZEEvUkdPZWdFV001SzJ0OUZRaDBmR24vd2IzOUs3?=
 =?utf-8?B?azB1Mk1UbHlraUdieXh0ZnNvbWlxb29aY2VlQUtFUnZPSndLM2FiSm1xVEpq?=
 =?utf-8?B?ZmhIR1gzV29xMEc1TGkrVXUxb2RHZGdSSFRLaFVZUlFOT3diczdEWnExcWRE?=
 =?utf-8?B?TUpxSURvSHphc1dMK2xxU0RESGhENnBjeEhKQnM5UVFHN0JmR3JINnJIOFNS?=
 =?utf-8?B?V0FaeVBlanVXMy9XOVVvUktzbXNRaWxra3VlVlpLMXVKWXVaNkVVTUNxZ1Z6?=
 =?utf-8?B?dU5yM3U5OEpJNE50WkFzelg3M204S1JyUUpEZU5IWU5qL2gyMzgwWGhZR1hK?=
 =?utf-8?B?ZWlBRkJ1dWtlT2hFbmYvNVZMT3FMbjVXcHQvL1dIUDNMaURldkpLbUpXQk55?=
 =?utf-8?B?and5eUZOL2l5dW9QWUhpYUVIVEpJTkNGd2JuTE4xK2EzS1N4UjhnbG44RTZq?=
 =?utf-8?B?bHFiREFJaU9nVDFTRVF4ZFpuS0lMWmFnRG9rMENadzBnRit5SDhtblRDRWVz?=
 =?utf-8?B?VEI1azNTQSs3bzFrMmNraUZ3RWxwdUJHdVhYWXFRZFVMQ1FwYW9oQnQwTHhO?=
 =?utf-8?B?OFVaTVJhMXB4dDc1dGljN1JhTFNSZlhhYzlsbEJlYzczZVlCcEVNTjhxNW1z?=
 =?utf-8?B?UlVzYXZmNzZVRy9GQXFjV25MM3A4ZHM1YnMrUGEvbTlrcFJXbFkzV3k2aWtS?=
 =?utf-8?B?ZHM3YkJ1a2dpRU82Yk5YQWtOSXZaQmJIVFhxdnNRMGZTRTdiWG8wbkdsYmpp?=
 =?utf-8?B?bktvNlNuVGViU0lkWUNDUEhmQ3BnRFFjWHVvMHphOU5iUlV0QjdqVFlZSVc3?=
 =?utf-8?B?dThNVXJ1d3grVnJpblFYVUZTaGtvWmhTNGhLc215MXB4am4xOU9CRnQrdU1T?=
 =?utf-8?B?emIrQUpFNkw1cmU5aWxiL2VUcHhQSlhOWllpTHNqNlRQcTFZZXExci9rOEFn?=
 =?utf-8?B?clpQUmltYjFHakFXSVdCT2Q5Zll6R1dmRXY0WTdQS0RqR242VFg1NGRQTzVL?=
 =?utf-8?B?MTJqMEtYZFRYR1grb1dJM2pJaW5vUEFzcTF5eTZ5azZ2YUh4aHpXUE9SKys4?=
 =?utf-8?B?VnlXLzdyWkxTVGdQdjNXRlcrcGtTS25nMXJRU3lKRVBpZ0FSbGdKRWFuT0kx?=
 =?utf-8?Q?G1y8=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 11:38:45.2424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d81d63-1c45-4367-a957-08de52984f6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8277
Received-SPF: permerror client-ip=2a01:111:f403:c105::5;
 envelope-from=skolothumtho@nvidia.com;
 helo=CH5PR02CU005.outbound.protection.outlook.com
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

From: Nicolin Chen <nicolinc@nvidia.com>

Linux now provides a VFIO dmabuf exporter to expose PCI BAR memory for P2P
use cases. Create a dmabuf for each mapped BAR region after the mmap is set
up, and store the returned fd in the region’s RAMBlock. This allows QEMU to
pass the fd to dma_map_file(), enabling iommufd to import the dmabuf and map
the BAR correctly in the host IOMMU page table.

If the kernel lacks support or dmabuf setup fails, QEMU skips the setup
and continues with normal mmap handling.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/vfio/region.c     | 69 +++++++++++++++++++++++++++++++++++++++++++-
 hw/vfio/trace-events |  1 +
 2 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/region.c b/hw/vfio/region.c
index ca75ab1be4..8476a54dda 100644
--- a/hw/vfio/region.c
+++ b/hw/vfio/region.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qemu/units.h"
 #include "monitor/monitor.h"
+#include "system/ramblock.h"
 #include "vfio-helpers.h"
 
 /*
@@ -238,13 +239,53 @@ static void vfio_subregion_unmap(VFIORegion *region, int index)
     region->mmaps[index].mmap = NULL;
 }
 
+static int vfio_region_create_dma_buf(VFIORegion *region)
+{
+    g_autofree struct vfio_device_feature *feature = NULL;
+    VFIODevice *vbasedev = region->vbasedev;
+    struct vfio_device_feature_dma_buf *dma_buf;
+    size_t total_size;
+    int i, ret;
+
+    g_assert(region->nr_mmaps);
+
+    total_size = sizeof(*feature) + sizeof(*dma_buf) +
+                 sizeof(struct vfio_region_dma_range) * region->nr_mmaps;
+    feature = g_malloc0(total_size);
+    *feature = (struct vfio_device_feature) {
+        .argsz = total_size,
+        .flags = VFIO_DEVICE_FEATURE_GET | VFIO_DEVICE_FEATURE_DMA_BUF,
+    };
+
+    dma_buf = (void *)feature->data;
+    *dma_buf = (struct vfio_device_feature_dma_buf) {
+        .region_index = region->nr,
+        .open_flags = O_RDWR,
+        .nr_ranges = region->nr_mmaps,
+    };
+
+    for (i = 0; i < region->nr_mmaps; i++) {
+        dma_buf->dma_ranges[i].offset = region->mmaps[i].offset;
+        dma_buf->dma_ranges[i].length = region->mmaps[i].size;
+    }
+
+    ret = vfio_device_get_feature(vbasedev, feature);
+    for (i = 0; i < region->nr_mmaps; i++) {
+        trace_vfio_region_dmabuf(region->vbasedev->name, ret, region->nr,
+                                 memory_region_name(region->mem),
+                                 region->mmaps[i].offset,
+                                 region->mmaps[i].size);
+    }
+    return ret;
+}
+
 int vfio_region_mmap(VFIORegion *region)
 {
     int i, ret, prot = 0;
     char *name;
     int fd;
 
-    if (!region->mem) {
+    if (!region->mem || !region->nr_mmaps) {
         return 0;
     }
 
@@ -305,6 +346,32 @@ int vfio_region_mmap(VFIORegion *region)
                                region->mmaps[i].size - 1);
     }
 
+    ret = vfio_region_create_dma_buf(region);
+    if (ret < 0) {
+        if (ret == -ENOTTY) {
+            warn_report_once("VFIO dma-buf not supported in kernel: "
+                             "PCI BAR IOMMU mappings may fail");
+        } else {
+            error_report("%s: failed to create dma-buf (%s): "
+                         "PCI BAR IOMMU mappings may fail",
+                         memory_region_name(region->mem), strerror(errno));
+        }
+        /*
+         * Return success as VFIO region mmap succeeded and dmabuf is optional.
+         * P2P DMA or exposing device memory use cases will not be supported.
+         */
+        return 0;
+    }
+
+    /* Assign the dmabuf fd to associated RAMBlock */
+    for (i = 0; i < region->nr_mmaps; i++) {
+        MemoryRegion *mr = &region->mmaps[i].mem;
+        RAMBlock *ram_block = mr->ram_block;
+
+        ram_block->fd = ret;
+        ram_block->fd_offset = region->mmaps[i].offset;
+    }
+
     return 0;
 
 no_mmap:
diff --git a/hw/vfio/trace-events b/hw/vfio/trace-events
index 1e895448cd..592a0349d4 100644
--- a/hw/vfio/trace-events
+++ b/hw/vfio/trace-events
@@ -117,6 +117,7 @@ vfio_device_put(int fd) "close vdev->fd=%d"
 vfio_region_write(const char *name, int index, uint64_t addr, uint64_t data, unsigned size) " (%s:region%d+0x%"PRIx64", 0x%"PRIx64 ", %d)"
 vfio_region_read(char *name, int index, uint64_t addr, unsigned size, uint64_t data) " (%s:region%d+0x%"PRIx64", %d) = 0x%"PRIx64
 vfio_region_setup(const char *dev, int index, const char *name, unsigned long flags, unsigned long offset, unsigned long size) "Device %s, region %d \"%s\", flags: 0x%lx, offset: 0x%lx, size: 0x%lx"
+vfio_region_dmabuf(const char *dev, int fd, int index,  const char *name, unsigned long offset, unsigned long size) "Device %s, dmabuf fd %d region %d \"%s\", offset: 0x%lx, size: 0x%lx"
 vfio_region_mmap_fault(const char *name, int index, unsigned long offset, unsigned long size, int fault) "Region %s mmaps[%d], [0x%lx - 0x%lx], fault: %d"
 vfio_region_mmap(const char *name, unsigned long offset, unsigned long end) "Region %s [0x%lx - 0x%lx]"
 vfio_region_exit(const char *name, int index) "Device %s, region %d"
-- 
2.43.0


