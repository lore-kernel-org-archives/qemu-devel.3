Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A21CCD195
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Oct 2025 06:15:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9dje-0004GV-MJ; Fri, 17 Oct 2025 02:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9djc-0004F9-Fi
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:14:40 -0400
Received: from mail-westcentralusazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c112::7] helo=CY3PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v9djX-0008He-GG
 for qemu-devel@nongnu.org; Fri, 17 Oct 2025 02:14:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZaMyoCPEgDEDliYHculFL/bvHzcs3YLh30e/wqRw6LSFTcsO1fgoUG3zbtIYrhSllrp6gJhYH/AJmzDPTt8YJdtkfLkxvaDVVL6C07rrx9MfI7bNFn8Gn3emOEktbIkT8t/Ac4JGEW+iYmMXiOJXpsy4y91ouzUuCh7zqFqLN/8FxxscHXo41HBHYxdXXEl/JLnOifnP8UakwmotcdeVGkbsGup4YVI5U2aWyzZZvlIMltZBwdYJvp6OgsRMKOvyqseptS7xZK5/4mkRkL/XdmInQ8fPdQCr1Brp336NxclERdArA+10TFwxY7JoPdjuzyFwEtqDxETWx1nvSaqG4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u5CaXy3Vq/oMW2meOhC0Nh7UC6+eV9MMpDH3oU1q7VE=;
 b=Td2ODKLgUm8Ans6Amc6PVicv7IdbilpcT03DCxKGccivJcgOLqMuJhtqWk0TAJTEXx4HV5laBK0KjS2++6jeTKnQV/xnFmDm1DX1mo4I4U7JqSKkFPnbkWGlFU8g8sAOHEen8zyHjq3nWIC358lqvO4gCVTozOOf5uMRrTaBYdbk+jNBE8U6MJqj2nvlozTOwtBhhJkVL0ikkuoQfbDsMOpfFbaghtNdd7q8wrJiJg5gWyB+yEsyqKPKtoRVUoAKtr6shyJK7dYkHDPstYRpiELUznpE8m1XM09qmuDZsXuX9GAFl+el6YUNh6OlTOAnSmIsHrue23sTEIrsyd783w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u5CaXy3Vq/oMW2meOhC0Nh7UC6+eV9MMpDH3oU1q7VE=;
 b=0iaifBWxbxmA2tu0qFeYhA1MyJlzlXM1x2yt4UtqN4wNMk9VcZ0pVoSQ6wcjVCL8ouMrOLpQvibkodcsifYShBUaCZOVcD4UofVs3djhomFVF6yDy4IEVdAc/ZpQobVKl66PzdFhDT3zkSfHfSHqOyBNAv34546c8OXsF7eqoSo=
