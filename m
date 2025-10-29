Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E4A7CCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 10:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE31h-0004PQ-1y; Wed, 29 Oct 2025 06:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE31e-0004P3-O1
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:03:30 -0400
Received: from mail-northcentralusazlp170100001.outbound.protection.outlook.com
 ([2a01:111:f403:c105::1] helo=CH1PR05CU001.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sairaj.ArunKodilkar@amd.com>)
 id 1vE31a-0004C4-9D
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 06:03:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CyAAmnZbGGgg0lPSLQ0ZgxwKJ4CPGS1n/RqtUi7mm4uhjJjAIPpA29qb+HoyitTWtcVK4C15Vo65YbQmdPwbKL2A3AmqVjVVg1SAmklLwRUAyYj4VFZ6qTpnvT+CAaxOdzz9teqx24geFzAFWResJ1srbvKrZGxcJ0uHglnrimpKEiTjeGSRITKK1PS+Ez7OBiBQOcz8PjjpCuYbYBjE1G5f0UfXCMVT/Na1uruZOb/wyVW1GxkR3pqZ15UHWUAtlo5t9HOQc+C0SY1JvhCQkhzanhdMsS9oukV7D6Od+uF24VNwVw7os7OtsDt91JNZDWRyTaEFF1NHqZMFPJ+euQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bf1B/H7NzD2snA92lk0wyoyd2QWsUAmfEuMtaU8nugk=;
 b=wp6X1XnR3Rg50U+ybUMnQVmqc1OGVhKVNkbGMTtNllmmt5JttI2l4dxpM06SC4NoXLZMc3K6MVxDhVGFjAJh1QZN23oDpgfEjN3iH6GZXojM5wtf6n8qdUy+Hp9pKmQp1a8kTQOSIBfqIEL+2+EGWPPoLDqLPfxJq/mdnia/IlbKv8QPz9S9A94dHeiM/7WYIcYz9ROyaqFXyQhDrO4OXQYdxIPSUbkgbRss4G0UejNTOS27SDC7DWA1GCitOxPUNSjshXJkRLWz2swLrxKRJhXouQ/DARyu2O6334XSaWGJeCoV2hpES3OfpybesxS8o6sabp5UjNPOJ7txz1mbLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bf1B/H7NzD2snA92lk0wyoyd2QWsUAmfEuMtaU8nugk=;
 b=G/5VeYtFFxbgbaeB0KBay0ywGUtrgSFgBo/9aC0xiuceZQjTh0X3qNh4HTlEKrkTnoKksTCXPk6TGbH0a64ZfSujgavxqStC1aEiz0Bl8aue9yKUkI+BBboJQa/7Zrv60H2ZbSi+S/lO+kb4zTbZM4c5A4MmkOmmI+V7YczWj4g=
