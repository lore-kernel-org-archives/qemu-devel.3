Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB882CCF9FE
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 10:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEmkb-0002ta-IN; Fri, 31 Oct 2025 06:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkX-0002qu-BD; Fri, 31 Oct 2025 06:52:53 -0400
Received: from mail-westusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c000::1] helo=BYAPR05CU005.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <skolothumtho@nvidia.com>)
 id 1vEmkS-0002tn-8E; Fri, 31 Oct 2025 06:52:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuhDyjQubrcenBs3XsC3jg1YUz9pXmJwBpD6PV1hWLWVpXbDeRO+ARnUSBwkDbRDaWn1ZilUuVUzqqYbmfDVSxqwhP2ZeKrhI68x8sFtQSLSKoxxGkBt7CNUimFJygR3ULlmp/dFjEvBKq7CIY1efx+a9LYsEc+2+aAZt0oYnjCTA/mEbc1WhzE53pOFuWHpb0lkfx1vgSuSO3MkAU9XtU9Dqm4OxLqOATJn70QBrvHcd5/wlmetTWZaBr03sAAROfUj1mPZP/ya415BgCEqHfXqPv7tgesQrmeQIVw5y9ibuKtK3L+YIH8Ygp6nLF/XfiV11ZvaezUmExbR25BYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ClVGz80L8jUr8B2zYHZ1WY8NHWbShRbNSEA7lCu0ZzU=;
 b=ETQlbdPScr/vDBaBAJqaCgXVlgE71o/bCaVhOApZsZRV7MB1UH8ce/SybZLTj7A4hGGsYFkgy/C5v7zaYhqlo3eIUVWChjAJPcAGnwWKczuiyNnyWbvuBW0sAf7H9TeZENQ4T1s+2riR83Ay47qcgh7sknBLnATIHJ/khjI6QmHr0wq8fFRdUWEsd/+BNvPjQGArjB4ACArKlLop4vfof3LcJsy3HLKGGxcdeRE+PlxLxno0rK8SF4LzfqJ8+4E5vCLtafYGVSTOiVo4RJ+lkyja6OVkOGlZysf1ZLjZ6ghG7+6q8s8Xcog3t40gwkue+Msa1BVSnhl9dT1zQP8VeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=nongnu.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ClVGz80L8jUr8B2zYHZ1WY8NHWbShRbNSEA7lCu0ZzU=;
 b=RvAJEgnYLqDjT50E/Bm96TXJFfDUxnAWuklW+VY7lZ4QSTQgZxAWeDVQ4yeorussIP9LKwtfnYYbr8JifmL/L1hFbL3I1rCZThmyK94btFnoXmHSJxOjv9N/SDyNvGVf+uoGYy2GADM1Qxg4XxWOF2hQ7M5eJjwYC0MgKeXQZMk1vbw5v69n6grqVxbF0GWIEmNfj8NlACUupjpomRViHIgQWApLhk7B87xnkmFPBsuruWYshbupay3HG1MjnI2DuSAZWhooPO8Qv/QyRTXFAZEsY9oW/5K6ZhrR2DL9dLkUFJq+DeR6iqifccZANf6vSJF8WOLQ+YCmOsIdutazEw==
