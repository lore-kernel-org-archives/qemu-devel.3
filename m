Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612D0CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 16:45:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6XHY-00035f-Oj; Wed, 08 Oct 2025 12:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6XHT-00035K-Jq
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:44:47 -0400
Received: from mail-westus3azlp170110003.outbound.protection.outlook.com
 ([2a01:111:f403:c107::3] helo=PH0PR06CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1v6XHI-0002cR-MX
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 12:44:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBP5Hx0NWFy2hexHwsLGt8CmeT6xu1Q086mD2CHP74Wl44pRrHZRf62TRUSeXNXZ9b2Z0t1PB5MAoPsvCN2Na0MeQmAc48ockUFzmY6WFef2JIFLx7g3y6L8i9aBiKOAZgiyaAVxYDcErlW/o3DmZDQ/9MTlTZ33PJNt2LpP47SUeffQ7JdGUkuST9Sm6T5KQFFFU6GVXkTNnqieWYV/AODlGjhlHK3bq4V77thLgaNBs46q9HH5L7B7Dn93XE6K47oud4E4OygjMF43ID9xbcWr29TqdDbh29TUwzJNeAZ6ywN7tj2sVcgRCB9VM/QIfZFWEo+087wfDAE1lOr5eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=INvhcU/1eMeOTi3ukTDqeshiQ1vjU+/UANoMOJfSOCA=;
 b=tQYQiDtjPGILpUtfi9Tbdijw7w4aWJ4O/2wRvugH8OmDS/8rwR556lCsvk/CnDTFCCiYLTdl38iZ7c3b1j62AYOiluyk7XPqUdE6rBJtv5nzJDd5UW0bF3GqumSLec8KuWltKT6oxw93XxB04iRbrCddix9A+V08E4DR3Ufs1STslnwV+pz8vsGAfvt6w3X+aLQeYihQPdFSnAF9a6qzK8JwDMNBkB1zUzMuGWarqhTwGcguKdasJKc5eGJl3oMVup3FQqHnh6EE6H6Ec2GXOW2X3NhBv2iAQgTO/WR20cTtbxCJzxeORNmal+K9JIhKL2cZ4ccsx4iMn3g8U6W3/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nongnu.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=INvhcU/1eMeOTi3ukTDqeshiQ1vjU+/UANoMOJfSOCA=;
 b=4UiL08TIWV4PbRLM3QWTeN4LQR1oDPEk6dqCpnEcBF9QSjZD76GZoCkTS68AUI1OpYmeL3BLfAbXxxhp0//I6EjlKj5j6/3M6i38tbuiJwCCvZI8Iw9UhDVFptZCn9hvMYgnFU76M+gz7EMfWHYiNcqktWfqtsUKG4Ags6s9yMw=
Received: from SN7PR04CA0108.namprd04.prod.outlook.com (2603:10b6:806:122::23)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Wed, 8 Oct
 2025 16:44:22 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com
 (2603:10b6:806:122:cafe::e8) by SN7PR04CA0108.outlook.office365.com
 (2603:10b6:806:122::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.20 via Frontend Transport; Wed,
 8 Oct 2025 16:44:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Wed, 8 Oct 2025 16:44:20 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 8 Oct
 2025 09:44:14 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>
CC: <mst@redhat.com>, <pbonzini@redhat.com>, <richard.henderson@linaro.org>,
 <philmd@linaro.org>, <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>, 
 <marcel.apfelbaum@gmail.com>, <eduardo@habkost.net>,
 <santosh.shukla@amd.com>, <aik@amd.com>, Sairaj Kodilkar <sarunkod@amd.com>
Subject: [PATCH 2/2] hw/i386/amd_iommu: Support 64 bit address for IOTLB lookup
Date: Wed, 8 Oct 2025 22:13:24 +0530
Message-ID: <20251008164324.21553-3-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251008164324.21553-1-sarunkod@amd.com>
References: <20251008164324.21553-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b6ae16-c3c8-401e-4fd3-08de0689edbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?RSXLgm0ZDt1zIki9ZGA+9V+it2283mlJfTIaiJVk04tJz3ONvsmjwwkegCI4?=
 =?us-ascii?Q?SJCLzIYL0vwpkSNNjoynMz3JWhzyqeh0tBnEGhrd46pWoIep6z7llqWSA9tq?=
 =?us-ascii?Q?bhRCHdphw2il3jNZYSeTS0QjeFd6YOvAhfdZXdTbIdh8gSTL6HvBdtNS8XQc?=
 =?us-ascii?Q?oTcE5jKqwq4IWcQcaVMK0RiBBvTXw0tide6lKNxirXdoJflFc6q0Bbq1W45e?=
 =?us-ascii?Q?hexYqQ2vQoRTilB4uzBp5HlrnmuKRs78iKqWcIBWCBW2/TV35SAFVFuxy4hD?=
 =?us-ascii?Q?fZneihvlGyyWi/9lffIkNmQI5iluxcLvFth89Rc/f3gKpWk8zHh1wPpltKhH?=
 =?us-ascii?Q?PSTdFbKJYoxOd+NYl9dXlbtZRtFnDO4hYrXM4UaOl733Q/wMo3PqLid46YXw?=
 =?us-ascii?Q?T52YuiGmQu0CSujPddfmvti6Fd9cmdAdCRF7H0uF3meCNqydqluETNAZEJyt?=
 =?us-ascii?Q?gTCZWD0JQKBVL0bZ7zf0DWN6FW6UXNbROTncnJde7rgkWjoaN67G1g73XIuV?=
 =?us-ascii?Q?fNBeeTO4vBIsBzldVxc5FNEq4z7q15Xway8H7F8i5et9elrZSu53FtLcTsT+?=
 =?us-ascii?Q?r93mMSab+uEnrdDWTOaFQyztbMETaCKC0juMPcticXXE6540lW4gU5jmyER0?=
 =?us-ascii?Q?ip3tXO38T0AcPii2cpxSWoiBuPrc92iAAdejwD7/y+jaSj7dBV9+xdDlwmNn?=
 =?us-ascii?Q?81dQxiJDCNzlOIwiRwt6QL0DbIjrx3qc9ClBdXMnmHHq/Knkng9lKIMALJsh?=
 =?us-ascii?Q?8Gcv7xuWohJh2TZmq/6UwOOhEMCNTyF3GzkBT29q0znrgoj80QlLhk49ueKm?=
 =?us-ascii?Q?j5WR7NRnPW2a6v1OAyrE1h7UFNE7Bq7em+KfDgCPbJF8Pet0D8+nbFOlQQ8m?=
 =?us-ascii?Q?VlSyewWeXRkQBE01yptl77V16OhXq6UxM/gpzd9wa0z1dNfZotVA4JLNzKmx?=
 =?us-ascii?Q?xifi+AA+oVQoQLJKS2fimUJWbETVBHLCOW66nbY0VmOEPUurKl+EjgWWxNjF?=
 =?us-ascii?Q?FeS/rQ7f4IpMKq5kU8aNfGpsqmjgtRReOYxohpikEAFwwQsi9XHc2Df2RFDu?=
 =?us-ascii?Q?GCBUJPY7JoHGEYzbhH0iAWmX3xpawJ9TWf4DHQPayCn4GcsIkwn3XrW6H5xN?=
 =?us-ascii?Q?KW1FxHjdZ6I0Id3nBoVOPqFUXg0OniFmc1hmVybcv8pYkxF5cNeXb5J3XyGr?=
 =?us-ascii?Q?o+PAkmeRidPOU34rfAJFe3azkZW9BkaKtnB/dhJ0hnC2HiCRY06sjd2Cv8m3?=
 =?us-ascii?Q?PTXddY9/Z6JEkI8221Tx1UXORfRKSAtnLMXTsBav+c9Y7drnFfCyNgk+6a2x?=
 =?us-ascii?Q?G/jozcts+pZ7Y2wheuSczy0ai98IQRLVHsT+6dr3l8wrv0P8a4AEhowS7vQb?=
 =?us-ascii?Q?g680WPO0ullSj0174sS6//+4zKSfkswvZ4T5O3a5k64cDv+bnYZXXXpGiV5y?=
 =?us-ascii?Q?Epj88dk7CX6JSNQZSppBLQFnu0X/0bs5T6h1FUDK8LTc9AoysEwzNXlp2qDZ?=
 =?us-ascii?Q?QcZgttaZzzyJ/FmqoJ5/xALY0j4qZizUdrYcQKH7UZNnH/pSzO4BLRhWvVOW?=
 =?us-ascii?Q?FoEFogeiomJ79Jn4ZDI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 16:44:20.1407 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b6ae16-c3c8-401e-4fd3-08de0689edbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284
Received-SPF: permerror client-ip=2a01:111:f403:c107::3;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=PH0PR06CU001.outbound.protection.outlook.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Physical AMD IOMMU supports upto 64 bits of DMA address. When device tries
to read or write from the given DMA address, IOMMU translates the address
using page table assigned to that device. Since IOMMU uses per device page
tables, the emulated IOMMU should use the cache tag of 68 bits
(64 bit address - 12 bit page alignment + 16 device ID).

Current emulated AMD IOMMU uses GLib hash table to create software iotlb
and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
to 60 bits. This cause failure while setting up the device when guest is
booted with "iommu.forcedac=1".

To solve this problem, define `struct amdvi_iotlb_key` which uses 64 bit
IOVA and 16 bit devid as key to store and lookup IOTLB entry.

Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 51 ++++++++++++++++++++++++++++-----------------
 hw/i386/amd_iommu.h |  5 +++--
 2 files changed, 35 insertions(+), 21 deletions(-)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 0a4b4d46d885..5106d9cc4036 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
     int devfn;
 } amdvi_as_key;
 
+typedef struct amdvi_iotlb_key {
+    uint64_t gfn;
+    uint16_t devid;
+} amdvi_iotlb_key;
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
     const struct amdvi_as_key *key1 = v1;
@@ -423,11 +418,27 @@ static AMDVIAddressSpace *amdvi_get_as_by_devid(AMDVIState *s, uint16_t devid)
                              amdvi_find_as_by_devid, &devid);
 }
 