Received: from MN0P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::19)
 by LV8PR12MB9112.namprd12.prod.outlook.com (2603:10b6:408:184::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.19; Wed, 29 Oct
 2025 10:03:18 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:52a:cafe::8b) by MN0P221CA0016.outlook.office365.com
 (2603:10b6:208:52a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Wed,
 29 Oct 2025 10:03:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Wed, 29 Oct 2025 10:03:17 +0000
Received: from BLR-L1-SARUNKOD.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Oct
 2025 03:03:13 -0700
From: Sairaj Kodilkar <sarunkod@amd.com>
To: <mst@redhat.com>, <imammedo@redhat.com>, <anisinha@redhat.com>,
 <marcel.apfelbaum@gmail.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <eduardo@habkost.net>, <yi.l.liu@intel.com>,
 <eric.auger@redhat.com>, <zhenzhong.duan@intel.com>, <cohuck@redhat.com>,
 <qemu-devel@nongnu.org>, <alejandro.j.jimenez@oracle.com>,
 <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>
CC: Sairaj Kodilkar <sarunkod@amd.com>
Subject: [RFC PATCH 3/5] amd-iommu: Add support for set/unset IOMMU for VFIO
 PCI devices
Date: Wed, 29 Oct 2025 15:31:50 +0530
Message-ID: <20251029100152.4807-4-sarunkod@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251029100152.4807-1-sarunkod@amd.com>
References: <20251029100152.4807-1-sarunkod@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|LV8PR12MB9112:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d2bd29-f9c4-4fa0-90e4-08de16d26205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|36860700013|376014|1800799024|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oQ1+jlknbSURp9Ni0qwz3uVtO5ULauHWqKPbybfCUhMBuzFSU5w/B01EqvpM?=
 =?us-ascii?Q?yZlNrh+AWRlANFwoXHt2I9kYRrCvAliTuqPcvd0mfcs7Ni4SG9Xa9Hff15wO?=
 =?us-ascii?Q?VM6pk49AZMkucDccDxc3U+pmi+EAqAr+DBO2VJiTIzcbT0NomHFkuICMwk++?=
 =?us-ascii?Q?co7xOtS/6kBRRjPTX4lbNexilPcoUG5hgbJGe4MuP3ma3Wd8YqtsoVrxJrWU?=
 =?us-ascii?Q?+RoDIHNi0l10GI6++h2wSj6X+QbLgabnUFgPqovF+iOPK2JcWrly0Sl81mvy?=
 =?us-ascii?Q?frpCPKhJYAK/OrLU44LhHk5GBB2Hh7wmHh2+EZsvwC63gVIKn+ThxS/G62LR?=
 =?us-ascii?Q?xzN/n7M2B8bx4sRk2+4BL0fuqlN8/0veKGr+PFOmdXWQLaaVqdGDDGEioZCG?=
 =?us-ascii?Q?uesghKHdFb1vjXtgeA7OZb8cMG3sXl9Pagf16OpB6UIDgXoDuRid1ZTJPMeU?=
 =?us-ascii?Q?bTTTyuDJv6uOX13eaCsuftCWN6r8luBcCYP7/IGKRsdhYc+zaP2cttZiE463?=
 =?us-ascii?Q?nJaWbP5CCMkEHaS1xLPUlLEmc+Kt70yknL1pTn9RVIPGamhcBBrmebPAJfzH?=
 =?us-ascii?Q?wzrOgQA5WHrLxwyyisZbByss2mE17CphLJbEYRS7aTP0OOgTUck/RFx3d6V0?=
 =?us-ascii?Q?RkwIwrczDCLwmCr1hEKWhBxebphbZ+2Shb87sU5k3Ops8nRqquB8N+2Z2gQ1?=
 =?us-ascii?Q?2faXnNKrawJMOhxO+sOBJLPFUMrcFceQDPGtX8NLpRJq302Hwng7lHqmMtae?=
 =?us-ascii?Q?r9tQ5mUjDKSmuakZOhl+QO9LuxiUJsEdBrk2yQIIvxq+5tms/SMSB4+K6Y1Z?=
 =?us-ascii?Q?FXopXWHnqal2oU4jpuEeOJBV7kLPExscBXxX9YJ2pJII5QLIcb2kYLe3KxPA?=
 =?us-ascii?Q?ZgPWwZxtS33vxkFU0nDUkacMHaLC43DKUjdtA0CuQoksecMc1bfoG9xyDkIP?=
 =?us-ascii?Q?enTALdEk1HaVr2J/lngiX8CrrvxANxu7zVqA9vNvdtw/G8LD8VLKjYI5894a?=
 =?us-ascii?Q?RUA/8nP5PGbp5Yu6Bj4PoN65Ki1qPl4+sWKLlfB5xmQ5upsFSAAowDz+0yng?=
 =?us-ascii?Q?oZkEPOnFPIfBQsI9bAeV6sQk/j8efbHeVGIiYDLyZHaFqAm80Qg7em+kElFS?=
 =?us-ascii?Q?7L4yfrJec2Ud3IdonZBT9jhkjpAIUkKu/fcONO5sp/JLCclwfzhzc7y4fxgn?=
 =?us-ascii?Q?ZHcaBccpXLv7U/+hCggE14RD3cNyVR6w7ni2rrewQWpAYd54Vt7dBJoq9Tpe?=
 =?us-ascii?Q?uYp+BrAJC5bKvs2oXvucxu5PGN+SYS3GfQU0/kan5M6PNFMbRafSBGD5PsDi?=
 =?us-ascii?Q?1dBc59jH/AQZnq8MAkJ32VZAaM04EwgjSibWIji66UmS+8ejtKsr6AHp+8GY?=
 =?us-ascii?Q?//pRaJ8ZAbi+Qn6pddViGszNevZim8RbpHFJHZjMkBvxJpncdWrV6ckZKyZJ?=
 =?us-ascii?Q?rWi300WFUXE5HJSD/vDn1qeowurPwMUn+67IjPHOzsyMp+SIC4T1SXQE6jo1?=
 =?us-ascii?Q?swpA/idsQzDzs9BDAFz+IxpW012sBpCH2M5a8CD+nKmHztAj7vRQ5Ac6bNYD?=
 =?us-ascii?Q?Q6kPoTGPWR0zm7t+8v58aZVZ0yMMaSM+fCTfz/tr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(36860700013)(376014)(1800799024)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 10:03:17.6237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d2bd29-f9c4-4fa0-90e4-08de16d26205
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9112
Received-SPF: permerror client-ip=2a01:111:f403:c105::1;
 envelope-from=Sairaj.ArunKodilkar@amd.com;
 helo=CH1PR05CU001.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

"Set" function tracks VFIO devices in the hash table. This is useful when
looking up per-device host IOMMU information later on.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
---
 hw/i386/amd_iommu.c | 71 +++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/amd_iommu.h |  8 +++++
 2 files changed, 79 insertions(+)

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 378e0cb55eab..8b146f4d33d2 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -382,6 +382,22 @@ static guint amdvi_uint64_hash(gconstpointer v)
     return (guint)*(const uint64_t *)v;
 }
 