Received: from CH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::23)
 by IA1PR12MB6188.namprd12.prod.outlook.com (2603:10b6:208:3e4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 06:14:25 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::cd) by CH0P220CA0009.outlook.office365.com
 (2603:10b6:610:ef::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.12 via Frontend Transport; Fri,
 17 Oct 2025 06:14:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Fri, 17 Oct 2025 06:14:23 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Oct
 2025 23:14:19 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>, <aik@amd.com>, "Sairaj
 Kodilkar" <sarunkod@amd.com>
Subject: [PATCH v3 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
Date: Fri, 17 Oct 2025 11:43:22 +0530
Message-ID: <20251017061322.1584-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251017061322.1584-1-sarunkod@amd.com>
References: <20251017061322.1584-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|IA1PR12MB6188:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc1d75a-eed5-4517-d5d2-08de0d446b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BYEjLBnaoQVrcaVMYmWy1LEHpriKi4Zpb2Ihmb1Y7OHZKvp9pEfTLNwRw58m?=
 =?us-ascii?Q?x4myMlK+YsvfMwNXs2c1leydIqMq6z13ZASJs0BOXptBuXdLi1eWedKfOsAu?=
 =?us-ascii?Q?HO+k5gShM3figeyIpIjfTA+3lfUh8W8w8LrJ8RIzs5q5/eZqBn/wFo3K6mv+?=
 =?us-ascii?Q?cKt40VYiD7sVw+QE0zCKJ59qBWYLn6UtUVeTPeuOfSAZj62iQO+lgZOmYWrv?=
 =?us-ascii?Q?40EMWTRBmyYbqRgtW2AU7TXDpokvD5L2rfiWMcsZk/zYnTWDeeYrd8a0WbKT?=
 =?us-ascii?Q?3da8OBU8nEIpYIv353Ic9LX04jDsSpHvGQDoR2/XHOVofYuqimT0mfZ5odf2?=
 =?us-ascii?Q?Hx/8QlAJyV+BeU3Rx6wMHIwV5kUyy2jgELGghndacfSI6pGFsDrWNazVwquv?=
 =?us-ascii?Q?VIf3RlzADTHbatCa3k3DrKqokoN0uG6oNj4GV8eTKEQUUlJmsyBll9ON6u3u?=
 =?us-ascii?Q?nQuldtfs/dEbhz1hFSHyMfG/G/6pr7mmIpDpaC4EDbDaOwkbN6sjqJOAKvv7?=
 =?us-ascii?Q?TizVIUju7nmJJq+k5a+jKI8usKwHlFX535JvnwBrj3Tt55Aj4LLC4iRqElaA?=
 =?us-ascii?Q?NhGfsmDCnFUfjobRSU4KNviF1uQyGV3c/xci0khdJR9l9vWCCIlBjT8X1dBD?=
 =?us-ascii?Q?cEyFFT4Zv0LifmCB0zss5TY8B/L3sgJFrd507QrA8b+FR+AM7/gzitanwjwY?=
 =?us-ascii?Q?yLE4rwraSOlNp6Vp7iLlcFjM32K2tQjarourkNg7nKnWuAlrYvduECcFH6Md?=
 =?us-ascii?Q?/v1/1+wcoPnxdWQ3GE1X8uCp74fw+WU0rl3Xr6c46uMjByFkTZ2q4NBBnSiN?=
 =?us-ascii?Q?TUZHeFSfxiSga+SsPrsgn3zLNJfPGNh6hkE7DszM7IOQ5brhQejaWNNk8CFS?=
 =?us-ascii?Q?98szvA1vDN31BOVfBeC4pQRWEdBlbfjLaVZ9tyRgsl9jdwHEuCXdKuzjOQ/n?=
 =?us-ascii?Q?RjYgt2F2TqDlvbLmqtN354UIechI6B324lT0imufa6KnTvCStmUjwTP54qqF?=
 =?us-ascii?Q?2P12hMHFlxbjIBZHhu0+ni/E/Cc5wuOLepyeWQmkvAOwg4L8KHosFh6EVfEU?=
 =?us-ascii?Q?5Wiz5ZQC46LHoSp4yauOdwCPxgYw+GQJAbFWg3QEgtnvy8gb4n7LR4YX5B+M?=
 =?us-ascii?Q?W4pJQBSzcRmOaPzwebbzqJ2dzI9+o3SWqNQ37sNSrLaDEzr3N/gqLBJSLxUZ?=
 =?us-ascii?Q?b0xVInyZbIvEuPNSZuHBLbpYKSVBeqmoSJvyn/t87IxkZkXRx79mwvnh+oZc?=
 =?us-ascii?Q?V/38ZgxgHxh0TghOalFEcUn94rI9on5moQ6RHrA0e4ltixOOAThr5IxvUDO1?=
 =?us-ascii?Q?J1XfK6V3MiykS3RUgXrEu6feqJOvvf9OqeTst0RlwFHkl0+m+oCDfRpt9s8l?=
 =?us-ascii?Q?EQpe8Abhy+bdxJPd+bSABjhI7Tu9cKifP3y3hA0xpbCNMtulv3ENgDjIamhV?=
 =?us-ascii?Q?sUKBMzedsCvFp3XMvXbMt3FXLpRFWzWGJuSlkpGAe/eEQSTw2B/j1BNrj3nT?=
 =?us-ascii?Q?dxHeMpxgwPKf0kEf5qj133e3PD0Lp3+mb9SzsHHli2+e87+QD2guPe4cBgmJ?=
 =?us-ascii?Q?dmyBW2OKMcyBj5Wt1O8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:14:23.9233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc1d75a-eed5-4517-d5d2-08de0d446b29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6188
Received-SPF: permerror client-ip=2a01:111:f403:c112::7;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CY3PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
to read or write from a given DMA address, IOMMU translates the address
using page table assigned to that device. Since IOMMU uses per device page
tables, the emulated IOMMU should use the cache tag of 68 bits
(64 bit address - 12 bit page alignment + 16 bit device ID).

Current emulated AMD IOMMU uses GLib hash table to create software iotlb
and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
to 60 bits. This causes failure while setting up the device when guest is
booted with "iommu.forcedac=1".

To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
the devid to construct the 64 bit hash key in order avoid the truncation
as much as possible (reducing hash collisions).

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
 hw/i386/amd_iommu.h |  4 ++--
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index c2cd5213eb1b..5487894aba40 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -106,6 +106,11 @@ typedef struct AMDVIAsKey {
     uint8_t devfn;
 } AMDVIAsKey;
 
+typedef struct AMDVIIOTLBKey {
+    uint64_t gfn;
+    uint16_t devid;
+} AMDVIIOTLBKey;
+
 uint64_t amdvi_extended_feature_register(AMDVIState *s)
 {
     uint64_t feature = AMDVI_DEFAULT_EXT_FEATURES;
@@ -377,16 +382,6 @@ static void amdvi_log_pagetab_error(AMDVIState *s, uint16_t devid,
              PCI_STATUS_SIG_TARGET_ABORT);
 }
 
-static gboolean amdvi_uint64_equal(gconstpointer v1, gconstpointer v2)
-{
-    return *((const uint64_t *)v1) == *((const uint64_t *)v2);
-}
-
-static guint amdvi_uint64_hash(gconstpointer v)
-{
-    return (guint)*(const uint64_t *)v;
-}
-
 static gboolean amdvi_as_equal(gconstpointer v1, gconstpointer v2)
 {
     const AMDVIAsKey *key1 = v1;
@@ -425,11 +420,30 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
                              amdvi_find_as_by_devid, &devid);
 }
 
+static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
+{
+    const AMDVIIOTLBKey *key1 = v1;
+    const AMDVIIOTLBKey *key2 = v2;
+
+    return key1->devid == key2->devid && key1->gfn == key2->gfn;
+}
+
+static guint amdvi_iotlb_hash(gconstpointer v)
+{
+    const AMDVIIOTLBKey *key = v;
+    /* Use GPA and DEVID to find the bucket */
+    return (guint)(key->gfn << AMDVI_PAGE_SHIFT_4K |
+                   (key->devid & ~AMDVI_PAGE_MASK_4K));
+}
+
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    AMDVIIOTLBKey key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr),
+        .devid = devid,
+    };
     return g_hash_table_lookup(s->iotlb, &key);
 }
 