+static gboolean amdvi_iotlb_equal(gconstpointer v1, gconstpointer v2)
+{
+    const amdvi_iotlb_key *key1 = v1;
+    const amdvi_iotlb_key *key2 = v2;
+
+    return key1->devid == key2->devid && key1->gfn == key2->gfn;
+}
+
+static guint amdvi_iotlb_hash(gconstpointer v)
+{
+    const amdvi_iotlb_key *key = v;
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
+    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
     return g_hash_table_lookup(s->iotlb, &key);
 }
 
@@ -449,8 +460,7 @@ static gboolean amdvi_iotlb_remove_by_devid(gpointer key, gpointer value,
 static void amdvi_iotlb_remove_page(AMDVIState *s, hwaddr addr,
                                     uint64_t devid)
 {
-    uint64_t key = (addr >> AMDVI_PAGE_SHIFT_4K) |
-                   ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+    amdvi_iotlb_key key = {devid, AMDVI_GET_IOTLB_GFN(addr)};
     g_hash_table_remove(s->iotlb, &key);
 }
 
@@ -461,8 +471,10 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
     /* don't cache erroneous translations */
     if (to_cache.perm != IOMMU_NONE) {
         AMDVIIOTLBEntry *entry = g_new(AMDVIIOTLBEntry, 1);
-        uint64_t *key = g_new(uint64_t, 1);
-        uint64_t gfn = gpa >> AMDVI_PAGE_SHIFT_4K;
+        amdvi_iotlb_key *key = g_new(amdvi_iotlb_key, 1);
+
+        key->gfn = AMDVI_GET_IOTLB_GFN(gpa);
+        key->devid = devid;
 
         trace_amdvi_cache_update(domid, PCI_BUS_NUM(devid), PCI_SLOT(devid),
                 PCI_FUNC(devid), gpa, to_cache.translated_addr);
@@ -475,7 +487,8 @@ static void amdvi_update_iotlb(AMDVIState *s, uint16_t devid,
         entry->perms = to_cache.perm;
         entry->translated_addr = to_cache.translated_addr;
         entry->page_mask = to_cache.addr_mask;
-        *key = gfn | ((uint64_t)(devid) << AMDVI_DEVID_SHIFT);
+        entry->devid = devid;
+
         g_hash_table_replace(s->iotlb, key, entry);
     }
 }
@@ -2529,8 +2542,8 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
         }
     }
 
-    s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
-                                     amdvi_uint64_equal, g_free, g_free);
+    s->iotlb = g_hash_table_new_full(amdvi_iotlb_hash,
+                                     amdvi_iotlb_equal, g_free, g_free);
 
     s->address_spaces = g_hash_table_new_full(amdvi_as_hash,
                                      amdvi_as_equal, g_free, g_free);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index 38471b95d153..8089f9472ac4 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -220,8 +220,9 @@
 #define PAGE_SIZE_PTE_COUNT(pgsz)       (1ULL << ((ctz64(pgsz) - 12) % 9))
 
 /* IOTLB */
-#define AMDVI_IOTLB_MAX_SIZE 1024
-#define AMDVI_DEVID_SHIFT    36
+#define AMDVI_IOTLB_MAX_SIZE        1024
+#define AMDVI_IOTLB_DEVID_SHIFT     48
+#define AMDVI_GET_IOTLB_GFN(addr)   (addr >> AMDVI_PAGE_SHIFT_4K)
 
 /* default extended feature */
 #define AMDVI_DEFAULT_EXT_FEATURES \
-- 
2.34.1