+static guint amdvi_dte_hash(gconstpointer v)
+{
+    const struct AMDVI_dte_key *key = v;
+    guint value = (guint)(uintptr_t)key->bus;
+
+    return (guint)(value << 8 | key->devfn);
+}
+
+static gboolean amdvi_dte_equal(gconstpointer v1, gconstpointer v2)
+{
+    const struct AMDVI_dte_key *key1 = v1;
+    const struct AMDVI_dte_key *key2 = v2;
+
+    return (key1->bus == key2->bus) && (key1->devfn == key2->devfn);
+}
+
 static AMDVIIOTLBEntry *amdvi_iotlb_lookup(AMDVIState *s, hwaddr addr,
                                            uint64_t devid)
 {
@@ -2291,8 +2307,60 @@ static AddressSpace *amdvi_host_dma_iommu(PCIBus *bus, void *opaque, int devfn)
     return &iommu_as[devfn]->as;
 }
 
+static bool amdvi_set_iommu_device(PCIBus *bus, void *opaque, int devfn,
+                                   HostIOMMUDevice *hiod, Error **errp)
+{
+    AMDVIState *s = opaque;
+    struct AMDVI_dte_key *new_key;
+    struct AMDVI_dte_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+
+    assert(hiod);
+    assert(0 <= devfn && devfn < PCI_DEVFN_MAX);
+
+    if (g_hash_table_lookup(s->hiod_hash, &key)) {
+        error_setg(errp, "Host IOMMU device already exist");
+        return false;
+    }
+
+    if (hiod->caps.type != IOMMU_HW_INFO_TYPE_AMD &&
+        hiod->caps.type != IOMMU_HW_INFO_TYPE_DEFAULT) {
+        error_setg(errp, "IOMMU hardware is not compatible");
+        return false;
+    }
+
+    new_key = g_malloc(sizeof(*new_key));
+    new_key->bus = bus;
+    new_key->devfn = devfn;
+
+    object_ref(hiod);
+    g_hash_table_insert(s->hiod_hash, new_key, hiod);
+
+    return true;
+}
+
+static void amdvi_unset_iommu_device(PCIBus *bus, void *opaque,
+                                     int devfn)
+{
+    AMDVIState *s = opaque;
+    struct AMDVI_dte_key key = {
+        .bus = bus,
+        .devfn = devfn,
+    };
+
+    if (!g_hash_table_lookup(s->hiod_hash, &key)) {
+        return;
+    }
+
+    g_hash_table_remove(s->hiod_hash, &key);
+}
+
 static const PCIIOMMUOps amdvi_iommu_ops = {
     .get_address_space = amdvi_host_dma_iommu,
+    .set_iommu_device = amdvi_set_iommu_device,
+    .unset_iommu_device = amdvi_unset_iommu_device,
 };
 
 static const MemoryRegionOps mmio_mem_ops = {
@@ -2510,6 +2578,9 @@ static void amdvi_sysbus_realize(DeviceState *dev, Error **errp)
     s->iotlb = g_hash_table_new_full(amdvi_uint64_hash,
                                      amdvi_uint64_equal, g_free, g_free);
 
+    s->hiod_hash = g_hash_table_new_full(amdvi_dte_hash,
+                                         amdvi_dte_equal, g_free, g_free);
+
     /* set up MMIO */
     memory_region_init_io(&s->mr_mmio, OBJECT(s), &mmio_mem_ops, s,
                           "amdvi-mmio", AMDVI_MMIO_SIZE);
diff --git a/hw/i386/amd_iommu.h b/hw/i386/amd_iommu.h
index daf82fc85f96..e6f6902fe06d 100644
--- a/hw/i386/amd_iommu.h
+++ b/hw/i386/amd_iommu.h
@@ -358,6 +358,11 @@ struct AMDVIPCIState {
     uint32_t capab_offset;       /* capability offset pointer    */
 };
 
+struct AMDVI_dte_key {
+    PCIBus *bus;
+    uint8_t devfn;
+};
+
 struct AMDVIState {
     X86IOMMUState iommu;        /* IOMMU bus device             */
     AMDVIPCIState *pci;         /* IOMMU PCI device             */
@@ -416,6 +421,9 @@ struct AMDVIState {
     /* IOTLB */
     GHashTable *iotlb;
 
+    /* HostIOMMUDevice hash table*/
+    GHashTable *hiod_hash;
+
     /* Interrupt remapping */
     bool ga_enabled;
     bool xtsup;
-- 
2.34.1