Received: from DM5PR07CA0098.namprd07.prod.outlook.com (2603:10b6:4:ae::27) by
 CH3PR12MB9078.namprd12.prod.outlook.com (2603:10b6:610:196::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.15; Fri, 31 Oct
 2025 10:52:37 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:4:ae:cafe::70) by DM5PR07CA0098.outlook.office365.com
 (2603:10b6:4:ae::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.15 via Frontend Transport; Fri,
 31 Oct 2025 10:52:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 10:52:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:28 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 31 Oct
 2025 03:52:24 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <qemu-arm@nongnu.org>, <qemu-devel@nongnu.org>
CC: <eric.auger@redhat.com>, <peter.maydell@linaro.org>, <jgg@nvidia.com>,
 <nicolinc@nvidia.com>, <ddutile@redhat.com>, <berrange@redhat.com>,
 <nathanc@nvidia.com>, <mochs@nvidia.com>, <smostafa@google.com>,
 <wangzhou1@hisilicon.com>, <jiangkunkun@huawei.com>,
 <jonathan.cameron@huawei.com>, <zhangfei.gao@linaro.org>,
 <zhenzhong.duan@intel.com>, <yi.l.liu@intel.com>, <kjaju@nvidia.com>
Subject: [PATCH v5 03/32] hw/arm/smmu-common: Factor out common helper
 functions and export
Date: Fri, 31 Oct 2025 10:49:36 +0000
Message-ID: <20251031105005.24618-4-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031105005.24618-1-skolothumtho@nvidia.com>
References: <20251031105005.24618-1-skolothumtho@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|CH3PR12MB9078:EE_
X-MS-Office365-Filtering-Correlation-Id: 094d92ae-2d1d-4b5e-7421-08de186b9ad9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|7416014|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v/UEdEF9+DfBAEshsZore0JIfQvZl51gMLrX0RyVx+m/v/SGW+jeLKak0Qeo?=
 =?us-ascii?Q?o0SmdqTCO+lwsUlcCvkF5oJ06XBF9dOkCwiuzOGXwDO/kRqrEalf08xKiGiE?=
 =?us-ascii?Q?h180KlqsOqGTn2shtJFYNem0nPYignAqNz95YkoBdDa6snGdRTZZ+ISnHAVp?=
 =?us-ascii?Q?zrBDiszskP1qEVwT5v7xle81iNR4aJMKa36Y9a2gi+3rqWPNGtlx5JrfQQsO?=
 =?us-ascii?Q?NVQR2xozxDQ1nPgO4Iz2xHnoo+ZI/HG+hFYm9E1p1l60jO0RS+rOfhgKwuZ+?=
 =?us-ascii?Q?pKrWLhzauVaky+yU/8kEKTC2VdSAxvYiTtIo+0sGtoKAxifwiD02t87YUdxo?=
 =?us-ascii?Q?QPuz3K96NrnO2Pvu7k1x4aLEJs90f/tD+T2zWCuiuZdK8xaqTh66sd0GZmnV?=
 =?us-ascii?Q?+X61XHT+h5yrTD2jYuwA7ZUv9ni/hFYwzP5jQE4i81qZHReUZZWTDqy/UWLg?=
 =?us-ascii?Q?Azc1+N1sMlZ2t1ONmMdSijr3r4N83KHDpv4K2ncr+pBCifMNKDe6vir8XACW?=
 =?us-ascii?Q?quNckn7qLEEQE3mpME12zHQ1VeAwY95HAOibpBQrga8Muzde091ZNGP/HHBp?=
 =?us-ascii?Q?yvzVgt8FxZRXqXBtwfcEpvnolxJ8Qfvqv0/WbrI9uewHySvOSHPLRm7S/zPY?=
 =?us-ascii?Q?nEpvi4o0Na16pT4UcRCWbDZzqanRiuFcWk9yXTzY9iFEwmAElRNYIehyGgGw?=
 =?us-ascii?Q?PMA2Xyfro5lNn7EylceOc5DajdKLiq0sRDFz3fpsW8quWGd4TWQ7yYD3av6o?=
 =?us-ascii?Q?by8SjcS5zHLeW1mg8+eXlE4xzHa9KVG5Gm6SCUHPrhOBD+r5ITQz8iEcDm3z?=
 =?us-ascii?Q?elG33BgYiUnKJvQf6WKhUAlUtPv0H/UyTiuNmHiJM7gzQwWwkJZBYs6ALJ/5?=
 =?us-ascii?Q?nO9rNHzBzJxMhloTfdmvo2qQ+FymD/JqgOhAkiXwNF+5XXp/DiNlOYx8gL7g?=
 =?us-ascii?Q?CqeqAEsK97AqIchXmJlt3TCgSxO+HJyB8xRxsIOnkiEAxFaWzA9bbq0h7Swp?=
 =?us-ascii?Q?/PMTlX+Hzw98hQnvxPDPk35NUBlx9WLY+n5x/DNdRBYDmcO8XiFOaudmnMla?=
 =?us-ascii?Q?vQNxIRSyRMsxFyRNyQi8OaB4T/yqIF+RVFRVLainH1iVhVkM3zOlgV/einLW?=
 =?us-ascii?Q?CbCdSTacMykdj/PRWPFCM1+kEQ+QC9gQNkYRIa80H3rLmaYbk2A4XIY3R8q4?=
 =?us-ascii?Q?a9zshDivh8y7bOksRxg9UWRUAmX9kqgaBo44YyWF/341daO/mndX1bkDmT8Q?=
 =?us-ascii?Q?KBAJm1dDkrv9xoDY7BRe6gS4sagfD7CiITUt8NK0yzHqt4SPhOCV9eoLwSUJ?=
 =?us-ascii?Q?UCuUCmgs8u/LbA4HTbQBFI87E6D/DKgtuJW8Vj67pdoOcp7KpNfj7RxeS2WT?=
 =?us-ascii?Q?lYJYeLvrU+l3etgo/XoWQu+KjXP/QjT8xGRTpVyT1ahxf7mqATrTE9BvvHFr?=
 =?us-ascii?Q?9scrUUFzZb/9ny0Gu1mEqnwe3iT9Lx++tGOe1RiLGG0Ns14RskLRJMoxPCbx?=
 =?us-ascii?Q?fUqwq8TBsE24hzLfcR7+DW+ABjFyCOUpS1CRIu7g0C9l/8e6ptRQEhb8CpV+?=
 =?us-ascii?Q?zVyzpX6Rt+ZFUH+U02Q=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 10:52:37.0537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 094d92ae-2d1d-4b5e-7421-08de186b9ad9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9078
Received-SPF: permerror client-ip=2a01:111:f403:c000::1;
 envelope-from=skolothumtho@nvidia.com;
 helo=BYAPR05CU005.outbound.protection.outlook.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Factor out common helper functions and export. Subsequent patches for
smmuv3 accel support will make use of this.

Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 hw/arm/smmu-common.c         | 44 +++++++++++++++++++++---------------
 include/hw/arm/smmu-common.h |  6 +++++
 2 files changed, 32 insertions(+), 18 deletions(-)

diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 62a7612184..59d6147ec9 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -847,12 +847,24 @@ SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num)
     return NULL;
 }
 