@@ -451,8 +465,10 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
 static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
                                     uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    AMDVIIOTLBKey key = {
+        .gfn = AMDVI_GET_IOTLB_GFN(addr),
+        .devid = devid,
+    };
     g_hash_table_remove(s->iotlb, &key);
 }
 
@@ -463,8 +479,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
         AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-        uint64_t *key = g_new(uint64_t, 1);
-        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+        AMDVIIOTLBKey *key = g_new(AMDVIIOTLBKey, 1);
+
+        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
+        key->devid = devid;
 
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
@@ -477,7 +495,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
         entry->perms = to_cache.perm;
         entry->translated_addr = to_cache.translated_addr;
         entry->page_mask = to_cache.addr_mask;
-        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+        entry->devid = devid;
+
         g_hash_table_replace(s->iotlb, key, entry);
     }
 }
@@ -2526,8 +2545,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
+                                     amdvi_iotlb_equal, g_free, g_free);
 
     s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
                                      amdvi_as_equal, g_free, g_free);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 38471b95d153..302ccca5121f 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -220,8 +220,8 @@
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
 
 /* IOTLB */
-#define AMDVI_IOTLB_MAX_SIZE 1024
-#define AMDVI_DEVID_SHIFT    36
+#define AMDVI_IOTLB_MAX_SIZE        1024
+#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-- 
2.34.1