-static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn)
 {
-    SMMUState *s = opaque;
-    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
-    SMMUDevice *sdev;
     static unsigned int index;
+    g_autofree char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn,
+                                            index++);
+    sdev->smmu = s;
+    sdev->bus = bus;
+    sdev->devfn = devfn;
+
+    memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
+                             s->mrtypename, OBJECT(s), name, UINT64_MAX);
+    address_space_init(&sdev->as, MEMORY_REGION(&sdev->iommu), name);
+    trace_smmu_add_mr(name);
+}
+
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus)
+{
+    SMMUPciBus *sbus = g_hash_table_lookup(s->smmu_pcibus_by_busptr, bus);
 
     if (!sbus) {
         sbus = g_malloc0(sizeof(SMMUPciBus) +
@@ -861,23 +873,19 @@ static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
         g_hash_table_insert(s->smmu_pcibus_by_busptr, bus, sbus);
     }
 
+    return sbus;
+}
+
+static AddressSpace *smmu_find_add_as(PCIBus *bus, void *opaque, int devfn)
+{
+    SMMUState *s = opaque;
+    SMMUPciBus *sbus = smmu_get_sbus(s, bus);
+    SMMUDevice *sdev;
+
     sdev = sbus->pbdev[devfn];
     if (!sdev) {
-        char *name = g_strdup_printf("%s-%d-%d", s->mrtypename, devfn, index++);
-
         sdev = sbus->pbdev[devfn] = g_new0(SMMUDevice, 1);
-
-        sdev->smmu = s;
-        sdev->bus = bus;
-        sdev->devfn = devfn;
-
-        memory_region_init_iommu(&sdev->iommu, sizeof(sdev->iommu),
-                                 s->mrtypename,
-                                 OBJECT(s), name, UINT64_MAX);
-        address_space_init(&sdev->as,
-                           MEMORY_REGION(&sdev->iommu), name);
-        trace_smmu_add_mr(name);
-        g_free(name);
+        smmu_init_sdev(s, sdev, bus, devfn);
     }
 
     return &sdev->as;
diff --git a/include/hw/arm/smmu-common.h b/include/hw/arm/smmu-common.h
index 80d0fecfde..d307ddd952 100644
--- a/include/hw/arm/smmu-common.h
+++ b/include/hw/arm/smmu-common.h
@@ -180,6 +180,12 @@ OBJECT_DECLARE_TYPE(SMMUState, SMMUBaseClass, ARM_SMMU)
 /* Return the SMMUPciBus handle associated to a PCI bus number */
 SMMUPciBus *smmu_find_smmu_pcibus(SMMUState *s, uint8_t bus_num);
 
+/* Return the SMMUPciBus handle associated to a PCI bus */
+SMMUPciBus *smmu_get_sbus(SMMUState *s, PCIBus *bus);
+
+/* Initialize SMMUDevice handle associated to a SMMUPciBus */
+void smmu_init_sdev(SMMUState *s, SMMUDevice *sdev, PCIBus *bus, int devfn);
+
 /* Return the stream ID of an SMMU device */
 static inline uint16_t smmu_get_sid(SMMUDevice *sdev)
 {
-- 
2.43.0


